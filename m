Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFC445E67C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 04:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344374AbhKZDXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 22:23:25 -0500
Received: from mga17.intel.com ([192.55.52.151]:43927 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1357637AbhKZDVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 22:21:22 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="216309876"
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208,223";a="216309876"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 19:18:06 -0800
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208,223";a="498257515"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.143])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 19:17:59 -0800
Date:   Fri, 26 Nov 2021 11:17:48 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Roman Gushchin <guro@fb.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com, fengwei.yin@intel.com
Subject: Re: [memcg, kmem]  58056f7750:  hackbench.throughput 10.3%
 improvement
Message-ID: <20211126031748.GA11450@xsang-OptiPlex-9020>
References: <20211124083435.GB18309@xsang-OptiPlex-9020>
 <YZ5v2LZlpzHieq/+@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YZ5v2LZlpzHieq/+@dhcp22.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Michal Hocko,

On Wed, Nov 24, 2021 at 06:01:12PM +0100, Michal Hocko wrote:
> On Wed 24-11-21 16:34:35, kernel test robot wrote:
> > 
> > 
> > Greeting,
> > 
> > FYI, we noticed a 10.3% improvement of hackbench.throughput due to commit:
> > 
> > 
> > commit: 58056f77502f3567b760c9a8fc8d2e9081515b2d ("memcg, kmem: further deprecate kmem.limit_in_bytes")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> I am really surprised to see an improvement from this patch. I do not
> expect your benchmarking would be using kmem limit. The above patch
> hasn't really removed the page counter out of the picture so there
> shouldn't be any real reason for performance improvement. I strongly
> suspect this is just some benchmark artifact or unreliable evaluation.

Fengwei Yin helped further analyze this improvement.

The patch changed the behavior of function obj_cgroup_charge_pages. It's shown
in the perf-callstack as following line:

   5.63 ± 11%      -5.6        0.00        perf-profile.calltrace.cycles-pp.page_counter_try_charge.obj_cgroup_charge_pages.obj_cgroup_charge.kmem_cache_alloc_node.__alloc_skb

So Fengwei prepared a patch which reverting the changes in
obj_cgroup_charge_pages in 58056f7750 (as attached mod.patch)

by this patch, the performance is similar to 16f6bf266c, the improvement
disappear.

=========================================================================================
compiler/cpufreq_governor/ipc/iterations/kconfig/mode/nr_threads/rootfs/tbox_group/testcase/ucode:
  gcc-9/performance/socket/4/x86_64-rhel-8.3/process/100%/debian-10.4-x86_64-20200603.cgz/lkp-cpl-4sp1/hackbench/0x700001e

commit:
  16f6bf266c ("mm/list_lru.c: prefer struct_size over open coded arithmetic")
  58056f7750 ("memcg, kmem: further deprecate kmem.limit_in_bytes")
  ae12af515d ('58056f7750' minus 'changes in obj_cgroup_charge_pages', attached mod.patch)


16f6bf266c94017c 58056f77502f3567b760c9a8fc8 ae12af515da0d557c25f86e89b0
---------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
    124966            +8.8%     136017 ±  2%      -0.1%     124791 ±  2%  hackbench.throughput
...
      5.41 ± 12%      -5.4        0.00            +0.3        5.73 ± 13%  perf-profile.calltrace.cycles-pp.page_counter_try_charge.obj_cgroup_charge_pages.obj_cgroup_charge.kmem_cache_alloc_node.__alloc_skb

detail comparison data as attached 16f6b-58056-ae12a

in brief, the result prove what we suspect. The original patch removed code
   -           !page_counter_try_charge(&memcg->kmem, nr_pages, &counter)) {
which improved the hackbench throughput. Thanks.


> -- 
> Michal Hocko
> SUSE Labs

--x+6KMIRAuhnl3hBn
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="mod.patch"

From ae12af515da0d557c25f86e89b0251d2da2ad8dc Mon Sep 17 00:00:00 2001
From: Shakeel Butt <shakeelb@google.com>
Date: Fri, 5 Nov 2021 13:37:44 -0700
Subject: [PATCH] memcg, kmem: further deprecate kmem.limit_in_bytes

update for debugging by Fengwei

The deprecation process of kmem.limit_in_bytes started with the commit
0158115f702 ("memcg, kmem: deprecate kmem.limit_in_bytes") which also
explains in detail the motivation behind the deprecation.  To summarize,
it is the unexpected behavior on hitting the kmem limit.  This patch
moves the deprecation process to the next stage by disallowing to set
the kmem limit.  In future we might just remove the kmem.limit_in_bytes
file completely.

[akpm@linux-foundation.org: s/ENOTSUPP/EOPNOTSUPP/]
[arnd@arndb.de: mark cancel_charge() inline]
  Link: https://lkml.kernel.org/r/20211022070542.679839-1-arnd@kernel.org

Link: https://lkml.kernel.org/r/20211019153408.2916808-1-shakeelb@google.com
Signed-off-by: Shakeel Butt <shakeelb@google.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Roman Gushchin <guro@fb.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Cc: Vasily Averin <vvs@virtuozzo.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 .../admin-guide/cgroup-v1/memory.rst          | 11 ++--------
 mm/memcontrol.c                               | 21 +++----------------
 2 files changed, 5 insertions(+), 27 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
index 41191b5fb69d9..faac50149a222 100644
--- a/Documentation/admin-guide/cgroup-v1/memory.rst
+++ b/Documentation/admin-guide/cgroup-v1/memory.rst
@@ -87,10 +87,8 @@ Brief summary of control files.
  memory.oom_control		     set/show oom controls.
  memory.numa_stat		     show the number of memory usage per numa
 				     node
- memory.kmem.limit_in_bytes          set/show hard limit for kernel memory
-                                     This knob is deprecated and shouldn't be
-                                     used. It is planned that this be removed in
-                                     the foreseeable future.
+ memory.kmem.limit_in_bytes          This knob is deprecated and writing to
+                                     it will return -ENOTSUPP.
  memory.kmem.usage_in_bytes          show current kernel memory allocation
  memory.kmem.failcnt                 show the number of kernel memory usage
 				     hits limits
@@ -518,11 +516,6 @@ will be charged as a new owner of it.
   charged file caches. Some out-of-use page caches may keep charged until
   memory pressure happens. If you want to avoid that, force_empty will be useful.
 
-  Also, note that when memory.kmem.limit_in_bytes is set the charges due to
-  kernel pages will still be seen. This is not considered a failure and the
-  write will still return success. In this case, it is expected that
-  memory.kmem.usage_in_bytes == memory.usage_in_bytes.
-
 5.2 stat file
 -------------
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e092cce3c96e7..22c2f97773eeb 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2771,8 +2771,7 @@ static inline int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	return try_charge_memcg(memcg, gfp_mask, nr_pages);
 }
 
-#if defined(CONFIG_MEMCG_KMEM) || defined(CONFIG_MMU)
-static void cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages)
+static inline void cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages)
 {
 	if (mem_cgroup_is_root(memcg))
 		return;
@@ -2781,7 +2780,6 @@ static void cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages)
 	if (do_memsw_account())
 		page_counter_uncharge(&memcg->memsw, nr_pages);
 }
-#endif
 
 static void commit_charge(struct page *page, struct mem_cgroup *memcg)
 {
@@ -3714,17 +3712,6 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 }
 #endif /* CONFIG_MEMCG_KMEM */
 
-static int memcg_update_kmem_max(struct mem_cgroup *memcg,
-				 unsigned long max)
-{
-	int ret;
-
-	mutex_lock(&memcg_max_mutex);
-	ret = page_counter_set_max(&memcg->kmem, max);
-	mutex_unlock(&memcg_max_mutex);
-	return ret;
-}
-
 static int memcg_update_tcp_max(struct mem_cgroup *memcg, unsigned long max)
 {
 	int ret;
@@ -3790,10 +3777,8 @@ static ssize_t mem_cgroup_write(struct kernfs_open_file *of,
 			ret = mem_cgroup_resize_max(memcg, nr_pages, true);
 			break;
 		case _KMEM:
-			pr_warn_once("kmem.limit_in_bytes is deprecated and will be removed. "
-				     "Please report your usecase to linux-mm@kvack.org if you "
-				     "depend on this functionality.\n");
-			ret = memcg_update_kmem_max(memcg, nr_pages);
+			/* kmem.limit_in_bytes is deprecated. */
+			ret = -EOPNOTSUPP;
 			break;
 		case _TCP:
 			ret = memcg_update_tcp_max(memcg, nr_pages);
-- 
2.30.2


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename=16f6b-58056-ae12a
Content-Transfer-Encoding: 8bit

=========================================================================================
compiler/cpufreq_governor/ipc/iterations/kconfig/mode/nr_threads/rootfs/tbox_group/testcase/ucode:
  gcc-9/performance/socket/4/x86_64-rhel-8.3/process/100%/debian-10.4-x86_64-20200603.cgz/lkp-cpl-4sp1/hackbench/0x700001e

commit: 
  16f6bf266c ("mm/list_lru.c: prefer struct_size over open coded arithmetic")
  58056f7750 ("memcg, kmem: further deprecate kmem.limit_in_bytes")
  ae12af515d ('58056f7750' minus 'changes in obj_cgroup_charge_pages')


16f6bf266c94017c 58056f77502f3567b760c9a8fc8 ae12af515da0d557c25f86e89b0 
---------------- --------------------------- --------------------------- 
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \  
    124966            +8.8%     136017 ±  2%      -0.1%     124791 ±  2%  hackbench.throughput
    549.79            -8.7%     502.22 ±  2%      +0.2%     551.09 ±  2%  hackbench.time.elapsed_time
    549.79            -8.7%     502.22 ±  2%      +0.2%     551.09 ±  2%  hackbench.time.elapsed_time.max
 3.459e+08 ±  4%     -55.5%  1.538e+08 ±  2%      -1.8%  3.399e+08 ±  7%  hackbench.time.involuntary_context_switches
     11332 ±  3%      +5.0%      11897 ±  4%      +4.0%      11786 ±  9%  hackbench.time.major_page_faults
      2511            -0.1%       2507            -0.2%       2505        hackbench.time.maximum_resident_set_size
   1065639            +1.5%    1082033            +0.1%    1066775        hackbench.time.minor_page_faults
      4096            +0.0%       4096            +0.0%       4096        hackbench.time.page_size
     14098            -0.2%      14070            +0.0%      14102        hackbench.time.percent_of_cpu_this_job_got
     76469            -8.7%      69789 ±  2%      +0.3%      76669 ±  2%  hackbench.time.system_time
      1044           -15.7%     880.24 ±  2%      +0.4%       1049 ±  3%  hackbench.time.user_time
 9.104e+08 ±  3%     -40.5%  5.414e+08            -0.9%  9.021e+08 ±  4%  hackbench.time.voluntary_context_switches
 9.296e+08 ±  5%      +3.9%  9.657e+08 ±  6%      -3.5%   8.97e+08 ±  6%  cpuidle..time
  23745171 ±  3%      +2.5%   24331987 ±  5%      -2.3%   23201408 ±  7%  cpuidle..usage
    604.26            -7.7%     557.85 ±  2%      +0.0%     604.52 ±  2%  uptime.boot
      8065 ±  5%      +3.0%       8305 ±  4%      -2.0%       7903 ±  5%  uptime.idle
     51.69 ±  5%      +2.8%      53.13 ±  5%      -1.5%      50.92 ±  5%  boot-time.boot
     24.13 ±  3%      +1.3%      24.45            -1.1%      23.87 ±  7%  boot-time.dhcp
      6563 ±  5%      +3.5%       6793 ±  6%      -2.0%       6433 ±  5%  boot-time.idle
      1.51            -0.0%       1.51            +0.1%       1.51        boot-time.smp_boot
      1.17 ±  5%      +0.1        1.31 ±  5%      -0.0        1.15 ±  5%  mpstat.cpu.all.idle%
      0.00 ±282%      +0.0        0.00 ±282%      -0.0        0.00        mpstat.cpu.all.iowait%
      1.03 ±  3%      +0.0        1.04 ±  2%      -0.0        1.02 ±  3%  mpstat.cpu.all.irq%
      0.05 ±  2%      +0.0        0.05 ±  4%      -0.0        0.05 ±  4%  mpstat.cpu.all.soft%
     96.41            -0.1       96.34            +0.0       96.44        mpstat.cpu.all.sys%
      1.34            -0.1        1.26            +0.0        1.34        mpstat.cpu.all.usr%
      1.00            +0.0%       1.00            +0.0%       1.00        vmstat.cpu.id
     96.11            -0.1%      96.00            +0.3%      96.40        vmstat.cpu.sy
      1.00            +0.0%       1.00            +0.0%       1.00        vmstat.cpu.us
      0.00          -100.0%       0.00          -100.0%       0.00        vmstat.io.bi
   3820664 ±  4%      +6.4%    4064548 ±  5%      -0.1%    3817708 ±  3%  vmstat.memory.cache
  69525466 ± 56%      -0.4%   69222747 ± 57%     +80.4%  1.254e+08        vmstat.memory.free
      2741           -12.2%       2406            +0.0%       2742        vmstat.procs.r
   2321844 ±  3%     -38.4%    1430042            -1.3%    2291373 ±  5%  vmstat.system.cs
    534709           -10.0%     481329            -0.2%     533877        vmstat.system.in
    549.79            -8.7%     502.22 ±  2%      +0.2%     551.09 ±  2%  time.elapsed_time
    549.79            -8.7%     502.22 ±  2%      +0.2%     551.09 ±  2%  time.elapsed_time.max
 3.459e+08 ±  4%     -55.5%  1.538e+08 ±  2%      -1.8%  3.399e+08 ±  7%  time.involuntary_context_switches
     11332 ±  3%      +5.0%      11897 ±  4%      +4.0%      11786 ±  9%  time.major_page_faults
      2511            -0.1%       2507            -0.2%       2505        time.maximum_resident_set_size
   1065639            +1.5%    1082033            +0.1%    1066775        time.minor_page_faults
      4096            +0.0%       4096            +0.0%       4096        time.page_size
     14098            -0.2%      14070            +0.0%      14102        time.percent_of_cpu_this_job_got
     76469            -8.7%      69789 ±  2%      +0.3%      76669 ±  2%  time.system_time
      1044           -15.7%     880.24 ±  2%      +0.4%       1049 ±  3%  time.user_time
 9.104e+08 ±  3%     -40.5%  5.414e+08            -0.9%  9.021e+08 ±  4%  time.voluntary_context_switches
      0.00          -100.0%       0.00          -100.0%       0.00        numa-numastat.node0.interleave_hit
    970854 ± 41%      +0.1%     972288 ± 48%      +1.8%     988159 ± 37%  numa-numastat.node0.local_node
   1005478 ± 39%      +1.0%    1015118 ± 44%      +0.8%    1013739 ± 36%  numa-numastat.node0.numa_hit
     34666 ± 62%     +23.7%      42872 ± 59%     -26.1%      25617 ± 73%  numa-numastat.node0.other_node
      0.00          -100.0%       0.00          -100.0%       0.00        numa-numastat.node1.interleave_hit
    408322 ± 29%      -0.5%     406369 ± 49%     +56.2%     637941 ± 57%  numa-numastat.node1.local_node
    464078 ± 24%      -0.1%     463706 ± 43%     +49.3%     692793 ± 51%  numa-numastat.node1.numa_hit
     55757 ± 27%      +2.9%      57348 ± 19%      +1.6%      56674 ± 18%  numa-numastat.node1.other_node
      0.00          -100.0%       0.00          -100.0%       0.00        numa-numastat.node2.interleave_hit
    498985 ± 62%     +43.0%     713776 ± 69%      -8.1%     458542 ± 48%  numa-numastat.node2.local_node
    554215 ± 54%     +36.3%     755664 ± 62%      -7.9%     510203 ± 42%  numa-numastat.node2.numa_hit
     55229 ± 26%     -24.1%      41898 ± 60%      -6.5%      51654 ± 36%  numa-numastat.node2.other_node
      0.00          -100.0%       0.00          -100.0%       0.00        numa-numastat.node3.interleave_hit
    897162 ± 48%     -17.2%     743028 ± 27%     -23.0%     691233 ± 17%  numa-numastat.node3.local_node
    946687 ± 45%     -15.9%     796330 ± 25%     -20.5%     752614 ± 15%  numa-numastat.node3.numa_hit
     49525 ± 48%      +7.6%      53296 ± 31%     +23.9%      61381 ± 12%  numa-numastat.node3.other_node
      3240            +0.1%       3243            +0.1%       3242        turbostat.Avg_MHz
     98.63            -0.1       98.53            +0.1       98.72        turbostat.Busy%
      3292            +0.2%       3298            -0.0%       3292        turbostat.Bzy_MHz
  20404132 ±  3%      +2.0%   20812865 ±  4%      -2.6%   19873691 ±  7%  turbostat.C1
      0.42 ±  5%      +0.1        0.52 ±  6%      -0.0        0.42 ± 11%  turbostat.C1%
   2738720 ± 12%      +5.9%    2900028 ± 24%      -5.3%    2594275 ± 14%  turbostat.C1E
      0.55 ± 36%      -0.1        0.50 ± 57%      -0.2        0.35 ± 48%  turbostat.C1E%
    262620 ± 81%     +32.8%     348645 ± 54%     +69.7%     445760 ± 35%  turbostat.C6
      0.22 ± 86%      +0.1        0.33 ± 76%      +0.2        0.38 ± 41%  turbostat.C6%
      1.31 ±  6%      +5.2%       1.38 ±  8%      -8.9%       1.19 ±  9%  turbostat.CPU%c1
      0.06 ±114%     +53.8%       0.09 ± 93%     +55.8%       0.09 ± 55%  turbostat.CPU%c6
     64.67 ±  3%      +0.3%      64.89 ±  4%      -2.9%      62.80 ±  2%  turbostat.CoreTmp
 2.949e+08           -17.8%  2.424e+08 ±  2%      +0.0%  2.949e+08 ±  2%  turbostat.IRQ
    176.27 ± 16%     -39.8      136.48 ± 27%     -19.0      157.27 ± 24%  turbostat.PKG_%
      0.04 ±143%     +73.0%       0.07 ±110%     +60.5%       0.07 ± 57%  turbostat.Pkg%pc2
     64.67 ±  4%      +0.2%      64.78 ±  3%      -2.9%      62.80 ±  2%  turbostat.PkgTmp
    590.26            -0.2%     589.12            -0.2%     588.93        turbostat.PkgWatt
     50.47            +2.8%      51.87            -0.9%      50.02        turbostat.RAMWatt
      2494            +0.0%       2494            +0.0%       2494        turbostat.TSC_MHz
    953610 ±  8%     +13.9%    1086414 ± 13%      +4.0%     992116 ±  7%  meminfo.Active
    953610 ±  8%     +13.9%    1086414 ± 13%      +4.0%     992116 ±  7%  meminfo.Active(anon)
    195098            +5.3%     205478 ±  2%      +0.6%     196239        meminfo.AnonHugePages
    476116 ±  2%      +2.2%     486605            -1.1%     470982 ±  2%  meminfo.AnonPages
   3677241 ±  4%      +6.6%    3918609 ±  5%      -0.1%    3673478 ±  3%  meminfo.Cached
  38302780 ± 50%      +0.0%   38302780 ± 50%     +71.9%   65827892        meminfo.CommitLimit
   3796111 ±  4%      +6.9%    4059131 ±  5%      -0.1%    3791204 ±  3%  meminfo.Committed_AS
 1.215e+08            +0.2%  1.218e+08            -0.4%   1.21e+08        meminfo.DirectMap1G
  13458773 ± 11%      -1.8%   13210965 ± 10%      +4.1%   14008934 ± 10%  meminfo.DirectMap2M
   1010235 ±  7%      +1.5%    1025026 ±  3%      -3.7%     972711 ±  6%  meminfo.DirectMap4k
      2048            +0.0%       2048            +0.0%       2048        meminfo.Hugepagesize
    719493 ± 15%     +16.4%     837626 ± 12%      -6.8%     670755 ± 13%  meminfo.Inactive
    719493 ± 15%     +16.4%     837626 ± 12%      -6.8%     670755 ± 13%  meminfo.Inactive(anon)
    155699            -0.8%     154489            +0.2%     156050        meminfo.KReclaimable
    108799            +0.7%     109612            +0.6%     109482        meminfo.KernelStack
    294395 ± 26%     +25.5%     369407 ± 19%     -17.0%     244433 ± 29%  meminfo.Mapped
  69245453 ± 56%      -0.4%   68940062 ± 57%     +80.5%   1.25e+08        meminfo.MemAvailable
  69525821 ± 56%      -0.4%   69221036 ± 57%     +80.4%  1.254e+08        meminfo.MemFree
  76605560 ± 50%      +0.0%   76605560 ± 50%     +71.9%  1.317e+08        meminfo.MemTotal
   7079737 ±  9%      +4.3%    7384522 ±  8%     -12.0%    6228488 ±  2%  meminfo.Memused
      1354 ± 35%      -7.0%       1259 ± 42%      -1.4%       1334 ± 34%  meminfo.Mlocked
    201906 ±  2%      +0.7%     203359 ±  3%      -0.6%     200707 ±  2%  meminfo.PageTables
     91700            +0.2%      91846            -0.3%      91389        meminfo.Percpu
    155699            -0.8%     154489            +0.2%     156050        meminfo.SReclaimable
    659151            +2.7%     676639            +1.0%     665469        meminfo.SUnreclaim
   1197463 ± 12%     +20.1%    1437842 ± 15%      -0.5%    1191946 ± 11%  meminfo.Shmem
    814851            +2.0%     831130            +0.8%     821521        meminfo.Slab
   2479973            +0.0%    2480947            +0.1%    2481725        meminfo.Unevictable
 3.436e+10            +0.0%  3.436e+10            +0.0%  3.436e+10        meminfo.VmallocTotal
    276529            +0.4%     277523            +1.6%     280895        meminfo.VmallocUsed
   7840788 ±  8%      +3.4%    8104693 ±  7%     -10.0%    7055413        meminfo.max_used_kB
    484.22 ±  7%      +1.5%     491.44 ±  3%      -3.8%     465.90 ±  6%  proc-vmstat.direct_map_level2_splits
     10.11 ± 14%      -2.2%       9.89 ± 13%      +4.8%      10.60 ± 13%  proc-vmstat.direct_map_level3_splits
    238471 ±  8%     +13.7%     271152 ± 13%      +4.4%     248881 ±  7%  proc-vmstat.nr_active_anon
    118933 ±  2%      +2.2%     121565            -1.1%     117619 ±  2%  proc-vmstat.nr_anon_pages
     94.89            +5.3%      99.89 ±  2%      +0.5%      95.40        proc-vmstat.nr_anon_transparent_hugepages
   1726720 ± 56%      -0.4%    1719109 ± 57%     +80.6%    3117816        proc-vmstat.nr_dirty_background_threshold
   3457663 ± 56%      -0.4%    3442423 ± 57%     +80.6%    6243256        proc-vmstat.nr_dirty_threshold
    918994 ±  4%      +6.5%     979014 ±  5%      -0.0%     918879 ±  3%  proc-vmstat.nr_file_pages
  17382098 ± 56%      -0.4%   17305880 ± 57%     +80.4%   31357124        proc-vmstat.nr_free_pages
    179395 ± 15%     +16.6%     209137 ± 12%      -6.8%     167227 ± 13%  proc-vmstat.nr_inactive_anon
      7.22 ± 29%      -3.1%       7.00 ± 21%      -4.5%       6.90 ± 28%  proc-vmstat.nr_isolated_anon
    108770            +0.7%     109514            +0.6%     109404        proc-vmstat.nr_kernel_stack
     73027 ± 26%     +26.3%      92201 ± 18%     -16.9%      60679 ± 29%  proc-vmstat.nr_mapped
    338.67 ± 36%      -7.3%     314.11 ± 42%      -1.4%     333.80 ± 34%  proc-vmstat.nr_mlock
     50466 ±  2%      +0.7%      50795 ±  3%      -0.7%      50126 ±  2%  proc-vmstat.nr_page_table_pages
    299050 ± 13%     +20.0%     358823 ± 15%      -0.2%     298496 ± 11%  proc-vmstat.nr_shmem
     38926            -0.8%      38621            +0.2%      39014        proc-vmstat.nr_slab_reclaimable
    164649            +2.7%     169088            +1.0%     166276        proc-vmstat.nr_slab_unreclaimable
    619993            +0.0%     620236            +0.1%     620431        proc-vmstat.nr_unevictable
    238471 ±  8%     +13.7%     271152 ± 13%      +4.4%     248881 ±  7%  proc-vmstat.nr_zone_active_anon
    179395 ± 15%     +16.6%     209137 ± 12%      -6.8%     167227 ± 13%  proc-vmstat.nr_zone_inactive_anon
    619993            +0.0%     620236            +0.1%     620431        proc-vmstat.nr_zone_unevictable
    384718 ±  7%     +10.9%     426838 ± 10%      -3.0%     373075 ±  8%  proc-vmstat.numa_hint_faults
    112727 ± 15%     +21.8%     137288 ± 20%      +0.4%     113148 ± 18%  proc-vmstat.numa_hint_faults_local
   2972848 ±  2%      +2.0%    3032880 ±  2%      +0.0%    2973496        proc-vmstat.numa_hit
    105.67 ± 30%    +156.5%     271.00 ± 27%     +30.1%     137.50 ± 29%  proc-vmstat.numa_huge_pte_updates
      0.00          -100.0%       0.00          -100.0%       0.00        proc-vmstat.numa_interleave
   2777712 ±  2%      +2.2%    2837523 ±  3%      +0.1%    2780021        proc-vmstat.numa_local
    195178            +0.1%     195415            +0.1%     195328        proc-vmstat.numa_other
    174122 ±  9%     +12.6%     196013 ±  7%      +4.7%     182252 ±  6%  proc-vmstat.numa_pages_migrated
    664123 ±  6%     +17.4%     779591 ±  8%      -0.5%     660659 ±  4%  proc-vmstat.numa_pte_updates
    357620 ± 13%     +24.1%     443937 ± 15%      +0.1%     357890 ± 12%  proc-vmstat.pgactivate
      0.00          -100.0%       0.00          -100.0%       0.00        proc-vmstat.pgalloc_dma32
   2977481 ±  2%      +2.1%    3040606 ±  2%      +0.2%    2983328        proc-vmstat.pgalloc_normal
   3094786            +0.3%    3103731 ±  2%      -0.5%    3078871        proc-vmstat.pgfault
   2635402            -0.7%    2617600            +0.3%    2642152        proc-vmstat.pgfree
      1.33 ± 86%     -25.0%       1.00 ±141%     +12.5%       1.50 ±120%  proc-vmstat.pgmigrate_fail
    174122 ±  9%     +12.6%     196013 ±  7%      +4.7%     182252 ±  6%  proc-vmstat.pgmigrate_success
      0.00          -100.0%       0.00          -100.0%       0.00        proc-vmstat.pgpgin
      0.00          -100.0%       0.00          -100.0%       0.00        proc-vmstat.pgpgout
    136943            -3.8%     131730            -0.6%     136087        proc-vmstat.pgreuse
     97.56           +61.8%     157.89 ±  7%      +5.2%     102.60 ± 11%  proc-vmstat.thp_collapse_alloc
      0.56 ±226%     +40.0%       0.78 ±157%    +152.0%       1.40 ±124%  proc-vmstat.thp_deferred_split_page
     21.89 ±  6%      -2.5%      21.33 ±  8%      -2.2%      21.40 ±  6%  proc-vmstat.thp_fault_alloc
     27.56 ± 61%     +41.5%      39.00 ± 14%     +47.7%      40.70 ± 33%  proc-vmstat.thp_migration_success
      0.56 ±226%     +40.0%       0.78 ±157%    +152.0%       1.40 ±124%  proc-vmstat.thp_split_pmd
      0.00          -100.0%       0.00          -100.0%       0.00        proc-vmstat.thp_zero_page_alloc
    105.78            +1.2%     107.00 ±  3%      +0.0%     105.80        proc-vmstat.unevictable_pgs_culled
    586.00            +0.0%     586.00            +0.0%     586.00        proc-vmstat.unevictable_pgs_mlocked
     10.83            -1.4%      10.68            +0.1%      10.83        perf-stat.i.MPKI
 1.676e+10            -6.3%  1.572e+10 ±  2%      +0.1%  1.677e+10 ±  3%  perf-stat.i.branch-instructions
      0.80            -0.2        0.64 ±  2%      -0.0        0.78        perf-stat.i.branch-miss-rate%
 1.312e+08           -24.5%   99000890 ±  2%      -3.3%  1.268e+08 ±  3%  perf-stat.i.branch-misses
     27.84            +1.0       28.88            +0.1       27.97        perf-stat.i.cache-miss-rate%
 2.375e+08            +2.2%  2.426e+08 ±  2%      +0.3%  2.382e+08        perf-stat.i.cache-misses
 8.639e+08            -2.2%  8.452e+08            -0.2%  8.623e+08 ±  2%  perf-stat.i.cache-references
   2338889 ±  3%     -38.3%    1443136 ±  2%      -1.0%    2316609 ±  5%  perf-stat.i.context-switches
      5.89            -0.3%       5.87 ±  2%      +0.3%       5.90 ±  2%  perf-stat.i.cpi
    144554            -0.0%     144521            -0.0%     144547        perf-stat.i.cpu-clock
 4.647e+11            +0.1%  4.653e+11            +0.0%  4.648e+11        perf-stat.i.cpu-cycles
    143176 ±  2%     -14.5%     122362            -2.4%     139707 ±  3%  perf-stat.i.cpu-migrations
      1993            -2.5%       1943 ±  2%      -0.5%       1983 ±  2%  perf-stat.i.cycles-between-cache-misses
      0.07 ±  4%      -0.0        0.06 ±  5%      +0.0        0.07 ±  6%  perf-stat.i.dTLB-load-miss-rate%
  16460680 ±  3%     -14.4%   14082480 ±  6%      +3.5%   17035401 ±  7%  perf-stat.i.dTLB-load-misses
 2.403e+10            -2.9%  2.332e+10 ±  2%      -0.1%    2.4e+10 ±  2%  perf-stat.i.dTLB-loads
      0.03 ±  9%      +0.0        0.04 ±  7%      +0.0        0.03 ± 12%  perf-stat.i.dTLB-store-miss-rate%
   3969081 ±  9%     +28.0%    5080192 ±  8%      +3.3%    4100343 ± 12%  perf-stat.i.dTLB-store-misses
 1.414e+10            -2.3%  1.381e+10 ±  2%      -0.1%  1.412e+10 ±  2%  perf-stat.i.dTLB-stores
     70.69            -0.2       70.52            -1.0       69.72        perf-stat.i.iTLB-load-miss-rate%
  56241980           -36.8%   35526810 ±  7%      -4.7%   53612134 ±  6%  perf-stat.i.iTLB-load-misses
  22949008 ±  2%     -35.9%   14714272 ±  2%      -1.2%   22682884 ±  5%  perf-stat.i.iTLB-loads
 8.394e+10            -5.0%  7.974e+10 ±  2%      -0.0%  8.393e+10 ±  3%  perf-stat.i.instructions
      1549           +48.3%       2298 ±  6%      +6.0%       1642 ±  2%  perf-stat.i.instructions-per-iTLB-miss
      0.18            -5.5%       0.17 ±  2%      -0.1%       0.18 ±  3%  perf-stat.i.ipc
     42.01 ±  3%      +9.4%      45.97 ±  6%      +5.6%      44.36 ±  9%  perf-stat.i.major-faults
      3.22            +0.2%       3.22            +0.0%       3.22        perf-stat.i.metric.GHz
    873.37            +3.4%     902.94 ±  2%      +0.2%     875.02        perf-stat.i.metric.K/sec
    386.67            -3.8%     372.05 ±  2%      -0.1%     386.44 ±  2%  perf-stat.i.metric.M/sec
      7129            +4.2%       7429 ±  2%      +0.3%       7149 ±  3%  perf-stat.i.minor-faults
     65.90            -5.5       60.41 ±  2%      +0.2       66.05 ±  2%  perf-stat.i.node-load-miss-rate%
  39698182            -3.8%   38178391            -0.0%   39694736        perf-stat.i.node-load-misses
  20918129 ±  3%     +21.5%   25420030 ±  6%      -0.5%   20810824 ±  5%  perf-stat.i.node-loads
     43.31 ±  2%      -4.9       38.37 ±  6%      -0.0       43.29 ±  6%  perf-stat.i.node-store-miss-rate%
  15582379           +11.3%   17346514 ±  4%      +1.2%   15774193 ±  6%  perf-stat.i.node-store-misses
  20688927 ±  3%     +36.0%   28141872 ±  6%      +0.9%   20882759 ±  5%  perf-stat.i.node-stores
      7170            +4.2%       7475 ±  2%      +0.3%       7193 ±  3%  perf-stat.i.page-faults
    144554            -0.0%     144521            -0.0%     144547        perf-stat.i.task-clock
     10.34            +1.7%      10.51            +0.1%      10.35        perf-stat.overall.MPKI
      0.78            -0.2        0.62 ±  2%      -0.0        0.75        perf-stat.overall.branch-miss-rate%
     28.17            +1.0       29.14            +0.2       28.32        perf-stat.overall.cache-miss-rate%
      5.63            +3.6%       5.84 ±  2%      +0.4%       5.66 ±  2%  perf-stat.overall.cpi
      1935            -1.5%       1906            -0.2%       1931        perf-stat.overall.cycles-between-cache-misses
      0.07 ±  4%      -0.0        0.06 ±  5%      +0.0        0.07 ±  6%  perf-stat.overall.dTLB-load-miss-rate%
      0.03 ±  9%      +0.0        0.04 ±  7%      +0.0        0.03 ± 12%  perf-stat.overall.dTLB-store-miss-rate%
     70.94            +0.0       70.96            -0.8       70.12        perf-stat.overall.iTLB-load-miss-rate%
      1501           +50.4%       2257 ±  6%      +5.6%       1584 ±  3%  perf-stat.overall.instructions-per-iTLB-miss
      0.18            -3.4%       0.17 ±  2%      -0.4%       0.18 ±  2%  perf-stat.overall.ipc
     64.46            -5.3       59.14 ±  2%      +0.0       64.50        perf-stat.overall.node-load-miss-rate%
     40.56 ±  2%      -4.2       36.36 ±  4%      -0.1       40.44 ±  4%  perf-stat.overall.node-store-miss-rate%
 1.646e+10            -4.4%  1.574e+10 ±  2%      -0.3%  1.641e+10 ±  2%  perf-stat.ps.branch-instructions
 1.287e+08           -23.7%   98157500 ±  2%      -3.8%  1.238e+08 ±  3%  perf-stat.ps.branch-misses
 2.404e+08            +1.6%  2.443e+08            +0.3%  2.411e+08        perf-stat.ps.cache-misses
 8.535e+08            -1.8%  8.385e+08 ±  2%      -0.2%  8.516e+08 ±  2%  perf-stat.ps.cache-references
   2321332 ±  3%     -38.5%    1427041            -1.4%    2289492 ±  5%  perf-stat.ps.context-switches
    143728            -0.0%     143706            +0.0%     143729        perf-stat.ps.cpu-clock
 4.652e+11            +0.1%  4.656e+11            +0.1%  4.655e+11        perf-stat.ps.cpu-cycles
    130273 ±  2%     -13.9%     112142            -2.4%     127191 ±  4%  perf-stat.ps.cpu-migrations
  16105899 ±  4%     -12.7%   14066449 ±  6%      +3.1%   16604020 ±  7%  perf-stat.ps.dTLB-load-misses
 2.372e+10            -1.7%  2.333e+10 ±  2%      -0.3%  2.365e+10 ±  2%  perf-stat.ps.dTLB-loads
   3896963 ±  9%     +28.8%    5017745 ±  8%      +3.7%    4041931 ± 12%  perf-stat.ps.dTLB-store-misses
 1.398e+10            -1.2%  1.381e+10 ±  2%      -0.3%  1.393e+10 ±  2%  perf-stat.ps.dTLB-stores
  55002135           -35.5%   35500351 ±  7%      -5.4%   52036263 ±  5%  perf-stat.ps.iTLB-load-misses
  22527807 ±  2%     -35.7%   14482551            -1.6%   22166418 ±  5%  perf-stat.ps.iTLB-loads
 8.258e+10            -3.3%  7.981e+10 ±  2%      -0.3%  8.233e+10 ±  2%  perf-stat.ps.instructions
     21.07 ±  3%     +14.9%      24.21 ±  3%      +3.9%      21.89 ± 11%  perf-stat.ps.major-faults
      5290            +9.8%       5808            -0.7%       5252 ±  2%  perf-stat.ps.minor-faults
  39359143            -4.2%   37711538            -0.1%   39304251        perf-stat.ps.node-load-misses
  21706088 ±  2%     +20.2%   26085952 ±  5%      -0.3%   21638055 ±  3%  perf-stat.ps.node-loads
  14624093           +12.3%   16426007 ±  2%      +0.6%   14717593 ±  4%  perf-stat.ps.node-store-misses
  21442585 ±  3%     +34.3%   28791155 ±  4%      +1.1%   21685868 ±  4%  perf-stat.ps.node-stores
      5311            +9.8%       5832            -0.7%       5273 ±  2%  perf-stat.ps.page-faults
    143728            -0.0%     143706            +0.0%     143729        perf-stat.ps.task-clock
 4.546e+13           -11.8%  4.011e+13            -0.1%  4.541e+13 ±  2%  perf-stat.total.instructions
     47657 ± 97%    +458.2%     266032 ± 98%    +210.2%     147808 ±177%  numa-meminfo.node0.Active
     47657 ± 97%    +458.2%     266032 ± 98%    +210.2%     147808 ±177%  numa-meminfo.node0.Active(anon)
    120967 ± 53%     -19.6%      97276 ± 52%     -28.5%      86531 ± 78%  numa-meminfo.node0.AnonHugePages
    296596 ± 42%     -18.7%     241083 ± 49%     -19.7%     238129 ± 49%  numa-meminfo.node0.AnonPages
    468129 ± 28%     -25.3%     349802 ± 41%     -19.5%     376771 ± 43%  numa-meminfo.node0.AnonPages.max
   2445748 ±  4%      +2.6%    2508824 ± 34%     -21.4%    1923397 ± 53%  numa-meminfo.node0.FilePages
    312534 ± 38%      +8.4%     338907 ± 49%      -8.2%     286768 ± 53%  numa-meminfo.node0.Inactive
    312534 ± 38%      +8.4%     338907 ± 49%      -8.2%     286768 ± 53%  numa-meminfo.node0.Inactive(anon)
     77156 ± 12%      -7.2%      71565 ± 24%     -12.0%      67863 ± 39%  numa-meminfo.node0.KReclaimable
     74240 ± 49%     -12.4%      65004 ± 64%      -9.7%      67025 ± 60%  numa-meminfo.node0.KernelStack
     60903 ± 22%     +70.7%     103964 ± 52%     +10.3%      67206 ± 68%  numa-meminfo.node0.Mapped
  12043117 ± 99%      +0.5%   12098621 ± 98%    +145.9%   29619941 ±  4%  numa-meminfo.node0.MemFree
  16117656 ± 72%      +0.0%   16117656 ± 72%    +102.5%   32632720        numa-meminfo.node0.MemTotal
   4074537 ± 13%      -1.4%    4019034 ± 23%     -26.1%    3012777 ± 42%  numa-meminfo.node0.MemUsed
      1227 ± 36%     -15.4%       1038 ± 51%     -18.3%       1003 ± 72%  numa-meminfo.node0.Mlocked
    155718 ± 53%     -14.8%     132673 ± 70%     -10.8%     138963 ± 64%  numa-meminfo.node0.PageTables
     77156 ± 12%      -7.2%      71565 ± 24%     -12.0%      67863 ± 39%  numa-meminfo.node0.SReclaimable
    290379 ± 32%      -7.0%     270066 ± 39%      -5.6%     274193 ± 37%  numa-meminfo.node0.SUnreclaim
     63799 ± 95%    +470.7%     364079 ± 98%    +208.3%     196714 ±171%  numa-meminfo.node0.Shmem
    367536 ± 28%      -7.0%     341631 ± 33%      -6.9%     342057 ± 35%  numa-meminfo.node0.Slab
   2382015 ±  4%     -10.0%    2144787 ± 31%     -27.5%    1726800 ± 60%  numa-meminfo.node0.Unevictable
     52928 ±236%    +128.7%     121042 ±171%     -70.8%      15437 ±185%  numa-meminfo.node1.Active
     52928 ±236%    +128.7%     121042 ±171%     -70.8%      15437 ±185%  numa-meminfo.node1.Active(anon)
      7420 ±247%    +205.0%      22632 ±148%    +259.5%      26675 ±160%  numa-meminfo.node1.AnonHugePages
     27898 ± 89%     +86.7%      52095 ± 75%    +200.2%      83738 ±122%  numa-meminfo.node1.AnonPages
     64171 ±136%    +141.7%     155132 ± 72%    +215.9%     202712 ± 74%  numa-meminfo.node1.AnonPages.max
    102114 ±185%     +74.0%     177649 ±169%      -8.5%      93448 ±119%  numa-meminfo.node1.FilePages
     57407 ±120%     +89.0%     108514 ±101%     +59.0%      91259 ±109%  numa-meminfo.node1.Inactive
     57407 ±120%     +89.0%     108514 ±101%     +59.0%      91259 ±109%  numa-meminfo.node1.Inactive(anon)
     23943 ± 50%     -10.9%      21341 ± 53%     +19.9%      28708 ± 32%  numa-meminfo.node1.KReclaimable
      5008 ±  7%     +44.9%       7259 ± 92%    +357.4%      22909 ±155%  numa-meminfo.node1.KernelStack
     39912 ± 78%     +44.5%      57692 ± 79%     -32.7%      26867 ± 26%  numa-meminfo.node1.Mapped
  15828867 ± 75%      -0.8%   15707015 ± 74%    +104.5%   32369002        numa-meminfo.node1.MemFree
  16507692 ± 70%      +0.0%   16507692 ± 70%    +100.0%   33022756        numa-meminfo.node1.MemTotal
    678823 ± 42%     +18.0%     800675 ± 39%      -3.7%     653752 ± 70%  numa-meminfo.node1.MemUsed
     81.44 ±150%    -100.0%       0.00           -25.8%      60.40 ±164%  numa-meminfo.node1.Mlocked
    442.67 ± 49%   +1367.5%       6496 ±258%   +9001.1%      40287 ±197%  numa-meminfo.node1.PageTables
     23943 ± 50%     -10.9%      21341 ± 53%     +19.9%      28708 ± 32%  numa-meminfo.node1.SReclaimable
    109026 ±  9%      +5.4%     114957 ± 16%     +44.5%     157536 ± 57%  numa-meminfo.node1.SUnreclaim
     82634 ±229%    +114.9%     177611 ±169%     -72.0%      23128 ±143%  numa-meminfo.node1.Shmem
    132970 ± 16%      +2.5%     136299 ± 17%     +40.1%     186245 ± 50%  numa-meminfo.node1.Slab
     19561 ±281%     -99.8%      38.67 ± 84%    +259.8%      70380 ±156%  numa-meminfo.node1.Unevictable
      3658 ± 76%    +513.2%      22438 ±226%     -70.5%       1078 ±126%  numa-meminfo.node2.Active
      3658 ± 76%    +513.2%      22438 ±226%     -70.5%       1078 ±126%  numa-meminfo.node2.Active(anon)
     33687 ±176%      +1.2%      34102 ±107%     +20.2%      40478 ±122%  numa-meminfo.node2.AnonHugePages
     78324 ±143%     +44.7%     113315 ± 74%      +6.5%      83425 ± 82%  numa-meminfo.node2.AnonPages
    160316 ± 99%     +35.4%     217099 ± 73%      -3.2%     155229 ± 69%  numa-meminfo.node2.AnonPages.max
     53077 ±175%    +514.4%     326126 ±206%   +1198.8%     689358 ±148%  numa-meminfo.node2.FilePages
     79374 ±141%     +50.9%     119813 ± 69%     +10.1%      87372 ± 82%  numa-meminfo.node2.Inactive
     79374 ±141%     +50.9%     119813 ± 69%     +10.1%      87372 ± 82%  numa-meminfo.node2.Inactive(anon)
     15435 ± 61%     +75.7%      27123 ± 57%     +90.3%      29368 ± 87%  numa-meminfo.node2.KReclaimable
     14430 ±190%    +120.9%      31874 ±121%      -3.8%      13880 ±190%  numa-meminfo.node2.KernelStack
     26905 ± 29%     +36.9%      36821 ± 30%     +12.7%      30332 ± 46%  numa-meminfo.node2.Mapped
  15781205 ± 75%      -2.9%   15318900 ± 78%    +101.8%   31847819 ±  3%  numa-meminfo.node2.MemFree
  16507690 ± 70%      +0.0%   16507690 ± 70%    +100.0%   33022760        numa-meminfo.node2.MemTotal
    726483 ± 63%     +63.6%    1188789 ± 63%     +61.7%    1174939 ±101%  numa-meminfo.node2.MemUsed
     16.11 ±282%    +794.5%     144.11 ±163%   +1519.4%     260.90 ±152%  numa-meminfo.node2.Mlocked
     21971 ±278%    +182.9%      62149 ±142%     -10.7%      19613 ±292%  numa-meminfo.node2.PageTables
     15435 ± 61%     +75.7%      27123 ± 57%     +90.3%      29368 ± 87%  numa-meminfo.node2.SReclaimable
    123517 ± 60%     +41.3%     174552 ± 58%      +2.5%     126578 ± 59%  numa-meminfo.node2.SUnreclaim
      4822 ± 56%    +504.6%      29154 ±218%      +6.7%       5143 ±162%  numa-meminfo.node2.Shmem
    138953 ± 58%     +45.1%     201677 ± 56%     +12.2%     155947 ± 62%  numa-meminfo.node2.Slab
     48270 ±192%    +515.3%     297032 ±230%   +1317.5%     684214 ±149%  numa-meminfo.node2.Unevictable
    855975 ± 12%     -20.3%     682366 ± 21%      -1.6%     842275 ± 29%  numa-meminfo.node3.Active
    855975 ± 12%     -20.3%     682366 ± 21%      -1.6%     842275 ± 29%  numa-meminfo.node3.Active(anon)
     32856 ±180%     +56.3%      51347 ± 90%     +30.5%      42862 ± 93%  numa-meminfo.node3.AnonHugePages
     71537 ±144%      +9.7%      78500 ± 65%     -10.6%      63940 ± 73%  numa-meminfo.node3.AnonPages
    128788 ± 92%     +26.9%     163477 ± 48%     -14.8%     109743 ± 52%  numa-meminfo.node3.AnonPages.max
   1080901 ± 11%     -15.9%     908748 ± 21%      -9.3%     980394 ± 28%  numa-meminfo.node3.FilePages
    266438 ± 42%      -0.1%     266077 ± 23%     -24.1%     202278 ± 40%  numa-meminfo.node3.Inactive
    266438 ± 42%      -0.1%     266077 ± 23%     -24.1%     202278 ± 40%  numa-meminfo.node3.Inactive(anon)
     39114 ± 37%     -12.0%      34434 ± 32%     -23.1%      30085 ± 26%  numa-meminfo.node3.KReclaimable
     14563 ±190%     -65.8%       4980 ±  4%     -65.2%       5061 ±  8%  numa-meminfo.node3.KernelStack
    162862 ± 22%      +2.3%     166600 ± 12%     -27.5%     118014 ± 38%  numa-meminfo.node3.Mapped
  25877064 ± 14%      +0.9%   26100691 ± 15%     +22.1%   31590087        numa-meminfo.node3.MemFree
  27472521 ± 14%      +0.0%   27472521 ± 14%     +20.0%   32977548        numa-meminfo.node3.MemTotal
   1595455 ± 25%     -14.0%    1371829 ± 15%     -13.0%    1387459 ± 21%  numa-meminfo.node3.MemUsed
     32.56 ±187%    +146.4%      80.22 ±151%     -53.9%      15.00 ±300%  numa-meminfo.node3.Mlocked
     22575 ±274%     -96.0%     907.44 ± 25%     -97.5%     561.10 ± 50%  numa-meminfo.node3.PageTables
     39114 ± 37%     -12.0%      34434 ± 32%     -23.1%      30085 ± 26%  numa-meminfo.node3.SReclaimable
    134418 ± 58%     -14.1%     115495 ±  9%     -21.3%     105772 ±  9%  numa-meminfo.node3.SUnreclaim
   1050808 ±  7%     -17.2%     869739 ± 17%      -6.7%     980079 ± 28%  numa-meminfo.node3.Shmem
    173533 ± 52%     -13.6%     149930 ± 14%     -21.7%     135858 ± 12%  numa-meminfo.node3.Slab
     30125 ±274%     +29.8%      39089 ±184%     -98.9%     329.90 ±145%  numa-meminfo.node3.Unevictable
     12006 ± 97%    +462.2%      67502 ± 98%    +205.4%      36672 ±177%  numa-vmstat.node0.nr_active_anon
     73951 ± 42%     -18.6%      60172 ± 49%     -19.5%      59555 ± 49%  numa-vmstat.node0.nr_anon_pages
     58.67 ± 53%     -19.9%      47.00 ± 53%     -28.8%      41.80 ± 79%  numa-vmstat.node0.nr_anon_transparent_hugepages
    611469 ±  4%      +2.7%     628193 ± 34%     -21.4%     480632 ± 53%  numa-vmstat.node0.nr_file_pages
   3011229 ± 99%      +0.4%    3023948 ± 98%    +145.9%    7405070 ±  4%  numa-vmstat.node0.nr_free_pages
     77876 ± 38%      +8.7%      84620 ± 49%      -7.8%      71780 ± 54%  numa-vmstat.node0.nr_inactive_anon
      5.11 ± 62%     -23.9%       3.89 ± 74%     -21.7%       4.00 ± 72%  numa-vmstat.node0.nr_isolated_anon
     74088 ± 49%     -12.3%      64963 ± 64%      -9.6%      66986 ± 60%  numa-vmstat.node0.nr_kernel_stack
     15198 ± 21%     +70.9%      25970 ± 52%     +10.9%      16854 ± 69%  numa-vmstat.node0.nr_mapped
    307.89 ± 36%     -15.3%     260.89 ± 50%     -18.6%     250.60 ± 72%  numa-vmstat.node0.nr_mlock
     38850 ± 53%     -14.7%      33152 ± 70%     -10.7%      34698 ± 64%  numa-vmstat.node0.nr_page_table_pages
     15982 ± 95%    +475.7%      92006 ± 98%    +206.4%      48962 ±171%  numa-vmstat.node0.nr_shmem
     19286 ± 12%      -7.2%      17894 ± 24%     -12.0%      16965 ± 39%  numa-vmstat.node0.nr_slab_reclaimable
     72509 ± 32%      -6.9%      67515 ± 39%      -5.6%      68457 ± 37%  numa-vmstat.node0.nr_slab_unreclaimable
    595503 ±  4%     -10.0%     536196 ± 31%     -27.5%     431700 ± 60%  numa-vmstat.node0.nr_unevictable
     12006 ± 97%    +462.2%      67502 ± 98%    +205.4%      36672 ±177%  numa-vmstat.node0.nr_zone_active_anon
     77876 ± 38%      +8.7%      84620 ± 49%      -7.8%      71780 ± 54%  numa-vmstat.node0.nr_zone_inactive_anon
    595503 ±  4%     -10.0%     536196 ± 31%     -27.5%     431700 ± 60%  numa-vmstat.node0.nr_zone_unevictable
   1848553 ± 25%      -2.6%    1800789 ± 26%      -6.1%    1736589 ± 33%  numa-vmstat.node0.numa_hit
     12562 ±  2%      -1.0%      12433            +0.3%      12603        numa-vmstat.node0.numa_interleave
   1809182 ± 26%      -3.1%    1752906 ± 28%      -5.8%    1704673 ± 34%  numa-vmstat.node0.numa_local
     39412 ± 55%     +21.6%      47920 ± 51%     -18.9%      31944 ± 53%  numa-vmstat.node0.numa_other
     13589 ±237%    +121.9%      30159 ±171%     -71.4%       3891 ±186%  numa-vmstat.node1.nr_active_anon
      6976 ± 89%     +85.2%      12919 ± 76%    +199.4%      20886 ±123%  numa-vmstat.node1.nr_anon_pages
      3.33 ±261%    +220.0%      10.67 ±153%    +281.0%      12.70 ±163%  numa-vmstat.node1.nr_anon_transparent_hugepages
     25604 ±185%     +73.4%      44387 ±168%      -8.6%      23390 ±118%  numa-vmstat.node1.nr_file_pages
   3957253 ± 75%      -0.8%    3927252 ± 74%    +104.5%    8092068        numa-vmstat.node1.nr_free_pages
     14072 ±117%     +92.6%      27098 ±101%     +61.8%      22763 ±110%  numa-vmstat.node1.nr_inactive_anon
      0.00       +2.2e+101%       0.22 ±187%   +6e+101%       0.60 ±200%  numa-vmstat.node1.nr_isolated_anon
      5008 ±  7%     +42.8%       7150 ± 90%    +357.0%      22886 ±155%  numa-vmstat.node1.nr_kernel_stack
      9815 ± 73%     +47.0%      14427 ± 80%     -31.6%       6712 ± 26%  numa-vmstat.node1.nr_mapped
     20.44 ±150%    -100.0%       0.00           -27.6%      14.80 ±165%  numa-vmstat.node1.nr_mlock
    110.33 ± 49%   +1310.2%       1555 ±257%   +9013.8%      10055 ±197%  numa-vmstat.node1.nr_page_table_pages
     20734 ±229%    +114.0%      44377 ±168%     -72.0%       5810 ±143%  numa-vmstat.node1.nr_shmem
      5987 ± 50%     -11.2%       5318 ± 53%     +19.9%       7177 ± 32%  numa-vmstat.node1.nr_slab_reclaimable
     27236 ±  9%      +5.3%      28679 ± 16%     +44.4%      39332 ± 57%  numa-vmstat.node1.nr_slab_unreclaimable
      4890 ±281%     -99.8%       9.33 ± 84%    +259.8%      17594 ±156%  numa-vmstat.node1.nr_unevictable
     13589 ±237%    +121.9%      30159 ±171%     -71.4%       3891 ±186%  numa-vmstat.node1.nr_zone_active_anon
     14072 ±117%     +92.6%      27098 ±101%     +61.8%      22763 ±110%  numa-vmstat.node1.nr_zone_inactive_anon
      4890 ±281%     -99.8%       9.33 ± 84%    +259.8%      17594 ±156%  numa-vmstat.node1.nr_zone_unevictable
    632542 ± 24%      -8.7%     577346 ± 24%     +35.5%     857049 ± 44%  numa-vmstat.node1.numa_hit
     12406 ±  2%      +1.0%      12533            +1.4%      12577        numa-vmstat.node1.numa_interleave
    558214 ± 28%     -10.4%     500246 ± 28%     +40.1%     782013 ± 49%  numa-vmstat.node1.numa_local
     74329 ± 21%      +3.7%      77102 ± 14%      +1.6%      75492 ± 12%  numa-vmstat.node1.numa_other
    917.33 ± 75%    +529.2%       5771 ±228%     -70.7%     268.70 ±126%  numa-vmstat.node2.nr_active_anon
     19580 ±143%     +44.6%      28315 ± 75%      +6.2%      20788 ± 83%  numa-vmstat.node2.nr_anon_pages
     16.22 ±178%      +0.7%      16.33 ±109%     +19.6%      19.40 ±124%  numa-vmstat.node2.nr_anon_transparent_hugepages
     13272 ±175%    +515.4%      81676 ±206%   +1198.5%     172338 ±148%  numa-vmstat.node2.nr_file_pages
   3945408 ± 75%      -2.9%    3829644 ± 78%    +101.8%    7961885 ±  3%  numa-vmstat.node2.nr_free_pages
     19841 ±141%     +50.8%      29924 ± 69%      +9.8%      21775 ± 82%  numa-vmstat.node2.nr_inactive_anon
      0.22 ±282%    +450.0%       1.22 ±126%    +125.0%       0.50 ±300%  numa-vmstat.node2.nr_isolated_anon
     14415 ±190%    +121.5%      31931 ±121%      -4.0%      13840 ±190%  numa-vmstat.node2.nr_kernel_stack
      6716 ± 28%     +36.4%       9163 ± 30%     +12.7%       7571 ± 45%  numa-vmstat.node2.nr_mapped
      4.00 ±282%    +788.9%      35.56 ±163%   +1527.5%      65.10 ±152%  numa-vmstat.node2.nr_mlock
      5483 ±278%    +184.1%      15575 ±142%     -11.0%       4882 ±292%  numa-vmstat.node2.nr_page_table_pages
      1208 ± 56%    +515.1%       7432 ±219%      +6.3%       1284 ±162%  numa-vmstat.node2.nr_shmem
      3862 ± 61%     +75.5%       6778 ± 57%     +90.0%       7340 ± 87%  numa-vmstat.node2.nr_slab_reclaimable
     30865 ± 60%     +41.3%      43627 ± 58%      +2.3%      31587 ± 59%  numa-vmstat.node2.nr_slab_unreclaimable
     12067 ±192%    +515.3%      74257 ±230%   +1317.5%     171053 ±149%  numa-vmstat.node2.nr_unevictable
    917.33 ± 75%    +529.2%       5771 ±228%     -70.7%     268.70 ±126%  numa-vmstat.node2.nr_zone_active_anon
     19841 ±141%     +50.8%      29925 ± 69%      +9.7%      21775 ± 82%  numa-vmstat.node2.nr_zone_inactive_anon
     12067 ±192%    +515.3%      74257 ±230%   +1317.5%     171053 ±149%  numa-vmstat.node2.nr_zone_unevictable
    649296 ± 60%     +37.9%     895335 ± 51%     +25.4%     814381 ± 50%  numa-vmstat.node2.numa_hit
     12562 ±  2%      -1.0%      12441            +0.3%      12601        numa-vmstat.node2.numa_interleave
    573521 ± 70%     +45.4%     834037 ± 57%     +29.9%     744884 ± 55%  numa-vmstat.node2.numa_local
     75775 ± 19%     -19.1%      61305 ± 40%      -8.3%      69489 ± 24%  numa-vmstat.node2.numa_other
    214329 ± 11%     -20.2%     171128 ± 20%      -2.4%     209087 ± 29%  numa-vmstat.node3.nr_active_anon
     17902 ±144%      +9.9%      19667 ± 64%     -10.7%      15992 ± 73%  numa-vmstat.node3.nr_anon_pages
     15.67 ±185%     +58.2%      24.78 ± 91%     +30.2%      20.40 ± 96%  numa-vmstat.node3.nr_anon_transparent_hugepages
    270595 ± 10%     -16.0%     227386 ± 20%     -10.0%     243571 ± 28%  numa-vmstat.node3.nr_file_pages
   6469018 ± 14%      +0.9%    6525092 ± 15%     +22.1%    7898786        numa-vmstat.node3.nr_free_pages
     66661 ± 41%      -0.7%      66225 ± 22%     -24.2%      50530 ± 40%  numa-vmstat.node3.nr_inactive_anon
      0.56 ±282%    -100.0%       0.00           -82.0%       0.10 ±300%  numa-vmstat.node3.nr_isolated_anon
     14545 ±190%     -65.8%       4978 ±  4%     -65.2%       5061 ±  8%  numa-vmstat.node3.nr_kernel_stack
     40475 ± 20%      +2.1%      41319 ± 13%     -27.9%      29198 ± 38%  numa-vmstat.node3.nr_mapped
      8.11 ±187%    +147.9%      20.11 ±150%     -55.6%       3.60 ±300%  numa-vmstat.node3.nr_mlock
      5634 ±274%     -96.0%     224.78 ± 25%     -97.5%     140.20 ± 50%  numa-vmstat.node3.nr_page_table_pages
    263072 ±  7%     -17.3%     217634 ± 17%      -7.4%     243492 ± 28%  numa-vmstat.node3.nr_shmem
      9780 ± 37%     -11.9%       8619 ± 32%     -23.1%       7518 ± 26%  numa-vmstat.node3.nr_slab_reclaimable
     33577 ± 58%     -14.1%      28845 ±  8%     -21.3%      26418 ±  9%  numa-vmstat.node3.nr_slab_unreclaimable
      7531 ±274%     +29.8%       9772 ±184%     -98.9%      82.20 ±146%  numa-vmstat.node3.nr_unevictable
    214329 ± 11%     -20.2%     171128 ± 20%      -2.4%     209086 ± 29%  numa-vmstat.node3.nr_zone_active_anon
     66661 ± 41%      -0.7%      66225 ± 22%     -24.2%      50530 ± 40%  numa-vmstat.node3.nr_zone_inactive_anon
      7531 ±274%     +29.8%       9772 ±184%     -98.9%      82.20 ±146%  numa-vmstat.node3.nr_zone_unevictable
    986837 ± 49%      -8.9%     899223 ± 26%     -21.9%     770811 ± 15%  numa-vmstat.node3.numa_hit
     12404 ±  2%      +1.0%      12529            +1.4%      12574        numa-vmstat.node3.numa_interleave
    918845 ± 54%      -9.9%     827518 ± 29%     -24.9%     690018 ± 17%  numa-vmstat.node3.numa_local
     67991 ± 35%      +5.5%      71699 ± 23%     +18.8%      80792 ±  9%  numa-vmstat.node3.numa_other
    784208            -0.0%     784167            -0.0%     784111        slabinfo.Acpi-Operand.active_objs
     14003            -0.0%      14003            -0.0%      14002        slabinfo.Acpi-Operand.active_slabs
    784211            -0.0%     784168            -0.0%     784112        slabinfo.Acpi-Operand.num_objs
     14003            -0.0%      14003            -0.0%      14002        slabinfo.Acpi-Operand.num_slabs
      1589 ± 12%      +1.0%       1606 ± 12%     -10.9%       1416 ±  6%  slabinfo.Acpi-Parse.active_objs
     21.78 ± 12%      +1.0%      22.00 ± 12%     -10.9%      19.40 ±  6%  slabinfo.Acpi-Parse.active_slabs
      1589 ± 12%      +1.0%       1606 ± 12%     -10.9%       1416 ±  6%  slabinfo.Acpi-Parse.num_objs
     21.78 ± 12%      +1.0%      22.00 ± 12%     -10.9%      19.40 ±  6%  slabinfo.Acpi-Parse.num_slabs
    453.33 ±  8%      +2.5%     464.67 ±  8%      -6.6%     423.30 ± 16%  slabinfo.Acpi-State.active_objs
      8.89 ±  8%      +2.5%       9.11 ±  8%      -6.6%       8.30 ± 16%  slabinfo.Acpi-State.active_slabs
    453.33 ±  8%      +2.5%     464.67 ±  8%      -6.6%     423.30 ± 16%  slabinfo.Acpi-State.num_objs
      8.89 ±  8%      +2.5%       9.11 ±  8%      -6.6%       8.30 ± 16%  slabinfo.Acpi-State.num_slabs
     18.00            +0.0%      18.00            +0.0%      18.00        slabinfo.DCCP.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.DCCP.active_slabs
     18.00            +0.0%      18.00            +0.0%      18.00        slabinfo.DCCP.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.DCCP.num_slabs
     17.00            +0.0%      17.00            +0.0%      17.00        slabinfo.DCCPv6.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.DCCPv6.active_slabs
     17.00            +0.0%      17.00            +0.0%      17.00        slabinfo.DCCPv6.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.DCCPv6.num_slabs
    291.56 ±  3%      -1.2%     288.00            -0.1%     291.20 ±  3%  slabinfo.RAW.active_objs
      9.11 ±  3%      -1.2%       9.00            -0.1%       9.10 ±  3%  slabinfo.RAW.active_slabs
    291.56 ±  3%      -1.2%     288.00            -0.1%     291.20 ±  3%  slabinfo.RAW.num_objs
      9.11 ±  3%      -1.2%       9.00            -0.1%       9.10 ±  3%  slabinfo.RAW.num_slabs
    156.00            +0.0%     156.00            +0.0%     156.00        slabinfo.RAWv6.active_objs
      6.00            +0.0%       6.00            +0.0%       6.00        slabinfo.RAWv6.active_slabs
    156.00            +0.0%     156.00            +0.0%     156.00        slabinfo.RAWv6.num_objs
      6.00            +0.0%       6.00            +0.0%       6.00        slabinfo.RAWv6.num_slabs
     54.44 ±  8%      +2.9%      56.00            +2.9%      56.00        slabinfo.TCP.active_objs
      3.89 ±  8%      +2.9%       4.00            +2.9%       4.00        slabinfo.TCP.active_slabs
     54.44 ±  8%      +2.9%      56.00            +2.9%      56.00        slabinfo.TCP.num_objs
      3.89 ±  8%      +2.9%       4.00            +2.9%       4.00        slabinfo.TCP.num_slabs
     39.00            +0.0%      39.00            +0.0%      39.00        slabinfo.TCPv6.active_objs
      3.00            +0.0%       3.00            +0.0%       3.00        slabinfo.TCPv6.active_slabs
     39.00            +0.0%      39.00            +0.0%      39.00        slabinfo.TCPv6.num_objs
      3.00            +0.0%       3.00            +0.0%       3.00        slabinfo.TCPv6.num_slabs
    159.67 ±  9%      +0.9%     161.11 ±  9%      -3.6%     153.90 ± 13%  slabinfo.UDPv6.active_objs
      6.11 ± 12%      -1.8%       6.00 ± 11%      -6.7%       5.70 ± 17%  slabinfo.UDPv6.active_slabs
    159.67 ±  9%      +0.9%     161.11 ±  9%      -3.6%     153.90 ± 13%  slabinfo.UDPv6.num_objs
      6.11 ± 12%      -1.8%       6.00 ± 11%      -6.7%       5.70 ± 17%  slabinfo.UDPv6.num_slabs
     10891 ±  3%      +3.2%      11234 ±  4%      -0.1%      10885 ±  3%  slabinfo.UNIX.active_objs
    364.00 ±  3%      +3.1%     375.44 ±  4%      -0.1%     363.60 ±  3%  slabinfo.UNIX.active_slabs
     10932 ±  3%      +3.2%      11278 ±  4%      -0.1%      10924 ±  3%  slabinfo.UNIX.num_objs
    364.00 ±  3%      +3.1%     375.44 ±  4%      -0.1%     363.60 ±  3%  slabinfo.UNIX.num_slabs
    119995            +0.4%     120457            +0.2%     120179        slabinfo.anon_vma.active_objs
      2619            +0.4%       2630            +0.1%       2622        slabinfo.anon_vma.active_slabs
    120501            +0.4%     121002            +0.1%     120680        slabinfo.anon_vma.num_objs
      2619            +0.4%       2630            +0.1%       2622        slabinfo.anon_vma.num_slabs
    221372            +0.6%     222730            +0.2%     221729        slabinfo.anon_vma_chain.active_objs
      3477            +0.6%       3498            +0.2%       3483        slabinfo.anon_vma_chain.active_slabs
    222595            +0.6%     223976            +0.2%     222987        slabinfo.anon_vma_chain.num_objs
      3477            +0.6%       3498            +0.2%       3483        slabinfo.anon_vma_chain.num_slabs
     65.33 ± 31%     +10.7%      72.33 ± 30%     -29.3%      46.20 ± 18%  slabinfo.bdev_cache.active_objs
      3.11 ± 31%     +10.7%       3.44 ± 30%     -29.3%       2.20 ± 18%  slabinfo.bdev_cache.active_slabs
     65.33 ± 31%     +10.7%      72.33 ± 30%     -29.3%      46.20 ± 18%  slabinfo.bdev_cache.num_objs
      3.11 ± 31%     +10.7%       3.44 ± 30%     -29.3%       2.20 ± 18%  slabinfo.bdev_cache.num_slabs
     17.78 ± 28%     +10.0%      19.56 ± 34%     +17.0%      20.80 ± 35%  slabinfo.biovec-128.active_objs
      1.11 ± 28%     +10.0%       1.22 ± 34%     +17.0%       1.30 ± 35%  slabinfo.biovec-128.active_slabs
     17.78 ± 28%     +10.0%      19.56 ± 34%     +17.0%      20.80 ± 35%  slabinfo.biovec-128.num_objs
      1.11 ± 28%     +10.0%       1.22 ± 34%     +17.0%       1.30 ± 35%  slabinfo.biovec-128.num_slabs
    280.89 ± 21%      -7.6%     259.56 ± 12%      +1.4%     284.80 ± 19%  slabinfo.biovec-64.active_objs
      8.78 ± 21%      -7.6%       8.11 ± 12%      +1.4%       8.90 ± 19%  slabinfo.biovec-64.active_slabs
    280.89 ± 21%      -7.6%     259.56 ± 12%      +1.4%     284.80 ± 19%  slabinfo.biovec-64.num_objs
      8.78 ± 21%      -7.6%       8.11 ± 12%      +1.4%       8.90 ± 19%  slabinfo.biovec-64.num_slabs
     56.00            -1.6%      55.11 ±  4%     +17.1%      65.60 ±  4%  slabinfo.biovec-max.active_objs
      7.00            -1.6%       6.89 ±  4%     +17.1%       8.20 ±  4%  slabinfo.biovec-max.active_slabs
     56.00            -1.6%      55.11 ±  4%     +17.1%      65.60 ±  4%  slabinfo.biovec-max.num_objs
      7.00            -1.6%       6.89 ±  4%     +17.1%       8.20 ±  4%  slabinfo.biovec-max.num_slabs
      0.00          -100.0%       0.00       +3.8e+103%      38.00        slabinfo.btrfs_ordered_extent.active_objs
      0.00          -100.0%       0.00         +1e+102%       1.00        slabinfo.btrfs_ordered_extent.active_slabs
      0.00          -100.0%       0.00       +3.8e+103%      38.00        slabinfo.btrfs_ordered_extent.num_objs
      0.00          -100.0%       0.00         +1e+102%       1.00        slabinfo.btrfs_ordered_extent.num_slabs
     78.00 ± 47%     +27.8%      99.67 ± 45%      +0.0%      78.00        slabinfo.buffer_head.active_objs
      2.00 ± 47%     +27.8%       2.56 ± 45%      +0.0%       2.00        slabinfo.buffer_head.active_slabs
     78.00 ± 47%     +27.8%      99.67 ± 45%      +0.0%      78.00        slabinfo.buffer_head.num_objs
      2.00 ± 47%     +27.8%       2.56 ± 45%      +0.0%       2.00        slabinfo.buffer_head.num_slabs
     19059            +2.6%      19548 ±  3%      +1.3%      19302 ±  2%  slabinfo.cred_jar.active_objs
    457.33 ±  2%      +2.6%     469.44 ±  3%      +1.3%     463.50 ±  2%  slabinfo.cred_jar.active_slabs
     19227 ±  2%      +2.6%      19732 ±  3%      +1.4%      19495 ±  2%  slabinfo.cred_jar.num_objs
    457.33 ±  2%      +2.6%     469.44 ±  3%      +1.3%     463.50 ±  2%  slabinfo.cred_jar.num_slabs
     78.00 ± 47%     +22.2%      95.33 ± 51%     -50.0%      39.00        slabinfo.dax_cache.active_objs
      2.00 ± 47%     +22.2%       2.44 ± 51%     -50.0%       1.00        slabinfo.dax_cache.active_slabs
     78.00 ± 47%     +22.2%      95.33 ± 51%     -50.0%      39.00        slabinfo.dax_cache.num_objs
      2.00 ± 47%     +22.2%       2.44 ± 51%     -50.0%       1.00        slabinfo.dax_cache.num_slabs
    149386            -0.8%     148229            +0.2%     149758        slabinfo.dentry.active_objs
      3847            -2.1%       3764 ±  2%      +0.6%       3869        slabinfo.dentry.active_slabs
    161591            -2.1%     158152 ±  2%      +0.6%     162550        slabinfo.dentry.num_objs
      3847            -2.1%       3764 ±  2%      +0.6%       3869        slabinfo.dentry.num_slabs
     30.00            +0.0%      30.00            +0.0%      30.00        slabinfo.dmaengine-unmap-128.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-128.active_slabs
     30.00            +0.0%      30.00            +0.0%      30.00        slabinfo.dmaengine-unmap-128.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-128.num_slabs
      1429 ± 19%      -8.5%       1307 ± 11%      -8.6%       1306 ± 14%  slabinfo.dmaengine-unmap-16.active_objs
     33.44 ± 19%      -7.3%      31.00 ± 11%      -8.8%      30.50 ± 14%  slabinfo.dmaengine-unmap-16.active_slabs
      1431 ± 19%      -7.7%       1320 ± 12%      -8.7%       1306 ± 14%  slabinfo.dmaengine-unmap-16.num_objs
     33.44 ± 19%      -7.3%      31.00 ± 11%      -8.8%      30.50 ± 14%  slabinfo.dmaengine-unmap-16.num_slabs
     15.00            +0.0%      15.00            +0.0%      15.00        slabinfo.dmaengine-unmap-256.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-256.active_slabs
     15.00            +0.0%      15.00            +0.0%      15.00        slabinfo.dmaengine-unmap-256.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-256.num_slabs
     25911 ± 13%     +19.6%      30992 ± 12%      +4.7%      27132 ± 28%  slabinfo.ep_head.active_objs
    100.78 ± 13%     +19.6%     120.56 ± 12%      +4.8%     105.60 ± 29%  slabinfo.ep_head.active_slabs
     25911 ± 13%     +19.6%      30992 ± 12%      +4.7%      27132 ± 28%  slabinfo.ep_head.num_objs
    100.78 ± 13%     +19.6%     120.56 ± 12%      +4.8%     105.60 ± 29%  slabinfo.ep_head.num_slabs
      1192 ± 11%      +9.5%       1305 ± 10%      -4.2%       1142 ± 10%  slabinfo.file_lock_cache.active_objs
     31.89 ± 11%      +9.4%      34.89 ± 11%      -4.7%      30.40 ± 10%  slabinfo.file_lock_cache.active_slabs
      1192 ± 11%      +9.5%       1305 ± 10%      -4.2%       1142 ± 10%  slabinfo.file_lock_cache.num_objs
     31.89 ± 11%      +9.4%      34.89 ± 11%      -4.7%      30.40 ± 10%  slabinfo.file_lock_cache.num_slabs
     16896 ±  2%      -2.1%      16545 ±  2%      -0.6%      16792 ±  4%  slabinfo.files_cache.active_objs
    368.22 ±  2%      -2.0%     360.78 ±  2%      -0.5%     366.20 ±  4%  slabinfo.files_cache.active_slabs
     16960 ±  2%      -2.0%      16621 ±  2%      -0.5%      16868 ±  4%  slabinfo.files_cache.num_objs
    368.22 ±  2%      -2.0%     360.78 ±  2%      -0.5%     366.20 ±  4%  slabinfo.files_cache.num_slabs
     30601            -0.1%      30579            -0.7%      30372        slabinfo.filp.active_objs
    490.67            -0.0%     490.44            -0.7%     487.10        slabinfo.filp.active_slabs
     31418            -0.0%      31408            -0.7%      31198        slabinfo.filp.num_objs
    490.67            -0.0%     490.44            -0.7%     487.10        slabinfo.filp.num_slabs
      3145 ±  6%      +4.1%       3273 ± 10%     -13.4%       2722 ± 10%  slabinfo.fsnotify_mark_connector.active_objs
     24.22 ±  7%      +4.1%      25.22 ± 10%     -14.1%      20.80 ± 11%  slabinfo.fsnotify_mark_connector.active_slabs
      3145 ±  6%      +4.1%       3273 ± 10%     -13.4%       2722 ± 10%  slabinfo.fsnotify_mark_connector.num_objs
     24.22 ±  7%      +4.1%      25.22 ± 10%     -14.1%      20.80 ± 11%  slabinfo.fsnotify_mark_connector.num_slabs
     82903            -0.0%      82893            +0.3%      83155        slabinfo.ftrace_event_field.active_objs
    975.33            -0.0%     975.22            +0.3%     978.30        slabinfo.ftrace_event_field.active_slabs
     82903            -0.0%      82893            +0.3%      83155        slabinfo.ftrace_event_field.num_objs
    975.33            -0.0%     975.22            +0.3%     978.30        slabinfo.ftrace_event_field.num_slabs
     98.00            +0.0%      98.00            +0.0%      98.00        slabinfo.hugetlbfs_inode_cache.active_objs
      2.00            +0.0%       2.00            +0.0%       2.00        slabinfo.hugetlbfs_inode_cache.active_slabs
     98.00            +0.0%      98.00            +0.0%      98.00        slabinfo.hugetlbfs_inode_cache.num_objs
      2.00            +0.0%       2.00            +0.0%       2.00        slabinfo.hugetlbfs_inode_cache.num_slabs
    105449            +0.1%     105526            +0.4%     105856        slabinfo.inode_cache.active_objs
      2072            +0.1%       2074            +0.4%       2081        slabinfo.inode_cache.active_slabs
    105731            +0.1%     105810            +0.4%     106169        slabinfo.inode_cache.num_objs
      2072            +0.1%       2074            +0.4%       2081        slabinfo.inode_cache.num_slabs
     44.00            +0.0%      44.00            +0.0%      44.00        slabinfo.ip6-frags.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.ip6-frags.active_slabs
     44.00            +0.0%      44.00            +0.0%      44.00        slabinfo.ip6-frags.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.ip6-frags.num_slabs
     73.00            +0.0%      73.00           +10.0%      80.30 ± 27%  slabinfo.ip_fib_alias.active_objs
      1.00            +0.0%       1.00           +10.0%       1.10 ± 27%  slabinfo.ip_fib_alias.active_slabs
     73.00            +0.0%      73.00           +10.0%      80.30 ± 27%  slabinfo.ip_fib_alias.num_objs
      1.00            +0.0%       1.00           +10.0%       1.10 ± 27%  slabinfo.ip_fib_alias.num_slabs
     85.00            +0.0%      85.00           +10.0%      93.50 ± 27%  slabinfo.ip_fib_trie.active_objs
      1.00            +0.0%       1.00           +10.0%       1.10 ± 27%  slabinfo.ip_fib_trie.active_slabs
     85.00            +0.0%      85.00           +10.0%      93.50 ± 27%  slabinfo.ip_fib_trie.num_objs
      1.00            +0.0%       1.00           +10.0%       1.10 ± 27%  slabinfo.ip_fib_trie.num_slabs
    141510            -0.0%     141474            +0.0%     141569        slabinfo.kernfs_node_cache.active_objs
      2210            -0.0%       2209            +0.0%       2211        slabinfo.kernfs_node_cache.active_slabs
    141510            -0.0%     141474            +0.0%     141579        slabinfo.kernfs_node_cache.num_objs
      2210            -0.0%       2209            +0.0%       2211        slabinfo.kernfs_node_cache.num_slabs
      1623 ± 20%     +11.1%       1803 ± 20%      +2.1%       1656 ± 15%  slabinfo.khugepaged_mm_slot.active_objs
     44.33 ± 20%     +11.5%      49.44 ± 21%      +2.0%      45.20 ± 15%  slabinfo.khugepaged_mm_slot.active_slabs
      1623 ± 20%     +11.1%       1803 ± 20%      +2.1%       1656 ± 15%  slabinfo.khugepaged_mm_slot.num_objs
     44.33 ± 20%     +11.5%      49.44 ± 21%      +2.0%      45.20 ± 15%  slabinfo.khugepaged_mm_slot.num_slabs
     12015            +0.3%      12048            -0.3%      11981        slabinfo.kmalloc-128.active_objs
    189.22            +0.3%     189.78            -0.2%     188.80        slabinfo.kmalloc-128.active_slabs
     12147            +0.2%      12174            -0.2%      12128        slabinfo.kmalloc-128.num_objs
    189.22            +0.3%     189.78            -0.2%     188.80        slabinfo.kmalloc-128.num_slabs
     66767            +0.2%      66916            +0.5%      67070        slabinfo.kmalloc-16.active_objs
    261.78            +0.1%     262.00            +0.4%     262.90        slabinfo.kmalloc-16.active_slabs
     67127            +0.1%      67211            +0.4%      67419        slabinfo.kmalloc-16.num_objs
    261.78            +0.1%     262.00            +0.4%     262.90        slabinfo.kmalloc-16.num_slabs
     10489            +0.0%      10489            +0.3%      10524        slabinfo.kmalloc-192.active_objs
    255.22            +0.1%     255.56            +0.2%     255.70        slabinfo.kmalloc-192.active_slabs
     10733            +0.0%      10737            +0.1%      10739        slabinfo.kmalloc-192.num_objs
    255.22            +0.1%     255.56            +0.2%     255.70        slabinfo.kmalloc-192.num_slabs
      7200            +1.0%       7271            -0.1%       7192        slabinfo.kmalloc-1k.active_objs
    227.78            +0.6%     229.22            -0.3%     227.10        slabinfo.kmalloc-1k.active_slabs
      7305            +0.7%       7354            -0.3%       7283        slabinfo.kmalloc-1k.num_objs
    227.78            +0.6%     229.22            -0.3%     227.10        slabinfo.kmalloc-1k.num_slabs
     17105            -0.1%      17081            +0.2%      17146        slabinfo.kmalloc-256.active_objs
    269.44            -0.3%     268.67            +0.2%     269.90        slabinfo.kmalloc-256.active_slabs
     17270            -0.3%      17226            +0.2%      17308        slabinfo.kmalloc-256.num_objs
    269.44            -0.3%     268.67            +0.2%     269.90        slabinfo.kmalloc-256.num_slabs
      7177 ±  2%      +1.5%       7283 ±  2%      -0.7%       7128        slabinfo.kmalloc-2k.active_objs
    461.22 ±  2%      +1.4%     467.89 ±  2%      -0.5%     458.90        slabinfo.kmalloc-2k.active_slabs
      7388 ±  2%      +1.5%       7495 ±  2%      -0.5%       7351        slabinfo.kmalloc-2k.num_objs
    461.22 ±  2%      +1.4%     467.89 ±  2%      -0.5%     458.90        slabinfo.kmalloc-2k.num_slabs
    208895            +0.1%     209012            +0.2%     209253        slabinfo.kmalloc-32.active_objs
      1640            +0.1%       1642            +0.2%       1643        slabinfo.kmalloc-32.active_slabs
    210009            +0.1%     210234            +0.2%     210436        slabinfo.kmalloc-32.num_objs
      1640            +0.1%       1642            +0.2%       1643        slabinfo.kmalloc-32.num_slabs
      2761            -0.2%       2756            +0.3%       2769        slabinfo.kmalloc-4k.active_objs
    355.78            -0.2%     355.22            +0.4%     357.20        slabinfo.kmalloc-4k.active_slabs
      2850            -0.1%       2847            +0.4%       2861        slabinfo.kmalloc-4k.num_objs
    355.78            -0.2%     355.22            +0.4%     357.20        slabinfo.kmalloc-4k.num_slabs
     41435            +0.9%      41794            -0.2%      41355        slabinfo.kmalloc-512.active_objs
    779.89 ±  2%      +0.9%     787.11 ±  2%      -0.1%     779.30        slabinfo.kmalloc-512.active_slabs
     49943 ±  2%      +0.9%      50417 ±  2%      -0.1%      49895        slabinfo.kmalloc-512.num_objs
    779.89 ±  2%      +0.9%     787.11 ±  2%      -0.1%     779.30        slabinfo.kmalloc-512.num_slabs
    169054            +0.0%     169089            -0.2%     168655        slabinfo.kmalloc-64.active_objs
      2647            +0.0%       2648            -0.2%       2641        slabinfo.kmalloc-64.active_slabs
    169467            +0.0%     169528            -0.2%     169117        slabinfo.kmalloc-64.num_objs
      2647            +0.0%       2648            -0.2%       2641        slabinfo.kmalloc-64.num_slabs
     91000            -0.9%      90167            -0.1%      90925        slabinfo.kmalloc-8.active_objs
    181.00            -0.5%     180.11            -0.4%     180.20        slabinfo.kmalloc-8.active_slabs
     92870            -0.5%      92436            -0.3%      92555        slabinfo.kmalloc-8.num_objs
    181.00            -0.5%     180.11            -0.4%     180.20        slabinfo.kmalloc-8.num_slabs
      1102            +0.3%       1106            -0.9%       1092        slabinfo.kmalloc-8k.active_objs
    289.44            +0.0%     289.56            -0.4%     288.30        slabinfo.kmalloc-8k.active_slabs
      1159            +0.0%       1159            -0.4%       1154        slabinfo.kmalloc-8k.num_objs
    289.44            +0.0%     289.56            -0.4%     288.30        slabinfo.kmalloc-8k.num_slabs
      8867            +0.1%       8873            -1.1%       8767        slabinfo.kmalloc-96.active_objs
    221.11            +0.5%     222.11 ±  2%      -0.7%     219.60        slabinfo.kmalloc-96.active_slabs
      9311            +0.4%       9346 ±  2%      -0.8%       9241        slabinfo.kmalloc-96.num_objs
    221.11            +0.5%     222.11 ±  2%      -0.7%     219.60        slabinfo.kmalloc-96.num_slabs
    362.67 ±  8%      -2.0%     355.56 ±  8%      +7.6%     390.40 ±  8%  slabinfo.kmalloc-cg-128.active_objs
      5.67 ±  8%      -2.0%       5.56 ±  8%      +7.6%       6.10 ±  8%  slabinfo.kmalloc-cg-128.active_slabs
    362.67 ±  8%      -2.0%     355.56 ±  8%      +7.6%     390.40 ±  8%  slabinfo.kmalloc-cg-128.num_objs
      5.67 ±  8%      -2.0%       5.56 ±  8%      +7.6%       6.10 ±  8%  slabinfo.kmalloc-cg-128.num_slabs
      3644 ±  7%      -0.6%       3624 ±  8%      -6.8%       3395 ±  6%  slabinfo.kmalloc-cg-16.active_objs
     13.78 ±  6%      -2.4%      13.44 ±  9%      -7.1%      12.80 ±  6%  slabinfo.kmalloc-cg-16.active_slabs
      3644 ±  7%      -0.6%       3624 ±  8%      -6.8%       3395 ±  6%  slabinfo.kmalloc-cg-16.num_objs
     13.78 ±  6%      -2.4%      13.44 ±  9%      -7.1%      12.80 ±  6%  slabinfo.kmalloc-cg-16.num_slabs
      5492 ±  6%      -8.2%       5039 ±  7%      -2.9%       5330 ±  9%  slabinfo.kmalloc-cg-192.active_objs
    130.33 ±  6%      -8.3%     119.56 ±  7%      -3.0%     126.40 ±  9%  slabinfo.kmalloc-cg-192.active_slabs
      5492 ±  6%      -8.2%       5039 ±  7%      -2.9%       5330 ±  9%  slabinfo.kmalloc-cg-192.num_objs
    130.33 ±  6%      -8.3%     119.56 ±  7%      -3.0%     126.40 ±  9%  slabinfo.kmalloc-cg-192.num_slabs
      4493 ±  5%      -6.8%       4186 ±  6%      -2.2%       4393 ±  9%  slabinfo.kmalloc-cg-1k.active_objs
    140.22 ±  6%      -7.1%     130.33 ±  6%      -2.4%     136.80 ±  9%  slabinfo.kmalloc-cg-1k.active_slabs
      4500 ±  6%      -7.0%       4186 ±  6%      -2.4%       4393 ±  9%  slabinfo.kmalloc-cg-1k.num_objs
    140.22 ±  6%      -7.1%     130.33 ±  6%      -2.4%     136.80 ±  9%  slabinfo.kmalloc-cg-1k.num_slabs
      1137 ±  9%      +6.3%       1208 ±  9%      +4.0%       1182 ±  7%  slabinfo.kmalloc-cg-256.active_objs
     17.11 ±  9%      +7.8%      18.44 ±  9%      +5.2%      18.00 ±  7%  slabinfo.kmalloc-cg-256.active_slabs
      1137 ±  9%      +6.3%       1208 ±  9%      +4.0%       1182 ±  7%  slabinfo.kmalloc-cg-256.num_objs
     17.11 ±  9%      +7.8%      18.44 ±  9%      +5.2%      18.00 ±  7%  slabinfo.kmalloc-cg-256.num_slabs
    563.44 ± 12%      +0.8%     568.11 ±  6%      -1.6%     554.70 ±  7%  slabinfo.kmalloc-cg-2k.active_objs
     34.78 ± 12%      +0.6%      35.00 ±  6%      -1.7%      34.20 ±  7%  slabinfo.kmalloc-cg-2k.active_slabs
    563.44 ± 12%      +0.8%     568.11 ±  6%      -1.6%     554.70 ±  7%  slabinfo.kmalloc-cg-2k.num_objs
     34.78 ± 12%      +0.6%      35.00 ±  6%      -1.7%      34.20 ±  7%  slabinfo.kmalloc-cg-2k.num_slabs
     15011 ± 13%      -1.3%      14821 ±  6%      -1.1%      14849 ± 15%  slabinfo.kmalloc-cg-32.active_objs
    116.78 ± 13%      -1.2%     115.33 ±  6%      -1.0%     115.60 ± 15%  slabinfo.kmalloc-cg-32.active_slabs
     15011 ± 13%      -1.3%      14821 ±  6%      -1.1%      14849 ± 15%  slabinfo.kmalloc-cg-32.num_objs
    116.78 ± 13%      -1.2%     115.33 ±  6%      -1.0%     115.60 ± 15%  slabinfo.kmalloc-cg-32.num_slabs
      1152            +0.0%       1152            +0.0%       1152        slabinfo.kmalloc-cg-4k.active_objs
    144.00            +0.0%     144.00            +0.0%     144.00        slabinfo.kmalloc-cg-4k.active_slabs
      1152            +0.0%       1152            +0.0%       1152        slabinfo.kmalloc-cg-4k.num_objs
    144.00            +0.0%     144.00            +0.0%     144.00        slabinfo.kmalloc-cg-4k.num_slabs
    157912            +8.7%     171620            +0.5%     158689        slabinfo.kmalloc-cg-512.active_objs
      3143           +10.4%       3469            +0.7%       3165        slabinfo.kmalloc-cg-512.active_slabs
    201196           +10.4%     222071            +0.7%     202609        slabinfo.kmalloc-cg-512.num_objs
      3143           +10.4%       3469            +0.7%       3165        slabinfo.kmalloc-cg-512.num_slabs
      2569 ± 12%      +8.7%       2791 ± 11%      -0.2%       2563 ± 14%  slabinfo.kmalloc-cg-64.active_objs
     39.56 ± 12%      +8.7%      43.00 ± 11%      +0.4%      39.70 ± 14%  slabinfo.kmalloc-cg-64.active_slabs
      2569 ± 12%      +8.7%       2791 ± 11%      -0.2%       2563 ± 14%  slabinfo.kmalloc-cg-64.num_objs
     39.56 ± 12%      +8.7%      43.00 ± 11%      +0.4%      39.70 ± 14%  slabinfo.kmalloc-cg-64.num_slabs
     83860            -0.4%      83524            -0.1%      83796        slabinfo.kmalloc-cg-8.active_objs
    163.67            -0.3%     163.11            -0.1%     163.50        slabinfo.kmalloc-cg-8.active_slabs
     84014            -0.2%      83808            -0.0%      83973        slabinfo.kmalloc-cg-8.num_objs
    163.67            -0.3%     163.11            -0.1%     163.50        slabinfo.kmalloc-cg-8.num_slabs
     34.56 ±  3%      +0.0%      34.56 ±  3%      +0.1%      34.60 ±  3%  slabinfo.kmalloc-cg-8k.active_objs
      7.89 ±  3%      +0.0%       7.89 ±  3%      +0.1%       7.90 ±  3%  slabinfo.kmalloc-cg-8k.active_slabs
     34.56 ±  3%      +0.0%      34.56 ±  3%      +0.1%      34.60 ±  3%  slabinfo.kmalloc-cg-8k.num_objs
      7.89 ±  3%      +0.0%       7.89 ±  3%      +0.1%       7.90 ±  3%  slabinfo.kmalloc-cg-8k.num_slabs
    484.33 ±  5%      -4.8%     461.00 ±  9%      -8.3%     444.20 ±  8%  slabinfo.kmalloc-cg-96.active_objs
     10.56 ±  6%      -5.3%      10.00 ± 10%      -9.1%       9.60 ±  9%  slabinfo.kmalloc-cg-96.active_slabs
    484.33 ±  5%      -4.8%     461.00 ±  9%      -8.3%     444.20 ±  8%  slabinfo.kmalloc-cg-96.num_objs
     10.56 ±  6%      -5.3%      10.00 ± 10%      -9.1%       9.60 ±  9%  slabinfo.kmalloc-cg-96.num_slabs
    945.78 ± 13%      +3.0%     974.22 ± 10%     -10.0%     851.20 ± 16%  slabinfo.kmalloc-rcl-128.active_objs
     15.22 ± 14%      +5.8%      16.11 ± 11%     -10.0%      13.70 ± 12%  slabinfo.kmalloc-rcl-128.active_slabs
    974.22 ± 14%      +5.8%       1031 ± 11%     -10.0%     876.80 ± 12%  slabinfo.kmalloc-rcl-128.num_objs
     15.22 ± 14%      +5.8%      16.11 ± 11%     -10.0%      13.70 ± 12%  slabinfo.kmalloc-rcl-128.num_slabs
     42.00            +0.0%      42.00            +0.0%      42.00        slabinfo.kmalloc-rcl-192.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.kmalloc-rcl-192.active_slabs
     42.00            +0.0%      42.00            +0.0%      42.00        slabinfo.kmalloc-rcl-192.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.kmalloc-rcl-192.num_slabs
      9415 ±  6%      +1.1%       9514 ±  5%      -1.3%       9293 ±  4%  slabinfo.kmalloc-rcl-64.active_objs
    146.89 ±  6%      +0.9%     148.22 ±  5%      -1.5%     144.70 ±  4%  slabinfo.kmalloc-rcl-64.active_slabs
      9441 ±  6%      +0.8%       9514 ±  5%      -1.5%       9299 ±  4%  slabinfo.kmalloc-rcl-64.num_objs
    146.89 ±  6%      +0.9%     148.22 ±  5%      -1.5%     144.70 ±  4%  slabinfo.kmalloc-rcl-64.num_slabs
      2641 ± 14%      -0.9%       2616 ±  8%      -9.1%       2401 ± 12%  slabinfo.kmalloc-rcl-96.active_objs
     64.00 ± 14%      -1.9%      62.78 ±  8%      -9.7%      57.80 ± 12%  slabinfo.kmalloc-rcl-96.active_slabs
      2688 ± 14%      -1.8%       2640 ±  8%      -9.5%       2431 ± 12%  slabinfo.kmalloc-rcl-96.num_objs
     64.00 ± 14%      -1.9%      62.78 ±  8%      -9.7%      57.80 ± 12%  slabinfo.kmalloc-rcl-96.num_slabs
    519.11 ±  9%      +1.4%     526.22 ± 12%     +13.4%     588.80 ±  9%  slabinfo.kmem_cache.active_objs
      8.11 ±  9%      +1.4%       8.22 ± 12%     +13.4%       9.20 ±  9%  slabinfo.kmem_cache.active_slabs
    519.11 ±  9%      +1.4%     526.22 ± 12%     +13.4%     588.80 ±  9%  slabinfo.kmem_cache.num_objs
      8.11 ±  9%      +1.4%       8.22 ± 12%     +13.4%       9.20 ±  9%  slabinfo.kmem_cache.num_slabs
      1065 ±  4%      +0.7%       1072 ±  6%      +7.7%       1146 ±  4%  slabinfo.kmem_cache_node.active_objs
     17.11 ±  4%      +0.6%      17.22 ±  5%      +6.4%      18.20 ±  4%  slabinfo.kmem_cache_node.active_slabs
      1095 ±  4%      +0.6%       1102 ±  5%      +6.4%       1164 ±  4%  slabinfo.kmem_cache_node.num_objs
     17.11 ±  4%      +0.6%      17.22 ±  5%      +6.4%      18.20 ±  4%  slabinfo.kmem_cache_node.num_slabs
     39083            -0.5%      38895            +0.2%      39146        slabinfo.lsm_file_cache.active_objs
    231.78            -0.4%     230.89            +0.3%     232.50        slabinfo.lsm_file_cache.active_slabs
     39481            -0.4%      39316            +0.3%      39597        slabinfo.lsm_file_cache.num_objs
    231.78            -0.4%     230.89            +0.3%     232.50        slabinfo.lsm_file_cache.num_slabs
     13009            -0.6%      12931 ±  2%      -0.4%      12950 ±  2%  slabinfo.mm_struct.active_objs
    437.33            -0.5%     435.11 ±  2%      -0.4%     435.60 ±  2%  slabinfo.mm_struct.active_slabs
     13134            -0.5%      13069 ±  2%      -0.4%      13083 ±  2%  slabinfo.mm_struct.num_objs
    437.33            -0.5%     435.11 ±  2%      -0.4%     435.60 ±  2%  slabinfo.mm_struct.num_slabs
      1098 ±  5%      -3.1%       1064 ±  5%      -2.6%       1070 ±  6%  slabinfo.mnt_cache.active_objs
     20.56 ±  5%      -1.6%      20.22 ±  6%      -2.2%      20.10 ±  5%  slabinfo.mnt_cache.active_slabs
      1098 ±  5%      -3.1%       1064 ±  5%      -2.6%       1070 ±  6%  slabinfo.mnt_cache.num_objs
     20.56 ±  5%      -1.6%      20.22 ±  6%      -2.2%      20.10 ±  5%  slabinfo.mnt_cache.num_slabs
     34.00            +0.0%      34.00            +0.0%      34.00        slabinfo.mqueue_inode_cache.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.mqueue_inode_cache.active_slabs
     34.00            +0.0%      34.00            +0.0%      34.00        slabinfo.mqueue_inode_cache.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.mqueue_inode_cache.num_slabs
      1153            -0.2%       1152            -0.2%       1152        slabinfo.names_cache.active_objs
    144.22            -0.2%     144.00            -0.2%     144.00        slabinfo.names_cache.active_slabs
      1153            -0.2%       1152            -0.2%       1152        slabinfo.names_cache.num_objs
    144.22            -0.2%     144.00            -0.2%     144.00        slabinfo.names_cache.num_slabs
     34.00            +0.0%      34.00            +0.0%      34.00        slabinfo.nfs_read_data.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.nfs_read_data.active_slabs
     34.00            +0.0%      34.00            +0.0%      34.00        slabinfo.nfs_read_data.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.nfs_read_data.num_slabs
    292.89 ± 10%      +7.1%     313.56 ±  7%      +5.8%     309.90 ±  6%  slabinfo.nsproxy.active_objs
      4.67 ± 14%      +9.5%       5.11 ± 11%      +7.1%       5.00 ±  8%  slabinfo.nsproxy.active_slabs
    292.89 ± 10%      +7.1%     313.56 ±  7%      +5.8%     309.90 ±  6%  slabinfo.nsproxy.num_objs
      4.67 ± 14%      +9.5%       5.11 ± 11%      +7.1%       5.00 ±  8%  slabinfo.nsproxy.num_slabs
    220.44 ± 13%      +3.1%     227.33 ± 12%      +9.7%     241.80 ±  7%  slabinfo.numa_policy.active_objs
      3.56 ± 13%      +3.1%       3.67 ± 12%      +9.7%       3.90 ±  7%  slabinfo.numa_policy.active_slabs
    220.44 ± 13%      +3.1%     227.33 ± 12%      +9.7%     241.80 ±  7%  slabinfo.numa_policy.num_objs
      3.56 ± 13%      +3.1%       3.67 ± 12%      +9.7%       3.90 ±  7%  slabinfo.numa_policy.num_slabs
     12239 ±  4%      -0.5%      12181 ±  6%      +3.5%      12664 ±  9%  slabinfo.pde_opener.active_objs
    119.44 ±  5%      -0.4%     119.00 ±  6%      +3.6%     123.70 ±  9%  slabinfo.pde_opener.active_slabs
     12239 ±  4%      -0.5%      12181 ±  6%      +3.5%      12664 ±  9%  slabinfo.pde_opener.num_objs
    119.44 ±  5%      -0.4%     119.00 ±  6%      +3.6%     123.70 ±  9%  slabinfo.pde_opener.num_slabs
      5544            +1.4%       5622            -0.4%       5523        slabinfo.perf_event.active_objs
    215.89            +1.1%     218.22            -0.4%     215.00        slabinfo.perf_event.active_slabs
      5841            +1.0%       5900            -0.4%       5818        slabinfo.perf_event.num_objs
    215.89            +1.1%     218.22            -0.4%     215.00        slabinfo.perf_event.num_slabs
     20396            +0.9%      20582 ±  2%      -0.2%      20355 ±  3%  slabinfo.pid.active_objs
    322.33 ±  2%      +1.1%     326.00 ±  3%      +0.1%     322.60 ±  3%  slabinfo.pid.active_slabs
     20664 ±  2%      +1.1%      20901 ±  3%      +0.1%      20675 ±  3%  slabinfo.pid.num_objs
    322.33 ±  2%      +1.1%     326.00 ±  3%      +0.1%     322.60 ±  3%  slabinfo.pid.num_slabs
      3071 ±  5%      -0.3%       3060 ±  6%      -0.2%       3065 ±  5%  slabinfo.pool_workqueue.active_objs
     50.44 ±  5%      +0.7%      50.78 ±  5%      +1.5%      51.20 ±  6%  slabinfo.pool_workqueue.active_slabs
      3246 ±  5%      +0.4%       3260 ±  5%      +1.4%       3293 ±  5%  slabinfo.pool_workqueue.num_objs
     50.44 ±  5%      +0.7%      50.78 ±  5%      +1.5%      51.20 ±  6%  slabinfo.pool_workqueue.num_slabs
      3854            +0.8%       3887 ±  2%      -0.8%       3822        slabinfo.proc_dir_entry.active_objs
     91.78            +0.8%      92.56 ±  2%      -0.8%      91.00        slabinfo.proc_dir_entry.active_slabs
      3854            +0.8%       3887 ±  2%      -0.8%       3822        slabinfo.proc_dir_entry.num_objs
     91.78            +0.8%      92.56 ±  2%      -0.8%      91.00        slabinfo.proc_dir_entry.num_slabs
     26759            +0.2%      26824 ±  2%      +1.0%      27028 ±  2%  slabinfo.proc_inode_cache.active_objs
    798.00            -5.7%     752.67 ±  6%      +0.3%     800.30        slabinfo.proc_inode_cache.active_slabs
     36726            -5.7%      34649 ±  6%      +0.3%      36837        slabinfo.proc_inode_cache.num_objs
    798.00            -5.7%     752.67 ±  6%      +0.3%     800.30        slabinfo.proc_inode_cache.num_slabs
     34934            +2.7%      35877 ±  2%      +0.1%      34956        slabinfo.radix_tree_node.active_objs
    624.33            +2.6%     640.44 ±  2%      +0.0%     624.40        slabinfo.radix_tree_node.active_slabs
     34984            +2.6%      35900 ±  2%      +0.0%      34991        slabinfo.radix_tree_node.num_objs
    624.33            +2.6%     640.44 ±  2%      +0.0%     624.40        slabinfo.radix_tree_node.num_slabs
     44.89 ± 44%      -0.5%      44.67 ± 41%     -46.5%      24.00 ± 30%  slabinfo.request_queue.active_objs
      4.00 ± 48%      -2.8%       3.89 ± 47%     -60.0%       1.60 ± 30%  slabinfo.request_queue.active_slabs
     60.00 ± 48%      -2.8%      58.33 ± 47%     -60.0%      24.00 ± 30%  slabinfo.request_queue.num_objs
      4.00 ± 48%      -2.8%       3.89 ± 47%     -60.0%       1.60 ± 30%  slabinfo.request_queue.num_slabs
     46.00            +0.0%      46.00            +0.0%      46.00        slabinfo.rpc_inode_cache.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.rpc_inode_cache.active_slabs
     46.00            +0.0%      46.00            +0.0%      46.00        slabinfo.rpc_inode_cache.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.rpc_inode_cache.num_slabs
    320.00            +0.0%     320.00            +0.0%     320.00        slabinfo.scsi_sense_cache.active_objs
      5.00            +0.0%       5.00            +0.0%       5.00        slabinfo.scsi_sense_cache.active_slabs
    320.00            +0.0%     320.00            +0.0%     320.00        slabinfo.scsi_sense_cache.num_objs
      5.00            +0.0%       5.00            +0.0%       5.00        slabinfo.scsi_sense_cache.num_slabs
      9792            +0.0%       9792            +0.0%       9792        slabinfo.seq_file.active_objs
    144.00            +0.0%     144.00            +0.0%     144.00        slabinfo.seq_file.active_slabs
      9792            +0.0%       9792            +0.0%       9792        slabinfo.seq_file.num_objs
    144.00            +0.0%     144.00            +0.0%     144.00        slabinfo.seq_file.num_slabs
      6210 ±  3%      +5.4%       6547 ±  4%      -2.1%       6079 ±  7%  slabinfo.shmem_inode_cache.active_objs
    144.00 ±  3%      +5.4%     151.78 ±  4%      -2.2%     140.80 ±  7%  slabinfo.shmem_inode_cache.active_slabs
      6211 ±  3%      +5.5%       6551 ±  4%      -2.1%       6079 ±  7%  slabinfo.shmem_inode_cache.num_objs
    144.00 ±  3%      +5.4%     151.78 ±  4%      -2.2%     140.80 ±  7%  slabinfo.shmem_inode_cache.num_slabs
     10589 ±  2%      +1.5%      10747            +2.8%      10885 ±  3%  slabinfo.sighand_cache.active_objs
    710.78 ±  2%      +1.5%     721.67 ±  2%      +2.8%     730.80 ±  3%  slabinfo.sighand_cache.active_slabs
     10670 ±  2%      +1.5%      10832 ±  2%      +2.8%      10969 ±  3%  slabinfo.sighand_cache.num_objs
    710.78 ±  2%      +1.5%     721.67 ±  2%      +2.8%     730.80 ±  3%  slabinfo.sighand_cache.num_slabs
     12915 ±  2%      -0.4%      12857 ±  2%      +0.6%      12991 ±  2%  slabinfo.signal_cache.active_objs
    466.78 ±  2%      -0.3%     465.44 ±  2%      +0.8%     470.70 ±  2%  slabinfo.signal_cache.active_slabs
     13079 ±  2%      -0.2%      13047 ±  2%      +0.9%      13196 ±  2%  slabinfo.signal_cache.num_objs
    466.78 ±  2%      -0.3%     465.44 ±  2%      +0.8%     470.70 ±  2%  slabinfo.signal_cache.num_slabs
      7284 ±  3%      -3.9%       7000 ±  4%      -0.7%       7234 ±  3%  slabinfo.sigqueue.active_objs
    142.33 ±  3%      -3.9%     136.78 ±  4%      -0.7%     141.40 ±  3%  slabinfo.sigqueue.active_slabs
      7284 ±  3%      -3.9%       7000 ±  4%      -0.7%       7234 ±  3%  slabinfo.sigqueue.num_objs
    142.33 ±  3%      -3.9%     136.78 ±  4%      -0.7%     141.40 ±  3%  slabinfo.sigqueue.num_slabs
    120.89 ± 16%      +5.9%     128.00            +5.9%     128.00        slabinfo.skbuff_fclone_cache.active_objs
      1.89 ± 16%      +5.9%       2.00            +5.9%       2.00        slabinfo.skbuff_fclone_cache.active_slabs
    120.89 ± 16%      +5.9%     128.00            +5.9%     128.00        slabinfo.skbuff_fclone_cache.num_objs
      1.89 ± 16%      +5.9%       2.00            +5.9%       2.00        slabinfo.skbuff_fclone_cache.num_slabs
    158072            +8.6%     171679            +0.5%     158910        slabinfo.skbuff_head_cache.active_objs
      3149           +10.3%       3474            +0.7%       3171        slabinfo.skbuff_head_cache.active_slabs
    201587           +10.3%     222400            +0.7%     202970        slabinfo.skbuff_head_cache.num_objs
      3149           +10.3%       3474            +0.7%       3171        slabinfo.skbuff_head_cache.num_slabs
     14118 ±  3%      +2.5%      14478 ±  4%      -0.5%      14050 ±  4%  slabinfo.sock_inode_cache.active_objs
    363.78 ±  3%      +2.5%     373.00 ±  4%      -0.4%     362.20 ±  4%  slabinfo.sock_inode_cache.active_slabs
     14209 ±  3%      +2.5%      14564 ±  4%      -0.4%      14148 ±  4%  slabinfo.sock_inode_cache.num_objs
    363.78 ±  3%      +2.5%     373.00 ±  4%      -0.4%     362.20 ±  4%  slabinfo.sock_inode_cache.num_slabs
      1480 ±  7%      +2.5%       1516 ±  6%      -0.5%       1473 ±  5%  slabinfo.task_group.active_objs
     31.67 ±  7%      +2.5%      32.44 ±  6%      -0.8%      31.40 ±  5%  slabinfo.task_group.active_slabs
      1480 ±  7%      +2.5%       1516 ±  6%      -0.5%       1473 ±  5%  slabinfo.task_group.num_objs
     31.67 ±  7%      +2.5%      32.44 ±  6%      -0.8%      31.40 ±  5%  slabinfo.task_group.num_slabs
      7648            +0.5%       7687            +0.6%       7694        slabinfo.task_struct.active_objs
      7657            +0.5%       7697            +0.6%       7703        slabinfo.task_struct.active_slabs
      7657            +0.5%       7697            +0.6%       7703        slabinfo.task_struct.num_objs
      7657            +0.5%       7697            +0.6%       7703        slabinfo.task_struct.num_slabs
    377.67 ±  9%      +0.2%     378.33 ±  6%      +0.1%     378.20 ± 11%  slabinfo.taskstats.active_objs
      7.78 ± 10%      +1.4%       7.89 ±  7%      +0.3%       7.80 ± 12%  slabinfo.taskstats.active_slabs
    377.67 ±  9%      +0.2%     378.33 ±  6%      +0.1%     378.20 ± 11%  slabinfo.taskstats.num_objs
      7.78 ± 10%      +1.4%       7.89 ±  7%      +0.3%       7.80 ± 12%  slabinfo.taskstats.num_slabs
      3716 ±  2%      +2.5%       3809 ±  3%      +0.7%       3744 ±  2%  slabinfo.trace_event_file.active_objs
     80.67 ±  2%      +2.6%      82.78 ±  3%      +0.5%      81.10 ±  2%  slabinfo.trace_event_file.active_slabs
      3726 ±  2%      +2.5%       3819 ±  3%      +0.5%       3744 ±  2%  slabinfo.trace_event_file.num_objs
     80.67 ±  2%      +2.6%      82.78 ±  3%      +0.5%      81.10 ±  2%  slabinfo.trace_event_file.num_slabs
     66.00            +0.0%      66.00            +0.0%      66.00        slabinfo.tw_sock_TCP.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.tw_sock_TCP.active_slabs
     66.00            +0.0%      66.00            +0.0%      66.00        slabinfo.tw_sock_TCP.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.tw_sock_TCP.num_slabs
    206611            +0.5%     207609            +0.2%     206952        slabinfo.vm_area_struct.active_objs
      5179            +0.5%       5205            +0.2%       5188        slabinfo.vm_area_struct.active_slabs
    207210            +0.5%     208249            +0.2%     207548        slabinfo.vm_area_struct.num_objs
      5179            +0.5%       5205            +0.2%       5188        slabinfo.vm_area_struct.num_slabs
     36064            +0.9%      36386            +0.7%      36310        slabinfo.vmap_area.active_objs
    572.89            +0.8%     577.33            +0.4%     575.30        slabinfo.vmap_area.active_slabs
     36697            +0.8%      36974            +0.4%      36856        slabinfo.vmap_area.num_objs
    572.89            +0.8%     577.33            +0.4%     575.30        slabinfo.vmap_area.num_slabs
      0.00          -100.0%       0.00       +5.1e+103%      51.00        slabinfo.xfrm_dst_cache.active_objs
      0.00          -100.0%       0.00         +1e+102%       1.00        slabinfo.xfrm_dst_cache.active_slabs
      0.00          -100.0%       0.00       +5.1e+103%      51.00        slabinfo.xfrm_dst_cache.num_objs
      0.00          -100.0%       0.00         +1e+102%       1.00        slabinfo.xfrm_dst_cache.num_slabs
     42.00            +0.0%      42.00            +0.0%      42.00        slabinfo.xfrm_state.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.xfrm_state.active_slabs
     42.00            +0.0%      42.00            +0.0%      42.00        slabinfo.xfrm_state.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.xfrm_state.num_slabs
     64.00 ± 23%      +6.2%      68.00 ± 16%      -4.4%      61.20 ± 26%  slabinfo.xfs_btree_cur.active_objs
      1.78 ± 23%      +6.2%       1.89 ± 16%      -4.4%       1.70 ± 26%  slabinfo.xfs_btree_cur.active_slabs
     64.00 ± 23%      +6.2%      68.00 ± 16%      -4.4%      61.20 ± 26%  slabinfo.xfs_btree_cur.num_objs
      1.78 ± 23%      +6.2%       1.89 ± 16%      -4.4%       1.70 ± 26%  slabinfo.xfs_btree_cur.num_slabs
    200.67 ±  8%      -2.3%     196.00 ± 14%      -5.8%     189.00 ± 17%  slabinfo.xfs_buf.active_objs
      4.78 ±  8%      -2.3%       4.67 ± 14%      -5.8%       4.50 ± 17%  slabinfo.xfs_buf.active_slabs
    200.67 ±  8%      -2.3%     196.00 ± 14%      -5.8%     189.00 ± 17%  slabinfo.xfs_buf.num_objs
      4.78 ±  8%      -2.3%       4.67 ± 14%      -5.8%       4.50 ± 17%  slabinfo.xfs_buf.num_slabs
     38.00            +0.0%      38.00          -100.0%       0.00        slabinfo.xfs_efi_item.active_objs
      1.00            +0.0%       1.00          -100.0%       0.00        slabinfo.xfs_efi_item.active_slabs
     38.00            +0.0%      38.00          -100.0%       0.00        slabinfo.xfs_efi_item.num_objs
      1.00            +0.0%       1.00          -100.0%       0.00        slabinfo.xfs_efi_item.num_slabs
    102.00            +0.0%     102.00            +0.0%     102.00        slabinfo.xfs_inode.active_objs
      3.00            +0.0%       3.00            +0.0%       3.00        slabinfo.xfs_inode.active_slabs
    102.00            +0.0%     102.00            +0.0%     102.00        slabinfo.xfs_inode.num_objs
      3.00            +0.0%       3.00            +0.0%       3.00        slabinfo.xfs_inode.num_slabs
    262.00            +0.0%     262.00            +0.0%     262.00        softirqs.BLOCK
      1.00            +0.0%       1.00            +0.0%       1.00        softirqs.CPU0.HI
     86.44 ±  3%      +1.2%      87.44 ±  2%      -1.2%      85.40 ±  2%  softirqs.CPU0.NET_RX
     83016 ±  6%      -9.6%      75018 ±  7%      -2.5%      80935 ±  6%  softirqs.CPU0.RCU
     18082 ±  5%      +4.4%      18871 ±  3%      -0.2%      18046 ±  7%  softirqs.CPU0.SCHED
    105.44            -0.2%     105.22            +0.1%     105.50        softirqs.CPU0.TASKLET
      2573 ±  5%      -2.3%       2514 ±  8%      +1.4%       2610 ±  3%  softirqs.CPU0.TIMER
     86.44 ±  3%      +1.2%      87.44 ±  2%      -1.2%      85.40 ±  2%  softirqs.CPU1.NET_RX
     84711 ±  6%      -9.2%      76921 ±  8%      -2.1%      82918 ±  7%  softirqs.CPU1.RCU
     16441 ±  3%      +6.3%      17478 ±  8%      -4.6%      15682 ±  5%  softirqs.CPU1.SCHED
      1.00 ±200%     -88.9%       0.11 ±282%     -90.0%       0.10 ±300%  softirqs.CPU1.TASKLET
    866.22 ± 34%     +63.4%       1415 ± 52%     +39.2%       1205 ± 46%  softirqs.CPU1.TIMER
     18438 ± 80%     -28.7%      13138 ±139%     -79.1%       3850 ±204%  softirqs.CPU10.NET_RX
      2.00 ± 33%     -11.1%       1.78 ± 35%      +5.0%       2.10 ± 33%  softirqs.CPU10.NET_TX
     85164 ±  7%     -10.3%      76391 ±  8%      -2.7%      82889 ±  7%  softirqs.CPU10.RCU
     17238 ± 11%      -1.2%      17030 ± 14%     -15.6%      14554 ±  8%  softirqs.CPU10.SCHED
      0.11 ±282%      +0.0%       0.11 ±282%     -10.0%       0.10 ±300%  softirqs.CPU10.TASKLET
      3524 ± 64%     -18.4%       2874 ± 92%     -54.3%       1609 ±132%  softirqs.CPU10.TIMER
     88.44 ±  2%      +1.1%      89.44 ±  2%      -1.2%      87.40 ±  2%  softirqs.CPU100.NET_RX
     90078 ±  8%     -11.8%      79488 ±  6%      -2.6%      87752 ±  6%  softirqs.CPU100.RCU
     15505 ±  5%      +7.5%      16674 ±  8%      +2.3%      15869 ±  5%  softirqs.CPU100.SCHED
      0.00          -100.0%       0.00         +2e+101%       0.20 ±200%  softirqs.CPU100.TASKLET
    628.33 ± 18%     -12.1%     552.56 ± 15%      -3.0%     609.50 ± 17%  softirqs.CPU100.TIMER
     88.44 ±  2%      +1.1%      89.44 ±  2%      -1.2%      87.40 ±  2%  softirqs.CPU101.NET_RX
     89726 ±  8%     -12.1%      78826 ±  6%      -2.6%      87364 ±  6%  softirqs.CPU101.RCU
     15433 ±  4%      +7.1%      16535 ±  7%      +2.8%      15860 ±  5%  softirqs.CPU101.SCHED
      0.00          -100.0%       0.00         +1e+101%       0.10 ±300%  softirqs.CPU101.TASKLET
    649.33 ± 26%     -16.6%     541.33 ± 11%      -9.2%     589.50 ± 11%  softirqs.CPU101.TIMER
     88.44 ±  2%      +1.1%      89.44 ±  2%      -1.2%      87.40 ±  2%  softirqs.CPU102.NET_RX
     89680 ±  8%     -12.0%      78940 ±  6%      -2.8%      87145 ±  6%  softirqs.CPU102.RCU
     15434 ±  5%      +7.2%      16538 ±  8%      +3.5%      15976 ±  5%  softirqs.CPU102.SCHED
      0.11 ±282%    -100.0%       0.00          +170.0%       0.30 ±213%  softirqs.CPU102.TASKLET
    607.22 ± 15%     -12.5%     531.33 ± 17%      -3.0%     589.10 ± 12%  softirqs.CPU102.TIMER
     88.44 ±  2%      +1.1%      89.44 ±  2%      -1.2%      87.40 ±  2%  softirqs.CPU103.NET_RX
     89894 ±  8%     -12.2%      78959 ±  6%      -2.4%      87731 ±  6%  softirqs.CPU103.RCU
     15478 ±  5%      +5.6%      16350 ±  8%      +4.1%      16114 ±  6%  softirqs.CPU103.SCHED
      0.67 ±122%     -83.3%       0.11 ±282%     -85.0%       0.10 ±300%  softirqs.CPU103.TASKLET
    601.22 ± 18%      -6.8%     560.44 ± 17%      +5.3%     632.90 ± 19%  softirqs.CPU103.TIMER
     88.44 ±  2%      +1.1%      89.44 ±  2%      -1.2%      87.40 ±  2%  softirqs.CPU104.NET_RX
     90149 ±  8%     -11.8%      79546 ±  6%      -2.5%      87912 ±  6%  softirqs.CPU104.RCU
     15309 ±  5%      +7.5%      16463 ±  7%      +3.9%      15905 ±  5%  softirqs.CPU104.SCHED
      0.00       +1.1e+101%       0.11 ±282%   +2e+101%       0.20 ±200%  softirqs.CPU104.TASKLET
    592.33 ± 15%     -14.7%     505.56 ± 21%     +10.2%     652.90 ± 11%  softirqs.CPU104.TIMER
     88.44 ±  2%      +1.1%      89.44 ±  2%      -1.2%      87.40 ±  2%  softirqs.CPU105.NET_RX
     89995 ±  8%     -12.0%      79211 ±  6%      -2.8%      87447 ±  6%  softirqs.CPU105.RCU
     15463 ±  6%      +6.7%      16502 ±  9%      +1.7%      15719 ±  5%  softirqs.CPU105.SCHED
      0.22 ±187%     -50.0%       0.11 ±282%    -100.0%       0.00        softirqs.CPU105.TASKLET
    650.89 ± 16%      +5.5%     686.44 ± 64%      -3.1%     630.70 ± 14%  softirqs.CPU105.TIMER
     88.44 ±  2%      +1.1%      89.44 ±  2%      -1.2%      87.40 ±  2%  softirqs.CPU106.NET_RX
     90650 ±  8%     -12.2%      79590 ±  6%      -2.9%      88015 ±  6%  softirqs.CPU106.RCU
     15516 ±  5%      +6.4%      16517 ±  8%      +1.9%      15810 ±  6%  softirqs.CPU106.SCHED
    663.44 ± 15%     -21.2%     522.56 ± 12%     +10.2%     730.80 ± 22%  softirqs.CPU106.TIMER
     88.44 ±  2%      +1.1%      89.44 ±  2%      -1.2%      87.40 ±  2%  softirqs.CPU107.NET_RX
      0.89 ±111%     -75.0%       0.22 ±282%     -77.5%       0.20 ±300%  softirqs.CPU107.NET_TX
     91263 ±  8%     -12.5%      79877 ±  6%      -3.2%      88303 ±  7%  softirqs.CPU107.RCU
     16795 ± 10%      +0.2%      16830 ±  8%      -3.8%      16153 ±  7%  softirqs.CPU107.SCHED
      0.00       +3.3e+101%       0.33 ±282%   +1e+101%       0.10 ±300%  softirqs.CPU107.TASKLET
      3292 ± 89%     -58.6%       1363 ±167%     -61.8%       1256 ± 98%  softirqs.CPU107.TIMER
     84187 ±  8%     -10.5%      75306 ±  6%      -3.4%      81293 ±  6%  softirqs.CPU108.RCU
     15449 ±  8%      +8.5%      16766 ±  3%      -1.7%      15181 ±  8%  softirqs.CPU108.SCHED
      0.56 ±226%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU108.TASKLET
    526.00 ± 17%     +22.6%     644.89 ± 54%      +6.7%     561.00 ± 20%  softirqs.CPU108.TIMER
     83743 ±  7%     -11.0%      74501 ±  7%      -3.6%      80726 ±  6%  softirqs.CPU109.RCU
     15669 ±  8%      +7.1%      16785 ±  3%      -2.0%      15353 ±  7%  softirqs.CPU109.SCHED
      0.00          -100.0%       0.00         +3e+101%       0.30 ±152%  softirqs.CPU109.TASKLET
    522.00 ±  7%      -9.9%     470.44 ± 18%      -5.9%     491.20 ± 20%  softirqs.CPU109.TIMER
      7281 ±154%      -2.0%       7134 ± 94%    +194.5%      21444 ±193%  softirqs.CPU11.NET_RX
      1.78 ± 51%     -12.5%       1.56 ± 61%      +6.9%       1.90 ± 36%  softirqs.CPU11.NET_TX
     85103 ±  5%     -10.4%      76287 ±  8%      -1.7%      83638 ±  6%  softirqs.CPU11.RCU
     15219 ±  5%      +5.6%      16065 ±  4%      +0.9%      15361 ±  8%  softirqs.CPU11.SCHED
      0.11 ±282%    +100.0%       0.22 ±282%     +80.0%       0.20 ±200%  softirqs.CPU11.TASKLET
      1792 ± 73%     +14.9%       2060 ± 76%     +39.1%       2493 ± 53%  softirqs.CPU11.TIMER
     83398 ±  8%     -10.8%      74412 ±  7%      -2.7%      81128 ±  6%  softirqs.CPU110.RCU
     15558 ±  6%      +7.5%      16723 ±  3%      +0.9%      15691 ±  6%  softirqs.CPU110.SCHED
      0.00       +3.3e+101%       0.33 ±199%   +1e+101%       0.10 ±300%  softirqs.CPU110.TASKLET
    527.44 ± 21%     -13.7%     455.11 ± 21%     +24.3%     655.50 ± 62%  softirqs.CPU110.TIMER
     83154 ±  7%     -10.5%      74425 ±  7%      -2.6%      80997 ±  6%  softirqs.CPU111.RCU
     15630 ±  7%      +8.9%      17024 ±  4%      -0.8%      15499 ±  7%  softirqs.CPU111.SCHED
      0.11 ±282%    +300.0%       0.44 ±282%     +80.0%       0.20 ±300%  softirqs.CPU111.TASKLET
    512.67 ± 14%     -10.9%     456.78 ± 11%     +18.2%     605.90 ± 64%  softirqs.CPU111.TIMER
     93508 ±  7%     -13.4%      80950 ±  8%      -4.4%      89350 ±  6%  softirqs.CPU112.RCU
     15726 ±  8%      +6.5%      16747 ±  3%      -2.2%      15381 ±  7%  softirqs.CPU112.SCHED
      0.00       +4.4e+101%       0.44 ±282%    -100.0%       0.00        softirqs.CPU112.TASKLET
    690.00 ± 14%     -13.8%     594.78 ± 15%      +2.1%     704.20 ± 12%  softirqs.CPU112.TIMER
     93465 ±  7%     -12.6%      81678 ±  7%      -3.9%      89789 ±  6%  softirqs.CPU113.RCU
     15964 ±  9%      +5.0%      16757 ±  4%      -4.4%      15265 ±  7%  softirqs.CPU113.SCHED
      0.00       +2.2e+101%       0.22 ±187%    -100.0%       0.00        softirqs.CPU113.TASKLET
    723.89 ± 14%     -10.4%     648.44 ± 15%      +2.6%     742.50 ± 23%  softirqs.CPU113.TIMER
     91899 ±  7%     -12.1%      80780 ±  7%      -3.7%      88455 ±  6%  softirqs.CPU114.RCU
     15681 ±  7%      +8.0%      16942 ±  3%      -1.7%      15409 ±  6%  softirqs.CPU114.SCHED
      0.11 ±282%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU114.TASKLET
    695.33 ± 10%     -11.2%     617.56 ± 21%      +2.3%     711.50 ± 18%  softirqs.CPU114.TIMER
     92748 ±  7%     -12.6%      81079 ±  7%      -3.9%      89152 ±  6%  softirqs.CPU115.RCU
     15677 ±  7%      +7.3%      16817 ±  4%      -1.0%      15519 ±  8%  softirqs.CPU115.SCHED
      0.00       +2.2e+101%       0.22 ±282%    -100.0%       0.00        softirqs.CPU115.TASKLET
    823.00 ± 32%     -22.3%     639.11 ± 16%     +13.2%     931.70 ± 49%  softirqs.CPU115.TIMER
     93281 ±  7%     -12.3%      81786 ±  7%      -3.4%      90134 ±  6%  softirqs.CPU116.RCU
     15692 ±  8%      +6.6%      16734 ±  4%      -2.1%      15356 ±  7%  softirqs.CPU116.SCHED
    742.67 ± 16%     -11.1%     660.56 ± 23%     +12.3%     834.30 ± 57%  softirqs.CPU116.TIMER
     93069 ±  7%     -12.2%      81696 ±  8%      -3.9%      89425 ±  6%  softirqs.CPU117.RCU
     15627 ±  8%     +10.8%      17320 ±  3%      -2.1%      15294 ±  7%  softirqs.CPU117.SCHED
      0.56 ±191%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU117.TASKLET
    688.56 ± 10%     +63.9%       1128 ± 78%      -3.9%     661.50 ± 11%  softirqs.CPU117.TIMER
     92044 ±  7%     -12.3%      80729 ±  7%      -3.7%      88683 ±  6%  softirqs.CPU118.RCU
     15687 ±  8%      +7.9%      16930 ±  4%      -2.2%      15349 ±  7%  softirqs.CPU118.SCHED
      0.00          -100.0%       0.00         +4e+101%       0.40 ±200%  softirqs.CPU118.TASKLET
    724.78 ± 24%      -8.3%     664.44 ± 20%     +10.4%     800.00 ± 37%  softirqs.CPU118.TIMER
     92781 ±  7%     -12.4%      81289 ±  7%      -3.8%      89259 ±  6%  softirqs.CPU119.RCU
     15852 ±  7%      +7.6%      17062 ±  4%      -4.7%      15110 ±  8%  softirqs.CPU119.SCHED
      0.11 ±282%    -100.0%       0.00           -10.0%       0.10 ±300%  softirqs.CPU119.TASKLET
    702.44 ± 13%      -8.8%     640.56 ± 20%     +17.3%     824.30 ± 48%  softirqs.CPU119.TIMER
     11175 ±142%     +14.5%      12801 ±146%     +12.6%      12586 ±147%  softirqs.CPU12.NET_RX
      1.56 ± 61%     +35.7%       2.11 ± 34%     +15.7%       1.80 ± 33%  softirqs.CPU12.NET_TX
     84568 ±  7%      -8.5%      77358 ±  7%      -1.3%      83488 ±  6%  softirqs.CPU12.RCU
     15883 ± 12%      +2.6%      16298 ±  6%      -6.4%      14863 ±  4%  softirqs.CPU12.SCHED
      0.22 ±187%    +150.0%       0.56 ±191%    +260.0%       0.80 ±192%  softirqs.CPU12.TASKLET
      1925 ± 85%      +4.6%       2014 ± 79%     +14.5%       2204 ± 56%  softirqs.CPU12.TIMER
     92709 ±  7%     -12.1%      81521 ±  7%      -3.7%      89324 ±  6%  softirqs.CPU120.RCU
     15694 ±  7%      +6.8%      16760 ±  3%      -1.6%      15438 ±  7%  softirqs.CPU120.SCHED
      0.44 ±282%    -100.0%       0.00           -55.0%       0.20 ±200%  softirqs.CPU120.TASKLET
    712.89 ± 11%     -13.9%     613.89 ± 17%     +19.7%     853.30 ± 66%  softirqs.CPU120.TIMER
     93299 ±  7%     -12.3%      81869 ±  7%      -3.9%      89668 ±  6%  softirqs.CPU121.RCU
     15668 ±  7%      +8.7%      17037 ±  3%      -2.5%      15271 ±  7%  softirqs.CPU121.SCHED
      0.00       +1.1e+101%       0.11 ±282%   +3e+101%       0.30 ±300%  softirqs.CPU121.TASKLET
    705.78 ± 19%     +19.0%     839.78 ± 61%      -0.7%     700.70 ± 20%  softirqs.CPU121.TIMER
     92837 ±  7%     -12.3%      81407 ±  7%      -3.8%      89347 ±  6%  softirqs.CPU122.RCU
     15873 ±  7%      +6.7%      16938 ±  4%      -3.5%      15314 ±  7%  softirqs.CPU122.SCHED
      0.00       +1.1e+101%       0.11 ±282%   +2e+101%       0.20 ±200%  softirqs.CPU122.TASKLET
    785.00 ± 26%     -12.4%     688.00 ± 26%     -14.4%     672.30 ± 17%  softirqs.CPU122.TIMER
     92143 ±  7%     -12.2%      80895 ±  7%      -3.8%      88647 ±  6%  softirqs.CPU123.RCU
     15729 ±  7%      +6.8%      16793 ±  5%      -1.9%      15433 ±  6%  softirqs.CPU123.SCHED
    664.11 ± 17%      -8.3%     609.22 ± 17%     +18.0%     783.40 ± 66%  softirqs.CPU123.TIMER
     92983 ±  7%     -13.2%      80701 ±  8%      -3.8%      89432 ±  6%  softirqs.CPU124.RCU
     15617 ±  7%      +7.9%      16849 ±  4%      -1.8%      15338 ±  6%  softirqs.CPU124.SCHED
      0.00       +1.1e+101%       0.11 ±282%    -100.0%       0.00        softirqs.CPU124.TASKLET
    676.00 ±  9%      -7.3%     626.78 ± 21%      +2.2%     690.70 ± 22%  softirqs.CPU124.TIMER
     93247 ±  7%     -12.5%      81605 ±  7%      -3.8%      89691 ±  6%  softirqs.CPU125.RCU
     15690 ±  7%      +6.8%      16758 ±  3%      -2.4%      15320 ±  7%  softirqs.CPU125.SCHED
    687.11 ± 18%      -6.0%     646.11 ± 17%      +2.6%     704.80 ± 22%  softirqs.CPU125.TIMER
     80148 ±  7%      -9.6%      72433 ±  7%      -2.6%      78055 ±  6%  softirqs.CPU126.RCU
     15558 ±  6%      +6.7%      16595 ±  9%      +1.5%      15797 ± 10%  softirqs.CPU126.SCHED
      0.11 ±282%    +400.0%       0.56 ±149%    -100.0%       0.00        softirqs.CPU126.TASKLET
    495.89 ± 27%     -15.4%     419.67 ± 22%     +23.9%     614.50 ± 91%  softirqs.CPU126.TIMER
     79733 ±  7%      -9.8%      71906 ±  7%      -2.8%      77491 ±  6%  softirqs.CPU127.RCU
     15460 ±  6%      +8.8%      16825 ±  9%      +0.4%      15523 ±  8%  softirqs.CPU127.SCHED
      0.22 ±282%     -50.0%       0.11 ±282%    -100.0%       0.00        softirqs.CPU127.TASKLET
    434.00 ± 20%      -3.9%     417.11 ± 15%      -0.6%     431.50 ±  8%  softirqs.CPU127.TIMER
     86047 ±  7%     -11.1%      76486 ±  7%      -3.0%      83447 ±  7%  softirqs.CPU128.RCU
     15665 ±  6%      +8.1%      16935 ±  9%      -0.4%      15605 ±  8%  softirqs.CPU128.SCHED
      0.11 ±282%      +0.0%       0.11 ±282%    -100.0%       0.00        softirqs.CPU128.TASKLET
    534.56 ± 13%      -3.1%     518.22 ± 19%      -1.1%     528.60 ± 30%  softirqs.CPU128.TIMER
     85969 ±  7%     -10.9%      76613 ±  7%      -3.1%      83314 ±  7%  softirqs.CPU129.RCU
     15515 ±  6%      +9.2%      16944 ±  8%      +0.5%      15586 ±  8%  softirqs.CPU129.SCHED
      0.22 ±187%     +50.0%       0.33 ±200%    -100.0%       0.00        softirqs.CPU129.TASKLET
    555.78 ± 12%     -11.9%     489.78 ± 24%     -13.7%     479.50 ± 19%  softirqs.CPU129.TIMER
     86.44 ±  3%      +1.2%      87.44 ±  2%      -1.2%      85.40 ±  2%  softirqs.CPU13.NET_RX
     84478 ±  6%      -8.2%      77529 ±  7%      -1.2%      83445 ±  7%  softirqs.CPU13.RCU
     14494            +8.3%      15697 ±  3%      -3.2%      14028 ±  3%  softirqs.CPU13.SCHED
      0.22 ±187%    -100.0%       0.00           +35.0%       0.30 ±300%  softirqs.CPU13.TASKLET
    807.44 ± 14%      -0.9%     800.11 ± 19%      -1.5%     795.30 ± 34%  softirqs.CPU13.TIMER
     86084 ±  7%     -11.1%      76555 ±  7%      -3.3%      83283 ±  7%  softirqs.CPU130.RCU
     15502 ±  6%      +8.5%      16814 ±  9%      +0.9%      15646 ±  7%  softirqs.CPU130.SCHED
      0.00       +1.1e+101%       0.11 ±282%   +2e+101%       0.20 ±300%  softirqs.CPU130.TASKLET
    569.33 ± 31%     -18.3%     465.11 ± 19%     -10.6%     508.70 ± 19%  softirqs.CPU130.TIMER
     86263 ±  7%     -11.3%      76544 ±  7%      -3.3%      83433 ±  7%  softirqs.CPU131.RCU
     15562 ±  6%      +7.8%      16770 ±  8%      -0.2%      15532 ±  8%  softirqs.CPU131.SCHED
      0.11 ±282%      +0.0%       0.11 ±282%    -100.0%       0.00        softirqs.CPU131.TASKLET
    531.89 ± 22%     -11.6%     470.44 ± 19%      -9.5%     481.20 ± 12%  softirqs.CPU131.TIMER
     85559 ±  7%     -10.9%      76238 ±  7%      -2.9%      83049 ±  7%  softirqs.CPU132.RCU
     15650 ±  7%      +7.8%      16871 ±  8%      +1.7%      15918 ±  9%  softirqs.CPU132.SCHED
      0.33 ±200%    -100.0%       0.00           -40.0%       0.20 ±200%  softirqs.CPU132.TASKLET
    536.44 ± 25%      -9.7%     484.22 ± 11%      -3.3%     518.60 ± 17%  softirqs.CPU132.TIMER
     85618 ±  7%     -11.1%      76103 ±  7%      -3.2%      82904 ±  7%  softirqs.CPU133.RCU
     15564 ±  5%      +8.3%      16863 ±  8%      +0.2%      15599 ±  7%  softirqs.CPU133.SCHED
      0.11 ±282%    -100.0%       0.00           -10.0%       0.10 ±300%  softirqs.CPU133.TASKLET
    529.11 ± 12%      -8.6%     483.56 ± 16%      -1.5%     521.40 ± 12%  softirqs.CPU133.TIMER
     85666 ±  7%     -10.2%      76895 ±  8%      -2.8%      83297 ±  7%  softirqs.CPU134.RCU
     15550 ±  6%     +11.9%      17395 ±  9%      +0.6%      15644 ±  8%  softirqs.CPU134.SCHED
      0.00       +2.2e+101%       0.22 ±187%    -100.0%       0.00        softirqs.CPU134.TASKLET
    519.44 ± 14%     +32.1%     686.22 ± 80%      -5.2%     492.50 ±  7%  softirqs.CPU134.TIMER
     86044 ±  7%     -10.9%      76634 ±  7%      -2.9%      83550 ±  7%  softirqs.CPU135.RCU
     15569 ±  5%      +9.3%      17019 ± 10%      +0.5%      15649 ±  9%  softirqs.CPU135.SCHED
      0.00       +6.7e+101%       0.67 ±234%   +5e+101%       0.50 ±300%  softirqs.CPU135.TASKLET
    569.67 ± 17%     -15.6%     481.00 ± 21%     +16.4%     663.20 ± 76%  softirqs.CPU135.TIMER
     86119 ±  7%     -10.9%      76697 ±  7%      -3.2%      83392 ±  7%  softirqs.CPU136.RCU
     15493 ±  6%      +8.2%      16758 ±  9%      +0.8%      15611 ±  8%  softirqs.CPU136.SCHED
      0.78 ±198%     -71.4%       0.22 ±282%    -100.0%       0.00        softirqs.CPU136.TASKLET
    599.11 ± 32%     -15.6%     505.78 ± 21%     -15.8%     504.40 ± 15%  softirqs.CPU136.TIMER
     85055 ±  7%     -10.8%      75853 ±  7%      -2.7%      82735 ±  7%  softirqs.CPU137.RCU
     15496 ±  5%      +9.9%      17025 ±  8%      +1.5%      15729 ±  8%  softirqs.CPU137.SCHED
    550.00 ± 18%     -12.6%     480.67 ± 15%      +2.3%     562.40 ± 15%  softirqs.CPU137.TIMER
     85504 ±  7%     -10.7%      76323 ±  7%      -2.6%      83275 ±  7%  softirqs.CPU138.RCU
     15399 ±  5%     +10.6%      17034 ±  8%      +0.9%      15534 ±  7%  softirqs.CPU138.SCHED
      0.00       +2.2e+101%       0.22 ±187%   +1e+101%       0.10 ±300%  softirqs.CPU138.TASKLET
    484.56 ± 15%      +0.2%     485.44 ± 18%      +2.2%     495.40 ± 12%  softirqs.CPU138.TIMER
     86109 ±  7%     -11.1%      76593 ±  7%      -3.0%      83483 ±  7%  softirqs.CPU139.RCU
     15501 ±  5%      +8.5%      16818 ±  8%      +0.8%      15618 ± 10%  softirqs.CPU139.SCHED
      0.11 ±282%      +0.0%       0.11 ±282%    +620.0%       0.80 ±207%  softirqs.CPU139.TASKLET
    560.78 ± 16%      -1.1%     554.89 ± 46%     +23.7%     693.50 ± 86%  softirqs.CPU139.TIMER
     86.44 ±  3%      +1.2%      87.44 ±  2%      -1.2%      85.40 ±  2%  softirqs.CPU14.NET_RX
     85234 ±  7%     -10.3%      76438 ±  7%      -4.0%      81845 ±  7%  softirqs.CPU14.RCU
     14319            +7.0%      15317 ±  3%      -0.0%      14318 ±  5%  softirqs.CPU14.SCHED
      2.22 ± 18%      -5.0%       2.11 ± 14%      +3.5%       2.30 ± 19%  softirqs.CPU14.TASKLET
      1041 ± 47%     -34.9%     678.33 ± 17%     -14.0%     895.00 ± 56%  softirqs.CPU14.TIMER
     85992 ±  7%     -11.0%      76519 ±  7%      -3.1%      83319 ±  7%  softirqs.CPU140.RCU
     15654 ±  6%      +7.2%      16784 ±  8%      -1.3%      15455 ±  7%  softirqs.CPU140.SCHED
      0.00          -100.0%       0.00         +1e+101%       0.10 ±300%  softirqs.CPU140.TASKLET
    557.00 ± 16%     -13.8%     480.00 ± 18%     -10.8%     497.10 ± 12%  softirqs.CPU140.TIMER
     85371 ±  7%     -10.5%      76426 ±  8%      -2.6%      83193 ±  7%  softirqs.CPU141.RCU
     15664 ±  6%      +7.9%      16907 ±  9%      +1.1%      15832 ± 10%  softirqs.CPU141.SCHED
      0.33 ±282%    -100.0%       0.00           -40.0%       0.20 ±300%  softirqs.CPU141.TASKLET
    563.67 ± 12%     -19.4%     454.44 ± 17%     +20.5%     679.40 ± 85%  softirqs.CPU141.TIMER
      0.00       +2.2e+101%       0.22 ±282%    -100.0%       0.00        softirqs.CPU142.NET_TX
     86029 ±  6%     -11.4%      76180 ±  8%      -3.5%      82986 ±  7%  softirqs.CPU142.RCU
     15536 ±  6%     +11.8%      17367 ± 11%      +0.1%      15556 ±  8%  softirqs.CPU142.SCHED
      0.33 ±282%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU142.TASKLET
    522.89 ± 10%    +152.4%       1319 ±180%      -8.4%     479.20 ±  6%  softirqs.CPU142.TIMER
      6.78 ±262%      -9.8%       6.11 ±260%     -94.1%       0.40 ±200%  softirqs.CPU143.NET_TX
     86233 ±  7%     -10.8%      76934 ±  7%      -3.3%      83401 ±  7%  softirqs.CPU143.RCU
     16392 ±  6%      +5.5%      17286 ± 12%      -2.4%      16001 ±  8%  softirqs.CPU143.SCHED
      0.33 ±200%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU143.TASKLET
      2093 ±103%      +4.2%       2181 ± 97%     -33.7%       1388 ±124%  softirqs.CPU143.TIMER
     86.44 ±  3%      +1.2%      87.44 ±  2%      -1.2%      85.40 ±  2%  softirqs.CPU15.NET_RX
     85206 ±  6%      -9.9%      76791 ±  7%      -2.6%      83016 ±  6%  softirqs.CPU15.RCU
     14388 ±  2%      +7.5%      15474 ±  4%      -3.2%      13921 ±  4%  softirqs.CPU15.SCHED
      1.78 ± 35%     +12.5%       2.00            +6.9%       1.90 ± 15%  softirqs.CPU15.TASKLET
    669.56 ± 19%      -3.8%     643.78 ± 20%     +26.4%     846.30 ± 29%  softirqs.CPU15.TIMER
     86.44 ±  3%      +1.2%      87.44 ±  2%      -1.2%      85.40 ±  2%  softirqs.CPU16.NET_RX
     79328 ±  7%      -9.3%      71969 ±  7%      -2.0%      77764 ±  7%  softirqs.CPU16.RCU
     14480 ±  3%      +5.9%      15330 ±  3%      -2.8%      14082 ±  3%  softirqs.CPU16.SCHED
      1.56 ± 53%     +35.7%       2.11 ± 14%     +15.7%       1.80 ± 41%  softirqs.CPU16.TASKLET
    695.78 ± 87%     -20.3%     554.44 ± 28%     -16.1%     583.90 ± 21%  softirqs.CPU16.TIMER
      0.00          -100.0%       0.00       +2.6e+103%      26.20 ±300%  softirqs.CPU17.BLOCK
     86.44 ±  3%      +1.2%      87.44 ±  2%      -1.2%      85.40 ±  2%  softirqs.CPU17.NET_RX
     79906 ±  7%      -9.5%      72319 ±  7%      -3.3%      77283 ±  7%  softirqs.CPU17.RCU
     14131            +9.2%      15431 ±  3%      -1.4%      13926 ±  5%  softirqs.CPU17.SCHED
      1.89 ± 16%      +5.9%       2.00 ± 47%     -10.0%       1.70 ± 37%  softirqs.CPU17.TASKLET
    746.44 ± 46%      -7.5%     690.67 ± 60%      +0.1%     747.50 ± 63%  softirqs.CPU17.TIMER
     88.44 ±  2%      +1.1%      89.44 ±  2%      -1.2%      87.40 ±  2%  softirqs.CPU18.NET_RX
      0.00       +2.2e+101%       0.22 ±282%   +2e+101%       0.20 ±300%  softirqs.CPU18.NET_TX
     91180 ±  8%     -12.2%      80022 ±  6%      -3.0%      88444 ±  6%  softirqs.CPU18.RCU
     15686 ±  5%      +7.5%      16859 ± 11%      +2.9%      16137 ± 11%  softirqs.CPU18.SCHED
      0.11 ±282%      +0.0%       0.11 ±282%    -100.0%       0.00        softirqs.CPU18.TASKLET
      1008 ± 42%     +48.2%       1494 ±162%     +36.7%       1379 ±142%  softirqs.CPU18.TIMER
     90.44 ±  2%      +1.1%      91.44 ±  2%      -1.2%      89.40 ±  2%  softirqs.CPU19.NET_RX
     90426 ±  8%     -12.3%      79333 ±  6%      -3.0%      87706 ±  7%  softirqs.CPU19.RCU
     15509 ±  4%      +5.6%      16375 ±  8%      +2.2%      15846 ±  6%  softirqs.CPU19.SCHED
      2.00           +11.1%       2.22 ± 28%      +0.0%       2.00 ± 22%  softirqs.CPU19.TASKLET
    786.78 ± 46%     -25.8%     583.89 ± 19%     -19.5%     633.60 ± 14%  softirqs.CPU19.TIMER
     86.44 ±  3%      +1.2%      87.44 ±  2%      -1.2%      85.40 ±  2%  softirqs.CPU2.NET_RX
      0.00          -100.0%       0.00         +1e+101%       0.10 ±300%  softirqs.CPU2.NET_TX
     84941 ±  6%      -7.7%      78386 ±  6%      -2.0%      83220 ±  6%  softirqs.CPU2.RCU
     15092 ±  3%      +7.5%      16231 ±  5%      +0.2%      15121 ±  6%  softirqs.CPU2.SCHED
      0.11 ±282%      +0.0%       0.11 ±282%     -10.0%       0.10 ±300%  softirqs.CPU2.TASKLET
    703.00 ± 37%     +63.2%       1147 ± 64%     +48.4%       1043 ± 66%  softirqs.CPU2.TIMER
     90.44 ±  2%      +1.1%      91.44 ±  2%      -1.2%      89.40 ±  2%  softirqs.CPU20.NET_RX
     89886 ±  8%     -12.0%      79086 ±  6%      -2.6%      87561 ±  7%  softirqs.CPU20.RCU
     15492 ±  5%      +7.1%      16598 ±  7%      +2.9%      15933 ±  5%  softirqs.CPU20.SCHED
      2.22 ± 28%      -5.0%       2.11 ± 14%     -10.0%       2.00 ± 22%  softirqs.CPU20.TASKLET
    718.33 ± 32%      -6.9%     668.89 ± 54%      -1.0%     711.30 ± 27%  softirqs.CPU20.TIMER
     90.44 ±  2%      +1.1%      91.44 ±  2%      -1.2%      89.40 ±  2%  softirqs.CPU21.NET_RX
     89661 ±  8%     -12.3%      78660 ±  6%      -3.2%      86812 ±  6%  softirqs.CPU21.RCU
     15713 ±  5%      +4.9%      16483 ±  8%      +1.4%      15933 ±  5%  softirqs.CPU21.SCHED
      2.00 ± 40%      +5.6%       2.11 ± 14%      +0.0%       2.00        softirqs.CPU21.TASKLET
    866.11 ± 78%     -41.5%     506.33 ± 18%     -28.8%     616.30 ± 15%  softirqs.CPU21.TIMER
     90.44 ±  2%      +1.1%      91.44 ±  2%      -1.2%      89.40 ±  2%  softirqs.CPU22.NET_RX
     89730 ±  8%     -11.9%      79029 ±  6%      -2.9%      87169 ±  6%  softirqs.CPU22.RCU
     15319 ±  5%      +8.1%      16555 ±  8%      +3.4%      15843 ±  5%  softirqs.CPU22.SCHED
      2.11 ± 14%     -10.5%       1.89 ± 16%      -5.3%       2.00        softirqs.CPU22.TASKLET
    646.89 ± 15%     -16.7%     538.89 ± 12%      -7.9%     595.60 ± 20%  softirqs.CPU22.TIMER
     90.44 ±  2%      +1.1%      91.44 ±  2%      -1.2%      89.40 ±  2%  softirqs.CPU23.NET_RX
     90359 ±  8%     -12.2%      79349 ±  6%      -2.7%      87899 ±  7%  softirqs.CPU23.RCU
     15413 ±  5%      +6.6%      16429 ±  7%      +2.6%      15817 ±  5%  softirqs.CPU23.SCHED
      2.11 ± 34%     -10.5%       1.89 ± 29%      -5.3%       2.00        softirqs.CPU23.TASKLET
    695.89 ± 13%     -22.5%     539.00 ± 11%      -3.1%     674.00 ± 21%  softirqs.CPU23.TIMER
     90.44 ±  2%      +1.1%      91.44 ±  2%      -1.2%      89.40 ±  2%  softirqs.CPU24.NET_RX
     90398 ±  8%     -12.2%      79346 ±  6%      -3.1%      87609 ±  6%  softirqs.CPU24.RCU
     15820 ±  6%      +3.8%      16421 ±  8%      +1.2%      16013 ±  6%  softirqs.CPU24.SCHED
      2.44 ± 51%     -22.7%       1.89 ± 29%     -10.0%       2.20 ± 18%  softirqs.CPU24.TASKLET
    852.00 ± 58%     -36.8%     538.33 ± 17%     -23.0%     656.10 ± 21%  softirqs.CPU24.TIMER
     90.44 ±  2%      +1.1%      91.44 ±  2%      -1.2%      89.40 ±  2%  softirqs.CPU25.NET_RX
     89602 ±  8%     -12.5%      78439 ±  6%      -2.5%      87341 ±  6%  softirqs.CPU25.RCU
     15433 ±  4%      +7.8%      16629 ±  8%      +3.1%      15918 ±  5%  softirqs.CPU25.SCHED
      2.22 ± 28%     -15.0%       1.89 ± 16%      -1.0%       2.20 ± 34%  softirqs.CPU25.TASKLET
    641.00 ± 11%     -14.8%     546.33 ± 19%      +3.8%     665.20 ± 19%  softirqs.CPU25.TIMER
     90.44 ±  2%      +1.1%      91.44 ±  2%      -1.2%      89.40 ±  2%  softirqs.CPU26.NET_RX
     89283 ±  8%     -12.0%      78553 ±  6%      -2.6%      86982 ±  6%  softirqs.CPU26.RCU
     15601 ±  6%      +5.7%      16495 ±  8%      +2.3%      15966 ±  5%  softirqs.CPU26.SCHED
      1.78 ± 23%     +12.5%       2.00           +18.1%       2.10 ± 14%  softirqs.CPU26.TASKLET
    822.56 ± 67%     -38.2%     508.22 ± 20%     -19.8%     659.70 ± 11%  softirqs.CPU26.TIMER
     90.44 ±  2%      +1.1%      91.44 ±  2%      -1.2%      89.40 ±  2%  softirqs.CPU27.NET_RX
     90342 ±  8%     -12.3%      79217 ±  6%      -2.5%      88054 ±  6%  softirqs.CPU27.RCU
     15553 ±  5%      +6.7%      16589 ±  7%      +1.6%      15809 ±  5%  softirqs.CPU27.SCHED
      0.00       +2.2e+101%       0.22 ±282%    -100.0%       0.00        softirqs.CPU27.TASKLET
    690.89 ± 19%     -23.0%     532.22 ± 14%     -11.6%     610.70 ± 18%  softirqs.CPU27.TIMER
     90.44 ±  2%      +1.1%      91.44 ±  2%      -1.2%      89.40 ±  2%  softirqs.CPU28.NET_RX
     90112 ±  8%     -12.1%      79229 ±  6%      -2.4%      87920 ±  6%  softirqs.CPU28.RCU
     15468 ±  4%      +7.3%      16599 ±  8%      +2.7%      15891 ±  5%  softirqs.CPU28.SCHED
      0.22 ±187%    -100.0%       0.00           -55.0%       0.10 ±300%  softirqs.CPU28.TASKLET
    628.22 ± 11%     -16.6%     523.78 ± 15%      +3.2%     648.40 ± 14%  softirqs.CPU28.TIMER
     90.44 ±  2%      +1.1%      91.44 ±  2%      -1.2%      89.40 ±  2%  softirqs.CPU29.NET_RX
     89766 ±  8%     -12.6%      78434 ±  7%      -2.8%      87280 ±  6%  softirqs.CPU29.RCU
     15475 ±  4%      +8.5%      16789 ±  9%      +2.6%      15880 ±  5%  softirqs.CPU29.SCHED
      0.11 ±282%      +0.0%       0.11 ±282%    -100.0%       0.00        softirqs.CPU29.TASKLET
    632.67 ± 11%     +15.0%     727.78 ± 79%      +2.5%     648.60 ± 10%  softirqs.CPU29.TIMER
     86.44 ±  3%      +1.2%      87.44 ±  2%      -1.2%      85.40 ±  2%  softirqs.CPU3.NET_RX
      0.00       +2.2e+101%       0.22 ±282%   +1e+101%       0.10 ±300%  softirqs.CPU3.NET_TX
     85323 ±  6%      -9.6%      77121 ±  7%      -2.3%      83401 ±  7%  softirqs.CPU3.RCU
     14404 ±  3%     +10.5%      15922 ±  5%      -2.2%      14090 ±  5%  softirqs.CPU3.SCHED
      0.00       +7.8e+101%       0.78 ±198%   +4e+101%       0.40 ±165%  softirqs.CPU3.TASKLET
    701.11 ± 64%     +93.6%       1357 ±108%     +23.5%     866.10 ± 67%  softirqs.CPU3.TIMER
     90.44 ±  2%      +1.1%      91.44 ±  2%      -1.2%      89.40 ±  2%  softirqs.CPU30.NET_RX
     88884 ±  8%     -11.6%      78558 ±  6%      -3.5%      85800 ±  5%  softirqs.CPU30.RCU
     15522 ±  5%      +7.6%      16699 ±  8%      +1.8%      15807 ±  6%  softirqs.CPU30.SCHED
      0.00       +2.2e+101%       0.22 ±187%   +6e+101%       0.60 ±300%  softirqs.CPU30.TASKLET
    600.67 ± 16%     -16.0%     504.67 ± 14%      -1.1%     594.20 ± 18%  softirqs.CPU30.TIMER
     90.44 ±  2%      +1.1%      91.44 ±  2%      -1.2%      89.40 ±  2%  softirqs.CPU31.NET_RX
     89039 ±  8%     -12.5%      77917 ±  5%      -2.2%      87071 ±  6%  softirqs.CPU31.RCU
     15508 ±  4%      +6.2%      16466 ±  9%      +2.2%      15841 ±  5%  softirqs.CPU31.SCHED
      0.00         +1e+102%       1.00 ±163%   +1e+101%       0.10 ±300%  softirqs.CPU31.TASKLET
    647.56 ± 18%     -16.6%     540.11 ± 19%      +2.2%     662.10 ± 26%  softirqs.CPU31.TIMER
     90.44 ±  2%      +1.1%      91.44 ±  2%      -1.2%      89.40 ±  2%  softirqs.CPU32.NET_RX
     83726 ±  8%     -11.0%      74489 ±  7%      -2.7%      81466 ±  6%  softirqs.CPU32.RCU
     15414 ±  5%      +8.0%      16645 ±  7%      +2.6%      15819 ±  6%  softirqs.CPU32.SCHED
      0.33 ±141%      +0.0%       0.33 ±282%     -10.0%       0.30 ±213%  softirqs.CPU32.TASKLET
    524.78 ± 17%     -11.2%     465.89 ± 20%      -3.6%     505.70 ± 21%  softirqs.CPU32.TIMER
     90.44 ±  2%      +1.1%      91.44 ±  2%      -1.2%      89.40 ±  2%  softirqs.CPU33.NET_RX
     83164 ±  7%     -10.8%      74149 ±  7%      -2.4%      81190 ±  6%  softirqs.CPU33.RCU
     15630 ±  5%      +5.5%      16488 ±  8%      +2.1%      15964 ±  5%  softirqs.CPU33.SCHED
      0.22 ±282%    -100.0%       0.00          +170.0%       0.60 ±249%  softirqs.CPU33.TASKLET
    558.33 ± 28%     -24.4%     422.33 ±  9%      -4.9%     531.10 ± 20%  softirqs.CPU33.TIMER
     90.44 ±  2%      +1.1%      91.44 ±  2%      -1.2%      89.40 ±  2%  softirqs.CPU34.NET_RX
     83901 ±  7%     -11.2%      74523 ±  6%      -2.6%      81759 ±  6%  softirqs.CPU34.RCU
     15920 ±  6%      +4.8%      16685 ±  9%      -0.2%      15884 ±  6%  softirqs.CPU34.SCHED
    619.67 ± 41%      -1.8%     608.22 ± 76%     -17.1%     514.00 ± 23%  softirqs.CPU34.TIMER
     90.44 ±  2%      +1.1%      91.44 ±  2%      -1.2%      89.40 ±  2%  softirqs.CPU35.NET_RX
      0.22 ±282%   +2650.0%       6.11 ±282%     -10.0%       0.20 ±300%  softirqs.CPU35.NET_TX
     84625 ±  8%     -11.5%      74918 ±  7%      -3.1%      81974 ±  6%  softirqs.CPU35.RCU
     15943 ±  8%      +5.7%      16847 ± 13%      +0.6%      16042 ±  4%  softirqs.CPU35.SCHED
      0.11 ±282%    -100.0%       0.00          +170.0%       0.30 ±213%  softirqs.CPU35.TASKLET
      1379 ±155%      -5.9%       1298 ±178%     -28.1%     991.90 ±144%  softirqs.CPU35.TIMER
     86.44 ±  3%      +1.2%      87.44 ±  2%      -1.2%      85.40 ±  2%  softirqs.CPU36.NET_RX
     90287 ±  7%     -11.9%      79575 ±  7%      -3.2%      87410 ±  6%  softirqs.CPU36.RCU
     15617 ±  8%      +7.7%      16814 ±  4%      -1.8%      15339 ±  8%  softirqs.CPU36.SCHED
      2.11 ± 14%      -5.3%       2.00            -0.5%       2.10 ± 14%  softirqs.CPU36.TASKLET
    761.11 ± 12%     -12.2%     668.33 ± 12%      -7.8%     702.10 ± 15%  softirqs.CPU36.TIMER
     86.44 ±  3%      +1.2%      87.44 ±  2%      -1.2%      85.40 ±  2%  softirqs.CPU37.NET_RX
     90076 ±  7%     -11.6%      79599 ±  7%      -3.8%      86692 ±  6%  softirqs.CPU37.RCU
     15734 ±  7%      +8.0%      16988 ±  3%      -4.9%      14970 ± 11%  softirqs.CPU37.SCHED
      1.89 ± 16%     +11.8%       2.11 ± 14%     +42.9%       2.70 ± 55%  softirqs.CPU37.TASKLET
    643.22 ±  9%      -2.3%     628.33 ± 14%      +2.4%     658.70 ± 14%  softirqs.CPU37.TIMER
     86.44 ±  3%      +1.2%      87.44 ±  2%      -1.2%      85.40 ±  2%  softirqs.CPU38.NET_RX
     89063 ±  8%     -11.0%      79298 ±  7%      -2.6%      86750 ±  7%  softirqs.CPU38.RCU
     15724 ±  7%      +7.1%      16842 ±  3%      -1.9%      15433 ±  7%  softirqs.CPU38.SCHED
      2.00            +0.0%       2.00            +5.0%       2.10 ± 14%  softirqs.CPU38.TASKLET
    648.67 ± 15%     -12.7%     566.44 ± 16%      +5.8%     686.10 ± 15%  softirqs.CPU38.TIMER
     86.44 ±  3%      +1.2%      87.44 ±  2%      -1.2%      85.40 ±  2%  softirqs.CPU39.NET_RX
     89071 ±  6%     -11.3%      79045 ±  8%      -2.5%      86811 ±  7%  softirqs.CPU39.RCU
     15837 ±  5%      +7.6%      17046 ±  4%      -3.6%      15263 ±  9%  softirqs.CPU39.SCHED
      2.33 ± 40%      -9.5%       2.11 ± 14%      -5.7%       2.20 ± 34%  softirqs.CPU39.TASKLET
    849.67 ± 58%     -31.6%     581.56 ± 14%     -21.4%     668.10 ± 14%  softirqs.CPU39.TIMER
     86.44 ±  3%      +1.2%      87.44 ±  2%      -1.2%      85.40 ±  2%  softirqs.CPU4.NET_RX
      0.00          -100.0%       0.00         +2e+101%       0.20 ±300%  softirqs.CPU4.NET_TX
     84191 ±  7%      -8.5%      77054 ±  7%      -1.1%      83267 ±  7%  softirqs.CPU4.RCU
     13623 ±  5%     +12.9%      15383 ±  3%      +3.7%      14124 ±  5%  softirqs.CPU4.SCHED
      0.11 ±282%    +100.0%       0.22 ±187%     +80.0%       0.20 ±200%  softirqs.CPU4.TASKLET
    584.44 ± 20%      +0.2%     585.56 ± 16%     +83.5%       1072 ±126%  softirqs.CPU4.TIMER
     86.44 ±  3%      +1.2%      87.44 ±  2%      -1.2%      85.40 ±  2%  softirqs.CPU40.NET_RX
     90249 ±  7%     -12.2%      79215 ±  7%      -4.0%      86629 ±  7%  softirqs.CPU40.RCU
     15666 ±  6%      +7.3%      16806 ±  3%      -1.2%      15476 ±  7%  softirqs.CPU40.SCHED
      2.00 ± 23%      +5.6%       2.11 ± 14%      +0.0%       2.00 ± 22%  softirqs.CPU40.TASKLET
    641.89 ± 16%      +3.8%     666.11 ± 17%     +22.5%     786.40 ± 71%  softirqs.CPU40.TIMER
     86.44 ±  3%      +1.2%      87.44 ±  2%      -1.2%      85.40 ±  2%  softirqs.CPU41.NET_RX
     90077 ±  7%     -11.8%      79406 ±  7%      -3.2%      87216 ±  6%  softirqs.CPU41.RCU
     15778 ±  8%      +6.2%      16762 ±  4%      -2.9%      15323 ±  7%  softirqs.CPU41.SCHED
      2.22 ± 46%      +5.0%       2.33 ± 40%     -14.5%       1.90 ± 15%  softirqs.CPU41.TASKLET
    698.89 ± 15%     -13.6%     603.78 ± 19%      -0.2%     697.60 ± 19%  softirqs.CPU41.TIMER
     86.44 ±  3%      +1.2%      87.44 ±  2%      -1.2%      85.40 ±  2%  softirqs.CPU42.NET_RX
      0.00          -100.0%       0.00         +2e+101%       0.20 ±300%  softirqs.CPU42.NET_TX
     89356 ±  7%     -11.4%      79197 ±  7%      -3.2%      86499 ±  7%  softirqs.CPU42.RCU
     15800 ±  7%      +7.0%      16903 ±  4%      -2.0%      15477 ±  6%  softirqs.CPU42.SCHED
      1.89 ± 16%     +11.8%       2.11 ± 14%     -10.0%       1.70 ± 26%  softirqs.CPU42.TASKLET
    664.44 ± 23%      -6.4%     621.67 ± 19%     +29.5%     860.70 ± 67%  softirqs.CPU42.TIMER
     86.44 ±  3%      +1.2%      87.44 ±  2%      -1.2%      85.40 ±  2%  softirqs.CPU43.NET_RX
     89722 ±  7%     -11.7%      79248 ±  7%      -3.5%      86610 ±  6%  softirqs.CPU43.RCU
     15854 ±  8%      +6.0%      16807 ±  5%      -0.8%      15729 ±  8%  softirqs.CPU43.SCHED
      2.11 ± 14%      -5.3%       2.00            -5.3%       2.00        softirqs.CPU43.TASKLET
    673.44 ± 33%     -15.2%     570.78 ± 15%     +29.7%     873.60 ± 58%  softirqs.CPU43.TIMER
     86.44 ±  3%      +1.2%      87.44 ±  2%      -1.2%      85.40 ±  2%  softirqs.CPU44.NET_RX
     90212 ±  7%     -11.4%      79900 ±  7%      -3.2%      87338 ±  7%  softirqs.CPU44.RCU
     15887 ±  7%      +5.9%      16819 ±  3%      -2.6%      15467 ±  7%  softirqs.CPU44.SCHED
      0.11 ±282%    +100.0%       0.22 ±187%     +80.0%       0.20 ±300%  softirqs.CPU44.TASKLET
    684.67 ± 24%     -15.2%     580.44 ± 18%     +50.9%       1032 ±108%  softirqs.CPU44.TIMER
     89779 ±  7%     -11.7%      79271 ±  7%      -2.9%      87179 ±  7%  softirqs.CPU45.RCU
     15765 ±  7%      +6.7%      16824 ±  3%      -2.8%      15325 ±  7%  softirqs.CPU45.SCHED
      0.11 ±282%    +100.0%       0.22 ±282%    -100.0%       0.00        softirqs.CPU45.TASKLET
    633.67 ± 20%      -3.6%     611.11 ± 16%      +1.0%     640.20 ± 16%  softirqs.CPU45.TIMER
     89366 ±  7%     -11.6%      78983 ±  7%      -3.2%      86466 ±  6%  softirqs.CPU46.RCU
     15825 ±  7%      +7.3%      16985 ±  4%      -1.5%      15589 ±  7%  softirqs.CPU46.SCHED
    606.89 ±  8%     +17.7%     714.11 ± 43%     +49.4%     906.90 ± 88%  softirqs.CPU46.TIMER
     89426 ±  7%     -11.2%      79420 ±  7%      -3.1%      86612 ±  6%  softirqs.CPU47.RCU
     15782 ±  7%      +6.6%      16831 ±  3%      -3.8%      15181 ±  8%  softirqs.CPU47.SCHED
      0.11 ±282%    +200.0%       0.33 ±141%     -10.0%       0.10 ±300%  softirqs.CPU47.TASKLET
    669.22 ± 14%     -11.3%     593.67 ± 18%      -1.5%     659.10 ± 13%  softirqs.CPU47.TIMER
     86980 ±  7%     -11.3%      77153 ±  7%      -3.4%      84040 ±  7%  softirqs.CPU48.RCU
     15829 ±  7%      +6.1%      16793 ±  4%      -2.9%      15374 ±  7%  softirqs.CPU48.SCHED
      0.22 ±282%     -50.0%       0.11 ±282%    -100.0%       0.00        softirqs.CPU48.TASKLET
    576.67 ± 15%      -6.5%     539.44 ± 14%      +3.1%     594.80 ± 25%  softirqs.CPU48.TIMER
     87101 ±  7%     -11.1%      77414 ±  7%      -3.2%      84300 ±  7%  softirqs.CPU49.RCU
     15617 ±  7%      +7.1%      16728 ±  4%      -1.7%      15354 ±  7%  softirqs.CPU49.SCHED
      0.00          -100.0%       0.00         +1e+101%       0.10 ±300%  softirqs.CPU49.TASKLET
    596.44 ± 18%      -2.3%     582.44 ± 21%      -9.2%     541.40 ±  9%  softirqs.CPU49.TIMER
      2.00            +0.0%       2.00            +0.0%       2.00        softirqs.CPU5.HI
     86.44 ±  3%      +1.2%      87.44 ±  2%      -1.2%      85.40 ±  2%  softirqs.CPU5.NET_RX
     85222 ±  6%      -9.9%      76768 ±  7%      -2.8%      82823 ±  7%  softirqs.CPU5.RCU
     14367            +7.1%      15388 ±  2%      -0.1%      14351 ±  8%  softirqs.CPU5.SCHED
     48.22            +0.0%      48.22            +0.4%      48.40        softirqs.CPU5.TASKLET
    615.33 ± 20%      -2.0%     603.33 ± 14%     +31.0%     805.90 ± 60%  softirqs.CPU5.TIMER
     86910 ±  7%     -11.2%      77170 ±  7%      -3.3%      84027 ±  6%  softirqs.CPU50.RCU
     15658 ±  7%      +8.6%      17004 ±  7%      -0.9%      15519 ±  8%  softirqs.CPU50.SCHED
    588.33 ± 14%     +21.9%     717.44 ± 74%      -7.5%     544.10 ± 19%  softirqs.CPU50.TIMER
     86810 ±  7%     -11.1%      77147 ±  7%      -3.3%      83934 ±  6%  softirqs.CPU51.RCU
     15842 ±  7%      +7.2%      16987 ±  4%      -2.3%      15485 ±  7%  softirqs.CPU51.SCHED
      0.11 ±282%      +0.0%       0.11 ±282%    -100.0%       0.00        softirqs.CPU51.TASKLET
    570.67 ±  7%      +6.6%     608.11 ± 24%      +0.6%     573.90 ± 18%  softirqs.CPU51.TIMER
     87075 ±  7%     -11.7%      76844 ±  8%      -3.2%      84331 ±  6%  softirqs.CPU52.RCU
     15899 ±  8%      +6.2%      16889 ±  3%      -2.7%      15471 ±  8%  softirqs.CPU52.SCHED
      0.00       +1.1e+101%       0.11 ±282%    -100.0%       0.00        softirqs.CPU52.TASKLET
    795.33 ± 77%     -33.5%     529.22 ± 14%     -28.7%     567.20 ± 26%  softirqs.CPU52.TIMER
      0.00          -100.0%       0.00         +2e+101%       0.20 ±300%  softirqs.CPU53.NET_TX
     86983 ±  7%     -11.0%      77421 ±  7%      -2.8%      84573 ±  7%  softirqs.CPU53.RCU
     15870 ±  7%      +6.0%      16825 ±  3%      -1.6%      15617 ±  7%  softirqs.CPU53.SCHED
      0.22 ±282%    -100.0%       0.00           -10.0%       0.20 ±300%  softirqs.CPU53.TASKLET
    542.89 ± 11%      +1.2%     549.67 ± 16%     +88.2%       1021 ±138%  softirqs.CPU53.TIMER
     87641 ±  7%     -11.4%      77691 ±  7%      -3.9%      84254 ±  6%  softirqs.CPU54.RCU
     15738 ±  6%      +6.4%      16742 ±  9%      -1.1%      15567 ±  9%  softirqs.CPU54.SCHED
      2.22 ± 28%     +10.0%       2.44 ± 39%      -5.5%       2.10 ± 14%  softirqs.CPU54.TASKLET
    779.11 ± 47%     -23.6%     595.22 ± 14%      +6.7%     831.50 ± 80%  softirqs.CPU54.TIMER
      0.00       +5.6e+102%       5.56 ±282%    -100.0%       0.00        softirqs.CPU55.NET_TX
     86779 ±  7%     -11.1%      77104 ±  7%      -3.4%      83866 ±  6%  softirqs.CPU55.RCU
     15610 ±  6%      +7.4%      16772 ±  9%      +0.4%      15670 ±  7%  softirqs.CPU55.SCHED
      2.22 ± 28%     -10.0%       2.00           -10.0%       2.00        softirqs.CPU55.TASKLET
    569.11 ± 21%     +10.5%     628.67 ± 40%      +8.6%     618.20 ± 68%  softirqs.CPU55.TIMER
     86823 ±  7%     -10.9%      77333 ±  7%      -3.4%      83858 ±  6%  softirqs.CPU56.RCU
     15737 ±  7%      +7.7%      16953 ±  9%      -0.8%      15604 ±  8%  softirqs.CPU56.SCHED
      2.11 ± 26%      -5.3%       2.00 ± 23%      -0.5%       2.10 ± 14%  softirqs.CPU56.TASKLET
    577.00 ± 16%      -0.3%     575.00 ± 36%      -7.6%     532.90 ± 16%  softirqs.CPU56.TIMER
     87217 ±  7%     -11.3%      77388 ±  7%      -4.2%      83519 ±  7%  softirqs.CPU57.RCU
     15804 ±  6%      +7.8%      17030 ±  9%      -1.1%      15627 ±  8%  softirqs.CPU57.SCHED
      2.11 ± 26%      +0.0%       2.11 ± 34%     -10.0%       1.90 ± 15%  softirqs.CPU57.TASKLET
    602.22 ± 18%     -17.8%     494.89 ± 15%     -18.6%     490.00 ± 17%  softirqs.CPU57.TIMER
     86829 ±  7%     -10.6%      77633 ±  7%      -3.4%      83855 ±  6%  softirqs.CPU58.RCU
     15613 ±  7%      +9.0%      17012 ±  8%      +0.1%      15634 ±  8%  softirqs.CPU58.SCHED
      2.11 ± 14%      -5.3%       2.00            -5.3%       2.00        softirqs.CPU58.TASKLET
    745.56 ± 64%     -28.1%     536.11 ± 18%     -29.1%     528.50 ± 20%  softirqs.CPU58.TIMER
     86859 ±  7%     -10.7%      77524 ±  7%      -3.5%      83832 ±  6%  softirqs.CPU59.RCU
     15543 ±  6%      +9.2%      16972 ±  9%      +0.2%      15576 ±  9%  softirqs.CPU59.SCHED
      1.89 ± 16%     +17.6%       2.22 ± 28%      +0.6%       1.90 ± 15%  softirqs.CPU59.TASKLET
    545.56 ± 12%      -3.5%     526.44 ± 17%     -12.1%     479.70 ± 10%  softirqs.CPU59.TIMER
     86.44 ±  3%      +1.2%      87.44 ±  2%      -1.2%      85.40 ±  2%  softirqs.CPU6.NET_RX
      0.00       +1.1e+101%       0.11 ±282%    -100.0%       0.00        softirqs.CPU6.NET_TX
     84644 ±  6%      -9.5%      76573 ±  7%      -2.8%      82315 ±  8%  softirqs.CPU6.RCU
     14286 ±  4%      +6.0%      15136 ±  3%      -1.0%      14149 ±  5%  softirqs.CPU6.SCHED
      0.11 ±282%    +200.0%       0.33 ±282%    -100.0%       0.00        softirqs.CPU6.TASKLET
    617.11 ± 21%      -3.0%     598.44 ±  9%      -5.7%     581.70 ± 23%  softirqs.CPU6.TIMER
     86218 ±  7%     -10.6%      77054 ±  7%      -2.9%      83749 ±  6%  softirqs.CPU60.RCU
     15591 ±  6%      +8.7%      16944 ±  8%      +0.7%      15706 ±  9%  softirqs.CPU60.SCHED
      2.00            +0.0%       2.00           +10.0%       2.20 ± 27%  softirqs.CPU60.TASKLET
    538.44 ± 19%      -5.1%     511.22 ± 18%      -6.5%     503.70 ± 10%  softirqs.CPU60.TIMER
     86375 ±  7%     -10.7%      77151 ±  7%      -3.1%      83666 ±  6%  softirqs.CPU61.RCU
     15654 ±  6%      +9.1%      17083 ±  7%      -0.2%      15615 ±  8%  softirqs.CPU61.SCHED
      2.00            +5.6%       2.11 ± 14%      +0.0%       2.00        softirqs.CPU61.TASKLET
    579.56 ± 21%     +10.8%     642.22 ± 68%      -4.5%     553.60 ± 15%  softirqs.CPU61.TIMER
     86843 ±  7%     -10.7%      77531 ±  7%      -3.4%      83927 ±  6%  softirqs.CPU62.RCU
     15635 ±  6%      +7.9%      16875 ±  8%      -0.5%      15556 ±  8%  softirqs.CPU62.SCHED
      0.11 ±282%    +100.0%       0.22 ±187%    -100.0%       0.00        softirqs.CPU62.TASKLET
    531.11 ± 16%      -0.8%     527.00 ± 17%      +4.4%     554.60 ± 10%  softirqs.CPU62.TIMER
     86085 ±  8%     -10.0%      77435 ±  7%      -2.6%      83857 ±  6%  softirqs.CPU63.RCU
     15599 ±  5%      +9.2%      17034 ±  9%      -0.1%      15577 ±  7%  softirqs.CPU63.SCHED
      0.00       +2.2e+101%       0.22 ±282%   +1e+101%       0.10 ±300%  softirqs.CPU63.TASKLET
    570.11 ± 17%      -6.4%     533.89 ± 14%      -5.7%     537.80 ± 10%  softirqs.CPU63.TIMER
     86600 ±  7%     -10.9%      77182 ±  7%      -3.3%      83761 ±  6%  softirqs.CPU64.RCU
     15622 ±  5%      +7.6%      16816 ±  8%      -1.0%      15465 ±  9%  softirqs.CPU64.SCHED
      0.11 ±282%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU64.TASKLET
    649.22 ± 40%     -19.6%     522.11 ± 11%     -14.5%     555.20 ± 19%  softirqs.CPU64.TIMER
     86414 ±  7%     -11.0%      76870 ±  7%      -3.1%      83773 ±  6%  softirqs.CPU65.RCU
     15752 ±  5%      +9.1%      17183 ±  9%      -0.9%      15617 ±  8%  softirqs.CPU65.SCHED
      0.00          -100.0%       0.00         +3e+101%       0.30 ±300%  softirqs.CPU65.TASKLET
    547.11 ± 28%     +44.9%     792.78 ± 88%      -3.5%     527.80 ± 14%  softirqs.CPU65.TIMER
     86186 ±  7%     -10.8%      76841 ±  7%      -3.2%      83432 ±  6%  softirqs.CPU66.RCU
     15619 ±  6%      +8.9%      17002 ±  7%      +0.5%      15690 ±  8%  softirqs.CPU66.SCHED
      0.11 ±282%    +300.0%       0.44 ±187%     -10.0%       0.10 ±300%  softirqs.CPU66.TASKLET
    605.89 ± 17%     -14.0%     521.33 ± 13%      -6.5%     566.80 ± 26%  softirqs.CPU66.TIMER
     86439 ±  7%     -10.9%      77049 ±  7%      -3.2%      83653 ±  7%  softirqs.CPU67.RCU
     15720 ±  6%      +7.0%      16821 ±  8%      -0.5%      15647 ±  8%  softirqs.CPU67.SCHED
      0.00       +2.2e+101%       0.22 ±282%    -100.0%       0.00        softirqs.CPU67.TASKLET
    713.11 ± 49%     -32.5%     481.00 ± 16%     -29.5%     502.80 ± 15%  softirqs.CPU67.TIMER
     86502 ±  7%     -10.9%      77040 ±  7%      -3.1%      83789 ±  6%  softirqs.CPU68.RCU
     15547 ±  6%      +9.6%      17047 ±  9%      +0.2%      15578 ±  8%  softirqs.CPU68.SCHED
      0.11 ±282%    +300.0%       0.44 ±187%     +80.0%       0.20 ±300%  softirqs.CPU68.TASKLET
    566.33 ± 12%     +18.0%     668.11 ± 81%     +23.7%     700.30 ± 65%  softirqs.CPU68.TIMER
     86420 ±  7%     -10.5%      77368 ±  7%      -3.2%      83641 ±  7%  softirqs.CPU69.RCU
     15757 ±  6%      +7.5%      16932 ±  9%      -1.6%      15504 ±  8%  softirqs.CPU69.SCHED
      0.22 ±282%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU69.TASKLET
    648.78 ±  8%     -22.8%     501.11 ± 18%     -16.8%     539.80 ± 12%  softirqs.CPU69.TIMER
     86.44 ±  3%      +1.2%      87.44 ±  2%      -1.2%      85.40 ±  2%  softirqs.CPU7.NET_RX
     84829 ±  6%      -9.8%      76503 ±  7%      -2.2%      82985 ±  6%  softirqs.CPU7.RCU
     14219            +9.1%      15517            -0.9%      14087 ±  3%  softirqs.CPU7.SCHED
      0.00       +7.8e+101%       0.78 ±240%   +2e+101%       0.20 ±200%  softirqs.CPU7.TASKLET
    587.78 ± 13%      +0.6%     591.33 ± 19%      +9.7%     644.80 ± 24%  softirqs.CPU7.TIMER
     86434 ±  7%     -11.0%      76939 ±  7%      -3.3%      83546 ±  7%  softirqs.CPU70.RCU
     15519 ±  5%      +9.5%      16994 ±  9%      +0.3%      15570 ±  7%  softirqs.CPU70.SCHED
      0.22 ±282%     -50.0%       0.11 ±282%    -100.0%       0.00        softirqs.CPU70.TASKLET
    582.89 ± 17%     -12.1%     512.22 ± 15%     -11.9%     513.50 ± 13%  softirqs.CPU70.TIMER
      0.22 ±282%      +0.0%       0.22 ±282%    -100.0%       0.00        softirqs.CPU71.NET_TX
     86323 ±  6%     -11.0%      76843 ±  7%      -3.3%      83512 ±  7%  softirqs.CPU71.RCU
     15860 ±  9%      +7.6%      17073 ±  8%      -1.6%      15605 ±  7%  softirqs.CPU71.SCHED
      0.56 ±149%     -80.0%       0.11 ±282%     -64.0%       0.20 ±300%  softirqs.CPU71.TASKLET
      1043 ±126%      -3.9%       1003 ±147%     -50.8%     513.50 ± 11%  softirqs.CPU71.TIMER
      0.00          -100.0%       0.00       +5.3e+103%      52.80 ±198%  softirqs.CPU72.BLOCK
     86255 ±  5%     -10.1%      77572 ±  7%      -2.4%      84212 ±  7%  softirqs.CPU72.RCU
     14087 ±  8%      +5.7%      14883 ±  2%      -2.8%      13688 ±  5%  softirqs.CPU72.SCHED
      2.11 ± 14%     +10.5%       2.33 ± 40%     -14.7%       1.80 ± 81%  softirqs.CPU72.TASKLET
    929.67 ± 74%     -31.2%     639.78 ± 18%      -4.1%     891.80 ± 27%  softirqs.CPU72.TIMER
     85501 ±  5%      -8.7%      78099 ±  7%      -1.5%      84233 ±  7%  softirqs.CPU73.RCU
     14134 ±  8%     +11.2%      15720 ±  4%      -1.5%      13921 ±  6%  softirqs.CPU73.SCHED
      2.00 ± 23%     +11.1%       2.22 ± 18%     -10.0%       1.80 ± 54%  softirqs.CPU73.TASKLET
      1018 ± 96%     +18.2%       1203 ± 64%     -14.5%     870.20 ± 43%  softirqs.CPU73.TIMER
      0.00       +2.9e+103%      29.11 ±282%    -100.0%       0.00        softirqs.CPU74.BLOCK
     86578 ±  6%     -10.0%      77929 ±  6%      -2.7%      84212 ±  6%  softirqs.CPU74.RCU
     14255 ±  5%      +7.2%      15277 ±  3%      -1.5%      14036 ±  6%  softirqs.CPU74.SCHED
      2.00           -38.9%       1.22 ± 92%      +0.0%       2.00 ± 38%  softirqs.CPU74.TASKLET
    884.33 ± 76%      -9.6%     799.11 ± 47%     -13.5%     765.10 ± 21%  softirqs.CPU74.TIMER
     29.11 ±282%    +100.0%      58.22 ±187%     -11.4%      25.80 ±299%  softirqs.CPU75.BLOCK
     86620 ±  5%      -9.7%      78218 ±  7%      -2.8%      84176 ±  7%  softirqs.CPU75.RCU
     13970 ±  4%      +7.6%      15028 ±  3%      -2.0%      13697 ±  6%  softirqs.CPU75.SCHED
      2.22 ± 66%     -25.0%       1.67 ± 48%     -14.5%       1.90 ± 15%  softirqs.CPU75.TASKLET
    664.33 ± 13%     +17.6%     781.22 ± 38%      +7.3%     712.90 ± 17%  softirqs.CPU75.TIMER
      0.44 ±282%   +6450.0%      29.11 ±282%    -100.0%       0.00        softirqs.CPU76.BLOCK
     86174 ±  6%      -9.5%      78005 ±  7%      -1.7%      84699 ±  7%  softirqs.CPU76.RCU
     13797 ±  4%      +4.2%      14381 ±  8%      -1.6%      13574 ±  4%  softirqs.CPU76.SCHED
      1.56 ± 74%      +0.0%       1.56 ± 96%     +22.1%       1.90 ± 64%  softirqs.CPU76.TASKLET
    710.56 ± 20%      -1.3%     701.22 ± 15%     +26.3%     897.40 ± 55%  softirqs.CPU76.TIMER
    175.11 ± 69%     -33.5%     116.44 ±111%     -55.1%      78.60 ±152%  softirqs.CPU77.BLOCK
     86853 ±  6%     -10.2%      77977 ±  6%      -2.6%      84606 ±  6%  softirqs.CPU77.RCU
     14459            +4.7%      15132 ±  2%      -4.6%      13798 ±  5%  softirqs.CPU77.SCHED
      0.00       +7.8e+101%       0.78 ±145%   +8e+101%       0.80 ±122%  softirqs.CPU77.TASKLET
    764.33 ± 43%     -15.8%     643.33 ± 13%     -11.3%     678.20 ± 11%  softirqs.CPU77.TIMER
     57.33 ±187%     -49.2%      29.11 ±282%     +37.1%      78.60 ±152%  softirqs.CPU78.BLOCK
     86444 ±  6%      -9.8%      77985 ±  7%      -2.4%      84337 ±  7%  softirqs.CPU78.RCU
     14064 ±  4%      +7.0%      15052 ±  3%      -0.4%      14003 ±  4%  softirqs.CPU78.SCHED
      0.44 ±187%     -75.0%       0.11 ±282%    +215.0%       1.40 ±128%  softirqs.CPU78.TASKLET
    702.22 ± 16%      -1.4%     692.67 ± 26%      +2.5%     720.10 ± 32%  softirqs.CPU78.TIMER
     86641 ±  6%     -10.3%      77754 ±  7%      -2.1%      84792 ±  6%  softirqs.CPU79.RCU
     14258 ±  2%      +8.3%      15435 ±  3%      -2.2%      13946 ±  5%  softirqs.CPU79.SCHED
      0.33 ±141%    -100.0%       0.00           +20.0%       0.40 ±229%  softirqs.CPU79.TASKLET
    684.22 ± 13%     -10.0%     615.89 ± 18%     +18.6%     811.20 ± 39%  softirqs.CPU79.TIMER
     86.33 ±  3%      +1.3%      87.44 ±  2%      -1.4%      85.10 ±  2%  softirqs.CPU8.NET_RX
     48.44 ± 35%     -30.7%      33.56 ± 70%     +12.5%      54.50 ±  2%  softirqs.CPU8.NET_TX
     84959 ±  6%      -9.3%      77034 ±  7%      -2.5%      82856 ±  8%  softirqs.CPU8.RCU
     14482 ±  2%      +6.4%      15404 ±  2%      -2.1%      14183 ±  3%  softirqs.CPU8.SCHED
      0.11 ±282%    -100.0%       0.00           -10.0%       0.10 ±300%  softirqs.CPU8.TASKLET
    830.22 ± 20%     -22.8%     641.00 ± 13%     -14.1%     713.00 ± 12%  softirqs.CPU8.TIMER
     87229 ±  6%      -9.9%      78622 ±  7%      -3.3%      84362 ±  7%  softirqs.CPU80.RCU
     14444 ±  2%      +6.3%      15356 ±  3%      -4.1%      13845 ±  3%  softirqs.CPU80.SCHED
      0.33 ±200%    -100.0%       0.00           -70.0%       0.10 ±300%  softirqs.CPU80.TASKLET
    683.22 ± 15%      -2.2%     668.00 ± 11%      -0.3%     681.40 ± 13%  softirqs.CPU80.TIMER
      0.11 ±282%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU81.NET_TX
     87691 ±  6%     -10.7%      78350 ±  7%      -3.0%      85067 ±  7%  softirqs.CPU81.RCU
     14352 ±  3%      +6.6%      15294 ±  2%      -3.5%      13846 ±  5%  softirqs.CPU81.SCHED
      0.11 ±282%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU81.TASKLET
    845.00 ± 49%     -16.1%     708.89 ± 20%      -1.0%     836.70 ± 35%  softirqs.CPU81.TIMER
      0.00       +1.1e+101%       0.11 ±282%    -100.0%       0.00        softirqs.CPU82.NET_TX
     87298 ±  6%     -10.1%      78517 ±  6%      -2.2%      85335 ±  7%  softirqs.CPU82.RCU
     14423 ±  2%      +6.1%      15300 ±  2%      -2.0%      14130 ±  3%  softirqs.CPU82.SCHED
      0.11 ±282%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU82.TASKLET
    830.22 ± 27%     -18.8%     673.89 ± 21%      -8.9%     756.20 ± 30%  softirqs.CPU82.TIMER
     86607 ±  7%      -9.6%      78311 ±  7%      -2.0%      84862 ±  7%  softirqs.CPU83.RCU
     14353 ±  2%      +6.9%      15344 ±  2%      -2.0%      14068 ±  6%  softirqs.CPU83.SCHED
      0.00          -100.0%       0.00         +2e+101%       0.20 ±200%  softirqs.CPU83.TASKLET
    634.44 ± 23%      +9.2%     692.89 ± 13%     +14.6%     726.80 ± 19%  softirqs.CPU83.TIMER
     87062 ±  6%      -9.7%      78604 ±  7%      -1.4%      85858 ±  7%  softirqs.CPU84.RCU
     14333            +7.7%      15438 ±  3%      -3.4%      13853 ±  5%  softirqs.CPU84.SCHED
      0.22 ±187%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU84.TASKLET
    822.22 ± 30%     -15.1%     698.11 ± 18%     +12.9%     928.20 ± 45%  softirqs.CPU84.TIMER
     87766 ±  7%     -11.0%      78121 ±  7%      -3.0%      85098 ±  7%  softirqs.CPU85.RCU
     14465 ±  3%      +7.7%      15583 ±  3%      -3.3%      13987 ±  5%  softirqs.CPU85.SCHED
      0.44 ±215%     -75.0%       0.11 ±282%     -55.0%       0.20 ±200%  softirqs.CPU85.TASKLET
    952.22 ± 63%      -2.0%     932.89 ± 62%     -22.5%     737.70 ± 18%  softirqs.CPU85.TIMER
     87638 ±  6%      -9.6%      79183 ±  6%      -2.5%      85408 ±  8%  softirqs.CPU86.RCU
     14362            +6.8%      15337 ±  3%      -2.4%      14019 ±  5%  softirqs.CPU86.SCHED
      0.11 ±282%      +0.0%       0.11 ±282%    +620.0%       0.80 ±156%  softirqs.CPU86.TASKLET
    836.89 ± 28%      -1.3%     825.89 ± 57%      +1.6%     850.20 ± 51%  softirqs.CPU86.TIMER
     87534 ±  6%     -10.3%      78547 ±  7%      -2.3%      85550 ±  6%  softirqs.CPU87.RCU
     14369 ±  3%      +6.6%      15311 ±  3%      -3.2%      13912 ±  4%  softirqs.CPU87.SCHED
      0.11 ±282%    -100.0%       0.00          +170.0%       0.30 ±300%  softirqs.CPU87.TASKLET
    857.78 ± 60%     -16.7%     714.89 ± 36%      -1.9%     841.60 ± 45%  softirqs.CPU87.TIMER
     86715 ±  6%      -9.7%      78293 ±  7%      -2.2%      84823 ±  7%  softirqs.CPU88.RCU
     14594 ±  3%      +4.6%      15269 ±  2%      -3.1%      14135 ±  5%  softirqs.CPU88.SCHED
      0.33 ±199%     -33.3%       0.22 ±187%    -100.0%       0.00        softirqs.CPU88.TASKLET
    814.67 ± 52%      -6.4%     762.56 ± 46%     -17.4%     673.00 ± 19%  softirqs.CPU88.TIMER
     87211 ±  6%      -9.4%      79033 ±  7%      -2.6%      84983 ±  7%  softirqs.CPU89.RCU
     14495 ±  3%      +5.5%      15295 ±  3%      -4.2%      13881 ±  5%  softirqs.CPU89.SCHED
      0.11 ±282%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU89.TASKLET
    902.89 ± 58%     -21.9%     705.56 ± 24%     -25.7%     671.10 ± 13%  softirqs.CPU89.TIMER
     12688 ±156%     +21.7%      15442 ±158%     +93.5%      24556 ±107%  softirqs.CPU9.NET_RX
      2.00 ± 52%     -16.7%       1.67 ± 40%     +25.0%       2.50 ± 32%  softirqs.CPU9.NET_TX
     84929 ±  7%      -9.1%      77216 ±  6%      -1.7%      83475 ±  7%  softirqs.CPU9.RCU
     15555 ± 12%      +5.2%      16367 ±  6%      +2.8%      15992 ± 10%  softirqs.CPU9.SCHED
      0.00       +2.2e+101%       0.22 ±282%   +2e+101%       0.20 ±300%  softirqs.CPU9.TASKLET
      2448 ±112%     -28.4%       1751 ± 64%     +31.5%       3218 ± 63%  softirqs.CPU9.TIMER
     90.44 ±  2%      +1.1%      91.44 ±  2%      -1.2%      89.40 ±  2%  softirqs.CPU90.NET_RX
      0.00          -100.0%       0.00         +2e+101%       0.20 ±300%  softirqs.CPU90.NET_TX
     87599 ±  7%     -11.9%      77178 ±  6%      -2.8%      85130 ±  6%  softirqs.CPU90.RCU
     15706 ±  7%      +4.0%      16339 ±  8%      +4.6%      16431 ± 10%  softirqs.CPU90.SCHED
      0.11 ±282%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU90.TASKLET
    841.33 ± 83%     -43.0%     479.89 ± 18%     +69.0%       1421 ±175%  softirqs.CPU90.TIMER
     90.44 ±  2%      +1.1%      91.44 ±  2%      -1.2%      89.40 ±  2%  softirqs.CPU91.NET_RX
     87086 ±  8%     -11.8%      76813 ±  6%      -3.0%      84487 ±  6%  softirqs.CPU91.RCU
     15365 ±  5%      +7.0%      16438 ±  8%      +3.0%      15833 ±  6%  softirqs.CPU91.SCHED
      0.00          -100.0%       0.00         +1e+101%       0.10 ±300%  softirqs.CPU91.TASKLET
    579.78 ± 22%     -17.9%     475.89 ± 10%      -3.3%     560.60 ± 16%  softirqs.CPU91.TIMER
     90.44 ±  2%      +1.1%      91.44 ±  2%      -1.2%      89.40 ±  2%  softirqs.CPU92.NET_RX
     86877 ±  8%     -11.5%      76869 ±  6%      -3.0%      84233 ±  7%  softirqs.CPU92.RCU
     15589 ±  4%      +6.1%      16540 ±  8%      +1.4%      15809 ±  6%  softirqs.CPU92.SCHED
      0.11 ±282%      +0.0%       0.11 ±282%    +440.0%       0.60 ±300%  softirqs.CPU92.TASKLET
    601.78 ± 18%     -21.2%     474.44 ± 11%     -12.2%     528.60 ± 17%  softirqs.CPU92.TIMER
     90.44 ±  2%      +1.1%      91.44 ±  2%      -1.2%      89.40 ±  2%  softirqs.CPU93.NET_RX
      0.00          -100.0%       0.00         +2e+101%       0.20 ±300%  softirqs.CPU93.NET_TX
     86505 ±  8%     -11.5%      76540 ±  6%      -2.6%      84253 ±  6%  softirqs.CPU93.RCU
     15578 ±  4%      +5.2%      16392 ±  8%      +2.7%      15991 ±  7%  softirqs.CPU93.SCHED
      0.11 ±282%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU93.TASKLET
    563.89 ± 12%     -16.6%     470.22 ± 21%     +70.9%     963.90 ±134%  softirqs.CPU93.TIMER
     90.44 ±  2%      +1.1%      91.44 ±  2%      -1.2%      89.40 ±  2%  softirqs.CPU94.NET_RX
     86593 ±  7%     -11.4%      76749 ±  6%      -2.8%      84141 ±  6%  softirqs.CPU94.RCU
     15670 ±  8%      +6.9%      16746 ±  9%      +0.9%      15814 ±  5%  softirqs.CPU94.SCHED
      0.00       +3.3e+101%       0.33 ±200%   +1e+101%       0.10 ±300%  softirqs.CPU94.TASKLET
    840.44 ±101%     -40.1%     503.78 ± 26%     -37.8%     522.90 ± 19%  softirqs.CPU94.TIMER
     90.44 ±  2%      +1.1%      91.44 ±  2%      -1.2%      89.40 ±  2%  softirqs.CPU95.NET_RX
     87174 ±  8%     -11.6%      77063 ±  6%      -2.8%      84751 ±  6%  softirqs.CPU95.RCU
     15449 ±  5%      +6.1%      16385 ±  7%      +2.8%      15877 ±  5%  softirqs.CPU95.SCHED
      0.22 ±187%    +100.0%       0.44 ±154%    -100.0%       0.00        softirqs.CPU95.TASKLET
    574.00 ± 16%     -13.7%     495.56 ± 14%     +11.8%     641.80 ± 16%  softirqs.CPU95.TIMER
     90.44 ±  2%      +1.1%      91.44 ±  2%      -1.2%      89.40 ±  2%  softirqs.CPU96.NET_RX
     90224 ±  8%     -11.7%      79625 ±  6%      -2.5%      87964 ±  6%  softirqs.CPU96.RCU
     15513 ±  4%      +6.2%      16470 ±  8%      +1.8%      15794 ±  6%  softirqs.CPU96.SCHED
      0.22 ±187%    -100.0%       0.00           -55.0%       0.10 ±300%  softirqs.CPU96.TASKLET
    735.89 ± 22%     -28.4%     526.56 ± 12%     -11.5%     651.30 ± 20%  softirqs.CPU96.TIMER
     90.44 ±  2%      +1.1%      91.44 ±  2%      -1.2%      89.40 ±  2%  softirqs.CPU97.NET_RX
     89263 ±  8%     -12.5%      78096 ±  7%      -2.3%      87214 ±  7%  softirqs.CPU97.RCU
     15517 ±  5%      +6.6%      16540 ±  8%      +2.4%      15887 ±  6%  softirqs.CPU97.SCHED
      0.11 ±282%      +0.0%       0.11 ±282%    -100.0%       0.00        softirqs.CPU97.TASKLET
    614.89 ± 17%     -11.7%     543.22 ± 12%     +16.2%     714.70 ± 21%  softirqs.CPU97.TIMER
     90.44 ±  2%      +1.1%      91.44 ±  2%      -1.2%      89.40 ±  2%  softirqs.CPU98.NET_RX
     89833 ±  8%     -12.1%      78961 ±  6%      -2.9%      87205 ±  6%  softirqs.CPU98.RCU
     15406 ±  4%      +6.5%      16407 ±  8%      +2.6%      15807 ±  5%  softirqs.CPU98.SCHED
      0.22 ±187%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU98.TASKLET
    643.11 ± 14%     -20.9%     508.67 ± 14%      -4.2%     615.80 ± 17%  softirqs.CPU98.TIMER
     90.44 ±  2%      +1.1%      91.44 ±  2%      -1.2%      89.40 ±  2%  softirqs.CPU99.NET_RX
     90475 ±  8%     -11.9%      79718 ±  6%      -2.8%      87964 ±  7%  softirqs.CPU99.RCU
     15761 ±  7%      +5.1%      16561 ±  8%      +0.2%      15787 ±  5%  softirqs.CPU99.SCHED
      0.00       +2.2e+101%       0.22 ±187%   +1e+101%       0.10 ±300%  softirqs.CPU99.TASKLET
    808.56 ± 65%     -37.1%     508.67 ±  9%     -24.6%     609.60 ± 17%  softirqs.CPU99.TIMER
      3.00            +0.0%       3.00            +0.0%       3.00        softirqs.HI
     54810 ± 31%      -1.8%      53802 ± 50%     +23.3%      67602 ± 56%  softirqs.NET_RX
     64.56 ±  2%      -6.2%      60.56 ±  4%      +1.5%      65.50 ±  2%  softirqs.NET_TX
  12602387 ±  7%     -11.1%   11208041 ±  7%      -2.9%   12234338 ±  6%  softirqs.RCU
   2218037 ±  2%      +7.1%    2376443 ±  3%      -0.6%    2204654 ±  5%  softirqs.SCHED
    236.44            +0.1%     236.67            +0.2%     236.80        softirqs.TASKLET
    110668 ±  6%      -8.4%     101344 ±  6%      -1.7%     108775 ±  4%  softirqs.TIMER
     22.07 ± 13%     -16.1        5.94 ± 31%      -2.1       19.93 ± 22%  perf-profile.calltrace.cycles-pp.perf_prepare_sample.perf_event_output_forward.__perf_event_overflow.perf_swevent_overflow.perf_tp_event
     20.97 ± 13%     -15.5        5.52 ± 33%      -2.1       18.89 ± 22%  perf-profile.calltrace.cycles-pp.perf_callchain.perf_prepare_sample.perf_event_output_forward.__perf_event_overflow.perf_swevent_overflow
     20.87 ± 13%     -15.4        5.49 ± 33%      -2.1       18.80 ± 22%  perf-profile.calltrace.cycles-pp.get_perf_callchain.perf_callchain.perf_prepare_sample.perf_event_output_forward.__perf_event_overflow
     18.72 ± 12%     -11.9        6.79 ± 19%      -1.4       17.29 ± 18%  perf-profile.calltrace.cycles-pp.__wake_up_common_lock.sock_def_readable.unix_stream_sendmsg.sock_sendmsg.sock_write_iter
     18.07 ± 12%     -11.8        6.32 ± 19%      -1.4       16.66 ± 18%  perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_common_lock.sock_def_readable.unix_stream_sendmsg.sock_sendmsg
     17.93 ± 13%     -11.7        6.22 ± 19%      -1.4       16.54 ± 18%  perf-profile.calltrace.cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.sock_def_readable.unix_stream_sendmsg
     17.83 ± 13%     -11.7        6.16 ± 19%      -1.4       16.46 ± 18%  perf-profile.calltrace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.sock_def_readable
     19.52 ± 11%     -11.3        8.24 ± 14%      -1.4       18.14 ± 17%  perf-profile.calltrace.cycles-pp.sock_def_readable.unix_stream_sendmsg.sock_sendmsg.sock_write_iter.new_sync_write
     10.75 ± 12%     -10.8        0.00            +0.6       11.36 ± 13%  perf-profile.calltrace.cycles-pp.page_counter_try_charge.obj_cgroup_charge_pages.obj_cgroup_charge.__kmalloc_node_track_caller.kmalloc_reserve
     15.98 ± 11%     -10.2        5.78 ± 19%      -1.1       14.88 ± 18%  perf-profile.calltrace.cycles-pp.schedule_timeout.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter.new_sync_read
     13.60 ± 13%     -10.2        3.42 ± 41%      -1.4       12.16 ± 23%  perf-profile.calltrace.cycles-pp.perf_callchain_kernel.get_perf_callchain.perf_callchain.perf_prepare_sample.perf_event_output_forward
     15.91 ± 11%     -10.2        5.74 ± 19%      -1.1       14.80 ± 18%  perf-profile.calltrace.cycles-pp.schedule.schedule_timeout.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
     15.78 ± 11%     -10.1        5.67 ± 19%      -1.1       14.68 ± 18%  perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_timeout.unix_stream_read_generic.unix_stream_recvmsg
     10.68 ± 13%      -7.6        3.11 ± 29%      -1.0        9.64 ± 22%  perf-profile.calltrace.cycles-pp.__perf_event_overflow.perf_swevent_overflow.perf_tp_event.perf_trace_sched_stat_runtime.update_curr
     10.63 ± 13%      -7.5        3.10 ± 29%      -1.0        9.59 ± 22%  perf-profile.calltrace.cycles-pp.perf_event_output_forward.__perf_event_overflow.perf_swevent_overflow.perf_tp_event.perf_trace_sched_stat_runtime
      6.20 ± 23%      -6.2        0.00            -0.9        5.32 ± 39%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.__get_user_nocheck_8.perf_callchain_user.get_perf_callchain.perf_callchain
      6.72 ± 13%      -6.1        0.66 ±127%      -0.7        6.01 ± 26%  perf-profile.calltrace.cycles-pp.perf_callchain_user.get_perf_callchain.perf_callchain.perf_prepare_sample.perf_event_output_forward
      5.41 ± 12%      -5.4        0.00            +0.3        5.73 ± 13%  perf-profile.calltrace.cycles-pp.page_counter_try_charge.obj_cgroup_charge_pages.obj_cgroup_charge.kmem_cache_alloc_node.__alloc_skb
      6.62 ± 14%      -5.2        1.39 ± 41%      -0.7        5.96 ± 23%  perf-profile.calltrace.cycles-pp.perf_swevent_overflow.perf_tp_event.perf_trace_sched_switch.__schedule.schedule
      6.61 ± 14%      -5.2        1.39 ± 41%      -0.7        5.95 ± 23%  perf-profile.calltrace.cycles-pp.__perf_event_overflow.perf_swevent_overflow.perf_tp_event.perf_trace_sched_switch.__schedule
      6.57 ± 14%      -5.2        1.38 ± 41%      -0.7        5.92 ± 23%  perf-profile.calltrace.cycles-pp.perf_event_output_forward.__perf_event_overflow.perf_swevent_overflow.perf_tp_event.perf_trace_sched_switch
      5.36 ± 16%      -5.2        0.19 ±282%      -0.7        4.62 ± 36%  perf-profile.calltrace.cycles-pp.__unwind_start.perf_callchain_kernel.get_perf_callchain.perf_callchain.perf_prepare_sample
      7.25 ± 13%      -4.9        2.36 ± 21%      -0.6        6.65 ± 19%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      7.20 ± 13%      -4.9        2.34 ± 21%      -0.6        6.60 ± 19%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common
      5.05 ± 14%      -4.8        0.20 ±282%      -0.6        4.41 ± 31%  perf-profile.calltrace.cycles-pp.unwind_next_frame.perf_callchain_kernel.get_perf_callchain.perf_callchain.perf_prepare_sample
     52.91            -4.7       48.19            -0.4       52.52        perf-profile.calltrace.cycles-pp.__libc_write
      7.05 ± 12%      -4.7        2.39 ± 22%      -0.6        6.49 ± 19%  perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.schedule_timeout.unix_stream_read_generic
      4.65 ± 17%      -4.6        0.06 ±282%      -0.7        3.91 ± 37%  perf-profile.calltrace.cycles-pp.unwind_next_frame.__unwind_start.perf_callchain_kernel.get_perf_callchain.perf_callchain
     52.21            -4.6       47.64            -0.3       51.86        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_write
     52.08            -4.5       47.54            -0.4       51.73        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write
      6.47 ± 14%      -4.5        1.99 ± 23%      -0.6        5.90 ± 20%  perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.autoremove_wake_function
      6.34 ± 12%      -4.3        2.06 ± 25%      -0.5        5.80 ± 21%  perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_task_fair.__schedule.schedule.schedule_timeout
      5.84 ± 14%      -4.2        1.68 ± 27%      -0.6        5.28 ± 22%  perf-profile.calltrace.cycles-pp.update_curr.enqueue_entity.enqueue_task_fair.ttwu_do_activate.try_to_wake_up
      6.03 ± 12%      -4.1        1.90 ± 26%      -0.5        5.49 ± 21%  perf-profile.calltrace.cycles-pp.update_curr.dequeue_entity.dequeue_task_fair.__schedule.schedule
      5.75 ± 12%      -4.0        1.78 ± 28%      -0.5        5.21 ± 22%  perf-profile.calltrace.cycles-pp.perf_trace_sched_stat_runtime.update_curr.dequeue_entity.dequeue_task_fair.__schedule
      5.50 ± 14%      -4.0        1.54 ± 29%      -0.5        4.96 ± 22%  perf-profile.calltrace.cycles-pp.perf_trace_sched_stat_runtime.update_curr.enqueue_entity.enqueue_task_fair.ttwu_do_activate
      5.69 ± 12%      -3.9        1.78 ± 26%      -0.5        5.19 ± 21%  perf-profile.calltrace.cycles-pp.perf_trace_sched_wakeup_template.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      5.60 ± 12%      -3.9        1.72 ± 28%      -0.5        5.07 ± 22%  perf-profile.calltrace.cycles-pp.perf_tp_event.perf_trace_sched_stat_runtime.update_curr.dequeue_entity.dequeue_task_fair
      5.33 ± 14%      -3.9        1.48 ± 29%      -0.5        4.79 ± 22%  perf-profile.calltrace.cycles-pp.perf_tp_event.perf_trace_sched_stat_runtime.update_curr.enqueue_entity.enqueue_task_fair
      5.54 ± 12%      -3.8        1.71 ± 27%      -0.5        5.04 ± 21%  perf-profile.calltrace.cycles-pp.perf_tp_event.perf_trace_sched_wakeup_template.try_to_wake_up.autoremove_wake_function.__wake_up_common
      5.48 ± 12%      -3.8        1.68 ± 28%      -0.5        4.96 ± 22%  perf-profile.calltrace.cycles-pp.perf_swevent_overflow.perf_tp_event.perf_trace_sched_stat_runtime.update_curr.dequeue_entity
      5.22 ± 14%      -3.8        1.44 ± 29%      -0.5        4.70 ± 22%  perf-profile.calltrace.cycles-pp.perf_swevent_overflow.perf_tp_event.perf_trace_sched_stat_runtime.update_curr.enqueue_entity
      5.32 ± 12%      -3.7        1.62 ± 28%      -0.5        4.84 ± 21%  perf-profile.calltrace.cycles-pp.perf_swevent_overflow.perf_tp_event.perf_trace_sched_wakeup_template.try_to_wake_up.autoremove_wake_function
      5.31 ± 12%      -3.7        1.62 ± 28%      -0.5        4.83 ± 21%  perf-profile.calltrace.cycles-pp.__perf_event_overflow.perf_swevent_overflow.perf_tp_event.perf_trace_sched_wakeup_template.try_to_wake_up
      5.29 ± 12%      -3.7        1.61 ± 28%      -0.5        4.81 ± 21%  perf-profile.calltrace.cycles-pp.perf_event_output_forward.__perf_event_overflow.perf_swevent_overflow.perf_tp_event.perf_trace_sched_wakeup_template
      4.86 ± 13%      -3.5        1.41 ± 29%      -0.5        4.41 ± 23%  perf-profile.calltrace.cycles-pp.perf_trace_sched_switch.__schedule.schedule.schedule_timeout.unix_stream_read_generic
      4.68 ± 13%      -3.3        1.34 ± 29%      -0.4        4.24 ± 23%  perf-profile.calltrace.cycles-pp.perf_tp_event.perf_trace_sched_switch.__schedule.schedule.schedule_timeout
      4.27 ± 13%      -3.1        1.13 ± 23%      -0.3        3.97 ± 18%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write
      4.21 ± 13%      -3.1        1.09 ± 24%      -0.3        3.90 ± 18%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write
      3.08 ± 12%      -3.1        0.00            -0.4        2.70 ± 34%  perf-profile.calltrace.cycles-pp.__get_user_nocheck_8.perf_callchain_user.get_perf_callchain.perf_callchain.perf_prepare_sample
      3.97 ± 13%      -3.0        0.97 ± 26%      -0.3        3.66 ± 19%  perf-profile.calltrace.cycles-pp.schedule.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.93 ± 13%      -3.0        0.96 ± 26%      -0.3        3.61 ± 19%  perf-profile.calltrace.cycles-pp.__schedule.schedule.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      2.56 ± 13%      -2.6        0.00            +0.2        2.74 ± 13%  perf-profile.calltrace.cycles-pp.propagate_protected_usage.page_counter_try_charge.obj_cgroup_charge_pages.obj_cgroup_charge.__kmalloc_node_track_caller
      2.20 ± 17%      -2.1        0.09 ±282%      -0.2        1.96 ± 24%  perf-profile.calltrace.cycles-pp.perf_trace_sched_switch.__schedule.schedule.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      2.11 ± 17%      -2.0        0.08 ±282%      -0.2        1.87 ± 24%  perf-profile.calltrace.cycles-pp.perf_tp_event.perf_trace_sched_switch.__schedule.schedule.exit_to_user_mode_prepare
      2.50 ± 12%      -1.6        0.89 ± 16%      -0.2        2.33 ± 17%  perf-profile.calltrace.cycles-pp._raw_spin_lock.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      2.18 ± 13%      -1.5        0.67 ± 38%      -0.2        2.01 ± 18%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.try_to_wake_up.autoremove_wake_function.__wake_up_common
     47.65            -1.3       46.31            -0.0       47.61        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write
     47.39            -1.3       46.07            -0.0       47.35        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write
     46.88            -1.3       45.57            -0.1       46.76        perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.29 ± 13%      -1.3        0.00            +0.1        1.39 ± 13%  perf-profile.calltrace.cycles-pp.propagate_protected_usage.page_counter_try_charge.obj_cgroup_charge_pages.obj_cgroup_charge.kmem_cache_alloc_node
     46.47            -1.2       45.23            -0.1       46.38        perf-profile.calltrace.cycles-pp.sock_write_iter.new_sync_write.vfs_write.ksys_write.do_syscall_64
     46.14            -1.1       45.02            -0.0       46.10        perf-profile.calltrace.cycles-pp.sock_sendmsg.sock_write_iter.new_sync_write.vfs_write.ksys_write
     45.81            -1.1       44.70            -0.1       45.75        perf-profile.calltrace.cycles-pp.unix_stream_sendmsg.sock_sendmsg.sock_write_iter.new_sync_write.vfs_write
      0.97 ± 13%      -1.0        0.00            -0.1        0.86 ± 34%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__schedule.schedule.schedule_timeout.unix_stream_read_generic
      0.89 ± 14%      -0.9        0.00            -0.1        0.78 ± 34%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.__schedule.schedule.schedule_timeout
      0.98 ± 14%      -0.9        0.12 ±187%      -0.0        0.95 ± 13%  perf-profile.calltrace.cycles-pp.select_task_rq_fair.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      0.73 ± 16%      -0.7        0.00            -0.1        0.65 ± 35%  perf-profile.calltrace.cycles-pp.select_idle_sibling.select_task_rq_fair.try_to_wake_up.autoremove_wake_function.__wake_up_common
      0.61 ±  6%      -0.6        0.00            -0.0        0.61 ±  7%  perf-profile.calltrace.cycles-pp.prepare_to_wait.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter.new_sync_read
      0.60 ±  5%      -0.6        0.00            -0.1        0.54 ± 33%  perf-profile.calltrace.cycles-pp.switch_mm_irqs_off.__schedule.schedule.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      0.58 ±  6%      -0.6        0.00            -0.1        0.53 ± 33%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read
      0.62 ±  5%      -0.6        0.06 ±282%      -0.0        0.62 ±  7%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read
      1.32 ±  3%      -0.5        0.78 ±  7%      -0.0        1.32 ±  6%  perf-profile.calltrace.cycles-pp.switch_mm_irqs_off.__schedule.schedule.schedule_timeout.unix_stream_read_generic
      0.30 ±125%      -0.3        0.00            -0.1        0.16 ±152%  perf-profile.calltrace.cycles-pp.__orc_find.unwind_next_frame.perf_callchain_kernel.get_perf_callchain.perf_callchain
      0.06 ±282%      -0.1        0.00            -0.0        0.05 ±300%  perf-profile.calltrace.cycles-pp.select_idle_cpu.select_idle_sibling.select_task_rq_fair.try_to_wake_up.autoremove_wake_function
      0.06 ±282%      -0.1        0.00            -0.1        0.00        perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.schedule_timeout.unix_stream_read_generic
      0.00            +0.0        0.00            +0.1        0.05 ±299%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__unfreeze_partials.skb_release_data.consume_skb
      0.00            +0.0        0.00            +0.1        0.06 ±300%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__unfreeze_partials.kmem_cache_free.unix_stream_read_generic
      0.00            +0.0        0.00            +0.1        0.06 ±300%  perf-profile.calltrace.cycles-pp.get_partial_node.___slab_alloc.__slab_alloc.__kmalloc_node_track_caller.kmalloc_reserve
      0.00            +0.0        0.00            +0.1        0.06 ±299%  perf-profile.calltrace.cycles-pp.get_partial_node.___slab_alloc.__slab_alloc.kmem_cache_alloc_node.__alloc_skb
      0.00            +0.0        0.00            +0.1        0.06 ±300%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__unfreeze_partials.skb_release_data.consume_skb.unix_stream_read_generic
      0.00            +0.0        0.00            +0.1        0.06 ±300%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__unfreeze_partials.kmem_cache_free.unix_stream_read_generic.unix_stream_recvmsg
      0.00            +0.0        0.00            +0.1        0.07 ±300%  perf-profile.calltrace.cycles-pp.__unfreeze_partials.skb_release_data.consume_skb.unix_stream_read_generic.unix_stream_recvmsg
      0.00            +0.0        0.00            +0.1        0.07 ±300%  perf-profile.calltrace.cycles-pp.__unfreeze_partials.kmem_cache_free.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      0.00            +0.1        0.06 ±282%      +0.0        0.00        perf-profile.calltrace.cycles-pp.get_mem_cgroup_from_objcg.obj_cgroup_charge_pages.obj_cgroup_charge.kmem_cache_alloc_node.__alloc_skb
      0.00            +0.1        0.06 ±282%      +0.0        0.00        perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.mod_objcg_state.kfree.skb_release_data.consume_skb
      0.00            +0.1        0.06 ±282%      +0.0        0.00        perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_timeout.sock_alloc_send_pskb.unix_stream_sendmsg
      0.00            +0.1        0.06 ±282%      +0.0        0.00        perf-profile.calltrace.cycles-pp._copy_from_iter.skb_copy_datagram_from_iter.unix_stream_sendmsg.sock_sendmsg.sock_write_iter
      0.00            +0.1        0.06 ±282%      +0.0        0.00        perf-profile.calltrace.cycles-pp.do_numa_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      0.00            +0.1        0.06 ±282%      +0.0        0.00        perf-profile.calltrace.cycles-pp.migrate_misplaced_page.do_numa_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.00            +0.1        0.06 ±282%      +0.0        0.00        perf-profile.calltrace.cycles-pp.migrate_pages.migrate_misplaced_page.do_numa_page.__handle_mm_fault.handle_mm_fault
      0.00            +0.1        0.06 ±282%      +0.0        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__wake_up_common_lock.sock_def_readable.unix_stream_sendmsg.sock_sendmsg
      0.00            +0.1        0.06 ±282%      +0.0        0.00        perf-profile.calltrace.cycles-pp.asm_exc_page_fault
      0.00            +0.1        0.06 ±282%      +0.0        0.00        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
      0.00            +0.1        0.06 ±282%      +0.0        0.00        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00            +0.1        0.06 ±282%      +0.0        0.00        perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00            +0.1        0.06 ±282%      +0.0        0.00        perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00            +0.1        0.11 ±187%      +0.0        0.00        perf-profile.calltrace.cycles-pp.schedule.schedule_timeout.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg
      0.00            +0.1        0.12 ±187%      +0.0        0.00        perf-profile.calltrace.cycles-pp.schedule_timeout.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg.sock_write_iter
      0.62 ±  2%      +0.2        0.79 ±  3%      +0.0        0.66 ±  4%  perf-profile.calltrace.cycles-pp.__check_object_size.simple_copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.unix_stream_read_actor
      0.65 ±  2%      +0.2        0.81 ±  3%      +0.0        0.68 ±  4%  perf-profile.calltrace.cycles-pp.simple_copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.unix_stream_read_actor.unix_stream_read_generic
      0.00            +0.2        0.18 ±141%      +0.0        0.00        perf-profile.calltrace.cycles-pp.mod_objcg_state.kmem_cache_free.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      0.74 ±  2%      +0.2        0.92 ±  4%      +0.0        0.77 ±  7%  perf-profile.calltrace.cycles-pp.skb_copy_datagram_from_iter.unix_stream_sendmsg.sock_sendmsg.sock_write_iter.new_sync_write
      0.00            +0.2        0.24 ±111%      +0.1        0.08 ±300%  perf-profile.calltrace.cycles-pp.___slab_alloc.__slab_alloc.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags
      0.61 ±  3%      +0.3        0.90 ±  3%      +0.0        0.64 ±  6%  perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copyout._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter
      0.64 ±  3%      +0.3        0.93 ±  3%      +0.0        0.67 ±  7%  perf-profile.calltrace.cycles-pp.copyout._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.unix_stream_read_actor
      0.00            +0.3        0.30 ± 89%      +0.1        0.13 ±206%  perf-profile.calltrace.cycles-pp.___slab_alloc.__slab_alloc.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb
      0.00            +0.3        0.30 ± 89%      +0.1        0.08 ±299%  perf-profile.calltrace.cycles-pp.__slab_alloc.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
      0.00            +0.3        0.30 ± 89%      +0.1        0.13 ±206%  perf-profile.calltrace.cycles-pp.__slab_alloc.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
      0.81 ±  2%      +0.3        1.11 ±  3%      +0.0        0.83 ±  5%  perf-profile.calltrace.cycles-pp._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.unix_stream_read_actor.unix_stream_read_generic
      0.00            +0.3        0.31 ±175%      +0.0        0.00        perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      0.00            +0.4        0.38 ±145%      +0.0        0.00        perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      0.00            +0.4        0.38 ±145%      +0.0        0.00        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
      0.00            +0.4        0.44 ± 53%      +0.0        0.00        perf-profile.calltrace.cycles-pp.mod_objcg_state.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
      0.52 ± 36%      +0.4        0.96 ±  3%      +0.0        0.55 ± 36%  perf-profile.calltrace.cycles-pp.__slab_free.skb_release_data.consume_skb.unix_stream_read_generic.unix_stream_recvmsg
      1.04 ±  6%      +0.4        1.49 ±  5%      +0.1        1.12 ± 10%  perf-profile.calltrace.cycles-pp._raw_spin_lock.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter.new_sync_read
      0.12 ±187%      +0.5        0.57 ±  7%      -0.0        0.10 ±200%  perf-profile.calltrace.cycles-pp.mod_objcg_state.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
      1.49 ±  2%      +0.5        1.97 ±  2%      +0.1        1.56 ±  4%  perf-profile.calltrace.cycles-pp.__skb_datagram_iter.skb_copy_datagram_iter.unix_stream_read_actor.unix_stream_read_generic.unix_stream_recvmsg
      1.50 ±  2%      +0.5        1.98 ±  2%      +0.1        1.57 ±  4%  perf-profile.calltrace.cycles-pp.skb_copy_datagram_iter.unix_stream_read_actor.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      1.52 ±  2%      +0.5        2.00 ±  2%      +0.1        1.59 ±  4%  perf-profile.calltrace.cycles-pp.unix_stream_read_actor.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter.new_sync_read
      0.72 ±  8%      +0.5        1.20 ±  9%      +0.1        0.77 ± 14%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.skb_queue_tail.unix_stream_sendmsg.sock_sendmsg.sock_write_iter
      0.74 ±  8%      +0.5        1.23 ±  9%      +0.1        0.79 ± 13%  perf-profile.calltrace.cycles-pp.skb_queue_tail.unix_stream_sendmsg.sock_sendmsg.sock_write_iter.new_sync_write
      0.30 ± 89%      +0.5        0.81 ±  9%      +0.0        0.33 ± 82%  perf-profile.calltrace.cycles-pp.get_mem_cgroup_from_objcg.obj_cgroup_uncharge_pages.kfree.skb_release_data.consume_skb
      0.06 ±282%      +0.5        0.58 ±  9%      +0.0        0.10 ±200%  perf-profile.calltrace.cycles-pp.mod_objcg_state.kfree.skb_release_data.consume_skb.unix_stream_read_generic
      0.64 ±  6%      +0.5        1.17 ±  9%      +0.1        0.70 ± 13%  perf-profile.calltrace.cycles-pp.skb_set_owner_w.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg.sock_write_iter
      0.06 ±282%      +0.5        0.60 ±  5%      +0.1        0.11 ±200%  perf-profile.calltrace.cycles-pp.mutex_lock.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter.new_sync_read
      0.53 ± 37%      +0.5        1.07 ±  8%      +0.1        0.63 ± 17%  perf-profile.calltrace.cycles-pp.skb_unlink.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter.new_sync_read
      0.24 ±112%      +0.6        0.80 ± 10%      +0.0        0.27 ±100%  perf-profile.calltrace.cycles-pp.get_mem_cgroup_from_objcg.obj_cgroup_charge_pages.obj_cgroup_charge.__kmalloc_node_track_caller.kmalloc_reserve
      0.39 ± 71%      +0.6        1.01 ±  6%      +0.1        0.50 ± 53%  perf-profile.calltrace.cycles-pp.mutex_unlock.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter.new_sync_read
      0.40 ± 71%      +0.6        1.03 ±  8%      +0.2        0.56 ± 38%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.skb_unlink.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      0.00            +0.7        0.67 ±  4%      +0.0        0.00        perf-profile.calltrace.cycles-pp.unix_write_space.sock_wfree.unix_destruct_scm.skb_release_head_state.skb_release_all
      0.00            +0.7        0.67 ± 90%      +0.0        0.00        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      0.00            +0.7        0.67 ± 90%      +0.0        0.00        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      0.00            +0.7        0.67 ± 90%      +0.0        0.00        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
      0.00            +0.7        0.67 ± 90%      +0.0        0.00        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
      0.84 ± 11%      +0.7        1.58 ±  5%      +0.1        0.90 ± 16%  perf-profile.calltrace.cycles-pp.__slab_free.kmem_cache_free.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      1.09 ±  8%      +0.8        1.84 ±  6%      +0.1        1.17 ± 12%  perf-profile.calltrace.cycles-pp._raw_spin_lock.unix_stream_sendmsg.sock_sendmsg.sock_write_iter.new_sync_write
      0.91 ± 14%      +0.8        1.67 ±  9%      +0.1        0.97 ± 14%  perf-profile.calltrace.cycles-pp.propagate_protected_usage.page_counter_uncharge.obj_cgroup_uncharge_pages.kmem_cache_free.unix_stream_read_generic
      1.13 ±  9%      +0.9        1.99 ±  3%      +0.1        1.20 ± 11%  perf-profile.calltrace.cycles-pp.sock_wfree.unix_destruct_scm.skb_release_head_state.skb_release_all.consume_skb
      1.16 ±  9%      +0.9        2.03 ±  3%      +0.1        1.24 ± 11%  perf-profile.calltrace.cycles-pp.unix_destruct_scm.skb_release_head_state.skb_release_all.consume_skb.unix_stream_read_generic
      1.18 ±  9%      +0.9        2.06 ±  4%      +0.1        1.26 ± 10%  perf-profile.calltrace.cycles-pp.skb_release_head_state.skb_release_all.consume_skb.unix_stream_read_generic.unix_stream_recvmsg
      1.19 ±  9%      +0.9        2.07 ±  4%      +0.1        1.27 ± 10%  perf-profile.calltrace.cycles-pp.skb_release_all.consume_skb.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      1.89 ± 13%      +1.5        3.36 ±  9%      +0.1        2.02 ± 13%  perf-profile.calltrace.cycles-pp.propagate_protected_usage.page_counter_uncharge.obj_cgroup_uncharge_pages.kfree.skb_release_data
      0.00            +1.7        1.69 ±  8%      +0.0        0.00        perf-profile.calltrace.cycles-pp.propagate_protected_usage.page_counter_charge.obj_cgroup_charge_pages.obj_cgroup_charge.kmem_cache_alloc_node
      3.60 ± 13%      +2.0        5.58 ±  5%      +0.2        3.79 ± 14%  perf-profile.calltrace.cycles-pp.page_counter_cancel.page_counter_uncharge.obj_cgroup_uncharge_pages.kmem_cache_free.unix_stream_read_generic
      6.02 ± 11%      +2.4        8.43 ±  5%      +0.3        6.34 ± 13%  perf-profile.calltrace.cycles-pp.obj_cgroup_charge_pages.obj_cgroup_charge.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags
      6.07 ± 11%      +2.4        8.48 ±  5%      +0.3        6.40 ± 13%  perf-profile.calltrace.cycles-pp.obj_cgroup_charge.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
      7.59 ±  9%      +2.7       10.26 ±  4%      +0.4        7.96 ± 12%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb.unix_stream_sendmsg
      4.57 ± 13%      +2.8        7.33 ±  5%      +0.3        4.82 ± 14%  perf-profile.calltrace.cycles-pp.page_counter_uncharge.obj_cgroup_uncharge_pages.kmem_cache_free.unix_stream_read_generic.unix_stream_recvmsg
      5.16 ± 12%      +3.2        8.32 ±  5%      +0.3        5.41 ± 13%  perf-profile.calltrace.cycles-pp.obj_cgroup_uncharge_pages.kmem_cache_free.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      0.00            +3.4        3.35 ±  8%      +0.0        0.00        perf-profile.calltrace.cycles-pp.propagate_protected_usage.page_counter_charge.obj_cgroup_charge_pages.obj_cgroup_charge.__kmalloc_node_track_caller
     46.70            +3.6       50.30            +0.3       47.03        perf-profile.calltrace.cycles-pp.__libc_read
      7.49 ± 12%      +3.7       11.22 ±  5%      +0.4        7.91 ± 13%  perf-profile.calltrace.cycles-pp.page_counter_cancel.page_counter_uncharge.obj_cgroup_uncharge_pages.kfree.skb_release_data
     45.67            +3.8       49.44            +0.3       45.99        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_read
     45.54            +3.8       49.34            +0.3       45.86        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read
     44.61            +4.0       48.58            +0.3       44.94        perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read
     44.81            +4.0       48.78            +0.3       45.14        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read
     43.44            +4.0       47.45            +0.3       43.78        perf-profile.calltrace.cycles-pp.unix_stream_recvmsg.sock_read_iter.new_sync_read.vfs_read.ksys_read
     43.35            +4.0       47.36            +0.3       43.68        perf-profile.calltrace.cycles-pp.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter.new_sync_read.vfs_read
     43.87            +4.0       47.89            +0.3       44.20        perf-profile.calltrace.cycles-pp.sock_read_iter.new_sync_read.vfs_read.ksys_read.do_syscall_64
     44.09            +4.0       48.11            +0.3       44.42        perf-profile.calltrace.cycles-pp.new_sync_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.26 ± 10%      +4.4       11.62 ±  4%      +0.4        7.65 ± 14%  perf-profile.calltrace.cycles-pp.kmem_cache_free.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter.new_sync_read
     11.96 ± 11%      +4.7       16.66 ±  5%      +0.6       12.58 ± 13%  perf-profile.calltrace.cycles-pp.obj_cgroup_charge_pages.obj_cgroup_charge.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb
     12.02 ± 11%      +4.7       16.72 ±  5%      +0.6       12.64 ± 13%  perf-profile.calltrace.cycles-pp.obj_cgroup_charge.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
     13.67 ± 10%      +5.0       18.63 ±  4%      +0.7       14.37 ± 12%  perf-profile.calltrace.cycles-pp.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
     13.73 ± 10%      +5.0       18.69 ±  4%      +0.7       14.42 ± 12%  perf-profile.calltrace.cycles-pp.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb.unix_stream_sendmsg
      9.49 ± 12%      +5.3       14.75 ±  5%      +0.6       10.05 ± 13%  perf-profile.calltrace.cycles-pp.page_counter_uncharge.obj_cgroup_uncharge_pages.kfree.skb_release_data.consume_skb
     10.71 ± 12%      +6.0       16.74 ±  5%      +0.6       11.28 ± 12%  perf-profile.calltrace.cycles-pp.obj_cgroup_uncharge_pages.kfree.skb_release_data.consume_skb.unix_stream_read_generic
     11.61 ± 11%      +6.3       17.88 ±  4%      +0.6       12.20 ± 12%  perf-profile.calltrace.cycles-pp.kfree.skb_release_data.consume_skb.unix_stream_read_generic.unix_stream_recvmsg
     12.64 ± 10%      +6.9       19.58 ±  4%      +0.7       13.32 ± 12%  perf-profile.calltrace.cycles-pp.skb_release_data.consume_skb.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      0.00            +7.4        7.38 ±  5%      +0.0        0.00        perf-profile.calltrace.cycles-pp.page_counter_charge.obj_cgroup_charge_pages.obj_cgroup_charge.kmem_cache_alloc_node.__alloc_skb
     22.01 ±  9%      +7.8       29.80 ±  4%      +1.1       23.08 ± 12%  perf-profile.calltrace.cycles-pp.alloc_skb_with_frags.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg.sock_write_iter
     21.94 ±  9%      +7.8       29.73 ±  4%      +1.1       23.01 ± 12%  perf-profile.calltrace.cycles-pp.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg
     14.04 ± 10%      +8.0       22.00 ±  4%      +0.8       14.81 ± 12%  perf-profile.calltrace.cycles-pp.consume_skb.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter.new_sync_read
     23.02 ±  9%      +8.7       31.68 ±  3%      +1.1       24.15 ± 12%  perf-profile.calltrace.cycles-pp.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg.sock_write_iter.new_sync_write
      0.00           +14.6       14.61 ±  5%      +0.0        0.00        perf-profile.calltrace.cycles-pp.page_counter_charge.obj_cgroup_charge_pages.obj_cgroup_charge.__kmalloc_node_track_caller.kmalloc_reserve
     24.37 ± 13%     -16.8        7.58 ± 28%      -2.3       22.07 ± 22%  perf-profile.children.cycles-pp.perf_tp_event
     23.71 ± 12%     -16.4        7.34 ± 28%      -2.2       21.48 ± 22%  perf-profile.children.cycles-pp.perf_swevent_overflow
     23.67 ± 13%     -16.3        7.32 ± 28%      -2.2       21.43 ± 22%  perf-profile.children.cycles-pp.__perf_event_overflow
     23.57 ± 13%     -16.3        7.29 ± 28%      -2.2       21.34 ± 22%  perf-profile.children.cycles-pp.perf_event_output_forward
     23.14 ± 13%     -16.0        7.11 ± 28%      -2.2       20.94 ± 22%  perf-profile.children.cycles-pp.perf_prepare_sample
     16.51 ± 12%     -15.9        0.59 ±  7%      +1.0       17.47 ± 13%  perf-profile.children.cycles-pp.page_counter_try_charge
     21.97 ± 13%     -15.3        6.66 ± 28%      -2.1       19.84 ± 22%  perf-profile.children.cycles-pp.perf_callchain
     21.86 ± 13%     -15.2        6.63 ± 28%      -2.1       19.74 ± 22%  perf-profile.children.cycles-pp.get_perf_callchain
     20.35 ± 11%     -13.0        7.38 ± 19%      -1.4       18.92 ± 18%  perf-profile.children.cycles-pp.schedule
     20.36 ± 11%     -12.9        7.49 ± 18%      -1.4       18.93 ± 18%  perf-profile.children.cycles-pp.__schedule
     18.91 ± 12%     -11.7        7.17 ± 18%      -1.4       17.48 ± 18%  perf-profile.children.cycles-pp.__wake_up_common_lock
     18.25 ± 12%     -11.5        6.70 ± 18%      -1.4       16.84 ± 18%  perf-profile.children.cycles-pp.__wake_up_common
     18.11 ± 12%     -11.5        6.59 ± 19%      -1.4       16.72 ± 18%  perf-profile.children.cycles-pp.autoremove_wake_function
     18.01 ± 12%     -11.5        6.54 ± 19%      -1.4       16.64 ± 18%  perf-profile.children.cycles-pp.try_to_wake_up
     19.53 ± 11%     -11.3        8.24 ± 14%      -1.4       18.15 ± 17%  perf-profile.children.cycles-pp.sock_def_readable
     14.41 ± 13%     -10.1        4.35 ± 28%      -1.5       12.96 ± 22%  perf-profile.children.cycles-pp.perf_callchain_kernel
     16.19 ± 11%     -10.0        6.20 ± 18%      -1.1       15.09 ± 18%  perf-profile.children.cycles-pp.schedule_timeout
     12.77 ± 12%      -8.5        4.30 ± 25%      -1.1       11.64 ± 21%  perf-profile.children.cycles-pp.update_curr
     11.75 ± 12%      -7.9        3.84 ± 27%      -1.1       10.65 ± 22%  perf-profile.children.cycles-pp.perf_trace_sched_stat_runtime
     10.94 ± 13%      -7.7        3.28 ± 28%      -1.1        9.84 ± 23%  perf-profile.children.cycles-pp.unwind_next_frame
      7.33 ± 14%      -5.3        2.05 ± 30%      -0.7        6.61 ± 23%  perf-profile.children.cycles-pp.perf_trace_sched_switch
      7.03 ± 13%      -4.9        2.14 ± 28%      -0.6        6.38 ± 22%  perf-profile.children.cycles-pp.perf_callchain_user
      7.40 ± 13%      -4.8        2.56 ± 20%      -0.6        6.82 ± 19%  perf-profile.children.cycles-pp.ttwu_do_activate
      7.34 ± 13%      -4.8        2.54 ± 21%      -0.6        6.77 ± 19%  perf-profile.children.cycles-pp.enqueue_task_fair
     53.04            -4.7       48.33            -0.4       52.66        perf-profile.children.cycles-pp.__libc_write
      6.66 ± 13%      -4.6        2.04 ± 28%      -0.6        6.06 ± 22%  perf-profile.children.cycles-pp.__get_user_nocheck_8
      7.15 ± 11%      -4.6        2.58 ± 21%      -0.6        6.59 ± 19%  perf-profile.children.cycles-pp.dequeue_task_fair
      6.60 ± 13%      -4.4        2.16 ± 23%      -0.5        6.05 ± 20%  perf-profile.children.cycles-pp.enqueue_entity
      6.43 ± 11%      -4.2        2.23 ± 24%      -0.6        5.88 ± 20%  perf-profile.children.cycles-pp.dequeue_entity
      5.75 ± 13%      -4.0        1.70 ± 29%      -0.6        5.17 ± 22%  perf-profile.children.cycles-pp.__unwind_start
      5.75 ± 12%      -3.9        1.88 ± 26%      -0.5        5.25 ± 21%  perf-profile.children.cycles-pp.perf_trace_sched_wakeup_template
      4.91 ± 12%      -3.3        1.62 ± 17%      -0.3        4.61 ± 16%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      4.82 ± 12%      -3.3        1.54 ± 18%      -0.3        4.50 ± 17%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      4.61 ± 13%      -2.8        1.85 ± 24%      -0.4        4.25 ± 21%  perf-profile.children.cycles-pp.asm_exc_page_fault
      3.13 ± 13%      -2.2        0.96 ± 28%      -0.3        2.83 ± 22%  perf-profile.children.cycles-pp.__orc_find
      4.03 ± 10%      -1.6        2.41 ± 17%      -0.1        3.95 ±  8%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     47.65            -1.3       46.31            -0.0       47.61        perf-profile.children.cycles-pp.ksys_write
     47.40            -1.3       46.08            -0.0       47.35        perf-profile.children.cycles-pp.vfs_write
     46.89            -1.3       45.58            -0.1       46.76        perf-profile.children.cycles-pp.new_sync_write
      1.75 ± 14%      -1.2        0.54 ± 28%      -0.2        1.60 ± 23%  perf-profile.children.cycles-pp.orc_find
     46.49            -1.2       45.29            -0.1       46.40        perf-profile.children.cycles-pp.sock_write_iter
      1.74 ± 12%      -1.2        0.55 ± 27%      -0.2        1.58 ± 22%  perf-profile.children.cycles-pp.unwind_get_return_address
      6.05 ±  5%      -1.1        4.91 ±  5%      -0.1        5.97 ±  6%  perf-profile.children.cycles-pp._raw_spin_lock
     46.15            -1.1       45.03            -0.0       46.11        perf-profile.children.cycles-pp.sock_sendmsg
     45.84            -1.1       44.73            -0.1       45.78        perf-profile.children.cycles-pp.unix_stream_sendmsg
      1.36 ± 12%      -0.9        0.45 ± 26%      -0.1        1.23 ± 22%  perf-profile.children.cycles-pp.__kernel_text_address
      2.00 ±  3%      -0.9        1.12 ±  6%      -0.0        1.97 ±  6%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      1.25 ± 11%      -0.8        0.42 ± 25%      -0.1        1.16 ± 20%  perf-profile.children.cycles-pp.native_irq_return_iret
      1.13 ± 12%      -0.8        0.33 ± 28%      -0.1        1.03 ± 22%  perf-profile.children.cycles-pp.kernelmode_fixup_or_oops
      1.10 ± 14%      -0.8        0.32 ± 29%      -0.1        0.99 ± 23%  perf-profile.children.cycles-pp.stack_access_ok
      1.05 ± 12%      -0.8        0.30 ± 28%      -0.1        0.94 ± 22%  perf-profile.children.cycles-pp.fixup_exception
      1.05 ± 12%      -0.7        0.33 ± 26%      -0.1        0.96 ± 22%  perf-profile.children.cycles-pp.kernel_text_address
      0.95 ± 13%      -0.7        0.27 ± 29%      -0.1        0.86 ± 22%  perf-profile.children.cycles-pp.search_exception_tables
     97.93            -0.7       97.26            -0.0       97.92        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.92 ± 13%      -0.7        0.26 ± 28%      -0.1        0.83 ± 22%  perf-profile.children.cycles-pp.search_extable
      0.88 ± 13%      -0.6        0.25 ± 28%      -0.1        0.79 ± 22%  perf-profile.children.cycles-pp.bsearch
     97.69            -0.6       97.06            -0.0       97.67        perf-profile.children.cycles-pp.do_syscall_64
      1.50 ± 13%      -0.6        0.92 ± 28%      -0.1        1.43 ± 19%  perf-profile.children.cycles-pp.exc_page_fault
      1.00 ± 14%      -0.5        0.46 ± 14%      -0.0        0.97 ± 13%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.86 ± 12%      -0.4        0.41 ±  8%      -0.0        0.83 ± 10%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.74 ± 15%      -0.4        0.31 ± 16%      -0.0        0.71 ± 14%  perf-profile.children.cycles-pp.select_idle_sibling
      0.67 ± 10%      -0.4        0.26 ± 26%      -0.1        0.62 ± 20%  perf-profile.children.cycles-pp.__perf_event_header__init_id
      0.91 ± 13%      -0.4        0.53 ± 15%      -0.0        0.88 ± 11%  perf-profile.children.cycles-pp.update_load_avg
      0.54 ± 14%      -0.4        0.16 ± 28%      -0.1        0.48 ± 22%  perf-profile.children.cycles-pp.cmp_ex_search
      0.48 ± 12%      -0.3        0.21 ± 11%      -0.0        0.46 ± 12%  perf-profile.children.cycles-pp.reweight_entity
      0.46 ± 11%      -0.3        0.19 ± 10%      -0.0        0.45 ±  9%  perf-profile.children.cycles-pp.load_new_mm_cr3
      0.44 ± 17%      -0.3        0.19 ± 17%      -0.0        0.43 ± 14%  perf-profile.children.cycles-pp.select_idle_cpu
      0.48 ±  9%      -0.2        0.24 ±  8%      -0.0        0.47 ±  8%  perf-profile.children.cycles-pp.switch_fpu_return
      0.38 ±  9%      -0.2        0.14 ± 25%      -0.0        0.34 ± 20%  perf-profile.children.cycles-pp.perf_event_pid_type
      0.32 ± 12%      -0.2        0.11 ± 28%      -0.0        0.30 ± 22%  perf-profile.children.cycles-pp.ftrace_graph_ret_addr
      0.33 ± 14%      -0.2        0.11 ± 27%      -0.0        0.30 ± 22%  perf-profile.children.cycles-pp.perf_output_begin_forward
      0.46 ±  4%      -0.2        0.25 ±  6%      -0.0        0.43 ±  8%  perf-profile.children.cycles-pp.__switch_to
      0.33 ± 10%      -0.2        0.13 ± 15%      -0.0        0.32 ± 16%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.30 ±  9%      -0.2        0.11 ± 27%      -0.0        0.28 ± 20%  perf-profile.children.cycles-pp.__task_pid_nr_ns
      0.34 ± 15%      -0.2        0.15 ± 26%      -0.0        0.31 ± 24%  perf-profile.children.cycles-pp.perf_trace_sched_migrate_task
      0.29 ± 18%      -0.2        0.11 ± 25%      -0.0        0.27 ± 16%  perf-profile.children.cycles-pp.available_idle_cpu
      0.28 ± 10%      -0.2        0.11 ± 15%      -0.0        0.27 ± 15%  perf-profile.children.cycles-pp.native_sched_clock
      0.39 ± 15%      -0.2        0.22 ± 22%      -0.0        0.36 ± 21%  perf-profile.children.cycles-pp.set_task_cpu
      0.24 ± 13%      -0.2        0.08 ± 42%      -0.0        0.22 ± 21%  perf-profile.children.cycles-pp.bad_get_user
      0.32 ± 11%      -0.2        0.15 ± 12%      -0.0        0.30 ± 11%  perf-profile.children.cycles-pp.set_next_entity
      0.38 ±  5%      -0.2        0.21 ±  6%      -0.0        0.36 ±  6%  perf-profile.children.cycles-pp.ttwu_do_wakeup
      0.30 ± 12%      -0.2        0.14 ± 11%      -0.0        0.27 ± 11%  perf-profile.children.cycles-pp.__switch_to_asm
      0.36 ±  6%      -0.2        0.20 ±  7%      -0.0        0.34 ±  7%  perf-profile.children.cycles-pp.check_preempt_curr
      0.33 ± 10%      -0.2        0.18 ± 12%      -0.0        0.32 ± 15%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.22 ± 16%      -0.1        0.08 ±  9%      -0.0        0.20 ± 15%  perf-profile.children.cycles-pp.__enqueue_entity
      0.21 ± 17%      -0.1        0.07 ± 42%      -0.0        0.21 ± 25%  perf-profile.children.cycles-pp.is_bpf_text_address
      0.31 ± 15%      -0.1        0.17 ± 21%      +0.0        0.32 ± 21%  perf-profile.children.cycles-pp.finish_task_switch
      0.20 ± 12%      -0.1        0.06 ± 40%      -0.0        0.19 ± 21%  perf-profile.children.cycles-pp.error_entry
      0.25 ± 13%      -0.1        0.11 ± 12%      -0.0        0.24 ± 12%  perf-profile.children.cycles-pp.__restore_fpregs_from_fpstate
      0.30 ±  4%      -0.1        0.16 ±  8%      -0.0        0.29 ±  7%  perf-profile.children.cycles-pp.check_preempt_wakeup
      0.27 ± 12%      -0.1        0.13 ± 12%      -0.0        0.26 ± 11%  perf-profile.children.cycles-pp.update_rq_clock
      0.67 ±  5%      -0.1        0.53 ± 11%      +0.0        0.67 ±  6%  perf-profile.children.cycles-pp.prepare_to_wait
      0.14 ± 17%      -0.1        0.01 ±282%      -0.0        0.13 ± 23%  perf-profile.children.cycles-pp.kvm_is_in_guest
      0.22 ± 15%      -0.1        0.09 ± 18%      -0.0        0.22 ± 17%  perf-profile.children.cycles-pp.cpuacct_charge
      0.14 ± 12%      -0.1        0.01 ±282%      -0.0        0.12 ± 21%  perf-profile.children.cycles-pp.__is_insn_slot_addr
      0.25 ± 12%      -0.1        0.12 ± 10%      -0.0        0.24 ± 10%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.23 ± 14%      -0.1        0.11 ± 13%      -0.0        0.22 ± 13%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.12 ± 12%      -0.1        0.01 ±282%      +0.0        0.13 ± 20%  perf-profile.children.cycles-pp.perf_misc_flags
      0.14 ± 17%      -0.1        0.02 ±114%      -0.0        0.13 ± 21%  perf-profile.children.cycles-pp.perf_tp_event_match
      0.15 ± 19%      -0.1        0.04 ± 75%      +0.0        0.16 ± 27%  perf-profile.children.cycles-pp.bpf_ksym_find
      0.15 ± 16%      -0.1        0.04 ± 74%      -0.0        0.14 ± 16%  perf-profile.children.cycles-pp.save_fpregs_to_fpstate
      0.14 ± 10%      -0.1        0.03 ± 91%      +0.0        0.15 ± 22%  perf-profile.children.cycles-pp.get_callchain_entry
      0.16 ± 16%      -0.1        0.06 ± 11%      -0.0        0.15 ± 13%  perf-profile.children.cycles-pp.put_prev_entity
      0.16 ± 13%      -0.1        0.05 ± 37%      -0.0        0.14 ± 18%  perf-profile.children.cycles-pp.perf_trace_buf_alloc
      0.10 ±  5%      -0.1        0.00            -0.0        0.08 ± 34%  perf-profile.children.cycles-pp.is_ftrace_trampoline
      0.14 ± 11%      -0.1        0.04 ± 72%      -0.0        0.12 ± 22%  perf-profile.children.cycles-pp.get_stack_info
      0.16 ± 13%      -0.1        0.06 ± 38%      -0.0        0.15 ± 20%  perf-profile.children.cycles-pp.perf_trace_buf_update
      0.10 ± 13%      -0.1        0.00            -0.0        0.09 ± 14%  perf-profile.children.cycles-pp.pick_next_entity
      0.10 ±  5%      -0.1        0.00            -0.0        0.07 ± 34%  perf-profile.children.cycles-pp.ftrace_ops_trampoline
      0.11 ± 10%      -0.1        0.03 ± 90%      -0.0        0.09 ± 35%  perf-profile.children.cycles-pp.perf_instruction_pointer
      0.16 ±  4%      -0.1        0.08 ± 14%      -0.0        0.16 ±  5%  perf-profile.children.cycles-pp.resched_curr
      0.07 ± 11%      -0.1        0.00            -0.0        0.07 ± 35%  perf-profile.children.cycles-pp.get_stack_info_noinstr
      0.12 ± 15%      -0.1        0.04 ± 56%      +0.0        0.12 ± 10%  perf-profile.children.cycles-pp.___perf_sw_event
      0.10 ± 15%      -0.1        0.03 ± 90%      -0.0        0.10 ± 19%  perf-profile.children.cycles-pp.tracing_gen_ctx_irq_test
      0.07 ± 14%      -0.1        0.00            -0.0        0.07 ±  8%  perf-profile.children.cycles-pp.rb_insert_color
      0.07 ± 17%      -0.1        0.00            -0.0        0.07 ± 13%  perf-profile.children.cycles-pp.set_next_buddy
      0.14 ± 15%      -0.1        0.07 ± 10%      -0.0        0.14 ± 12%  perf-profile.children.cycles-pp.update_min_vruntime
      0.07 ± 15%      -0.1        0.00            +0.0        0.07 ± 11%  perf-profile.children.cycles-pp._find_next_bit
      0.06 ± 10%      -0.1        0.00            -0.0        0.06 ± 10%  perf-profile.children.cycles-pp.rb_erase
      0.06 ± 14%      -0.1        0.00            -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.cpumask_next_wrap
      0.06 ±  9%      -0.1        0.00            -0.0        0.05 ± 34%  perf-profile.children.cycles-pp.perf_trace_run_bpf_submit
      0.15 ± 12%      -0.1        0.08 ±  9%      -0.0        0.14 ± 10%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.06 ± 11%      -0.1        0.00            -0.0        0.05 ± 35%  perf-profile.children.cycles-pp.__wrgsbase_inactive
      0.06 ±  9%      -0.1        0.00            -0.0        0.05 ± 34%  perf-profile.children.cycles-pp.__x64_sys_write
      0.06 ±  5%      -0.1        0.00            -0.0        0.05 ± 34%  perf-profile.children.cycles-pp.__bad_area_nosemaphore
      0.08 ± 16%      -0.1        0.02 ±142%      -0.0        0.07 ± 16%  perf-profile.children.cycles-pp.update_cfs_rq_h_load
      0.14 ± 13%      -0.1        0.09 ± 11%      -0.0        0.14 ± 12%  perf-profile.children.cycles-pp.preempt_schedule_common
      0.05 ± 38%      -0.1        0.00            -0.0        0.05 ± 34%  perf-profile.children.cycles-pp.is_module_text_address
      0.10 ± 10%      -0.0        0.05 ±  8%      +0.0        0.10 ±  8%  perf-profile.children.cycles-pp.__list_add_valid
      0.06 ±  8%      -0.0        0.01 ±187%      +0.0        0.06 ±  7%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.11 ±  9%      -0.0        0.06 ±  6%      +0.0        0.11 ±  7%  perf-profile.children.cycles-pp.__calc_delta
      0.08 ±  7%      -0.0        0.03 ± 70%      -0.0        0.08 ±  9%  perf-profile.children.cycles-pp.iov_iter_init
      0.17 ±  5%      -0.0        0.13 ±  6%      -0.0        0.17 ±  6%  perf-profile.children.cycles-pp.asm_sysvec_reschedule_ipi
      0.04 ± 71%      -0.0        0.00            -0.0        0.01 ±299%  perf-profile.children.cycles-pp.perf_swevent_get_recursion_context
      0.14 ±  4%      -0.0        0.10 ±  4%      -0.0        0.13 ±  9%  perf-profile.children.cycles-pp.rcu_read_unlock_strict
      0.56 ±  4%      -0.0        0.52 ±  3%      +0.0        0.56 ±  2%  perf-profile.children.cycles-pp.security_file_permission
      0.12 ±  5%      -0.0        0.09 ±  9%      -0.0        0.12 ±  5%  perf-profile.children.cycles-pp.finish_wait
      0.42 ±  4%      -0.0        0.39 ± 12%      +0.0        0.43 ±  6%  perf-profile.children.cycles-pp.update_cfs_group
      0.03 ± 90%      -0.0        0.00            -0.0        0.03 ±100%  perf-profile.children.cycles-pp.clear_buddies
      0.03 ± 90%      -0.0        0.00            +0.0        0.05 ± 34%  perf-profile.children.cycles-pp.cpumask_next
      0.03 ± 90%      -0.0        0.00            +0.0        0.05 ± 34%  perf-profile.children.cycles-pp.__rdgsbase_inactive
      0.03 ± 89%      -0.0        0.00            -0.0        0.02 ±122%  perf-profile.children.cycles-pp.ex_handler_uaccess
      0.05 ± 36%      -0.0        0.02 ±112%      -0.0        0.05 ± 35%  perf-profile.children.cycles-pp.clockevents_program_event
      0.02 ±114%      -0.0        0.00            -0.0        0.02 ±122%  perf-profile.children.cycles-pp.__cgroup_account_cputime
      0.27 ±  6%      -0.0        0.24 ±  5%      +0.0        0.28 ±  6%  perf-profile.children.cycles-pp.__cond_resched
      0.02 ±111%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.error_return
      0.02 ±111%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.restore_regs_and_return_to_kernel
      0.07 ±121%      -0.0        0.05 ±107%      +0.0        0.10 ± 81%  perf-profile.children.cycles-pp.sched_ttwu_pending
      0.08 ±108%      -0.0        0.07 ± 90%      +0.0        0.12 ± 80%  perf-profile.children.cycles-pp.__sysvec_call_function_single
      0.08 ±109%      -0.0        0.07 ± 90%      +0.0        0.12 ± 81%  perf-profile.children.cycles-pp.sysvec_call_function_single
      0.42 ±  4%      -0.0        0.42 ±  5%      -0.0        0.42 ±  3%  perf-profile.children.cycles-pp.get_obj_cgroup_from_current
      0.05 ±  8%      -0.0        0.05            +0.0        0.06 ±  7%  perf-profile.children.cycles-pp.security_socket_getpeersec_dgram
      0.36 ±  2%      -0.0        0.35 ±  2%      +0.0        0.36 ±  2%  perf-profile.children.cycles-pp.__fdget_pos
      0.40 ±  3%      -0.0        0.40 ±  3%      +0.0        0.41 ±  2%  perf-profile.children.cycles-pp.common_file_perm
      0.31 ±  3%      -0.0        0.31 ±  2%      +0.0        0.32 ±  2%  perf-profile.children.cycles-pp.__fget_light
      0.05 ±  9%      +0.0        0.05 ±  9%      -0.0        0.05 ±  9%  perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.00            +0.0        0.00            +0.0        0.01 ±299%  perf-profile.children.cycles-pp.maybe_add_creds
      0.00            +0.0        0.00            +0.0        0.01 ±299%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.03 ± 91%      +0.0        0.03 ± 90%      +0.0        0.04 ± 67%  perf-profile.children.cycles-pp.mem_cgroup_from_task
      0.09 ±109%      +0.0        0.09 ± 65%      +0.0        0.14 ± 73%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.34 ±  2%      +0.0        0.34 ±  3%      -0.0        0.34        perf-profile.children.cycles-pp.___might_sleep
      0.00            +0.0        0.01 ±282%      +0.0        0.00        perf-profile.children.cycles-pp.free_pgtables
      0.00            +0.0        0.01 ±282%      +0.0        0.00        perf-profile.children.cycles-pp.menu_select
      0.00            +0.0        0.01 ±282%      +0.0        0.00        perf-profile.children.cycles-pp.record__finish_output
      0.00            +0.0        0.01 ±282%      +0.0        0.00        perf-profile.children.cycles-pp.perf_session__process_events
      0.00            +0.0        0.01 ±282%      +0.0        0.00        perf-profile.children.cycles-pp.shmem_add_to_page_cache
      0.01 ±282%      +0.0        0.01 ±187%      +0.0        0.01 ±201%  perf-profile.children.cycles-pp.ktime_get
      0.00            +0.0        0.01 ±282%      +0.0        0.00        perf-profile.children.cycles-pp.cmd_record
      0.25 ±  4%      +0.0        0.25 ±  3%      +0.0        0.27 ±  3%  perf-profile.children.cycles-pp.security_socket_sendmsg
      0.13 ±  5%      +0.0        0.14 ±  7%      +0.0        0.13 ±  4%  perf-profile.children.cycles-pp.aa_file_perm
      0.06            +0.0        0.07            -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.refill_obj_stock
      0.00            +0.0        0.01 ±187%      +0.0        0.00        perf-profile.children.cycles-pp.perf_output_sample
      0.00            +0.0        0.01 ±188%      +0.0        0.00        perf-profile.children.cycles-pp.anon_vma_interval_tree_iter_next
      0.06            +0.0        0.07 ±  5%      +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.check_stack_object
      0.00            +0.0        0.01 ±187%      +0.0        0.00        perf-profile.children.cycles-pp.__anon_vma_interval_tree_subtree_search
      0.07            +0.0        0.09 ±  7%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.rcu_all_qs
      0.04 ± 53%      +0.0        0.06 ±  8%      +0.0        0.04 ± 33%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.00            +0.0        0.02 ±141%      +0.0        0.00        perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      0.15 ±  5%      +0.0        0.17 ±  4%      -0.0        0.14 ±  7%  perf-profile.children.cycles-pp.__ksize
      0.10 ±  4%      +0.0        0.12 ±  3%      +0.0        0.10 ±  6%  perf-profile.children.cycles-pp.wait_for_unix_gc
      0.05 ± 36%      +0.0        0.07 ± 13%      -0.0        0.03 ± 82%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.20 ±  5%      +0.0        0.22 ±  5%      +0.0        0.20 ±  9%  perf-profile.children.cycles-pp.__virt_addr_valid
      0.13 ±  5%      +0.0        0.16 ±  3%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.__might_fault
      0.00            +0.0        0.02 ±114%      +0.0        0.00        perf-profile.children.cycles-pp.migrate_task_rq_fair
      0.18            +0.0        0.21 ±  5%      +0.0        0.19 ±  4%  perf-profile.children.cycles-pp.__might_sleep
      0.00            +0.0        0.03 ±114%      +0.0        0.00        perf-profile.children.cycles-pp.wait_consider_task
      0.00            +0.0        0.03 ±156%      +0.0        0.00        perf-profile.children.cycles-pp.mmput
      0.00            +0.0        0.03 ±156%      +0.0        0.00        perf-profile.children.cycles-pp.exit_mmap
      0.19 ±  2%      +0.0        0.22 ±  2%      +0.0        0.19 ±  4%  perf-profile.children.cycles-pp.security_socket_recvmsg
      0.22 ±  2%      +0.0        0.25 ±  2%      +0.0        0.22 ±  2%  perf-profile.children.cycles-pp.sock_recvmsg
      0.00            +0.0        0.04 ± 72%      +0.0        0.00        perf-profile.children.cycles-pp.shmem_write_begin
      0.00            +0.0        0.04 ± 72%      +0.0        0.00        perf-profile.children.cycles-pp.shmem_getpage_gfp
      0.00            +0.0        0.04 ± 95%      +0.0        0.00        perf-profile.children.cycles-pp.__do_sys_wait4
      0.00            +0.0        0.04 ± 95%      +0.0        0.00        perf-profile.children.cycles-pp.kernel_wait4
      0.00            +0.0        0.04 ± 95%      +0.0        0.00        perf-profile.children.cycles-pp.do_wait
      0.26 ±  3%      +0.0        0.30 ±  2%      -0.0        0.25 ±  5%  perf-profile.children.cycles-pp.copyin
      0.00            +0.0        0.04 ± 78%      +0.0        0.00        perf-profile.children.cycles-pp.__libc_wait
      0.46 ±  5%      +0.0        0.51 ± 12%      -0.0        0.45 ±  8%  perf-profile.children.cycles-pp.task_tick_fair
      0.00            +0.0        0.05 ±112%      +0.0        0.00        perf-profile.children.cycles-pp.__x64_sys_exit_group
      0.00            +0.0        0.05 ±112%      +0.0        0.00        perf-profile.children.cycles-pp.do_group_exit
      0.00            +0.0        0.05 ±112%      +0.0        0.00        perf-profile.children.cycles-pp.do_exit
      0.50 ±  4%      +0.0        0.55 ± 12%      -0.0        0.49 ±  7%  perf-profile.children.cycles-pp.scheduler_tick
      0.00            +0.1        0.05 ±  6%      +0.0        0.00        perf-profile.children.cycles-pp.load_balance
      0.22 ±  2%      +0.1        0.27 ±  4%      +0.0        0.23 ±  3%  perf-profile.children.cycles-pp.__check_heap_object
      0.37            +0.1        0.42 ±  3%      +0.0        0.37 ±  4%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.04 ± 55%      +0.1        0.10 ± 23%      +0.0        0.04 ± 52%  perf-profile.children.cycles-pp.generic_perform_write
      0.04 ± 55%      +0.1        0.10 ± 23%      +0.0        0.04 ± 51%  perf-profile.children.cycles-pp.generic_file_write_iter
      0.04 ± 55%      +0.1        0.10 ± 23%      +0.0        0.04 ± 51%  perf-profile.children.cycles-pp.__generic_file_write_iter
      0.33 ±  2%      +0.1        0.38 ±  2%      +0.0        0.34 ±  3%  perf-profile.children.cycles-pp.aa_sk_perm
      0.00            +0.1        0.06 ± 17%      +0.0        0.01 ±299%  perf-profile.children.cycles-pp.__softirqentry_text_start
      0.56 ±  4%      +0.1        0.63 ± 11%      -0.0        0.55 ±  5%  perf-profile.children.cycles-pp.update_process_times
      0.38            +0.1        0.45 ±  3%      +0.0        0.38 ±  3%  perf-profile.children.cycles-pp.__entry_text_start
      0.41 ±  3%      +0.1        0.48 ±  4%      +0.0        0.42 ±  5%  perf-profile.children.cycles-pp._copy_from_iter
      0.74 ±  3%      +0.1        0.82 ±  8%      -0.0        0.74 ±  3%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.74 ±  3%      +0.1        0.82 ±  7%      -0.0        0.74 ±  3%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.58 ±  4%      +0.1        0.65 ± 11%      -0.0        0.57 ±  5%  perf-profile.children.cycles-pp.tick_sched_timer
      0.62 ±  3%      +0.1        0.70 ± 10%      -0.0        0.62 ±  4%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.56 ±  4%      +0.1        0.64 ± 11%      -0.0        0.56 ±  5%  perf-profile.children.cycles-pp.tick_sched_handle
      0.80 ±  2%      +0.1        0.89 ±  6%      -0.0        0.80 ±  2%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.01 ±187%      +0.1        0.11 ± 55%      +0.0        0.03 ±101%  perf-profile.children.cycles-pp.try_to_migrate_one
      0.00            +0.1        0.10 ± 54%      +0.0        0.01 ±299%  perf-profile.children.cycles-pp.schedule_idle
      0.26 ±  4%      +0.1        0.36 ±  6%      +0.0        0.26 ±  6%  perf-profile.children.cycles-pp.__build_skb_around
      0.49 ±  3%      +0.1        0.60 ±  5%      +0.0        0.50 ±  8%  perf-profile.children.cycles-pp.mutex_lock
      0.02 ±187%      +0.1        0.14 ± 47%      +0.0        0.04 ±101%  perf-profile.children.cycles-pp.try_to_migrate
      0.88 ±  3%      +0.1        1.02 ±  7%      -0.0        0.88 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.65 ±  2%      +0.2        0.82 ±  3%      +0.0        0.68 ±  4%  perf-profile.children.cycles-pp.simple_copy_to_iter
      0.74 ±  2%      +0.2        0.92 ±  4%      +0.0        0.77 ±  7%  perf-profile.children.cycles-pp.skb_copy_datagram_from_iter
      0.41 ± 14%      +0.2        0.59 ± 17%      +0.1        0.50 ± 45%  perf-profile.children.cycles-pp.get_partial_node
      0.02 ±187%      +0.2        0.24 ± 53%      +0.0        0.07 ± 85%  perf-profile.children.cycles-pp.remove_migration_pte
      0.92 ±  2%      +0.2        1.15 ±  3%      +0.0        0.96 ±  5%  perf-profile.children.cycles-pp.__check_object_size
      0.04 ±128%      +0.3        0.29 ± 52%      +0.0        0.09 ± 84%  perf-profile.children.cycles-pp.remove_migration_ptes
      0.73 ± 11%      +0.3        0.98 ± 12%      +0.1        0.84 ± 33%  perf-profile.children.cycles-pp.__slab_alloc
      0.28 ± 17%      +0.3        0.53 ±  7%      +0.0        0.30 ± 17%  perf-profile.children.cycles-pp.drain_stock
      0.73 ± 10%      +0.3        0.98 ± 12%      +0.1        0.84 ± 33%  perf-profile.children.cycles-pp.___slab_alloc
      0.47 ± 17%      +0.3        0.73 ± 20%      +0.1        0.58 ± 51%  perf-profile.children.cycles-pp.__unfreeze_partials
      0.32 ± 15%      +0.3        0.60 ±  6%      +0.0        0.34 ± 17%  perf-profile.children.cycles-pp.refill_stock
      0.39 ± 10%      +0.3        0.67 ±  5%      +0.0        0.41 ±  7%  perf-profile.children.cycles-pp.unix_write_space
      0.33 ± 16%      +0.3        0.62 ±  6%      +0.0        0.35 ± 19%  perf-profile.children.cycles-pp.try_charge_memcg
      0.64 ±  3%      +0.3        0.93 ±  3%      +0.0        0.67 ±  7%  perf-profile.children.cycles-pp.copyout
      0.04 ±134%      +0.3        0.34 ± 51%      +0.1        0.09 ± 86%  perf-profile.children.cycles-pp.page_vma_mapped_walk
      0.81 ±  2%      +0.3        1.12 ±  3%      +0.0        0.84 ±  5%  perf-profile.children.cycles-pp._copy_to_iter
      0.86 ±  3%      +0.3        1.20 ±  2%      +0.0        0.89 ±  6%  perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      0.19 ± 38%      +0.3        0.52 ± 45%      +0.1        0.24 ± 41%  perf-profile.children.cycles-pp.do_user_addr_fault
      1.26 ±  8%      +0.4        1.62 ±  8%      -0.0        1.25 ±  8%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.07 ±105%      +0.4        0.44 ± 50%      +0.1        0.13 ± 85%  perf-profile.children.cycles-pp.rmap_walk_anon
      0.07 ±105%      +0.4        0.45 ± 50%      +0.1        0.13 ± 85%  perf-profile.children.cycles-pp.migrate_misplaced_page
      0.07 ±105%      +0.4        0.45 ± 50%      +0.1        0.13 ± 85%  perf-profile.children.cycles-pp.migrate_pages
      0.07 ±106%      +0.4        0.46 ± 51%      +0.1        0.13 ± 85%  perf-profile.children.cycles-pp.do_numa_page
      0.09 ± 78%      +0.4        0.48 ± 49%      +0.1        0.14 ± 79%  perf-profile.children.cycles-pp.__handle_mm_fault
      0.09 ± 79%      +0.4        0.48 ± 49%      +0.1        0.14 ± 79%  perf-profile.children.cycles-pp.handle_mm_fault
      1.78 ±  6%      +0.4        2.21 ±  6%      -0.0        1.78 ±  7%  perf-profile.children.cycles-pp.mod_objcg_state
      0.56 ± 13%      +0.5        1.02 ±  6%      +0.0        0.60 ± 18%  perf-profile.children.cycles-pp.mutex_unlock
      1.51 ±  2%      +0.5        1.99 ±  2%      +0.1        1.58 ±  4%  perf-profile.children.cycles-pp.skb_copy_datagram_iter
      1.49 ±  2%      +0.5        1.97 ±  2%      +0.1        1.56 ±  4%  perf-profile.children.cycles-pp.__skb_datagram_iter
      1.52 ±  2%      +0.5        2.00            +0.1        1.59 ±  4%  perf-profile.children.cycles-pp.unix_stream_read_actor
      0.58 ± 12%      +0.5        1.07 ±  7%      +0.1        0.63 ± 17%  perf-profile.children.cycles-pp.skb_unlink
      0.74 ±  8%      +0.5        1.23 ±  9%      +0.1        0.80 ± 13%  perf-profile.children.cycles-pp.skb_queue_tail
      0.64 ±  6%      +0.5        1.17 ±  9%      +0.1        0.70 ± 14%  perf-profile.children.cycles-pp.skb_set_owner_w
      0.00            +0.6        0.56 ± 75%      +0.0        0.04 ±246%  perf-profile.children.cycles-pp.intel_idle
      0.01 ±282%      +0.6        0.60 ± 73%      +0.0        0.04 ±243%  perf-profile.children.cycles-pp.cpuidle_enter_state
      0.01 ±282%      +0.6        0.60 ± 73%      +0.0        0.04 ±243%  perf-profile.children.cycles-pp.cpuidle_enter
      0.01 ±190%      +0.7        0.75 ± 71%      +0.0        0.05 ±234%  perf-profile.children.cycles-pp.start_secondary
      0.01 ±190%      +0.7        0.75 ± 71%      +0.0        0.05 ±235%  perf-profile.children.cycles-pp.do_idle
      0.01 ±190%      +0.7        0.75 ± 71%      +0.0        0.05 ±235%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
      0.01 ±190%      +0.7        0.75 ± 71%      +0.0        0.05 ±235%  perf-profile.children.cycles-pp.cpu_startup_entry
      1.13 ±  9%      +0.9        1.99 ±  3%      +0.1        1.20 ± 11%  perf-profile.children.cycles-pp.sock_wfree
      1.17 ±  9%      +0.9        2.04 ±  3%      +0.1        1.25 ± 10%  perf-profile.children.cycles-pp.unix_destruct_scm
      1.19 ±  9%      +0.9        2.06 ±  4%      +0.1        1.27 ± 10%  perf-profile.children.cycles-pp.skb_release_head_state
      1.19 ±  9%      +0.9        2.07 ±  4%      +0.1        1.27 ± 10%  perf-profile.children.cycles-pp.skb_release_all
      1.51 ±  9%      +0.9        2.44 ±  9%      -0.0        1.51 ± 10%  perf-profile.children.cycles-pp.get_mem_cgroup_from_objcg
      1.42 ± 10%      +1.1        2.55 ±  4%      +0.1        1.50 ± 15%  perf-profile.children.cycles-pp.__slab_free
      2.94 ±  7%      +1.3        4.21 ±  5%      +0.3        3.23 ± 19%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      7.61 ±  9%      +2.7       10.29 ±  4%      +0.4        7.99 ± 12%  perf-profile.children.cycles-pp.kmem_cache_alloc_node
     46.83            +3.6       50.44            +0.3       47.15        perf-profile.children.cycles-pp.__libc_read
      7.12 ± 13%      +3.8       10.94 ±  8%      +0.5        7.61 ± 13%  perf-profile.children.cycles-pp.propagate_protected_usage
     44.62            +4.0       48.59            +0.3       44.96        perf-profile.children.cycles-pp.vfs_read
     44.82            +4.0       48.80            +0.3       45.15        perf-profile.children.cycles-pp.ksys_read
     43.45            +4.0       47.45            +0.3       43.79        perf-profile.children.cycles-pp.unix_stream_recvmsg
     43.88            +4.0       47.89            +0.3       44.22        perf-profile.children.cycles-pp.sock_read_iter
     43.37            +4.0       47.38            +0.3       43.70        perf-profile.children.cycles-pp.unix_stream_read_generic
     44.10            +4.0       48.12            +0.3       44.43        perf-profile.children.cycles-pp.new_sync_read
      7.27 ± 10%      +4.4       11.64 ±  4%      +0.4        7.66 ± 14%  perf-profile.children.cycles-pp.kmem_cache_free
     13.74 ± 10%      +5.0       18.70 ±  4%      +0.7       14.43 ± 12%  perf-profile.children.cycles-pp.kmalloc_reserve
     13.70 ± 10%      +5.0       18.66 ±  4%      +0.7       14.39 ± 12%  perf-profile.children.cycles-pp.__kmalloc_node_track_caller
     11.17 ± 12%      +5.8       16.95 ±  5%      +0.6       11.79 ± 13%  perf-profile.children.cycles-pp.page_counter_cancel
     11.62 ± 11%      +6.3       17.89 ±  4%      +0.6       12.20 ± 12%  perf-profile.children.cycles-pp.kfree
     12.64 ± 10%      +6.9       19.58 ±  4%      +0.7       13.32 ± 12%  perf-profile.children.cycles-pp.skb_release_data
     18.00 ± 11%      +7.1       25.10 ±  5%      +0.9       18.94 ± 13%  perf-profile.children.cycles-pp.obj_cgroup_charge_pages
     18.09 ± 11%      +7.1       25.21 ±  5%      +0.9       19.04 ± 13%  perf-profile.children.cycles-pp.obj_cgroup_charge
     21.95 ±  9%      +7.8       29.75 ±  4%      +1.1       23.02 ± 12%  perf-profile.children.cycles-pp.__alloc_skb
     22.01 ±  9%      +7.8       29.80 ±  4%      +1.1       23.08 ± 12%  perf-profile.children.cycles-pp.alloc_skb_with_frags
     14.04 ± 10%      +8.0       22.01 ±  4%      +0.8       14.81 ± 12%  perf-profile.children.cycles-pp.consume_skb
     14.33 ± 12%      +8.3       22.60 ±  5%      +0.8       15.16 ± 13%  perf-profile.children.cycles-pp.page_counter_uncharge
     23.02 ±  9%      +8.7       31.69 ±  3%      +1.1       24.15 ± 12%  perf-profile.children.cycles-pp.sock_alloc_send_pskb
     15.87 ± 12%      +9.2       25.08 ±  5%      +0.8       16.69 ± 13%  perf-profile.children.cycles-pp.obj_cgroup_uncharge_pages
      0.00           +22.1       22.06 ±  5%      +0.0        0.00        perf-profile.children.cycles-pp.page_counter_charge
     12.30 ± 11%     -12.1        0.17 ±  8%      +0.7       12.96 ± 13%  perf-profile.self.cycles-pp.page_counter_try_charge
      4.79 ± 13%      -3.4        1.40 ± 29%      -0.5        4.26 ± 23%  perf-profile.self.cycles-pp.unwind_next_frame
      3.62 ± 14%      -2.5        1.10 ± 28%      -0.3        3.32 ± 22%  perf-profile.self.cycles-pp.__get_user_nocheck_8
      3.12 ± 13%      -2.2        0.96 ± 28%      -0.3        2.82 ± 22%  perf-profile.self.cycles-pp.__orc_find
      4.03 ± 10%      -1.6        2.41 ± 17%      -0.1        3.94 ±  8%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      1.68 ± 14%      -1.2        0.52 ± 28%      -0.1        1.54 ± 22%  perf-profile.self.cycles-pp.orc_find
      1.26 ± 12%      -0.9        0.38 ± 30%      -0.1        1.11 ± 22%  perf-profile.self.cycles-pp.perf_callchain_kernel
      1.24 ± 11%      -0.8        0.42 ± 25%      -0.1        1.16 ± 20%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.97 ± 13%      -0.7        0.28 ± 29%      -0.1        0.87 ± 23%  perf-profile.self.cycles-pp.stack_access_ok
      1.52 ±  5%      -0.6        0.92 ±  7%      -0.0        1.51 ±  6%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.85 ± 10%      -0.4        0.46 ±  9%      +0.0        0.86 ± 10%  perf-profile.self.cycles-pp.__schedule
      0.52 ± 14%      -0.4        0.15 ± 27%      -0.1        0.46 ± 22%  perf-profile.self.cycles-pp.cmp_ex_search
      0.52 ± 12%      -0.4        0.16 ± 27%      -0.0        0.47 ± 23%  perf-profile.self.cycles-pp.__unwind_start
      0.51 ± 13%      -0.4        0.15 ± 28%      -0.0        0.46 ± 22%  perf-profile.self.cycles-pp.kernel_text_address
      0.51 ± 13%      -0.3        0.22 ± 10%      -0.0        0.50 ± 14%  perf-profile.self.cycles-pp.update_curr
      0.46 ± 11%      -0.3        0.19 ± 10%      -0.0        0.44 ±  9%  perf-profile.self.cycles-pp.load_new_mm_cr3
      0.38 ± 12%      -0.3        0.11 ± 28%      -0.0        0.35 ± 22%  perf-profile.self.cycles-pp.unwind_get_return_address
      0.35 ± 13%      -0.3        0.10 ± 41%      -0.0        0.32 ± 22%  perf-profile.self.cycles-pp.bsearch
      0.31 ± 15%      -0.2        0.08 ± 39%      -0.0        0.27 ± 21%  perf-profile.self.cycles-pp.perf_callchain_user
      0.34 ± 12%      -0.2        0.13 ± 18%      -0.0        0.31 ± 19%  perf-profile.self.cycles-pp.perf_tp_event
      0.28 ±  9%      -0.2        0.08 ± 40%      -0.0        0.24 ± 22%  perf-profile.self.cycles-pp.get_perf_callchain
      0.45 ±  3%      -0.2        0.25 ±  7%      -0.0        0.42 ±  9%  perf-profile.self.cycles-pp.__switch_to
      0.30 ± 14%      -0.2        0.10 ± 27%      -0.0        0.28 ± 22%  perf-profile.self.cycles-pp.perf_output_begin_forward
      0.29 ±  9%      -0.2        0.11 ± 26%      -0.0        0.27 ± 20%  perf-profile.self.cycles-pp.__task_pid_nr_ns
      0.27 ± 13%      -0.2        0.09 ± 41%      -0.0        0.25 ± 23%  perf-profile.self.cycles-pp.ftrace_graph_ret_addr
      0.28 ± 19%      -0.2        0.11 ± 25%      -0.0        0.27 ± 16%  perf-profile.self.cycles-pp.available_idle_cpu
      0.27 ± 13%      -0.2        0.10 ± 39%      -0.0        0.24 ± 22%  perf-profile.self.cycles-pp.__kernel_text_address
      0.28 ± 10%      -0.2        0.11 ± 25%      -0.0        0.27 ± 21%  perf-profile.self.cycles-pp.perf_prepare_sample
      0.27 ± 11%      -0.2        0.10 ± 17%      -0.0        0.25 ± 16%  perf-profile.self.cycles-pp.native_sched_clock
      0.23 ± 11%      -0.2        0.07 ± 42%      -0.0        0.20 ± 22%  perf-profile.self.cycles-pp.asm_exc_page_fault
      0.30 ± 12%      -0.2        0.14 ± 10%      -0.0        0.27 ± 10%  perf-profile.self.cycles-pp.__switch_to_asm
      0.23 ± 13%      -0.2        0.08 ± 40%      -0.0        0.22 ± 19%  perf-profile.self.cycles-pp.perf_trace_sched_switch
      0.30 ±  5%      -0.1        0.15 ±  4%      -0.0        0.26 ±  8%  perf-profile.self.cycles-pp.new_sync_write
      0.22 ± 16%      -0.1        0.08 ±  9%      -0.0        0.20 ± 15%  perf-profile.self.cycles-pp.__enqueue_entity
      0.29 ± 12%      -0.1        0.14 ± 12%      -0.0        0.27 ± 14%  perf-profile.self.cycles-pp.try_to_wake_up
      0.25 ± 13%      -0.1        0.11 ± 12%      -0.0        0.24 ± 13%  perf-profile.self.cycles-pp.__restore_fpregs_from_fpstate
      0.42 ± 13%      -0.1        0.28 ± 20%      -0.0        0.40 ± 10%  perf-profile.self.cycles-pp.update_load_avg
      0.25 ± 12%      -0.1        0.12 ±  9%      -0.0        0.24 ± 10%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.23 ± 15%      -0.1        0.11 ± 14%      -0.0        0.22 ± 18%  perf-profile.self.cycles-pp.perf_trace_sched_stat_runtime
      0.17 ± 13%      -0.1        0.05 ± 56%      -0.0        0.16 ± 21%  perf-profile.self.cycles-pp.error_entry
      0.21 ± 14%      -0.1        0.09 ± 15%      -0.0        0.21 ± 16%  perf-profile.self.cycles-pp.cpuacct_charge
      0.22 ± 15%      -0.1        0.10 ± 13%      -0.0        0.21 ± 14%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.12 ± 18%      -0.1        0.01 ±282%      -0.0        0.10 ± 36%  perf-profile.self.cycles-pp.kvm_is_in_guest
      0.14 ± 15%      -0.1        0.02 ±114%      -0.0        0.12 ± 21%  perf-profile.self.cycles-pp.perf_tp_event_match
      0.15 ± 19%      -0.1        0.04 ± 73%      +0.0        0.15 ± 27%  perf-profile.self.cycles-pp.bpf_ksym_find
      0.11 ±  6%      -0.1        0.00            -0.0        0.09 ± 34%  perf-profile.self.cycles-pp.perf_callchain
      0.11 ± 15%      -0.1        0.00            -0.0        0.09 ± 34%  perf-profile.self.cycles-pp.__is_insn_slot_addr
      0.14 ± 16%      -0.1        0.04 ± 74%      -0.0        0.14 ± 15%  perf-profile.self.cycles-pp.save_fpregs_to_fpstate
      0.13 ±  7%      -0.1        0.03 ± 90%      +0.0        0.14 ± 22%  perf-profile.self.cycles-pp.get_callchain_entry
      0.18 ± 11%      -0.1        0.07 ± 12%      -0.0        0.16 ± 13%  perf-profile.self.cycles-pp.reweight_entity
      0.23 ±  5%      -0.1        0.12 ±  9%      -0.0        0.22 ±  5%  perf-profile.self.cycles-pp.switch_fpu_return
      0.28 ±  6%      -0.1        0.18 ±  8%      -0.0        0.28 ±  6%  perf-profile.self.cycles-pp.prepare_to_wait
      0.20 ± 12%      -0.1        0.10 ±  6%      +0.0        0.20 ±  9%  perf-profile.self.cycles-pp.pick_next_task_fair
      0.10 ± 12%      -0.1        0.01 ±282%      -0.0        0.08 ± 35%  perf-profile.self.cycles-pp.exc_page_fault
      0.10 ± 11%      -0.1        0.01 ±282%      -0.0        0.09 ± 35%  perf-profile.self.cycles-pp.kernelmode_fixup_or_oops
      0.17 ± 14%      -0.1        0.08 ± 16%      -0.0        0.17 ± 14%  perf-profile.self.cycles-pp.update_rq_clock
      0.10 ± 13%      -0.1        0.01 ±187%      -0.0        0.10 ± 10%  perf-profile.self.cycles-pp.___perf_sw_event
      0.09 ±  4%      -0.1        0.00            -0.0        0.07 ± 35%  perf-profile.self.cycles-pp.ftrace_ops_trampoline
      0.17 ± 12%      -0.1        0.09 ±  5%      +0.0        0.18 ±  9%  perf-profile.self.cycles-pp.enqueue_entity
      0.10 ± 15%      -0.1        0.02 ±141%      -0.0        0.09 ± 18%  perf-profile.self.cycles-pp.perf_trace_buf_alloc
      0.09 ± 15%      -0.1        0.00            -0.0        0.08 ± 35%  perf-profile.self.cycles-pp.perf_event_output_forward
      0.16 ± 12%      -0.1        0.07 ± 10%      -0.0        0.15 ± 11%  perf-profile.self.cycles-pp.select_idle_sibling
      0.16 ± 17%      -0.1        0.07 ± 18%      -0.0        0.15 ± 14%  perf-profile.self.cycles-pp.select_idle_cpu
      0.16 ±  4%      -0.1        0.08 ± 14%      -0.0        0.16 ±  5%  perf-profile.self.cycles-pp.resched_curr
      0.09 ± 12%      -0.1        0.01 ±187%      -0.0        0.08 ± 34%  perf-profile.self.cycles-pp.do_user_addr_fault
      0.07 ± 12%      -0.1        0.00            -0.0        0.07 ± 36%  perf-profile.self.cycles-pp.perf_misc_flags
      0.10 ± 15%      -0.1        0.03 ± 90%      -0.0        0.10 ± 19%  perf-profile.self.cycles-pp.tracing_gen_ctx_irq_test
      0.34 ±  5%      -0.1        0.27 ±  4%      -0.0        0.29 ±  4%  perf-profile.self.cycles-pp.sock_write_iter
      0.15 ± 15%      -0.1        0.08 ± 14%      -0.0        0.14 ± 12%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.07 ± 17%      -0.1        0.00            -0.0        0.06 ±  9%  perf-profile.self.cycles-pp.set_next_buddy
      0.15 ± 10%      -0.1        0.08 ±  6%      -0.0        0.15 ± 10%  perf-profile.self.cycles-pp.select_task_rq_fair
      0.07 ± 14%      -0.1        0.00            +0.0        0.07 ±  8%  perf-profile.self.cycles-pp.rb_insert_color
      0.14 ± 11%      -0.1        0.07 ±  8%      +0.0        0.15 ±  8%  perf-profile.self.cycles-pp.dequeue_task_fair
      0.07 ± 16%      -0.1        0.00            -0.0        0.06 ± 14%  perf-profile.self.cycles-pp.pick_next_entity
      0.07 ± 12%      -0.1        0.00            +0.0        0.07 ± 34%  perf-profile.self.cycles-pp.__perf_event_overflow
      0.13 ±  9%      -0.1        0.07 ± 12%      +0.0        0.14 ± 11%  perf-profile.self.cycles-pp.schedule
      0.06 ± 12%      -0.1        0.00            -0.0        0.06 ± 35%  perf-profile.self.cycles-pp.perf_event_pid_type
      0.13 ± 14%      -0.1        0.06 ±  7%      +0.0        0.13 ± 12%  perf-profile.self.cycles-pp.update_min_vruntime
      0.06 ± 14%      -0.1        0.00            -0.0        0.06 ± 10%  perf-profile.self.cycles-pp._find_next_bit
      0.06 ± 12%      -0.1        0.00            -0.0        0.05 ± 35%  perf-profile.self.cycles-pp.get_stack_info
      0.06 ± 10%      -0.1        0.00            -0.0        0.06 ± 10%  perf-profile.self.cycles-pp.rb_erase
      0.06 ± 12%      -0.1        0.00            -0.0        0.06 ± 10%  perf-profile.self.cycles-pp.check_preempt_curr
      0.06 ± 11%      -0.1        0.00            -0.0        0.05 ± 35%  perf-profile.self.cycles-pp.__wrgsbase_inactive
      0.06 ±  5%      -0.1        0.00            -0.0        0.05 ± 34%  perf-profile.self.cycles-pp.__bad_area_nosemaphore
      0.08 ± 16%      -0.1        0.02 ±141%      -0.0        0.07 ± 13%  perf-profile.self.cycles-pp.update_cfs_rq_h_load
      0.06 ±  7%      -0.1        0.00            -0.0        0.04 ± 50%  perf-profile.self.cycles-pp.perf_trace_run_bpf_submit
      0.30 ±  6%      -0.1        0.24 ±  2%      -0.0        0.28 ±  6%  perf-profile.self.cycles-pp.__libc_read
      0.05 ±  9%      -0.1        0.00            -0.0        0.05 ± 34%  perf-profile.self.cycles-pp.__x64_sys_write
      0.13 ±  7%      -0.1        0.08 ±  5%      -0.0        0.13 ±  8%  perf-profile.self.cycles-pp.do_syscall_64
      0.13 ± 11%      -0.1        0.08 ±  7%      -0.0        0.13 ±  9%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.05 ± 36%      -0.1        0.00            -0.0        0.04 ± 51%  perf-profile.self.cycles-pp.set_next_entity
      0.05 ± 36%      -0.1        0.00            -0.0        0.04 ± 51%  perf-profile.self.cycles-pp.perf_trace_buf_update
      0.09 ± 12%      -0.1        0.03 ± 71%      +0.0        0.09 ± 13%  perf-profile.self.cycles-pp.dequeue_entity
      0.05 ± 36%      -0.1        0.00            -0.0        0.04 ± 65%  perf-profile.self.cycles-pp.fixup_exception
      0.05 ± 36%      -0.1        0.00            -0.0        0.04 ± 66%  perf-profile.self.cycles-pp.perf_instruction_pointer
      0.05 ± 36%      -0.1        0.00            -0.0        0.05 ± 34%  perf-profile.self.cycles-pp.ttwu_do_activate
      0.11 ± 14%      -0.0        0.06 ± 16%      -0.0        0.11 ± 11%  perf-profile.self.cycles-pp.perf_trace_sched_wakeup_template
      0.05 ±  9%      -0.0        0.01 ±282%      +0.0        0.06 ±  9%  perf-profile.self.cycles-pp.ksys_write
      0.09 ± 12%      -0.0        0.04 ± 72%      -0.0        0.08 ± 34%  perf-profile.self.cycles-pp.__perf_event_header__init_id
      0.10 ±  9%      -0.0        0.05 ±  8%      -0.0        0.10 ±  8%  perf-profile.self.cycles-pp.__list_add_valid
      0.11 ± 10%      -0.0        0.06 ±  6%      -0.0        0.10 ± 11%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.24 ±  5%      -0.0        0.20 ±  3%      +0.0        0.24 ±  5%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.11 ±  9%      -0.0        0.06 ±  6%      +0.0        0.11 ±  8%  perf-profile.self.cycles-pp.__calc_delta
      0.08 ± 10%      -0.0        0.03 ± 70%      -0.0        0.08 ± 12%  perf-profile.self.cycles-pp.iov_iter_init
      0.04 ± 54%      -0.0        0.00            +0.0        0.04 ± 50%  perf-profile.self.cycles-pp.__wake_up_common_lock
      0.04 ± 53%      -0.0        0.00            +0.0        0.05 ± 34%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.09 ±  8%      -0.0        0.05 ± 12%      -0.0        0.09 ± 13%  perf-profile.self.cycles-pp.finish_task_switch
      0.08 ±  7%      -0.0        0.05 ± 36%      -0.0        0.07 ± 10%  perf-profile.self.cycles-pp.check_preempt_wakeup
      0.03 ± 70%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.autoremove_wake_function
      0.22 ±  8%      -0.0        0.19 ±  4%      -0.0        0.22 ±  4%  perf-profile.self.cycles-pp.vfs_read
      0.07 ±  4%      -0.0        0.04 ± 53%      -0.0        0.06 ± 34%  perf-profile.self.cycles-pp.sock_sendmsg
      0.14 ±  7%      -0.0        0.11 ± 13%      -0.0        0.12 ± 13%  perf-profile.self.cycles-pp.__wake_up_common
      0.03 ± 90%      -0.0        0.00            -0.0        0.01 ±299%  perf-profile.self.cycles-pp.perf_swevent_get_recursion_context
      0.03 ± 89%      -0.0        0.00            -0.0        0.02 ±152%  perf-profile.self.cycles-pp.perf_swevent_overflow
      0.03 ± 89%      -0.0        0.00            +0.0        0.05 ± 33%  perf-profile.self.cycles-pp.__rdgsbase_inactive
      0.41 ±  4%      -0.0        0.39 ± 12%      +0.0        0.43 ±  6%  perf-profile.self.cycles-pp.update_cfs_group
      0.11 ±  6%      -0.0        0.09 ±  5%      +0.0        0.13 ±  6%  perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.08 ± 11%      -0.0        0.05 ±  6%      +0.0        0.08 ± 11%  perf-profile.self.cycles-pp.schedule_timeout
      0.21 ±  3%      -0.0        0.18 ±  4%      -0.0        0.20 ±  4%  perf-profile.self.cycles-pp.sock_read_iter
      0.02 ±111%      -0.0        0.00            -0.0        0.02 ±152%  perf-profile.self.cycles-pp.search_extable
      0.02 ±111%      -0.0        0.00            -0.0        0.02 ±152%  perf-profile.self.cycles-pp.is_bpf_text_address
      0.02 ±111%      -0.0        0.00            +0.0        0.03 ±100%  perf-profile.self.cycles-pp.clear_buddies
      0.13 ±  7%      -0.0        0.11 ±  5%      -0.0        0.13 ±  7%  perf-profile.self.cycles-pp.security_file_permission
      0.08 ±  5%      -0.0        0.06 ±  7%      -0.0        0.08 ±  7%  perf-profile.self.cycles-pp.rcu_read_unlock_strict
      0.23 ±  3%      -0.0        0.21 ±  3%      -0.0        0.22 ±  2%  perf-profile.self.cycles-pp.__libc_write
      0.01 ±188%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.__cgroup_account_cputime
      0.27 ±  6%      -0.0        0.26 ±  4%      +0.0        0.28 ±  4%  perf-profile.self.cycles-pp.common_file_perm
      0.01 ±187%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.ex_handler_uaccess
      0.03 ± 89%      -0.0        0.02 ±141%      +0.0        0.04 ± 33%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.36 ±  5%      -0.0        0.35 ±  4%      -0.0        0.36 ±  4%  perf-profile.self.cycles-pp.get_obj_cgroup_from_current
      0.08 ±  6%      -0.0        0.07 ±  5%      +0.0        0.09 ±  6%  perf-profile.self.cycles-pp.unix_stream_recvmsg
      0.05            -0.0        0.04 ± 35%      -0.0        0.04 ± 33%  perf-profile.self.cycles-pp.syscall_enter_from_user_mode
      0.01 ±282%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.security_socket_getpeersec_dgram
      0.01 ±282%      -0.0        0.00            -0.0        0.01 ±299%  perf-profile.self.cycles-pp.get_stack_info_noinstr
      0.01 ±282%      -0.0        0.00            +0.0        0.01 ±200%  perf-profile.self.cycles-pp.sched_clock_cpu
      0.05 ±  8%      -0.0        0.05 ±  6%      +0.0        0.06 ±  9%  perf-profile.self.cycles-pp.alloc_skb_with_frags
      0.30 ±  3%      -0.0        0.30 ±  2%      +0.0        0.31 ±  2%  perf-profile.self.cycles-pp.__fget_light
      0.00            +0.0        0.00            +0.0        0.01 ±299%  perf-profile.self.cycles-pp.ktime_get
      0.00            +0.0        0.00            +0.0        0.01 ±299%  perf-profile.self.cycles-pp.maybe_add_creds
      0.00            +0.0        0.00            +0.1        0.05        perf-profile.self.cycles-pp.security_socket_sendmsg
      0.24 ±  4%      +0.0        0.24 ±  3%      +0.1        0.32 ±  5%  perf-profile.self.cycles-pp.vfs_write
      0.33            +0.0        0.33 ±  3%      +0.0        0.33 ±  2%  perf-profile.self.cycles-pp.___might_sleep
      0.02 ±112%      +0.0        0.03 ±113%      +0.0        0.04 ± 66%  perf-profile.self.cycles-pp.mem_cgroup_from_task
      0.11 ±  3%      +0.0        0.11 ±  4%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp._copy_to_iter
      0.12 ±  7%      +0.0        0.12 ±  3%      -0.0        0.11 ±  4%  perf-profile.self.cycles-pp.sock_alloc_send_pskb
      0.00            +0.0        0.01 ±282%      +0.0        0.00        perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      0.00            +0.0        0.01 ±282%      +0.0        0.00        perf-profile.self.cycles-pp.do_idle
      0.00            +0.0        0.01 ±282%      +0.0        0.00        perf-profile.self.cycles-pp.set_task_cpu
      0.01 ±282%      +0.0        0.01 ±187%      +0.0        0.02 ±153%  perf-profile.self.cycles-pp.__might_fault
      0.00            +0.0        0.01 ±282%      +0.0        0.03 ± 81%  perf-profile.self.cycles-pp.__skb_datagram_iter
      0.12 ±  6%      +0.0        0.13 ±  5%      +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.aa_file_perm
      0.06 ±  5%      +0.0        0.07            -0.0        0.06 ±  8%  perf-profile.self.cycles-pp.refill_obj_stock
      0.03 ± 89%      +0.0        0.04 ± 53%      +0.0        0.04 ± 50%  perf-profile.self.cycles-pp.__fdget_pos
      0.00            +0.0        0.01 ±188%      +0.0        0.00        perf-profile.self.cycles-pp.__anon_vma_interval_tree_subtree_search
      0.00            +0.0        0.01 ±188%      +0.0        0.00        perf-profile.self.cycles-pp.anon_vma_interval_tree_iter_next
      0.05 ±  7%      +0.0        0.06 ±  7%      +0.0        0.06 ±  5%  perf-profile.self.cycles-pp.check_stack_object
      0.05 ±  9%      +0.0        0.07 ±  4%      +0.0        0.06 ±  6%  perf-profile.self.cycles-pp.__cond_resched
      0.05 ±  7%      +0.0        0.07 ±  9%      +0.0        0.06 ±  8%  perf-profile.self.cycles-pp.rcu_all_qs
      0.12 ± 12%      +0.0        0.13 ±  9%      +0.0        0.13 ± 20%  perf-profile.self.cycles-pp.get_partial_node
      0.09 ±  6%      +0.0        0.11 ±  6%      +0.0        0.09 ± 10%  perf-profile.self.cycles-pp.obj_cgroup_charge
      0.10 ±  4%      +0.0        0.12 ±  5%      +0.0        0.10 ±  9%  perf-profile.self.cycles-pp._copy_from_iter
      0.14 ±  5%      +0.0        0.16 ±  5%      -0.0        0.14 ±  8%  perf-profile.self.cycles-pp.__ksize
      0.03 ± 70%      +0.0        0.06 ±  8%      +0.0        0.04 ± 50%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.00            +0.0        0.02 ±111%      +0.0        0.01 ±200%  perf-profile.self.cycles-pp.unix_destruct_scm
      0.18 ±  2%      +0.0        0.20 ±  5%      +0.0        0.18 ±  4%  perf-profile.self.cycles-pp.new_sync_read
      0.19 ±  6%      +0.0        0.21 ±  5%      +0.0        0.20 ±  9%  perf-profile.self.cycles-pp.__virt_addr_valid
      0.10 ± 14%      +0.0        0.12 ± 12%      +0.0        0.11 ± 26%  perf-profile.self.cycles-pp.__unfreeze_partials
      0.16            +0.0        0.18 ±  4%      +0.0        0.17 ±  3%  perf-profile.self.cycles-pp.__might_sleep
      0.00            +0.0        0.03 ±114%      +0.0        0.00        perf-profile.self.cycles-pp.wait_consider_task
      0.19 ±  4%      +0.0        0.22 ±  3%      +0.0        0.19 ±  4%  perf-profile.self.cycles-pp.aa_sk_perm
      0.17            +0.0        0.21 ±  3%      -0.0        0.17 ±  4%  perf-profile.self.cycles-pp.__entry_text_start
      0.27 ±  2%      +0.0        0.31 ±  3%      -0.0        0.27 ±  4%  perf-profile.self.cycles-pp.__alloc_skb
      0.50 ±  3%      +0.0        0.54 ±  3%      +0.0        0.52 ±  4%  perf-profile.self.cycles-pp.__kmalloc_node_track_caller
      0.01 ±282%      +0.0        0.05            +0.0        0.02 ±152%  perf-profile.self.cycles-pp.ksys_read
      0.05 ± 36%      +0.0        0.09 ±  7%      +0.0        0.06 ± 15%  perf-profile.self.cycles-pp.skb_copy_datagram_from_iter
      0.34            +0.0        0.39 ±  4%      +0.0        0.34 ±  5%  perf-profile.self.cycles-pp.kmem_cache_alloc_node
      0.21 ±  2%      +0.1        0.26 ±  4%      +0.0        0.22 ±  3%  perf-profile.self.cycles-pp.__check_heap_object
      0.36            +0.1        0.42 ±  2%      +0.0        0.37 ±  3%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.47 ±  4%      +0.1        0.53 ± 10%      -0.0        0.46 ±  6%  perf-profile.self.cycles-pp.unix_stream_sendmsg
      0.51 ±  5%      +0.1        0.57 ±  4%      +0.0        0.51 ±  4%  perf-profile.self.cycles-pp.mod_objcg_state
      0.00            +0.1        0.06 ±  7%      +0.0        0.01 ±299%  perf-profile.self.cycles-pp.refill_stock
      0.21 ±  6%      +0.1        0.28 ±  6%      +0.0        0.23 ±  9%  perf-profile.self.cycles-pp.unix_write_space
      0.31 ±  7%      +0.1        0.38 ±  5%      +0.0        0.34 ± 17%  perf-profile.self.cycles-pp.___slab_alloc
      0.13 ± 15%      +0.1        0.21 ±  9%      +0.0        0.14 ± 16%  perf-profile.self.cycles-pp.page_counter_uncharge
      0.19 ±  5%      +0.1        0.27 ±  9%      +0.0        0.19 ±  8%  perf-profile.self.cycles-pp.__build_skb_around
      0.40 ±  3%      +0.1        0.51 ±  6%      +0.0        0.41 ±  5%  perf-profile.self.cycles-pp.kfree
      0.36 ±  4%      +0.1        0.49 ±  5%      +0.0        0.38 ± 10%  perf-profile.self.cycles-pp.mutex_lock
      0.45 ±  4%      +0.1        0.59 ±  3%      +0.0        0.48 ±  5%  perf-profile.self.cycles-pp.__check_object_size
      0.20 ±  9%      +0.1        0.35 ±  8%      +0.0        0.22 ± 14%  perf-profile.self.cycles-pp.consume_skb
      0.02 ±187%      +0.1        0.17 ± 48%      +0.0        0.06 ± 85%  perf-profile.self.cycles-pp.page_vma_mapped_walk
      0.20 ± 12%      +0.2        0.35 ±  7%      +0.0        0.20 ± 13%  perf-profile.self.cycles-pp.skb_release_data
      0.58 ±  3%      +0.2        0.79 ±  5%      +0.0        0.61 ±  6%  perf-profile.self.cycles-pp.kmem_cache_free
      1.02 ±  3%      +0.2        1.23 ±  4%      +0.0        1.03 ±  5%  perf-profile.self.cycles-pp.unix_stream_read_generic
      0.85 ±  3%      +0.3        1.18 ±  3%      +0.0        0.88 ±  6%  perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
      1.24 ±  8%      +0.4        1.59 ±  8%      -0.0        1.23 ±  8%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.73 ± 10%      +0.4        1.16 ±  9%      -0.0        0.72 ± 10%  perf-profile.self.cycles-pp.obj_cgroup_uncharge_pages
      0.55 ± 13%      +0.5        1.00 ±  6%      +0.0        0.59 ± 18%  perf-profile.self.cycles-pp.mutex_unlock
      0.70 ±  9%      +0.5        1.20 ±  9%      -0.0        0.70 ± 12%  perf-profile.self.cycles-pp.obj_cgroup_charge_pages
      0.63 ±  6%      +0.5        1.16 ±  9%      +0.1        0.70 ± 14%  perf-profile.self.cycles-pp.skb_set_owner_w
      0.00            +0.6        0.56 ± 75%      +0.0        0.04 ±246%  perf-profile.self.cycles-pp.intel_idle
      0.73 ±  9%      +0.6        1.30 ±  6%      +0.0        0.77 ± 13%  perf-profile.self.cycles-pp.sock_wfree
      0.78 ± 12%      +0.7        1.44 ±  7%      +0.1        0.84 ± 17%  perf-profile.self.cycles-pp.sock_def_readable
      2.19 ±  4%      +0.7        2.93 ±  8%      +0.1        2.31 ±  9%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      1.50 ±  9%      +0.9        2.41 ±  9%      -0.0        1.49 ± 10%  perf-profile.self.cycles-pp.get_mem_cgroup_from_objcg
      2.74 ±  5%      +1.0        3.73 ±  6%      +0.2        2.91 ±  8%  perf-profile.self.cycles-pp._raw_spin_lock
      1.40 ± 10%      +1.1        2.52 ±  4%      +0.1        1.48 ± 15%  perf-profile.self.cycles-pp.__slab_free
      7.04 ± 13%      +3.8       10.82 ±  8%      +0.5        7.53 ± 13%  perf-profile.self.cycles-pp.propagate_protected_usage
     11.05 ± 12%      +5.7       16.77 ±  5%      +0.6       11.66 ± 13%  perf-profile.self.cycles-pp.page_counter_cancel
      0.00           +16.8       16.82 ±  5%      +0.0        0.00        perf-profile.self.cycles-pp.page_counter_charge
      0.01 ± 97%   +5481.0%       0.78 ±169%   +1768.6%       0.26 ±215%  perf-sched.sch_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      2.40 ±187%     +61.3%       3.87 ±141%    +154.0%       6.10 ±100%  perf-sched.sch_delay.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.35 ±275%    +818.8%       3.19 ±134%    +430.5%       1.84 ±223%  perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
    481.14 ±119%     -72.9%     130.60 ±100%     -62.7%     179.68 ±199%  perf-sched.sch_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
    563.67 ±182%     -83.3%      94.39 ±152%     -10.3%     505.40 ±136%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.10 ±195%   +7040.3%       6.88 ±127%  +1.5e+05%     144.06 ±206%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
    128.76 ± 96%     -44.0%      72.05 ± 38%     +21.1%     155.95 ± 74%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
    109.48 ±144%     -68.4%      34.59 ±231%     +28.7%     140.91 ±184%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
    129.65 ± 28%     -55.9%      57.22 ± 30%     +28.4%     166.43 ± 32%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
     18.69 ± 21%     -35.1%      12.13 ± 12%      +5.1%      19.64 ± 24%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.18 ±282%     -99.9%       0.00 ±282%     -63.0%       1.92 ±208%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.ret_from_fork.[unknown]
      0.00 ±211%     -46.7%       0.00 ±282%     -43.0%       0.00 ±299%  perf-sched.sch_delay.avg.ms.futex_wait_queue_me.futex_wait.do_futex.__x64_sys_futex
    509.13 ±171%     -87.2%      65.15 ± 85%     -68.4%     161.11 ±142%  perf-sched.sch_delay.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.00          -100.0%       0.00       +8.7e+102%       8.75 ±299%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.__alloc_pages.__get_free_pages.pgd_alloc
      2.87 ±231%    -100.0%       0.00           -87.2%       0.37 ±300%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.__alloc_pages.__pmd_alloc.__handle_mm_fault
      0.00 ±282%    +200.0%       0.00 ±282%  +6.4e+05%       3.58 ±300%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.__alloc_pages.__pmd_alloc.copy_page_range
      0.59 ±282%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.__alloc_pages.alloc_pages_vma.do_anonymous_page
      0.00       +1.8e+103%      17.66 ±282%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.__alloc_pages.alloc_pages_vma.do_fault
      0.00 ±282%  +9.2e+05%       7.17 ±254%  +2.3e+05%       1.80 ±291%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.__alloc_pages.alloc_pages_vma.wp_page_copy
      0.00       +9.8e+101%       0.98 ±254% +1.5e+102%       1.47 ±300%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.__alloc_pages.pte_alloc_one.__pte_alloc
      0.00       +8.8e+101%       0.88 ±282% +9.1e+101%       0.91 ±300%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.__anon_vma_prepare.do_fault.__handle_mm_fault
     13.37 ±282%     -98.9%       0.15 ±282%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.__kmalloc.load_elf_phdrs.load_elf_binary
      0.00          -100.0%       0.00        +2.2e+99%       0.00 ±300%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.__kmalloc.security_task_alloc.copy_process
      0.88 ±194%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.__kmalloc_node.memcg_alloc_page_obj_cgroups.kmem_cache_alloc_node
     43.35 ± 26%     -41.3%      25.43 ± 17%      -2.5%      42.25 ± 31%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb
      0.02 ±265%  +3.6e+05%      66.13 ±278%  +6.8e+06%       1240 ±170%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables
      0.55 ±282%     -53.2%       0.26 ±282%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.__split_huge_pud.__handle_mm_fault.handle_mm_fault
     31.74 ± 47%     -48.3%      16.40 ± 36%     +11.9%      35.52 ± 45%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.aa_sk_perm.security_socket_recvmsg.sock_recvmsg
    162.59 ± 29%     -77.0%      37.47 ± 31%     -26.4%     119.62 ± 28%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.aa_sk_perm.security_socket_sendmsg.sock_sendmsg
    309.49 ±282%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.change_p4d_range.change_protection.change_prot_numa
      0.00       +3.3e+102%       3.34 ±282%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.change_p4d_range.change_protection.mprotect_fixup
      0.00          +1e+99%       0.00 ±282%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.copy_page_from_iter.pipe_write.new_sync_write
      0.00       +2.1e+102%       2.10 ±282%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.copy_page_to_iter.pipe_read.new_sync_read
      0.00          +2e+99%       0.00 ±192%    +7e+98%       0.00 ±300%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.copy_pte_range.copy_page_range.dup_mmap
      0.00        +4.3e+99%       0.00 ±282%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.count.isra.0
      0.00 ±282%  +34107.7%       0.49 ±222%  +81474.6%       1.18 ±209%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      8.54 ±282%    +187.0%      24.50 ±280%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.down_read.rmap_walk_anon.remove_migration_ptes
      0.00          -100.0%       0.00       +2.9e+102%       2.86 ±300%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.down_read.walk_component.link_path_walk
      0.00       +2.6e+101%       0.26 ±282%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.down_write.__anon_vma_prepare.do_anonymous_page
      0.00       +1.1e+100%       0.01 ±282%   +3e+102%       2.99 ±299%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.down_write.__vma_adjust.shift_arg_pages
      0.00       +5.7e+101%       0.57 ±282%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.down_write.anon_vma_clone.anon_vma_fork
      0.00 ±282%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.down_write.anon_vma_fork.dup_mmap
      0.00        +7.1e+99%       0.01 ±282%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.down_write.unlink_anon_vmas.free_pgtables
      0.80 ±282%  +34736.2%     280.24 ±280%     -99.1%       0.01 ±300%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.down_write.unlink_file_vma.free_pgtables
      0.00       +5.3e+100%       0.05 ±282%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.down_write.vma_link.mmap_region
      0.10 ±282%    +319.2%       0.40 ±282%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.down_write_killable.setup_arg_pages.load_elf_binary
      0.00       +2.8e+102%       2.75 ±282%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.down_write_killable.vm_mmap_pgoff.elf_map
      0.00 ±282%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.dput.__fput.task_work_run
      0.03 ±282%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.dput.nd_jump_root.pick_link
     21.47 ±282%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.dput.path_put.vfs_statx
      0.00          -100.0%       0.00        +2.7e+99%       0.00 ±299%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.dput.proc_invalidate_siblings_dcache.release_task
      0.00          -100.0%       0.00          +2e+98%       0.00 ±300%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.dput.step_into.path_openat
      0.00       +3.4e+100%       0.03 ±282%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.dput.step_into.walk_component
      0.00       +1.2e+101%       0.12 ±279%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.dput.terminate_walk.path_openat
      0.00       +1.1e+102%       1.14 ±282%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.exit_mmap.mmput.begin_new_exec
      0.00          -100.0%       0.00          +2e+98%       0.00 ±300%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.exit_mmap.mmput.do_exit
      2.29 ±282%     -56.6%       1.00 ±281%   +1013.8%      25.55 ±300%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.filemap_read.__kernel_read.exec_binprm
      0.00       +2.9e+103%      28.81 ±282%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.getname_kernel.open_exec
      0.00        +1.3e+99%       0.00 ±282%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.prepare_creds.copy_creds
      0.00          -100.0%       0.00       +9.5e+102%       9.53 ±300%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.security_file_alloc.__alloc_file
      0.00       +3.4e+102%       3.40 ±282%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.vm_area_alloc.__install_special_mapping
      0.65 ±282%     -91.8%       0.05 ±282%     -99.1%       0.01 ±204%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.vm_area_alloc.alloc_bprm
     74.14 ± 49%     -62.4%      27.88 ± 29%     -13.3%      64.30 ± 52%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags
      0.00         +5e+100%       0.05 ±282%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc_trace.perf_event_mmap.mmap_region
      0.00         +4e+101%       0.40 ±282%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc_trace.vmstat_start.seq_read_iter
      0.00       +3.8e+104%     384.59 ±279%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.migrate_pages.migrate_misplaced_page.do_numa_page
      0.00 ±282%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.ldt_dup_context.dup_mmap
     23.54 ± 85%     -49.8%      11.81 ± 46%     -24.0%      17.90 ± 57%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.unix_stream_read_generic.unix_stream_recvmsg
      0.00       +7.4e+102%       7.36 ±282%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.uprobe_clear_state.mmput
      0.00 ±282%   +3793.3%       0.06 ±240%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.remove_vma.exit_mmap.mmput
    407.14 ±138%     -91.7%      33.80 ±172%     -20.7%     322.75 ±219%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.rmap_walk_anon.remove_migration_ptes.migrate_pages
     67.38 ±178%     -68.4%      21.32 ±153%     +57.7%     106.27 ±298%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.rmap_walk_anon.try_to_migrate.migrate_pages
      1.22 ±282%  +28296.4%     346.40 ±206%   +2203.2%      28.10 ±300%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.shrink_dentry_list.shrink_dcache_parent.d_invalidate
      1247 ±207%     -81.6%     230.12 ± 99%     -52.9%     587.64 ±224%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate
     18.04 ±113%     -44.3%      10.04 ± 60%     -17.1%      14.96 ±202%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.sched_exec.bprm_execve
      0.00          -100.0%       0.00       +1.4e+100%       0.01 ±300%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode
     26.50 ±122%     -38.9%      16.19 ± 38%     -88.6%       3.02 ± 55%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      1.97 ±282%     -95.0%       0.10 ±282%      -2.1%       1.93 ±300%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.unmap_page_range.unmap_vmas.exit_mmap
      0.00          -100.0%       0.00       +2.1e+101%       0.21 ±300%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.unmap_vmas.exit_mmap.mmput
      0.00        +8.9e+98%       0.00 ±282%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.uprobe_start_dup_mmap.dup_mmap.dup_mm
      0.00 ±282%    +237.5%       0.01 ±131%     -21.2%       0.00 ±300%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr_locked
    356.81 ±241%     -15.7%     300.82 ±132%    +138.2%     849.78 ±201%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.stop_two_cpus.migrate_swap
     24.54 ±120%     -35.8%      15.76 ± 53%    +107.2%      50.85 ± 86%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.wait_for_unix_gc.unix_stream_sendmsg.sock_sendmsg
      1.86 ±198%     -14.8%       1.59 ±147%     -85.4%       0.27 ±200%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.wp_page_copy.__handle_mm_fault.handle_mm_fault
      0.86 ±187%   +2297.7%      20.70 ±279%      +5.4%       0.91 ±300%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.zap_pte_range.unmap_page_range.unmap_vmas
     71.63 ±140%     -40.4%      42.70 ± 67%     +89.9%     136.06 ±148%  perf-sched.sch_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork
      1299 ±178%     -75.4%     319.70 ±118%     -40.6%     771.76 ±116%  perf-sched.sch_delay.avg.ms.rwsem_down_read_slowpath.page_lock_anon_vma_read.rmap_walk_anon.try_to_migrate
      1451 ±121%     -79.0%     305.20 ±115%     +37.9%       2001 ±122%  perf-sched.sch_delay.avg.ms.rwsem_down_read_slowpath.rmap_walk_anon.remove_migration_ptes.migrate_pages
      3054 ±267%     -95.5%     137.59 ±257%     -49.2%       1551 ±299%  perf-sched.sch_delay.avg.ms.rwsem_down_write_slowpath.__put_anon_vma.unlink_anon_vmas.free_pgtables
      2018 ±137%     -75.8%     489.28 ± 77%     +15.3%       2328 ± 94%  perf-sched.sch_delay.avg.ms.rwsem_down_write_slowpath.unlink_anon_vmas.free_pgtables.exit_mmap
    129.63 ±201%    +182.1%     365.70 ±151%     -99.5%       0.62 ±277%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.15 ±262%     -93.5%       0.01 ± 54%     -91.6%       0.01 ± 48%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_select
      1.09 ±159%     +28.5%       1.40 ±116%    +111.9%       2.32 ±143%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
      0.01 ±282%     +58.0%       0.01 ±146%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.__skb_wait_for_more_packets.__unix_dgram_recvmsg.__sys_recvfrom
      0.07 ±217%  +1.2e+05%      84.03 ±199%     -77.8%       0.02 ± 32%  perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
     90.56 ± 78%     -58.1%      37.90 ± 54%      +6.0%      95.97 ± 66%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    128.24 ± 25%     -30.8%      88.68 ± 19%      +8.5%     139.20 ± 30%  perf-sched.sch_delay.avg.ms.schedule_timeout.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg
     20.70 ± 18%     -47.6%      10.84 ± 16%      +3.8%      21.48 ± 22%  perf-sched.sch_delay.avg.ms.schedule_timeout.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      0.00       +5.5e+104%     552.84 ±282% +4.2e+101%       0.42 ±270%  perf-sched.sch_delay.avg.ms.schedule_timeout.wait_for_completion.stop_two_cpus.migrate_swap
      6.45 ±203%      +8.5%       7.00 ±143%     -59.6%       2.61 ±223%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.00 ±282%  +24129.2%       0.65 ±282%  +5.5e+07%       1479 ±299%  perf-sched.sch_delay.avg.ms.syslog_print.do_syslog.part.0.kmsg_read
      1.94 ±281%     -18.2%       1.59 ±120%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open.isra
    698.44 ± 77%     -22.2%     543.21 ± 66%      +0.6%     702.45 ± 50%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork
      0.01 ± 97%   +9369.0%       1.33 ±186%   +2295.0%       0.34 ±197%  perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      2.58 ±187%     +50.1%       3.87 ±141%    +136.4%       6.10 ±100%  perf-sched.sch_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.35 ±275%   +1052.6%       4.01 ±131%    +553.6%       2.27 ±188%  perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      8760 ±112%     -56.4%       3820 ± 83%     -42.7%       5020 ±202%  perf-sched.sch_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      4103 ±185%     -38.4%       2528 ±125%     +18.5%       4862 ±130%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      4.06 ±192%  +12329.9%     505.21 ±136%  +1.2e+05%       4716 ±213%  perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      9639 ± 84%     -45.4%       5267 ± 36%     +11.9%      10785 ± 80%  perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      6842 ±138%     -86.6%     914.49 ±149%     -45.6%       3721 ±161%  perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
     20977 ± 17%     -60.9%       8211 ± 27%      +6.8%      22401 ± 18%  perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
     25194 ± 12%     -51.0%      12344 ± 23%      +1.8%      25656 ± 20%  perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
     10.36 ±282%     -99.9%       0.01 ±282%     -81.5%       1.92 ±208%  perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.ret_from_fork.[unknown]
      0.00 ±211%     -40.0%       0.00 ±282%     -43.0%       0.00 ±299%  perf-sched.sch_delay.max.ms.futex_wait_queue_me.futex_wait.do_futex.__x64_sys_futex
      9508 ±106%     -26.8%       6959 ± 46%     +13.2%      10767 ± 83%  perf-sched.sch_delay.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.00          -100.0%       0.00       +8.7e+102%       8.75 ±299%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.__alloc_pages.__get_free_pages.pgd_alloc
      3.89 ±192%    -100.0%       0.00           -62.3%       1.47 ±300%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.__alloc_pages.__pmd_alloc.__handle_mm_fault
      0.00 ±282%    +200.0%       0.00 ±282%  +6.4e+05%       3.58 ±300%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.__alloc_pages.__pmd_alloc.copy_page_range
      1.76 ±282%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.__alloc_pages.alloc_pages_vma.do_anonymous_page
      0.00       +1.8e+103%      17.66 ±282%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.__alloc_pages.alloc_pages_vma.do_fault
      0.01 ±282%  +5.9e+05%      37.30 ±243%  +2.5e+05%      15.97 ±295%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.__alloc_pages.alloc_pages_vma.wp_page_copy
      0.00       +9.4e+102%       9.45 ±265% +7.3e+102%       7.34 ±300%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.__alloc_pages.pte_alloc_one.__pte_alloc
      0.00       +1.8e+102%       1.75 ±282% +3.6e+102%       3.63 ±300%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.__anon_vma_prepare.do_fault.__handle_mm_fault
     13.37 ±282%     -97.8%       0.30 ±282%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.__kmalloc.load_elf_phdrs.load_elf_binary
      0.00          -100.0%       0.00        +2.2e+99%       0.00 ±300%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.__kmalloc.security_task_alloc.copy_process
      1.42 ±218%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.__kmalloc_node.memcg_alloc_page_obj_cgroups.kmem_cache_alloc_node
     23065 ± 13%     -56.8%       9958 ± 26%      +2.2%      23571 ± 27%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb
      0.04 ±252%  +6.8e+05%     262.55 ±280%  +1.8e+07%       6776 ±149%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables
      3.84 ±282%     -79.9%       0.77 ±282%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.__split_huge_pud.__handle_mm_fault.handle_mm_fault
     14295 ± 26%     -52.6%       6772 ± 34%     +21.3%      17334 ± 32%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.aa_sk_perm.security_socket_recvmsg.sock_recvmsg
     23567 ± 12%     -69.8%       7110 ± 30%      -2.1%      23063 ± 26%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.aa_sk_perm.security_socket_sendmsg.sock_sendmsg
      1237 ±282%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.change_p4d_range.change_protection.change_prot_numa
      0.00       +6.7e+102%       6.67 ±282%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.change_p4d_range.change_protection.mprotect_fixup
      0.00       +1.2e+100%       0.01 ±282%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.copy_page_from_iter.pipe_write.new_sync_write
      0.00       +2.1e+102%       2.10 ±282%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.copy_page_to_iter.pipe_read.new_sync_read
      0.00          +2e+99%       0.00 ±192%    +7e+98%       0.00 ±300%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.copy_pte_range.copy_page_range.dup_mmap
      0.00       +1.3e+100%       0.01 ±282%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.count.isra.0
      0.01 ±282%  +1.2e+05%       9.85 ±192%  +1.8e+05%      15.44 ±235%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      8.54 ±282%   +1052.4%      98.43 ±278%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.down_read.rmap_walk_anon.remove_migration_ptes
      0.00          -100.0%       0.00       +8.6e+102%       8.58 ±299%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.down_read.walk_component.link_path_walk
      0.00       +2.6e+101%       0.26 ±282%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.down_write.__anon_vma_prepare.do_anonymous_page
      0.00       +1.2e+101%       0.12 ±282%   +9e+102%       8.98 ±299%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.down_write.__vma_adjust.shift_arg_pages
      0.00       +6.5e+101%       0.65 ±282%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.down_write.anon_vma_clone.anon_vma_fork
      0.00 ±282%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.down_write.anon_vma_fork.dup_mmap
      0.00       +3.6e+100%       0.04 ±282%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.down_write.unlink_anon_vmas.free_pgtables
      6.44 ±282%  +21889.7%       1415 ±277%     -99.5%       0.03 ±300%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.down_write.unlink_file_vma.free_pgtables
      0.00       +4.2e+101%       0.42 ±282%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.down_write.vma_link.mmap_region
      0.95 ±282%     -15.8%       0.80 ±281%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.down_write_killable.setup_arg_pages.load_elf_binary
      0.00       +5.5e+102%       5.50 ±282%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.down_write_killable.vm_mmap_pgoff.elf_map
      0.00 ±282%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.dput.__fput.task_work_run
      0.06 ±282%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.dput.nd_jump_root.pick_link
     21.47 ±282%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.dput.path_put.vfs_statx
      0.00          -100.0%       0.00        +2.7e+99%       0.00 ±299%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.dput.proc_invalidate_siblings_dcache.release_task
      0.00          -100.0%       0.00          +3e+98%       0.00 ±300%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.dput.step_into.path_openat
      0.00       +5.8e+101%       0.58 ±282%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.dput.step_into.walk_component
      0.00       +7.3e+101%       0.73 ±280%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.dput.terminate_walk.path_openat
      0.00       +4.6e+102%       4.58 ±282%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.exit_mmap.mmput.begin_new_exec
      0.00          -100.0%       0.00        +1.2e+99%       0.00 ±300%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.exit_mmap.mmput.do_exit
      9.18 ±282%     -67.5%       2.99 ±281%    +178.4%      25.55 ±300%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.filemap_read.__kernel_read.exec_binprm
      0.00       +2.9e+103%      28.81 ±282%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.getname_kernel.open_exec
      0.00        +1.3e+99%       0.00 ±282%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.prepare_creds.copy_creds
      0.00          -100.0%       0.00       +9.5e+102%       9.53 ±300%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.security_file_alloc.__alloc_file
      0.00       +6.8e+102%       6.81 ±282%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.vm_area_alloc.__install_special_mapping
      0.65 ±282%     -34.4%       0.43 ±282%     -97.7%       0.01 ±217%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.vm_area_alloc.alloc_bprm
     19902 ± 33%     -64.2%       7125 ± 38%      +3.2%      20540 ± 26%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags
      0.00       +3.9e+101%       0.39 ±282%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc_trace.perf_event_mmap.mmap_region
      0.00         +8e+101%       0.80 ±282%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc_trace.vmstat_start.seq_read_iter
      0.00       +1.2e+105%       1158 ±278%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.migrate_pages.migrate_misplaced_page.do_numa_page
      0.00 ±282%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.ldt_dup_context.dup_mmap
     10208 ± 67%     -48.1%       5299 ± 39%      +2.5%      10460 ± 52%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.unix_stream_read_generic.unix_stream_recvmsg
      0.00       +7.4e+102%       7.36 ±282%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.uprobe_clear_state.mmput
      0.01 ±282%  +13110.0%       0.88 ±248%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.remove_vma.exit_mmap.mmput
     12653 ± 72%     -79.0%       2662 ±127%     -40.1%       7580 ±113%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.rmap_walk_anon.remove_migration_ptes.migrate_pages
      2590 ±187%     -49.6%       1305 ±190%     -50.3%       1288 ±295%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.rmap_walk_anon.try_to_migrate.migrate_pages
      9.76 ±282%   +5542.2%     550.61 ±188%   +8249.4%     814.79 ±300%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.shrink_dentry_list.shrink_dcache_parent.d_invalidate
      4110 ±197%     -18.5%       3351 ± 98%     -48.7%       2109 ±204%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate
     84.16 ±100%      -1.5%      82.93 ± 55%     -24.3%      63.68 ±191%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.sched_exec.bprm_execve
      0.00          -100.0%       0.00       +1.4e+100%       0.01 ±300%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      3477 ±141%     -51.9%       1672 ± 56%     -96.2%     133.50 ± 66%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      1.97 ±282%     -65.4%       0.68 ±282%    +193.6%       5.80 ±300%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.unmap_page_range.unmap_vmas.exit_mmap
      0.00          -100.0%       0.00       +2.1e+101%       0.21 ±300%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.unmap_vmas.exit_mmap.mmput
      0.00        +8.9e+98%       0.00 ±282%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.uprobe_start_dup_mmap.dup_mmap.dup_mm
      0.33 ±282%    +373.1%       1.58 ±134%      -9.1%       0.30 ±287%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr_locked
      3733 ±231%     -18.0%       3063 ±112%     +22.0%       4556 ±189%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.stop_two_cpus.migrate_swap
      7060 ±106%     -42.1%       4088 ± 61%     +62.9%      11505 ± 84%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.wait_for_unix_gc.unix_stream_sendmsg.sock_sendmsg
      8.92 ±160%    +191.1%      25.96 ±148%     -33.7%       5.91 ±242%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.wp_page_copy.__handle_mm_fault.handle_mm_fault
     12.24 ±199%   +3111.4%     392.97 ±279%     +48.7%      18.19 ±300%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.zap_pte_range.unmap_page_range.unmap_vmas
      1518 ±202%     -22.8%       1172 ± 73%     +42.1%       2158 ±152%  perf-sched.sch_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork
      7040 ±131%     -49.3%       3567 ±106%     +21.1%       8528 ±109%  perf-sched.sch_delay.max.ms.rwsem_down_read_slowpath.page_lock_anon_vma_read.rmap_walk_anon.try_to_migrate
      9129 ±104%     -47.1%       4825 ±113%      +4.0%       9493 ±120%  perf-sched.sch_delay.max.ms.rwsem_down_read_slowpath.rmap_walk_anon.remove_migration_ptes.migrate_pages
      3351 ±243%     -79.5%     687.82 ±257%     -46.2%       1803 ±299%  perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.__put_anon_vma.unlink_anon_vmas.free_pgtables
      8544 ±124%     -32.4%       5778 ± 83%     +69.8%      14512 ± 82%  perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.unlink_anon_vmas.free_pgtables.exit_mmap
      1138 ±260%    +119.9%       2504 ±153%     -99.9%       1.25 ±278%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.44 ±274%     -97.2%       0.01 ± 56%     -96.5%       0.02 ± 49%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_select
      3.16 ±164%     +86.3%       5.89 ±101%    +138.4%       7.54 ±147%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
      0.01 ±282%     +58.0%       0.01 ±146%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_timeout.__skb_wait_for_more_packets.__unix_dgram_recvmsg.__sys_recvfrom
      0.36 ±261%  +2.6e+05%     952.14 ±206%     -91.2%       0.03 ± 74%  perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      9639 ± 77%     -62.9%       3574 ± 50%     -25.7%       7163 ± 52%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     24898 ± 15%     -51.1%      12173 ± 27%      +2.9%      25623 ± 21%  perf-sched.sch_delay.max.ms.schedule_timeout.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg
     25137 ± 13%     -52.9%      11842 ± 25%      +0.1%      25173 ± 20%  perf-sched.sch_delay.max.ms.schedule_timeout.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      0.00          -100.0%       0.00        +1.9e+99%       0.00 ±299%  perf-sched.sch_delay.max.ms.schedule_timeout.wait_for_completion.rdmsr_safe_on_cpu.msr_read
      0.00       +5.5e+104%     552.84 ±282% +4.2e+101%       0.42 ±270%  perf-sched.sch_delay.max.ms.schedule_timeout.wait_for_completion.stop_two_cpus.migrate_swap
      1019 ±202%     +66.4%       1696 ±151%     -36.7%     645.39 ±224%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.00 ±282%  +37412.9%       1.29 ±282%  +4.3e+07%       1479 ±299%  perf-sched.sch_delay.max.ms.syslog_print.do_syslog.part.0.kmsg_read
      4.00 ±282%    +242.3%      13.69 ±130%    -100.0%       0.00        perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open.isra
     15981 ± 74%     -22.8%      12337 ± 27%     +28.7%      20566 ± 40%  perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork
     24.61 ± 19%     -30.7%      17.06 ± 13%      +3.8%      25.55 ± 23%  perf-sched.total_sch_delay.average.ms
     25670 ± 13%     -49.0%      13094 ± 25%      +1.1%      25947 ± 21%  perf-sched.total_sch_delay.max.ms
     86.11 ± 19%     -28.4%      61.62 ± 14%      +4.9%      90.31 ± 21%  perf-sched.total_wait_and_delay.average.ms
   1391798 ± 12%     +18.3%    1645969 ± 18%      +0.2%    1394008 ± 15%  perf-sched.total_wait_and_delay.count.ms
     51207 ± 13%     -48.9%      26189 ± 25%      +0.8%      51637 ± 21%  perf-sched.total_wait_and_delay.max.ms
     61.50 ± 19%     -27.5%      44.56 ± 14%      +5.3%      64.76 ± 21%  perf-sched.total_wait_time.average.ms
     25987 ± 12%     -45.5%      14154 ± 25%      +1.1%      26277 ± 20%  perf-sched.total_wait_time.max.ms
      0.00       +9.5e+104%     946.14 ±197% +1.5e+104%     150.05 ±300%  perf-sched.wait_and_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    129.13 ±282%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      2058 ±165%     -65.6%     707.75 ±187%     -82.9%     351.30 ±300%  perf-sched.wait_and_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      0.00          -100.0%       0.00       +1.9e+105%       1898 ±300%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.__x64_sys_exit.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1933 ±106%     -76.6%     452.62 ±112%     -36.0%       1236 ±165%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      1118 ±160%     -65.5%     385.56 ± 67%     +62.6%       1819 ± 89%  perf-sched.wait_and_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.00       +4.3e+103%      43.27 ±147%   +3e+104%     297.95 ±199%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
    550.82 ± 52%     -48.5%     283.73 ± 28%      +7.2%     590.46 ± 56%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
    511.95 ± 83%     -73.3%     136.86 ±118%     -38.2%     316.40 ±171%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
    495.94 ± 26%     -62.2%     187.24 ± 28%     +21.4%     601.91 ± 30%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
     70.62 ± 19%     -37.3%      44.28 ± 12%      +8.9%      76.88 ± 22%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1021 ±103%     -60.2%     406.79 ±122%     -49.8%     512.61 ± 75%  perf-sched.wait_and_delay.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.00          -100.0%       0.00       +8.7e+102%       8.75 ±299%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.__alloc_pages.__get_free_pages.pgd_alloc
      0.00          -100.0%       0.00       +1.3e+103%      13.13 ±299%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.__alloc_pages.__pmd_alloc.copy_page_range
      0.00       +1.8e+103%      17.66 ±282%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.__alloc_pages.alloc_pages_vma.do_fault
      0.00       +8.5e+102%       8.45 ±282%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.__alloc_pages.alloc_pages_vma.shmem_alloc_page
      0.00       +6.5e+102%       6.52 ±282%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.__alloc_pages.alloc_pages_vma.wp_page_copy
     13.37 ±282%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.__kmalloc.load_elf_phdrs.load_elf_binary
     17.68 ±282%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.__kmalloc.perf_read.vfs_read
      0.00       +5.5e+104%     546.74 ±282%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.__kmalloc_node.__vmalloc_area_node.constprop
     15.21 ±282%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.__kmalloc_node.memcg_alloc_page_obj_cgroups.kmem_cache_alloc_node
    160.03 ± 21%     -41.5%      93.54 ± 17%      -2.9%     155.31 ± 23%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb
      0.00       +4.9e+104%     485.33 ±153%   +4e+105%       4047 ±125%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables
    113.84 ± 46%     -57.8%      48.00 ± 72%     -10.8%     101.55 ± 54%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.aa_sk_perm.security_socket_recvmsg.sock_recvmsg
    574.46 ± 19%     -75.2%     142.72 ± 26%     -10.0%     516.76 ± 22%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.aa_sk_perm.security_socket_sendmsg.sock_sendmsg
    619.44 ±282%     -91.8%      50.65 ±282%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.change_p4d_range.change_protection.change_prot_numa
      4249 ±166%     -76.8%     985.69 ±120%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.down_read.rmap_walk_anon.remove_migration_ptes
      0.00       +8.4e+103%      84.25 ±238%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.down_write.anon_vma_clone.anon_vma_fork
      0.00       +5.6e+104%     557.16 ±282%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.down_write.unlink_file_vma.free_pgtables
     21.47 ±282%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.dput.path_put.vfs_statx
      0.00          -100.0%       0.00       +2.6e+103%      25.55 ±300%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.filemap_read.__kernel_read.exec_binprm
     52.45 ±282%     -57.9%      22.09 ±187%     -17.5%      43.28 ±127%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
      0.00       +2.9e+103%      28.81 ±282%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.getname_kernel.open_exec
      0.00       +1.3e+103%      13.30 ±282%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.prepare_creds.copy_creds
    281.24 ± 32%     -60.2%     112.06 ± 25%      -6.6%     262.54 ± 36%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags
      0.00       +7.7e+104%     773.77 ±278%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.migrate_pages.migrate_misplaced_page.do_numa_page
     18.71 ±282%    +128.7%      42.78 ±282%     +98.9%      37.21 ±219%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.perf_event_ctx_lock_nested.isra
      0.00       +6.9e+102%       6.94 ±282%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.seq_read_iter.new_sync_read
     54.31 ±118%     -86.5%       7.33 ±282%     -83.7%       8.83 ±300%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.unix_stream_read_generic.unix_stream_recvmsg
      1339 ±152%     -88.3%     157.19 ±114%     -17.9%       1099 ±198%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.rmap_walk_anon.remove_migration_ptes.migrate_pages
    473.43 ±215%     -68.6%     148.54 ±103%    +145.0%       1159 ±157%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.rmap_walk_anon.try_to_migrate.migrate_pages
     30.23 ±282%   +2623.9%     823.34 ±199%    +130.6%      69.70 ±300%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.shrink_dentry_list.shrink_dcache_parent.d_invalidate
      0.00          -100.0%       0.00       +4.8e+103%      47.92 ±299%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork
      5434 ±112%     -83.3%     909.70 ±104%     -68.7%       1698 ±195%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate
      0.00          -100.0%       0.00       +1.3e+103%      12.74 ±300%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.sched_exec.bprm_execve
      0.00       +9.5e+102%       9.50 ±282%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.try_to_migrate_one.rmap_walk_anon.try_to_migrate
     49.85 ±187%      +6.3%      53.01 ± 92%     -51.5%      24.19 ±201%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      0.00       +4.7e+104%     474.02 ±282%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.uprobe_start_dup_mmap.dup_mmap.dup_mm
    140.30 ± 34%     -80.6%      27.23 ±148%     -10.7%     125.27 ± 56%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr_locked
      1850 ±150%     -42.7%       1059 ± 78%     +44.7%       2678 ±142%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.stop_two_cpus.migrate_swap
     78.87 ± 97%     -35.8%      50.63 ± 74%     +82.5%     143.97 ± 70%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.wait_for_unix_gc.unix_stream_sendmsg.sock_sendmsg
    567.80 ±187%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.wp_page_copy.__handle_mm_fault.handle_mm_fault
      0.00       +7.1e+103%      70.60 ±282%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.zap_pte_range.unmap_page_range.unmap_vmas
    174.74 ±155%     -51.5%      84.66 ± 84%     +70.7%     298.32 ±150%  perf-sched.wait_and_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork
      2941 ±157%     -61.4%       1134 ±110%     +20.7%       3550 ± 91%  perf-sched.wait_and_delay.avg.ms.rwsem_down_read_slowpath.page_lock_anon_vma_read.rmap_walk_anon.try_to_migrate
      5053 ± 88%     -75.1%       1257 ± 99%     +72.1%       8698 ± 94%  perf-sched.wait_and_delay.avg.ms.rwsem_down_read_slowpath.rmap_walk_anon.remove_migration_ptes.migrate_pages
      7875 ±207%     -88.8%     879.95 ±146%     -48.0%       4098 ±224%  perf-sched.wait_and_delay.avg.ms.rwsem_down_write_slowpath.__put_anon_vma.unlink_anon_vmas.free_pgtables
      7281 ±111%     -73.7%       1915 ± 83%     +14.0%       8304 ± 86%  perf-sched.wait_and_delay.avg.ms.rwsem_down_write_slowpath.unlink_anon_vmas.free_pgtables.exit_mmap
    297.87 ±185%    +363.9%       1381 ± 84%     +12.5%     334.98 ±192%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
    261.09 ±163%    +382.7%       1260 ±115%    +785.7%       2312 ±148%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
      3266 ± 66%      -8.3%       2995 ± 27%     -27.5%       2369 ±114%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.00          -100.0%       0.00       +4.7e+104%     469.09 ±300%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.msleep.cpuinfo_open.do_dentry_open
    171.19 ± 96%     -61.6%      65.79 ± 96%     +17.9%     201.87 ± 79%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    469.12 ± 28%     -32.7%     315.85 ± 20%     +10.7%     519.16 ± 29%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg
     68.95 ± 17%     -43.8%      38.72 ± 15%      +3.5%      71.39 ± 21%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      0.00       +1.1e+105%       1105 ±282%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_timeout.wait_for_completion.stop_two_cpus.migrate_swap
      1631 ± 30%      +5.9%       1728 ± 37%     +13.3%       1848 ± 43%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.00       +2.2e+104%     223.52 ±282% +1.5e+105%       1478 ±299%  perf-sched.wait_and_delay.avg.ms.syslog_print.do_syslog.part.0.kmsg_read
      2142 ± 43%     +12.7%       2415 ± 35%      +7.0%       2293 ± 24%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork
      0.00       +6.7e+101%       0.67 ±141%   +2e+101%       0.20 ±300%  perf-sched.wait_and_delay.count.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.22 ±282%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_and_delay.count.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.67 ±141%     -16.7%       0.56 ±191%     -70.0%       0.20 ±300%  perf-sched.wait_and_delay.count.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      0.00          -100.0%       0.00         +1e+101%       0.10 ±300%  perf-sched.wait_and_delay.count.do_task_dead.do_exit.__x64_sys_exit.do_syscall_64.entry_SYSCALL_64_after_hwframe
     14.00 ± 78%    +196.8%      41.56 ± 56%     -25.0%      10.50 ±111%  perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      7.33 ±116%    +350.0%      33.00 ± 51%     +59.5%      11.70 ± 53%  perf-sched.wait_and_delay.count.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.00       +2.8e+103%      27.89 ±145% +8.4e+102%       8.40 ±157%  perf-sched.wait_and_delay.count.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
    127.78 ± 11%     +59.5%     203.78 ± 15%      -0.8%     126.70 ± 19%  perf-sched.wait_and_delay.count.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
     42.00 ± 68%      +5.8%      44.44 ±163%     -50.5%      20.80 ±124%  perf-sched.wait_and_delay.count.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
    999.00 ± 14%     +34.3%       1341 ± 16%      -6.1%     938.40 ±  9%  perf-sched.wait_and_delay.count.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
    342879 ± 12%      -7.8%     316107 ± 22%      -0.0%     342778 ± 18%  perf-sched.wait_and_delay.count.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
    126.00 ±103%    +215.9%     398.00 ± 61%      -1.5%     124.10 ± 78%  perf-sched.wait_and_delay.count.pipe_read.new_sync_read.vfs_read.ksys_read
      0.00          -100.0%       0.00         +1e+101%       0.10 ±300%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.__alloc_pages.__get_free_pages.pgd_alloc
      0.00          -100.0%       0.00         +1e+101%       0.10 ±300%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.__alloc_pages.__pmd_alloc.copy_page_range
      0.00       +1.1e+101%       0.11 ±282%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.__alloc_pages.alloc_pages_vma.do_fault
      0.00       +4.6e+102%       4.56 ±282%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.__alloc_pages.alloc_pages_vma.shmem_alloc_page
      0.00       +5.6e+101%       0.56 ±282%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.__alloc_pages.alloc_pages_vma.wp_page_copy
      0.11 ±282%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.__kmalloc.load_elf_phdrs.load_elf_binary
      0.11 ±282%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.__kmalloc.perf_read.vfs_read
      0.00       +1.1e+101%       0.11 ±282%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.__kmalloc_node.__vmalloc_area_node.constprop
      0.11 ±282%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.__kmalloc_node.memcg_alloc_page_obj_cgroups.kmem_cache_alloc_node
     11830 ± 14%     +43.6%      16983 ± 18%      +1.4%      11991 ± 12%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb
      0.00       +3.2e+102%       3.22 ±118% +3.9e+102%       3.90 ±113%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables
      1212 ± 39%     +22.0%       1478 ± 71%      -7.1%       1126 ± 50%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.aa_sk_perm.security_socket_recvmsg.sock_recvmsg
      1916 ± 10%     -13.8%       1651 ± 16%      +2.4%       1963 ±  8%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.aa_sk_perm.security_socket_sendmsg.sock_sendmsg
      0.44 ±282%     -50.0%       0.22 ±282%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.change_p4d_range.change_protection.change_prot_numa
      0.56 ±149%    +340.0%       2.44 ±120%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.down_read.rmap_walk_anon.remove_migration_ptes
      0.00       +3.3e+101%       0.33 ±199%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.down_write.anon_vma_clone.anon_vma_fork
      0.00       +5.6e+101%       0.56 ±282%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.down_write.unlink_file_vma.free_pgtables
      0.11 ±282%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.dput.path_put.vfs_statx
      0.00          -100.0%       0.00         +1e+101%       0.10 ±300%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.filemap_read.__kernel_read.exec_binprm
      0.11 ±282%  +20700.0%      23.11 ±219%  +16910.0%      18.90 ±206%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
      0.00       +1.1e+101%       0.11 ±282%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.kmem_cache_alloc.getname_kernel.open_exec
      0.00       +1.1e+101%       0.11 ±282%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.kmem_cache_alloc.prepare_creds.copy_creds
      1381 ± 12%     +47.7%       2040 ± 16%      -1.6%       1359 ±  9%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags
      0.00       +7.8e+101%       0.78 ±189%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.migrate_pages.migrate_misplaced_page.do_numa_page
      1.00 ±282%      +0.0%       1.00 ±282%     +90.0%       1.90 ±208%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.mutex_lock.perf_event_ctx_lock_nested.isra
      0.00       +1.1e+101%       0.11 ±282%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.mutex_lock.seq_read_iter.new_sync_read
    458.00 ±114%     -50.9%     224.67 ±282%     -78.9%      96.80 ±300%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.mutex_lock.unix_stream_read_generic.unix_stream_recvmsg
     87.44 ± 99%    +124.7%     196.44 ±112%      -7.1%      81.20 ±101%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.rmap_walk_anon.remove_migration_ptes.migrate_pages
     19.56 ±169%     +75.6%      34.33 ±152%     -70.9%       5.70 ±140%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.rmap_walk_anon.try_to_migrate.migrate_pages
      0.89 ±282%     +37.5%       1.22 ±184%    +226.2%       2.90 ±299%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.shrink_dentry_list.shrink_dcache_parent.d_invalidate
      0.00          -100.0%       0.00         +2e+101%       0.20 ±300%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork
      2.78 ±109%    +284.0%      10.67 ±103%     -60.4%       1.10 ±216%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate
      0.00          -100.0%       0.00         +4e+101%       0.40 ±300%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.stop_one_cpu.sched_exec.bprm_execve
      0.00       +1.1e+101%       0.11 ±282%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.try_to_migrate_one.rmap_walk_anon.try_to_migrate
     38.67 ±187%    +162.6%     101.56 ± 92%     -36.9%      24.40 ±201%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      0.00       +1.1e+101%       0.11 ±282%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.uprobe_start_dup_mmap.dup_mmap.dup_mm
    199.33 ± 22%     -60.5%      78.67 ±145%     -19.2%     161.00 ± 52%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr_locked
      4.56 ±124%    +231.7%      15.11 ± 93%     -16.6%       3.80 ±121%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.wait_for_completion.stop_two_cpus.migrate_swap
    267.67 ± 90%     +24.5%     333.33 ± 73%     +44.3%     386.30 ± 50%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.wait_for_unix_gc.unix_stream_sendmsg.sock_sendmsg
      2.44 ±188%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.wp_page_copy.__handle_mm_fault.handle_mm_fault
      0.00       +2.1e+102%       2.11 ±282%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.zap_pte_range.unmap_page_range.unmap_vmas
      9.44 ±140%    +201.2%      28.44 ± 80%     -10.0%       8.50 ±134%  perf-sched.wait_and_delay.count.rcu_gp_kthread.kthread.ret_from_fork
      8.44 ±184%    +292.1%      33.11 ±102%      +3.0%       8.70 ± 83%  perf-sched.wait_and_delay.count.rwsem_down_read_slowpath.page_lock_anon_vma_read.rmap_walk_anon.try_to_migrate
     12.11 ±122%    +151.4%      30.44 ±101%     -40.6%       7.20 ± 95%  perf-sched.wait_and_delay.count.rwsem_down_read_slowpath.rmap_walk_anon.remove_migration_ptes.migrate_pages
      0.56 ±172%    +300.0%       2.22 ± 98%     +26.0%       0.70 ±157%  perf-sched.wait_and_delay.count.rwsem_down_write_slowpath.__put_anon_vma.unlink_anon_vmas.free_pgtables
      8.78 ± 84%    +438.0%      47.22 ± 98%     +61.8%      14.20 ± 90%  perf-sched.wait_and_delay.count.rwsem_down_write_slowpath.unlink_anon_vmas.free_pgtables.exit_mmap
      2.22 ±166%    +120.0%       4.89 ± 58%     -59.5%       0.90 ±175%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      1.89 ±158%    +264.7%       6.89 ±182%    +122.4%       4.20 ±177%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
      5.44 ± 39%    +100.0%      10.89 ± 20%     -17.3%       4.50 ± 53%  perf-sched.wait_and_delay.count.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.00          -100.0%       0.00         +1e+101%       0.10 ±300%  perf-sched.wait_and_delay.count.schedule_timeout.msleep.cpuinfo_open.do_dentry_open
    105.56 ± 83%     +20.4%     127.11 ± 99%     -13.2%      91.60 ± 77%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     48549 ± 16%    +145.0%     118926 ± 14%      -4.5%      46349 ± 13%  perf-sched.wait_and_delay.count.schedule_timeout.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg
    979704 ± 12%     +20.5%    1180948 ± 18%      +0.4%     984031 ± 14%  perf-sched.wait_and_delay.count.schedule_timeout.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      0.00       +1.1e+101%       0.11 ±282%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_timeout.wait_for_completion.stop_two_cpus.migrate_swap
    234.22 ± 16%     +65.2%     386.89 ± 17%      +0.7%     235.80 ± 11%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork
      0.00       +2.2e+101%       0.22 ±282%   +1e+101%       0.10 ±300%  perf-sched.wait_and_delay.count.syslog_print.do_syslog.part.0.kmsg_read
    111.67 ± 27%     +71.5%     191.56 ± 19%      -6.1%     104.80 ± 12%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork
      0.00       +1.9e+105%       1891 ±197%   +3e+104%     299.94 ±299%  perf-sched.wait_and_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    256.95 ±282%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      4116 ±165%     -64.7%       1452 ±187%     -82.9%     702.29 ±299%  perf-sched.wait_and_delay.max.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      0.00          -100.0%       0.00       +1.9e+105%       1898 ±300%  perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.__x64_sys_exit.do_syscall_64.entry_SYSCALL_64_after_hwframe
     19823 ± 95%     -55.1%       8896 ± 77%     -34.9%      12906 ±157%  perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      8603 ±115%     -24.6%       6488 ± 56%     +68.9%      14532 ± 79%  perf-sched.wait_and_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.00       +2.5e+105%       2487 ±154% +9.6e+105%       9619 ±208%  perf-sched.wait_and_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
     24153 ± 50%     -53.2%      11309 ± 27%      -0.3%      24090 ± 53%  perf-sched.wait_and_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
     17861 ± 84%     -72.7%       4873 ± 97%     -49.1%       9095 ±146%  perf-sched.wait_and_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
     42890 ± 16%     -61.6%      16465 ± 26%      +3.9%      44574 ± 18%  perf-sched.wait_and_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
     50570 ± 12%     -50.4%      25092 ± 24%      +1.5%      51313 ± 21%  perf-sched.wait_and_delay.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
     22142 ± 42%     -24.8%      16644 ± 29%     -13.9%      19072 ± 54%  perf-sched.wait_and_delay.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.00          -100.0%       0.00       +8.7e+102%       8.75 ±299%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.__alloc_pages.__get_free_pages.pgd_alloc
      0.00          -100.0%       0.00       +1.3e+103%      13.13 ±299%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.__alloc_pages.__pmd_alloc.copy_page_range
      0.00       +1.8e+103%      17.66 ±282%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.__alloc_pages.alloc_pages_vma.do_fault
      0.00       +3.2e+104%     321.30 ±282%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.__alloc_pages.alloc_pages_vma.shmem_alloc_page
      0.00       +3.3e+103%      32.59 ±282%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.__alloc_pages.alloc_pages_vma.wp_page_copy
     13.37 ±282%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.__kmalloc.load_elf_phdrs.load_elf_binary
     17.68 ±282%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.__kmalloc.perf_read.vfs_read
      0.00       +5.5e+104%     546.74 ±282%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.__kmalloc_node.__vmalloc_area_node.constprop
     15.21 ±282%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.__kmalloc_node.memcg_alloc_page_obj_cgroups.kmem_cache_alloc_node
     46437 ± 13%     -57.1%      19940 ± 26%      +1.5%      47138 ± 28%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb
      0.00       +2.1e+105%       2130 ±140% +1.7e+106%      16824 ±118%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables
     28538 ± 36%     -63.4%      10440 ± 78%      -3.5%      27529 ± 58%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.aa_sk_perm.security_socket_recvmsg.sock_recvmsg
     47070 ± 12%     -68.7%      14739 ± 27%      -1.7%      46292 ± 26%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.aa_sk_perm.security_socket_sendmsg.sock_sendmsg
      2477 ±282%     -95.9%     101.30 ±282%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.change_p4d_range.change_protection.change_prot_numa
      6107 ±147%     -31.6%       4177 ±114%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.down_read.rmap_walk_anon.remove_migration_ptes
      0.00       +1.5e+104%     154.61 ±257%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.down_write.anon_vma_clone.anon_vma_fork
      0.00       +2.8e+105%       2785 ±282%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.down_write.unlink_file_vma.free_pgtables
     21.47 ±282%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.dput.path_put.vfs_statx
      0.00          -100.0%       0.00       +2.6e+103%      25.55 ±300%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.filemap_read.__kernel_read.exec_binprm
     52.45 ±282%   +3490.8%       1883 ±206%   +3867.2%       2080 ±199%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
      0.00       +2.9e+103%      28.81 ±282%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.getname_kernel.open_exec
      0.00       +1.3e+103%      13.30 ±282%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.prepare_creds.copy_creds
     41067 ± 26%     -64.6%      14557 ± 37%      +0.3%      41187 ± 25%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags
      0.00       +2.3e+105%       2323 ±277%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.migrate_pages.migrate_misplaced_page.do_numa_page
    167.77 ±282%    +127.6%     381.90 ±282%     +87.9%     315.32 ±203%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.perf_event_ctx_lock_nested.isra
      0.00       +6.9e+102%       6.94 ±282%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.seq_read_iter.new_sync_read
     15841 ±112%     -86.9%       2078 ±282%     -88.4%       1838 ±300%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.unix_stream_read_generic.unix_stream_recvmsg
     28263 ± 59%     -78.2%       6148 ±109%     -30.2%      19736 ± 84%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.rmap_walk_anon.remove_migration_ptes.migrate_pages
      8203 ±151%     -56.7%       3550 ±147%      -0.0%       8201 ±146%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.rmap_walk_anon.try_to_migrate.migrate_pages
    228.52 ±282%    +528.4%       1435 ±160%    +782.1%       2015 ±300%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.shrink_dentry_list.shrink_dcache_parent.d_invalidate
      0.00          -100.0%       0.00       +9.6e+103%      95.85 ±299%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork
     13310 ±115%     -48.0%       6925 ± 98%     -67.6%       4315 ±200%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate
      0.00          -100.0%       0.00       +4.2e+103%      41.57 ±300%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.sched_exec.bprm_execve
      0.00       +9.5e+102%       9.50 ±282%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.try_to_migrate_one.rmap_walk_anon.try_to_migrate
      5492 ±189%     -50.8%       2702 ± 93%     -52.5%       2609 ±200%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      0.00       +4.7e+104%     474.02 ±282%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.uprobe_start_dup_mmap.dup_mmap.dup_mm
      8135 ± 36%     -68.9%       2528 ±161%     -22.1%       6337 ± 58%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr_locked
     12417 ±142%     -37.5%       7763 ± 83%      +5.6%      13116 ±137%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.stop_two_cpus.migrate_swap
     14723 ± 99%     -52.5%       6998 ± 81%     +85.5%      27306 ± 63%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.wait_for_unix_gc.unix_stream_sendmsg.sock_sendmsg
      6231 ±187%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.wp_page_copy.__handle_mm_fault.handle_mm_fault
      0.00       +1.3e+105%       1331 ±282%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.zap_pte_range.unmap_page_range.unmap_vmas
      3334 ±190%     -35.3%       2159 ± 92%     +31.9%       4397 ±154%  perf-sched.wait_and_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork
     15894 ±117%     -47.9%       8285 ±102%     +37.5%      21853 ± 72%  perf-sched.wait_and_delay.max.ms.rwsem_down_read_slowpath.page_lock_anon_vma_read.rmap_walk_anon.try_to_migrate
     21737 ± 79%     -52.1%      10421 ±101%      -3.4%      20992 ± 92%  perf-sched.wait_and_delay.max.ms.rwsem_down_read_slowpath.rmap_walk_anon.remove_migration_ptes.migrate_pages
      9298 ±180%     -70.5%       2740 ±143%     -33.1%       6220 ±185%  perf-sched.wait_and_delay.max.ms.rwsem_down_write_slowpath.__put_anon_vma.unlink_anon_vmas.free_pgtables
     20703 ± 94%     -43.7%      11664 ± 81%     +40.5%      29088 ± 82%  perf-sched.wait_and_delay.max.ms.rwsem_down_write_slowpath.unlink_anon_vmas.free_pgtables.exit_mmap
      2416 ±247%    +127.7%       5501 ± 83%     -60.7%     949.86 ±188%  perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      1223 ±148%    +234.4%       4092 ± 99%    +497.7%       7314 ±128%  perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
     13645 ± 70%     -25.3%      10192 ± 32%     -34.3%       8971 ± 89%  perf-sched.wait_and_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.00          -100.0%       0.00       +4.7e+104%     469.09 ±300%  perf-sched.wait_and_delay.max.ms.schedule_timeout.msleep.cpuinfo_open.do_dentry_open
     18282 ± 88%     -71.0%       5307 ± 98%     -27.3%      13296 ± 72%  perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     49829 ± 15%     -50.4%      24700 ± 29%      +3.1%      51382 ± 21%  perf-sched.wait_and_delay.max.ms.schedule_timeout.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg
     50347 ± 13%     -52.7%      23820 ± 25%      -0.3%      50172 ± 20%  perf-sched.wait_and_delay.max.ms.schedule_timeout.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      0.00       +1.1e+105%       1105 ±282%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_timeout.wait_for_completion.stop_two_cpus.migrate_swap
     24128 ± 14%     -39.1%      14697 ± 32%      -0.2%      24088 ± 20%  perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.00       +4.5e+104%     445.75 ±282% +1.5e+105%       1478 ±299%  perf-sched.wait_and_delay.max.ms.syslog_print.do_syslog.part.0.kmsg_read
     26730 ± 28%     -16.9%      22207 ± 33%     +10.5%      29530 ± 39%  perf-sched.wait_and_delay.max.ms.worker_thread.kthread.ret_from_fork
      0.01 ±282%  +1.7e+07%     945.52 ±197%  +2.8e+06%     149.97 ±300%  perf-sched.wait_time.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    128.01 ±282%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      2058 ±165%     -65.7%     706.85 ±187%     -82.9%     351.14 ±300%  perf-sched.wait_time.avg.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      0.00          -100.0%       0.00       +1.9e+105%       1898 ±300%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.__x64_sys_exit.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1463 ±103%     -77.6%     328.10 ±116%     -27.5%       1060 ±164%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
    573.64 ±169%     -48.9%     293.16 ± 60%    +129.2%       1314 ±100%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.01 ±282%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_common_interrupt.[unknown]
      1.28 ±198%   +3224.8%      42.54 ±132%  +12057.8%     155.57 ±189%  perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
    422.06 ± 43%     -49.8%     211.68 ± 29%      +3.0%     434.52 ± 62%  perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
    403.57 ± 92%     -71.3%     115.71 ± 78%     -53.3%     188.29 ±148%  perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
    366.29 ± 30%     -64.5%     130.02 ± 28%     +18.9%     435.48 ± 31%  perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
     51.93 ± 19%     -38.1%      32.15 ± 12%     +10.2%      57.25 ± 22%  perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.01 ±184%     +35.4%       0.01 ±259%     -82.7%       0.00 ±163%  perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.ret_from_fork.[unknown]
      5.80 ±166%     -87.8%       0.71 ±282%     -79.3%       1.20 ±299%  perf-sched.wait_time.avg.ms.futex_wait_queue_me.futex_wait.do_futex.__x64_sys_futex
    512.27 ± 90%     -33.3%     341.64 ±134%     -31.4%     351.50 ±105%  perf-sched.wait_time.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.00       +3.1e+102%       3.12 ±237%    -100.0%       0.00        perf-sched.wait_time.avg.ms.pipe_write.new_sync_write.vfs_write.ksys_write
      0.01 ±282%  +25108.0%       1.40 ±280%   +3816.8%       0.22 ±266%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__alloc_pages.__get_free_pages.__pud_alloc
      0.04 ±203%    +238.3%       0.13 ±113%    +121.5%       0.08 ±176%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__alloc_pages.__get_free_pages.pgd_alloc
      0.01 ±282%     -65.6%       0.00 ±195%      +5.5%       0.01 ±300%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__alloc_pages.__get_free_pages.proc_pid_readlink
      0.11 ±189%     -15.4%       0.10 ±128%     -55.0%       0.05 ±140%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__alloc_pages.__pmd_alloc.__handle_mm_fault
      0.29 ±282%    -100.0%       0.00         +3189.4%       9.54 ±300%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__alloc_pages.__pmd_alloc.copy_page_range
      0.00        +1.6e+99%       0.00 ±282%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__alloc_pages.__pmd_alloc.move_page_tables
      0.02 ± 87%    +351.2%       0.11 ± 95%    +277.3%       0.09 ±132%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__alloc_pages.alloc_pages_vma.do_anonymous_page
      0.54 ±276%     -99.2%       0.00 ±187%     -97.2%       0.02 ±210%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__alloc_pages.alloc_pages_vma.do_fault
      3.10 ±197%    +229.6%      10.21 ±230%     +44.3%       4.47 ±183%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__alloc_pages.alloc_pages_vma.shmem_alloc_page
      0.07 ±205%    +164.4%       0.17 ±128%    +210.5%       0.21 ±170%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__alloc_pages.alloc_pages_vma.wp_page_copy
      0.00 ±282%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__alloc_pages.pipe_write.new_sync_write
      0.06 ±253%     -84.6%       0.01 ±102%     -72.0%       0.02 ±216%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__alloc_pages.pte_alloc_one.__do_fault
      0.25 ±156%    +401.3%       1.24 ±223%      +3.6%       0.26 ±203%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__alloc_pages.pte_alloc_one.__pte_alloc
      0.01 ±191%     -15.3%       0.01 ±241%     -51.2%       0.00 ±300%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__alloc_pages.pte_alloc_one.do_fault
      0.19 ±222%    +268.8%       0.69 ±214%     -47.5%       0.10 ±164%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__anon_vma_prepare.do_anonymous_page.__handle_mm_fault
      1.25 ±212%     -87.6%       0.16 ± 90%     -94.1%       0.07 ± 88%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__anon_vma_prepare.do_fault.__handle_mm_fault
      3.32 ±180%     +71.5%       5.70 ±195%     -19.3%       2.68 ±166%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__do_fault.do_fault.__handle_mm_fault
      0.00       +1.4e+100%       0.01 ±244% +1.8e+100%       0.02 ±300%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__fput.task_work_run.do_exit
      0.01 ±220%      +8.9%       0.02 ±282%    +156.2%       0.04 ±223%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__fput.task_work_run.exit_to_user_mode_prepare
      0.05 ± 89%     +16.2%       0.06 ± 75%    +963.5%       0.51 ±275%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__get_user_pages.__get_user_pages_remote.get_arg_page
      0.09 ±151%   +2959.4%       2.62 ±261%   +3843.3%       3.38 ±290%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__kmalloc.inotify_handle_inode_event.fsnotify
      0.00 ±282%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__kmalloc.load_elf_binary.exec_binprm
      2.00 ±210%     -25.2%       1.50 ±220%     -98.2%       0.04 ±149%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__kmalloc.load_elf_phdrs.load_elf_binary
     25.80 ±202%     -99.4%       0.16 ±282%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__kmalloc.perf_read.vfs_read
      0.05 ±171%     +92.3%       0.09 ±182%    +434.1%       0.25 ±289%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__kmalloc.security_prepare_creds.prepare_creds
      0.00        +2.4e+99%       0.00 ±282%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__kmalloc.task_numa_fault.do_numa_page
      0.00       +5.5e+104%     546.74 ±282%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__kmalloc_node.__vmalloc_area_node.constprop
      0.01 ±206%   +3535.1%       0.31 ±226%    +449.4%       0.05 ±134%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__kmalloc_node.alloc_cpumask_var_node.__sched_setaffinity
      4.48 ±281%     -98.1%       0.08 ±251%     -99.0%       0.04 ±166%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__kmalloc_node.alloc_cpumask_var_node.__x64_sys_sched_setaffinity
      0.00          -100.0%       0.00          +7e+98%       0.00 ±300%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__kmalloc_node.memcg_alloc_page_obj_cgroups.allocate_slab
     17.04 ±245%    -100.0%       0.00          -100.0%       0.00 ±239%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__kmalloc_node.memcg_alloc_page_obj_cgroups.kmem_cache_alloc_node
      0.00        +2.8e+99%       0.00 ±282%   +1e+100%       0.01 ±300%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__kmalloc_node.seq_read_iter.new_sync_read
    116.68 ± 20%     -41.6%      68.12 ± 17%      -3.1%     113.06 ± 21%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb
      0.10 ±124%  +4.4e+05%     419.97 ±137%  +2.9e+06%       2808 ±117%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables
      0.00          +2e+99%       0.00 ±192%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__split_huge_pmd.vma_adjust_trans_huge.__vma_adjust
      0.28 ±193%     -85.0%       0.04 ± 73%     -66.0%       0.10 ±144%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__split_huge_pud.__handle_mm_fault.handle_mm_fault
     88.15 ± 35%     -47.8%      46.02 ± 23%      -9.8%      79.48 ± 30%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.aa_sk_perm.security_socket_recvmsg.sock_recvmsg
    411.87 ± 18%     -74.4%     105.25 ± 26%      -3.6%     397.14 ± 25%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.aa_sk_perm.security_socket_sendmsg.sock_sendmsg
      0.00 ±210%    +672.7%       0.03 ±232%   +1511.8%       0.06 ±187%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.apparmor_file_alloc_security.security_file_alloc.__alloc_file
    310.07 ±282%     -83.6%      50.72 ±282%     -99.7%       0.78 ±189%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.change_p4d_range.change_protection.change_prot_numa
      0.20 ±191%    +514.9%       1.20 ±261%     -96.0%       0.01 ±198%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.change_p4d_range.change_protection.mprotect_fixup
      0.00       +3.1e+100%       0.03 ±275%  +1.3e+99%       0.00 ±299%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.copy_huge_page.migrate_page_copy.migrate_page
      0.00 ±193%    +664.1%       0.03 ±140%   +9926.9%       0.43 ±296%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.copy_page_from_iter.pipe_write.new_sync_write
      0.04 ±282%     -77.7%       0.01 ±282%     -88.0%       0.00 ±250%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.copy_page_to_iter.filemap_read.new_sync_read
      0.00       +2.1e+102%       2.11 ±282%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.copy_page_to_iter.pipe_read.new_sync_read
      0.00       +5.7e+101%       0.57 ±282% +3.3e+100%       0.03 ±300%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.copy_pte_range.copy_page_range.dup_mmap
      0.45 ±250%     -86.6%       0.06 ± 69%     -17.8%       0.37 ±220%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.copy_strings.isra.0
      0.03 ±248%    +499.6%       0.17 ± 99%     -20.6%       0.02 ±148%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.count.isra.0
      0.00       +3.9e+100%       0.04 ±282%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.cpus_read_lock.vmstat_start.seq_read_iter
      1.60 ±167%     +11.1%       1.78 ±210%     +11.3%       1.79 ±164%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00          -100.0%       0.00       +2.7e+100%       0.03 ±299%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_read.__do_sys_newuname.do_syscall_64
      0.00        +5.8e+99%       0.01 ±282%   +2e+100%       0.02 ±133%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_read.acct_collect.do_exit
      0.00          -100.0%       0.00        +1.4e+99%       0.00 ±300%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_read.do_user_addr_fault.exc_page_fault
      0.00        +3.3e+99%       0.00 ±282%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_read.get_arg_page.copy_string_kernel
      0.00 ±282%   +1200.0%       0.01 ±181%     +28.6%       0.00 ±300%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_read.kernfs_dop_revalidate.lookup_fast
      0.00        +7.4e+99%       0.01 ±190%    +6e+98%       0.00 ±300%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_read.kernfs_iop_getattr.vfs_fstat
      0.00 ±204%    +873.9%       0.02 ±228%     +95.7%       0.01 ±300%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_read.kernfs_iop_permission.inode_permission
      0.00 ±282%    +363.6%       0.01 ±258%     +30.9%       0.00 ±300%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_read.mmap_read_lock.do_exit
      0.00       +2.5e+100%       0.02 ±271%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_read.page_lock_anon_vma_read.rmap_walk_anon
      0.01 ±186%      -0.8%       0.01 ±182%   +9254.2%       1.30 ±298%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_read.path_openat.do_filp_open
      4260 ±165%     -77.4%     961.21 ±120%    -100.0%       0.55 ±196%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_read.rmap_walk_anon.remove_migration_ptes
      1.42 ±238%     -53.7%       0.66 ±223%     -65.0%       0.50 ±219%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_read.walk_component.link_path_walk
      0.10 ±264%     -55.0%       0.05 ±148%     -73.4%       0.03 ±269%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_read.walk_component.path_lookupat
      0.02 ± 76%     +75.9%       0.04 ±112%     -88.5%       0.00 ±300%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_read_killable.create_elf_tables.isra
      0.59 ±279%     -97.1%       0.02 ±200%     -99.9%       0.00 ±299%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_write.__anon_vma_prepare.do_anonymous_page
      0.03 ±188%      -4.6%       0.03 ±186%      -1.4%       0.03 ±268%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_write.__anon_vma_prepare.do_fault
      0.06 ±160%    +685.4%       0.48 ±250%     +46.1%       0.09 ±117%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_write.__vma_adjust.__split_vma
      0.95 ±155%      +4.2%       0.99 ±186%     +30.9%       1.24 ±195%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_write.__vma_adjust.shift_arg_pages
      0.00       +1.5e+100%       0.01 ±198% +4.9e+100%       0.05 ±267%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_write.__vma_adjust.vma_merge
      0.05 ±184%     +78.4%       0.09 ±175%     -83.4%       0.01 ±189%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_write.anon_vma_clone.__split_vma
      0.00       +8.4e+103%      83.68 ±237%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_write.anon_vma_clone.anon_vma_fork
      0.00       +2.1e+100%       0.02 ±282%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_write.expand_downwards.find_extend_vma
      0.00        +5.9e+99%       0.01 ±282% +4.9e+101%       0.49 ±299%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_write.expand_downwards.setup_arg_pages
      0.00 ±282%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_write.filename_create.do_mkdirat
      0.00         +5e+100%       0.05 ±282%    +7e+98%       0.00 ±299%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_write.generic_file_write_iter.new_sync_write
      0.16 ±141%   +2036.1%       3.44 ±266%     -40.2%       0.10 ±113%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_write.unlink_anon_vmas.free_pgtables
      0.08 ± 68%  +3.7e+05%     279.80 ±282%    +358.8%       0.35 ±160%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_write.unlink_file_vma.free_pgtables
      0.31 ±181%     -77.9%       0.07 ± 91%     -49.9%       0.16 ± 84%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_write.vma_link.mmap_region
      0.00          -100.0%       0.00       +3.8e+100%       0.04 ±299%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_write_killable.__vm_munmap.__x64_sys_munmap
      0.13 ±152%     -65.9%       0.04 ±170%     -99.3%       0.00 ±300%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_write_killable.__vm_munmap.elf_map
      2.36 ±282%     -98.5%       0.03 ±282%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_write_killable.__x64_sys_brk.do_syscall_64
      0.05 ±282%     -90.3%       0.01 ±192%     -61.6%       0.02 ±218%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_write_killable.alloc_bprm.do_execveat_common
      0.00 ±282%    +466.7%       0.02 ±246%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_write_killable.begin_new_exec.load_elf_binary
      0.00          -100.0%       0.00       +6.1e+100%       0.06 ±295%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_write_killable.do_mprotect_pkey.__x64_sys_mprotect
      0.13 ±242%     -67.6%       0.04 ± 90%     -46.9%       0.07 ±220%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_write_killable.map_vdso.load_elf_binary
      0.56 ±252%     -37.5%       0.35 ±242%     -88.0%       0.07 ±118%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_write_killable.setup_arg_pages.load_elf_binary
      0.19 ±149%    +490.0%       1.09 ±236%     -74.8%       0.05 ±252%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_write_killable.vm_brk_flags.load_elf_binary
      0.00 ±282%  +1.5e+05%       3.91 ±282%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_write_killable.vm_brk_flags.set_brk
      0.98 ±241%     -92.9%       0.07 ±101%     -31.8%       0.67 ±288%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_write_killable.vm_mmap_pgoff.elf_map
      0.20 ±143%     -71.5%       0.06 ±129%   +1688.2%       3.62 ±299%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_write_killable.vm_mmap_pgoff.ksys_mmap_pgoff
      0.02 ±114%    +112.7%       0.05 ±111%    +673.5%       0.17 ±195%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_write_killable.vm_mmap_pgoff.load_elf_binary
      9.46 ±136%     -71.2%       2.73 ±129%     -96.2%       0.36 ±131%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.dput.__fput.task_work_run
      0.00 ±282%    -100.0%       0.00         +5608.6%       0.04 ±300%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.dput.dcache_dir_close.__fput
      0.03 ±282%    -100.0%       0.00           -78.2%       0.01 ±300%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.dput.filename_create.do_mkdirat
      0.05 ±143%   +6959.9%       3.52 ±260%    +662.3%       0.38 ±268%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.dput.nd_jump_root.pick_link
      0.65 ±134%     -91.9%       0.05 ± 89%     -64.3%       0.23 ±266%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.dput.path_openat.do_filp_open
      0.00       +1.4e+100%       0.01 ±282%  +1.6e+99%       0.00 ±300%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.dput.path_put.__x64_sys_chdir
      0.00        +7.8e+98%       0.00 ±282%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.dput.path_put.do_readlinkat
      0.01 ±189%    +382.4%       0.04 ±126%     +44.7%       0.01 ±278%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.dput.path_put.free_fs_struct
      0.00 ±282%    +800.0%       0.01 ±282%   +2960.0%       0.02 ±250%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.dput.path_put.proc_pid_readlink
      0.00        +1.6e+99%       0.00 ±282%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.dput.path_put.set_fs_pwd
      0.00 ±282%    +194.1%       0.01 ±202%    +482.4%       0.02 ±300%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.dput.path_put.vfs_statx
      0.00       +4.3e+100%       0.04 ±282%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.dput.proc_invalidate_siblings_dcache.release_task
      0.00 ±282%    +200.0%       0.00 ±282%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.dput.step_into.handle_dots
      0.35 ±257%     -46.0%       0.19 ±163%     -94.0%       0.02 ±125%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.dput.step_into.path_openat
      1.18 ±267%     -35.8%       0.76 ±167%     -28.9%       0.84 ±272%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.dput.step_into.walk_component
      0.00        +6.4e+99%       0.01 ±188% +4.8e+100%       0.05 ±255%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.dput.terminate_walk.path_lookupat
      0.81 ±228%     -66.8%       0.27 ±163%     -55.5%       0.36 ±246%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.dput.terminate_walk.path_openat
      0.02 ±196%    +137.6%       0.05 ±265%     +74.3%       0.03 ±287%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.dput.walk_component.link_path_walk
      1.41 ±169%     -86.8%       0.19 ± 78%     -60.8%       0.55 ±230%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.exit_mmap.mmput.begin_new_exec
      1.95 ±273%     -95.8%       0.08 ± 63%     -11.7%       1.72 ±214%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.exit_mmap.mmput.do_exit
      0.00 ±282%    +237.1%       0.01 ±282%  +60166.6%       2.34 ±295%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.exit_signals.do_exit.do_group_exit
      0.07 ±233%   +5050.7%       3.59 ±226%   +1374.4%       1.03 ±224%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.filemap_read.__kernel_read.exec_binprm
      0.01 ±282%      +7.8%       0.01 ±246%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.filemap_read.__kernel_read.load_elf_binary
      0.01 ±282%     +29.4%       0.01 ±282%     -78.8%       0.00 ±300%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.filemap_read.__kernel_read.load_elf_phdrs
      0.05 ±210%     -93.7%       0.00 ±219%     -85.6%       0.01 ±266%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.filemap_read.new_sync_read.vfs_read
     61.26 ±237%     -38.7%      37.53 ± 96%     -19.2%      49.50 ±102%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
      0.35 ±160%     -35.1%       0.23 ±186%    +595.9%       2.43 ±290%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.__alloc_file.alloc_empty_file
      0.01 ±133%     +31.6%       0.02 ±123%    +234.6%       0.04 ±192%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.__anon_vma_prepare.do_anonymous_page
      0.02 ±113%    -100.0%       0.00           -51.6%       0.01 ±233%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.__anon_vma_prepare.do_fault
      0.01 ±248%    +495.1%       0.04 ±190%     -24.8%       0.01 ±181%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.__d_alloc.d_alloc
      0.01 ±282%     -59.6%       0.00 ±204%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.__d_alloc.d_alloc_cursor
      0.00        +2.9e+99%       0.00 ±282%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.getname_flags.__x64_sys_mknod
      0.09 ±178%     -73.2%       0.02 ±123%     -95.2%       0.00 ±208%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.getname_flags.do_sys_openat2
      0.01 ±219%     +36.6%       0.02 ±158%    +716.2%       0.09 ±273%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.getname_flags.user_path_at_empty
      0.00 ±282%   +1476.2%       0.04 ±273%   +1138.6%       0.03 ±204%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.getname_kernel.open_exec
      0.00 ±282%    +125.0%       0.00 ±282%    +957.5%       0.01 ±299%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.mm_alloc.alloc_bprm
      0.00       +1.3e+103%      13.29 ±282%    +3e+99%       0.00 ±300%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.prepare_creds.copy_creds
      0.00 ±146%    +260.7%       0.01 ±282%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.prepare_creds.do_faccessat
      0.03 ±121%     -71.3%       0.01 ±172%     -68.8%       0.01 ±300%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.proc_alloc_inode.alloc_inode
      0.00       +1.5e+101%       0.15 ±282%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.proc_reg_open.do_dentry_open
      0.14 ±123%     -62.0%       0.05 ± 74%     +80.2%       0.26 ±178%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.security_file_alloc.__alloc_file
      0.00          -100.0%       0.00        +2.1e+99%       0.00 ±299%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.seq_open.do_dentry_open
      0.00       +1.7e+100%       0.02 ±282%  +5.3e+99%       0.01 ±300%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.seq_open.kernfs_fop_open
      0.01 ±282%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.seq_open.proc_reg_open
      0.03 ±190%    +437.1%       0.14 ±125%     -67.0%       0.01 ±222%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.vm_area_alloc.__install_special_mapping
      0.06 ±132%   +1300.4%       0.80 ±203%    +320.4%       0.24 ± 91%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.vm_area_alloc.alloc_bprm
      0.00 ±282%   +1155.6%       0.05 ±187%    +970.0%       0.04 ±300%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.vm_area_alloc.do_brk_flags
      0.63 ±184%    +144.7%       1.55 ±270%     -82.0%       0.11 ±142%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.vm_area_alloc.mmap_region
      0.44 ±227%     -81.1%       0.08 ±203%     -78.0%       0.10 ±209%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.vm_area_dup.__split_vma
    207.10 ± 29%     -59.4%      84.18 ± 25%      -4.3%     198.25 ± 33%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags
      0.01 ±231%    +591.9%       0.05 ±174%     -55.0%       0.00 ±300%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc_trace.alloc_bprm.do_execveat_common
      0.00       +1.5e+100%       0.01 ±167%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc_trace.disk_seqf_start.seq_read_iter
      0.00        +6.7e+98%       0.00 ±282% +9.6e+100%       0.10 ±296%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc_trace.kernfs_fop_open.do_dentry_open
      0.37 ±282%     -92.4%       0.03 ±163%     -95.4%       0.02 ±284%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc_trace.load_elf_binary.exec_binprm
      0.40 ±211%     +69.0%       0.68 ±214%     -79.2%       0.08 ±113%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc_trace.perf_event_mmap.mmap_region
      0.00 ±282%    +166.7%       0.00 ±282%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc_trace.perf_event_mmap.mprotect_fixup
      0.00 ±282%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc_trace.single_open.proc_reg_open
      0.00 ±282%   +1212.5%       0.01 ±219%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc_trace.vmstat_start.seq_read_iter
      0.02 ±267%  +2.4e+06%     389.21 ±277%      -5.6%       0.02 ±161%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.migrate_pages.migrate_misplaced_page.do_numa_page
      0.02 ±282%     -86.0%       0.00 ±187%     -24.4%       0.01 ±300%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.mmput.begin_new_exec.load_elf_binary
      0.00        +7.4e+99%       0.01 ±188%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.mmput.do_exit.do_group_exit
      0.00        +4.7e+99%       0.00 ±143%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.mnt_want_write.filename_create.do_mkdirat
      0.00          -100.0%       0.00       +3.8e+100%       0.04 ±300%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.mnt_want_write.filename_create.do_mknodat
      0.00 ±282%    +913.5%       0.04 ±134%    +401.1%       0.02 ±271%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.move_page_tables.shift_arg_pages.setup_arg_pages
      0.03 ±282%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.__fdget_pos.ksys_write
      0.00       +7.9e+101%       0.79 ±256%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.__perf_event_read_value.perf_read
      0.00        +2.8e+99%       0.00 ±145% +3.5e+101%       0.35 ±287%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.fifo_open.do_dentry_open
      0.04 ±148%      -4.7%       0.04 ±138%     -64.0%       0.02 ±148%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.futex_cleanup_begin.futex_exec_release
      0.01 ±187%    +115.9%       0.03 ±167%    +221.4%       0.04 ±250%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.futex_cleanup_begin.futex_exit_release
      0.00 ±282%   +1914.3%       0.05 ±193%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.kernfs_fop_open.do_dentry_open
      0.00 ±282%     +18.2%       0.00 ±282%     -46.8%       0.00 ±299%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.kernfs_put_open_node.isra
      0.13 ±253%    +393.3%       0.62 ±270%     -52.2%       0.06 ±199%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.kernfs_seq_start.seq_read_iter
     18.90 ±279%    +135.0%      44.42 ±271%     +99.3%      37.66 ±216%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.perf_event_ctx_lock_nested.isra
      0.00       +4.5e+100%       0.04 ±282%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.perf_event_exit_task.do_exit
      0.01 ±227%   +4851.7%       0.48 ±270%    +135.9%       0.02 ±161%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.perf_event_for_each_child._perf_ioctl
      0.00 ±282%   +1260.0%       0.01 ±255%    +494.0%       0.00 ±300%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.perf_read.vfs_read
      0.00 ±282%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.pipe_release.__fput
      0.00 ±282%   +2060.0%       0.01 ±191%   +1322.0%       0.01 ±271%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.pipe_write.new_sync_write
      0.00         +7e+102%       6.97 ±281%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.seq_read_iter.new_sync_read
      0.00        +8.9e+98%       0.00 ±282%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.seq_read_iter.seq_read
      0.00 ±282%    -100.0%       0.00          +118.6%       0.00 ±300%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.slab_start.seq_read_iter
     55.94 ± 50%     -44.0%      31.35 ± 35%     -16.9%      46.49 ± 35%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.unix_stream_read_generic.unix_stream_recvmsg
      0.00        +4.6e+99%       0.00 ±282%  +1.8e+99%       0.00 ±200%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.uprobe_clear_state.mmput
      0.00       +1.6e+100%       0.02 ±282%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock_interruptible.bprm_execve.do_execveat_common
      0.01 ±282%     -67.8%       0.00 ±282%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.pagecache_get_page.shmem_getpage_gfp.shmem_write_begin
      0.00          -100.0%       0.00        +6.4e+99%       0.01 ±300%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.pick_link.step_into.path_openat
      0.02 ±115%   +4917.2%       0.97 ±264%    +298.8%       0.08 ±166%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.put_files_struct.do_exit.do_group_exit
      1.83 ±272%     -70.6%       0.54 ±251%     -97.3%       0.05 ±188%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.remove_vma.__do_munmap.__vm_munmap
      0.07 ±261%   +6204.9%       4.15 ±218%     -16.1%       0.06 ±300%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.remove_vma.__do_munmap.mmap_region
      0.40 ±158%    +396.7%       2.00 ±146%     +34.7%       0.54 ±175%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.remove_vma.exit_mmap.mmput
    935.81 ±160%     -85.6%     134.68 ± 98%     -16.4%     782.25 ±189%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.rmap_walk_anon.remove_migration_ptes.migrate_pages
    408.24 ±227%     -66.7%     136.12 ± 92%    +158.5%       1055 ±150%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.rmap_walk_anon.try_to_migrate.migrate_pages
     29.01 ±282%   +1555.6%     480.25 ±193%     +43.4%      41.60 ±300%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.shrink_dentry_list.shrink_dcache_parent.d_invalidate
      0.00          -100.0%       0.00       +4.8e+103%      47.92 ±299%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork
      4187 ±107%     -83.7%     681.25 ±107%     -73.4%       1113 ±186%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate
      0.15 ±123%   +1218.9%       1.94 ± 84%   +4343.0%       6.53 ±160%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.sched_exec.bprm_execve
      0.00          -100.0%       0.00        +4.6e+99%       0.00 ±300%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.switch_task_namespaces.do_exit.do_group_exit
      0.02 ±282%     -14.6%       0.02 ±173%     +30.8%       0.03 ±257%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.task_numa_work.task_work_run.exit_to_user_mode_prepare
      0.02 ±198%    +320.5%       0.07 ±279%    +501.0%       0.10 ±204%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.task_work_run.do_exit.do_group_exit
      0.01 ±158%    +207.9%       0.04 ±175%     -69.2%       0.00 ±203%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      1.05 ±196%   +1227.4%      13.99 ±190%    +326.2%       4.49 ±298%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.try_to_migrate_one.rmap_walk_anon.try_to_migrate
     44.83 ±120%     +18.8%      53.25 ± 58%     -18.8%      36.40 ±115%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      0.41 ±154%    +127.9%       0.94 ±259%    +387.0%       2.02 ±288%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.unmap_page_range.unmap_vmas.exit_mmap
      0.01 ±216%    +428.3%       0.03 ±174%    +304.2%       0.02 ±193%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.unmap_page_range.unmap_vmas.unmap_region
      3.99 ±269%     -53.2%       1.87 ±176%     -99.0%       0.04 ±164%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.unmap_vmas.exit_mmap.mmput
      0.21 ±179%     +23.4%       0.26 ±242%     -67.5%       0.07 ±148%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.unmap_vmas.unmap_region.__do_munmap
      0.00       +4.7e+104%     474.02 ±282%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.uprobe_start_dup_mmap.dup_mmap.dup_mm
    140.30 ± 34%     -60.9%      54.87 ± 41%      +1.6%     142.59 ± 31%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr_locked
      1494 ±134%     -48.8%     765.74 ± 66%     +23.0%       1839 ±128%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.stop_two_cpus.migrate_swap
     68.22 ± 61%     -21.5%      53.55 ± 23%     +57.1%     107.16 ± 41%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.wait_for_unix_gc.unix_stream_sendmsg.sock_sendmsg
    567.44 ±187%     -99.8%       0.91 ±150%     -99.9%       0.85 ±200%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.wp_page_copy.__handle_mm_fault.handle_mm_fault
      0.30 ±115%  +17296.5%      51.76 ±272%     +26.0%       0.38 ±170%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.zap_pte_range.unmap_page_range.unmap_vmas
    110.10 ±155%     -47.7%      57.56 ± 48%     +55.4%     171.09 ±141%  perf-sched.wait_time.avg.ms.rcu_gp_kthread.kthread.ret_from_fork
      1650 ±145%     -50.4%     818.73 ±109%     +68.4%       2778 ±116%  perf-sched.wait_time.avg.ms.rwsem_down_read_slowpath.page_lock_anon_vma_read.rmap_walk_anon.try_to_migrate
      3602 ± 79%     -73.6%     951.87 ± 94%     +85.9%       6697 ± 94%  perf-sched.wait_time.avg.ms.rwsem_down_read_slowpath.rmap_walk_anon.remove_migration_ptes.migrate_pages
      4821 ±178%     -84.6%     744.62 ±161%     -47.1%       2549 ±187%  perf-sched.wait_time.avg.ms.rwsem_down_write_slowpath.__put_anon_vma.unlink_anon_vmas.free_pgtables
      5262 ±103%     -72.9%       1428 ± 89%     +13.5%       5976 ± 85%  perf-sched.wait_time.avg.ms.rwsem_down_write_slowpath.unlink_anon_vmas.free_pgtables.exit_mmap
    168.38 ±190%    +503.5%       1016 ± 97%     +99.0%     335.14 ±192%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
    261.03 ±163%    +382.2%       1258 ±116%    +785.4%       2311 ±148%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
      0.04 ±282%     +85.0%       0.08 ±187%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_timeout.__skb_wait_for_more_packets.__unix_dgram_recvmsg.__sys_recvfrom
      3266 ± 66%     -10.9%       2911 ± 24%     -27.5%       2369 ±114%  perf-sched.wait_time.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
     13.74 ±141%     -32.4%       9.29 ±187%   +3314.0%     469.09 ±300%  perf-sched.wait_time.avg.ms.schedule_timeout.msleep.cpuinfo_open.do_dentry_open
     96.98 ± 80%     -50.4%      48.11 ± 49%     +26.3%     122.46 ± 63%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    340.87 ± 30%     -33.4%     227.17 ± 20%     +11.5%     379.96 ± 29%  perf-sched.wait_time.avg.ms.schedule_timeout.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg
     48.25 ± 17%     -42.2%      27.89 ± 15%      +3.4%      49.91 ± 20%  perf-sched.wait_time.avg.ms.schedule_timeout.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      0.00 ±282%     -52.2%       0.00 ±282%     -25.7%       0.00 ±300%  perf-sched.wait_time.avg.ms.schedule_timeout.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr_locked
      0.00          -100.0%       0.00       +2.1e+100%       0.02 ±299%  perf-sched.wait_time.avg.ms.schedule_timeout.wait_for_completion.rdmsr_safe_on_cpu.msr_read
      0.00       +5.5e+104%     552.86 ±282% +1.1e+101%       0.11 ±300%  perf-sched.wait_time.avg.ms.schedule_timeout.wait_for_completion.stop_two_cpus.migrate_swap
      1625 ± 30%      +5.9%       1721 ± 36%     +13.6%       1846 ± 43%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.19 ±282%  +1.2e+05%     222.87 ±282%    -100.0%       0.00        perf-sched.wait_time.avg.ms.syslog_print.do_syslog.part.0.kmsg_read
      3.16 ±145%     +41.2%       4.46 ±119%    +173.3%       8.63 ±209%  perf-sched.wait_time.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open.isra
      1444 ± 48%     +29.6%       1872 ± 31%     +10.2%       1591 ± 33%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork
      0.01 ±282%  +3.5e+07%       1891 ±197%  +5.5e+06%     299.94 ±300%  perf-sched.wait_time.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    256.02 ±282%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      4116 ±165%     -64.8%       1450 ±187%     -82.9%     702.29 ±300%  perf-sched.wait_time.max.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      0.00          -100.0%       0.00       +1.9e+105%       1898 ±300%  perf-sched.wait_time.max.ms.do_task_dead.do_exit.__x64_sys_exit.do_syscall_64.entry_SYSCALL_64_after_hwframe
     12573 ± 90%     -53.4%       5858 ± 75%     -36.9%       7938 ±144%  perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      4950 ±129%      +0.7%       4986 ± 61%    +118.6%      10820 ± 86%  perf-sched.wait_time.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.01 ±282%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_common_interrupt.[unknown]
     29.90 ±177%   +8435.1%       2551 ±134%  +16423.2%       4940 ±201%  perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
     16456 ± 28%     -55.1%       7385 ± 26%     +10.0%      18103 ± 49%  perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
     11563 ± 79%     -58.5%       4793 ± 77%     -47.7%       6044 ±125%  perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
     22557 ± 16%     -62.9%       8373 ± 25%      +4.8%      23636 ± 16%  perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
     25628 ± 11%     -49.7%      12901 ± 26%      +1.1%      25906 ± 20%  perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.02 ±140%      +3.6%       0.02 ±243%     -81.6%       0.00 ±157%  perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.ret_from_fork.[unknown]
      5.80 ±166%     -75.5%       1.42 ±282%     -79.3%       1.20 ±299%  perf-sched.wait_time.max.ms.futex_wait_queue_me.futex_wait.do_futex.__x64_sys_futex
     16012 ± 48%     -26.9%      11711 ± 34%     -23.1%      12317 ± 71%  perf-sched.wait_time.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.00       +3.1e+102%       3.12 ±237%    -100.0%       0.00        perf-sched.wait_time.max.ms.pipe_write.new_sync_write.vfs_write.ksys_write
      0.01 ±282%  +50148.0%       2.79 ±281%   +3824.0%       0.22 ±265%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__alloc_pages.__get_free_pages.__pud_alloc
      0.06 ±226%    +225.4%       0.20 ±142%     +76.5%       0.11 ±148%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__alloc_pages.__get_free_pages.pgd_alloc
      0.01 ±282%     -65.6%       0.00 ±195%      +5.5%       0.01 ±300%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__alloc_pages.__get_free_pages.proc_pid_readlink
      0.20 ±201%     +12.5%       0.22 ±121%     -58.7%       0.08 ±146%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__alloc_pages.__pmd_alloc.__handle_mm_fault
      0.29 ±282%    -100.0%       0.00         +3189.4%       9.54 ±300%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__alloc_pages.__pmd_alloc.copy_page_range
      0.00        +1.6e+99%       0.00 ±282%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__alloc_pages.__pmd_alloc.move_page_tables
      0.04 ± 87%    +591.7%       0.25 ±122%    +263.9%       0.13 ±147%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__alloc_pages.alloc_pages_vma.do_anonymous_page
      0.54 ±276%     -99.2%       0.00 ±187%     -97.2%       0.02 ±210%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__alloc_pages.alloc_pages_vma.do_fault
     15.46 ±150%   +2131.0%     344.87 ±261%     +98.0%      30.60 ±114%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__alloc_pages.alloc_pages_vma.shmem_alloc_page
      0.40 ±236%    +187.5%       1.15 ±160%    +203.9%       1.22 ±191%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__alloc_pages.alloc_pages_vma.wp_page_copy
      0.00 ±282%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__alloc_pages.pipe_write.new_sync_write
      0.06 ±250%     -83.2%       0.01 ±107%     -47.9%       0.03 ±215%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__alloc_pages.pte_alloc_one.__do_fault
      1.30 ±179%    +483.3%       7.57 ±220%     -48.2%       0.67 ±212%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__alloc_pages.pte_alloc_one.__pte_alloc
      0.01 ±191%     -15.3%       0.01 ±241%     -51.2%       0.00 ±300%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__alloc_pages.pte_alloc_one.do_fault
      0.81 ±251%    +436.1%       4.37 ±230%     -75.8%       0.20 ±161%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__anon_vma_prepare.do_anonymous_page.__handle_mm_fault
      4.60 ±223%     -91.3%       0.40 ±109%     -96.0%       0.18 ± 95%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__anon_vma_prepare.do_fault.__handle_mm_fault
     27.58 ±159%     +94.7%      53.70 ±144%     -34.3%      18.13 ±121%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__do_fault.do_fault.__handle_mm_fault
      0.00       +1.4e+100%       0.01 ±244% +1.8e+100%       0.02 ±300%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__fput.task_work_run.do_exit
      0.01 ±220%      +8.9%       0.02 ±282%    +156.2%       0.04 ±223%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__fput.task_work_run.exit_to_user_mode_prepare
      0.10 ±128%     +64.1%       0.16 ± 86%   +2430.3%       2.42 ±289%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__get_user_pages.__get_user_pages_remote.get_arg_page
      0.16 ±155%   +3185.3%       5.23 ±262%   +4146.0%       6.76 ±290%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__kmalloc.inotify_handle_inode_event.fsnotify
      0.00 ±282%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__kmalloc.load_elf_binary.exec_binprm
      5.76 ±207%     -37.2%       3.62 ±192%     -99.4%       0.04 ±146%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__kmalloc.load_elf_phdrs.load_elf_binary
     42.03 ±190%     -99.6%       0.16 ±282%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__kmalloc.perf_read.vfs_read
      0.05 ±171%    +109.0%       0.10 ±166%   +1444.8%       0.71 ±293%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__kmalloc.security_prepare_creds.prepare_creds
      0.00        +2.4e+99%       0.00 ±282%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__kmalloc.task_numa_fault.do_numa_page
      0.00       +5.5e+104%     546.74 ±282%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__kmalloc_node.__vmalloc_area_node.constprop
      0.01 ±220%   +7911.9%       1.05 ±261%    +440.8%       0.07 ±147%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__kmalloc_node.alloc_cpumask_var_node.__sched_setaffinity
      8.94 ±282%     -99.0%       0.08 ±251%     -99.1%       0.08 ±227%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__kmalloc_node.alloc_cpumask_var_node.__x64_sys_sched_setaffinity
      0.00          -100.0%       0.00          +7e+98%       0.00 ±300%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__kmalloc_node.memcg_alloc_page_obj_cgroups.allocate_slab
     19.19 ±220%    -100.0%       0.00          -100.0%       0.00 ±239%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__kmalloc_node.memcg_alloc_page_obj_cgroups.kmem_cache_alloc_node
      0.00        +2.8e+99%       0.00 ±282%   +1e+100%       0.01 ±300%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__kmalloc_node.seq_read_iter.new_sync_read
     24412 ± 13%     -55.2%      10931 ± 29%      +1.6%      24795 ± 23%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb
      0.21 ± 98%  +9.1e+05%       1873 ±126%  +5.1e+06%      10480 ±110%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables
      0.00          +2e+99%       0.00 ±192%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__split_huge_pmd.vma_adjust_trans_huge.__vma_adjust
      0.79 ±199%     -85.0%       0.12 ±104%     -81.2%       0.15 ±135%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__split_huge_pud.__handle_mm_fault.handle_mm_fault
     19444 ± 12%     -58.5%       8061 ± 23%      -4.9%      18497 ± 28%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.aa_sk_perm.security_socket_recvmsg.sock_recvmsg
     24284 ± 11%     -60.8%       9520 ± 31%      +2.9%      24982 ± 21%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.aa_sk_perm.security_socket_sendmsg.sock_sendmsg
      0.00 ±202%    +637.1%       0.03 ±229%   +1419.7%       0.06 ±187%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.apparmor_file_alloc_security.security_file_alloc.__alloc_file
      1240 ±282%     -91.8%     101.43 ±282%     -99.6%       4.51 ±197%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.change_p4d_range.change_protection.change_prot_numa
      0.39 ±192%    +521.4%       2.45 ±255%     -97.9%       0.01 ±190%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.change_p4d_range.change_protection.mprotect_fixup
      0.00       +1.5e+102%       1.47 ±282%  +1.9e+99%       0.00 ±300%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.copy_huge_page.migrate_page_copy.migrate_page
      0.01 ±210%   +1636.4%       0.11 ±190%  +14008.7%       0.86 ±298%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.copy_page_from_iter.pipe_write.new_sync_write
      0.04 ±282%     -77.7%       0.01 ±282%     -88.0%       0.00 ±250%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.copy_page_to_iter.filemap_read.new_sync_read
      0.00       +2.1e+102%       2.11 ±282%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.copy_page_to_iter.pipe_read.new_sync_read
      0.00       +5.7e+101%       0.57 ±282% +3.3e+100%       0.03 ±300%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.copy_pte_range.copy_page_range.dup_mmap
      3.67 ±276%     -95.8%       0.15 ± 79%     -44.6%       2.04 ±267%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.copy_strings.isra.0
      0.05 ±262%    +458.0%       0.27 ±116%     -21.8%       0.04 ±171%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.count.isra.0
      0.00       +3.9e+100%       0.04 ±282%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.cpus_read_lock.vmstat_start.seq_read_iter
     16.25 ±144%     +42.0%      23.07 ±140%    +127.6%      36.97 ±211%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00          -100.0%       0.00       +2.7e+100%       0.03 ±299%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_read.__do_sys_newuname.do_syscall_64
      0.00        +5.8e+99%       0.01 ±282%   +2e+100%       0.02 ±133%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_read.acct_collect.do_exit
      0.00          -100.0%       0.00        +1.4e+99%       0.00 ±300%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_read.do_user_addr_fault.exc_page_fault
      0.00        +3.3e+99%       0.00 ±282%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_read.get_arg_page.copy_string_kernel
      0.00 ±282%   +1200.0%       0.01 ±181%     +28.6%       0.00 ±300%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_read.kernfs_dop_revalidate.lookup_fast
      0.00        +7.4e+99%       0.01 ±190%    +6e+98%       0.00 ±300%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_read.kernfs_iop_getattr.vfs_fstat
      0.00 ±204%    +873.9%       0.02 ±228%     +95.7%       0.01 ±300%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_read.kernfs_iop_permission.inode_permission
      0.00 ±282%    +363.6%       0.01 ±258%     +30.9%       0.00 ±300%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_read.mmap_read_lock.do_exit
      0.00       +2.5e+100%       0.02 ±271%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_read.page_lock_anon_vma_read.rmap_walk_anon
      0.02 ±169%     +50.3%       0.02 ±192%   +8076.8%       1.30 ±298%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_read.path_openat.do_filp_open
      6129 ±146%     -33.4%       4080 ±114%    -100.0%       2.21 ±212%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_read.rmap_walk_anon.remove_migration_ptes
      5.94 ±229%     -24.3%       4.50 ±264%     -52.5%       2.82 ±273%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_read.walk_component.link_path_walk
      0.20 ±270%     -59.1%       0.08 ±161%     -85.2%       0.03 ±251%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_read.walk_component.path_lookupat
      0.03 ± 86%     +97.8%       0.06 ±132%     -91.8%       0.00 ±300%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_read_killable.create_elf_tables.isra
      1.74 ±281%     -98.7%       0.02 ±215%    -100.0%       0.00 ±299%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_write.__anon_vma_prepare.do_anonymous_page
      0.03 ±188%      +3.2%       0.03 ±178%      -1.4%       0.03 ±268%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_write.__anon_vma_prepare.do_fault
      0.15 ±178%    +525.9%       0.93 ±261%     -24.3%       0.11 ±113%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_write.__vma_adjust.__split_vma
      3.72 ±152%     +65.6%       6.16 ±177%     +40.0%       5.21 ±186%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_write.__vma_adjust.shift_arg_pages
      0.00       +1.5e+100%       0.01 ±198% +4.9e+100%       0.05 ±267%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_write.__vma_adjust.vma_merge
      0.05 ±184%     +89.2%       0.09 ±164%     -83.4%       0.01 ±189%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_write.anon_vma_clone.__split_vma
      0.00       +1.5e+104%     153.96 ±257%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_write.anon_vma_clone.anon_vma_fork
      0.00       +2.1e+100%       0.02 ±282%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_write.expand_downwards.find_extend_vma
      0.00        +5.9e+99%       0.01 ±282% +4.9e+101%       0.49 ±299%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_write.expand_downwards.setup_arg_pages
      0.00 ±282%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_write.filename_create.do_mkdirat
      0.00         +5e+100%       0.05 ±282%    +7e+98%       0.00 ±299%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_write.generic_file_write_iter.new_sync_write
      0.44 ±142%   +3050.4%      13.77 ±266%     -46.5%       0.23 ±134%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_write.unlink_anon_vmas.free_pgtables
      0.22 ± 69%  +6.4e+05%       1402 ±281%    +881.0%       2.14 ±190%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_write.unlink_file_vma.free_pgtables
      1.23 ±171%     -80.8%       0.24 ±114%     -69.7%       0.37 ±142%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_write.vma_link.mmap_region
      0.00          -100.0%       0.00       +3.8e+100%       0.04 ±299%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_write_killable.__vm_munmap.__x64_sys_munmap
      0.13 ±152%     -48.6%       0.07 ±171%     -99.3%       0.00 ±300%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_write_killable.__vm_munmap.elf_map
      2.36 ±282%     -98.5%       0.03 ±282%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_write_killable.__x64_sys_brk.do_syscall_64
      0.05 ±282%     -88.2%       0.01 ±187%     -60.2%       0.02 ±210%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_write_killable.alloc_bprm.do_execveat_common
      0.00 ±282%    +466.7%       0.02 ±246%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_write_killable.begin_new_exec.load_elf_binary
      0.00          -100.0%       0.00       +6.1e+100%       0.06 ±295%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_write_killable.do_mprotect_pkey.__x64_sys_mprotect
      0.34 ±265%     -82.9%       0.06 ±133%     -80.5%       0.07 ±220%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_write_killable.map_vdso.load_elf_binary
      1.14 ±247%     +39.9%       1.59 ±258%     -90.9%       0.10 ±110%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_write_killable.setup_arg_pages.load_elf_binary
      0.33 ±144%    +533.7%       2.06 ±251%     -72.0%       0.09 ±248%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_write_killable.vm_brk_flags.load_elf_binary
      0.00 ±282%  +1.5e+05%       3.91 ±282%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_write_killable.vm_brk_flags.set_brk
      2.89 ±246%     -95.4%       0.13 ±115%      +5.9%       3.06 ±296%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_write_killable.vm_mmap_pgoff.elf_map
      0.45 ±167%     -84.4%       0.07 ±120%    +701.2%       3.62 ±299%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_write_killable.vm_mmap_pgoff.ksys_mmap_pgoff
      0.04 ±143%    +126.9%       0.09 ±126%    +582.8%       0.26 ±160%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_write_killable.vm_mmap_pgoff.load_elf_binary
     30.30 ±131%     -58.5%      12.58 ±124%     -96.7%       1.01 ±138%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.dput.__fput.task_work_run
      0.00 ±282%    -100.0%       0.00         +5608.6%       0.04 ±300%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.dput.dcache_dir_close.__fput
      0.03 ±282%    -100.0%       0.00           -78.2%       0.01 ±300%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.dput.filename_create.do_mkdirat
      0.08 ±146%  +12699.3%      10.27 ±267%   +1193.0%       1.04 ±280%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.dput.nd_jump_root.pick_link
      1.36 ±135%     -94.3%       0.08 ± 80%     -52.3%       0.65 ±287%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.dput.path_openat.do_filp_open
      0.00       +1.4e+100%       0.01 ±282%  +1.6e+99%       0.00 ±300%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.dput.path_put.__x64_sys_chdir
      0.00        +7.8e+98%       0.00 ±282%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.dput.path_put.do_readlinkat
      0.01 ±217%    +221.6%       0.04 ±126%      -3.5%       0.01 ±278%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.dput.path_put.free_fs_struct
      0.00 ±282%    +800.0%       0.01 ±282%   +2960.0%       0.02 ±250%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.dput.path_put.proc_pid_readlink
      0.00        +2.2e+99%       0.00 ±282%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.dput.path_put.set_fs_pwd
      0.00 ±282%    +226.5%       0.01 ±188%    +482.4%       0.02 ±300%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.dput.path_put.vfs_statx
      0.00       +4.8e+100%       0.05 ±282%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.dput.proc_invalidate_siblings_dcache.release_task
      0.00 ±282%    +200.0%       0.00 ±282%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.dput.step_into.handle_dots
      0.37 ±244%     -19.8%       0.30 ±176%     -94.1%       0.02 ±120%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.dput.step_into.path_openat
     21.52 ±278%     -51.7%      10.40 ±179%     -89.9%       2.17 ±279%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.dput.step_into.walk_component
      0.00        +6.4e+99%       0.01 ±188% +4.8e+100%       0.05 ±255%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.dput.terminate_walk.path_lookupat
      2.89 ±205%     -41.5%       1.69 ±179%     -35.8%       1.86 ±284%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.dput.terminate_walk.path_openat
      0.03 ±217%     +57.5%       0.05 ±265%     +15.5%       0.03 ±287%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.dput.walk_component.link_path_walk
      5.84 ±171%     -91.2%       0.52 ± 83%     -32.3%       3.95 ±252%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.exit_mmap.mmput.begin_new_exec
      3.89 ±273%     -93.4%       0.26 ± 92%     +16.0%       4.52 ±183%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.exit_mmap.mmput.do_exit
      0.00 ±282%    +237.1%       0.01 ±282%  +60230.9%       2.35 ±295%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.exit_signals.do_exit.do_group_exit
      0.14 ±225%   +8383.6%      12.09 ±207%   +2006.1%       3.00 ±229%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.filemap_read.__kernel_read.exec_binprm
      0.01 ±282%      +7.8%       0.01 ±246%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.filemap_read.__kernel_read.load_elf_binary
      0.01 ±282%     +29.4%       0.01 ±282%     -78.8%       0.00 ±300%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.filemap_read.__kernel_read.load_elf_phdrs
      0.06 ±227%     -95.4%       0.00 ±219%     -89.6%       0.01 ±266%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.filemap_read.new_sync_read.vfs_read
    293.69 ±160%   +1363.7%       4298 ± 79%    +629.3%       2141 ±192%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
      1.96 ±234%     -77.6%       0.44 ±192%     +27.2%       2.50 ±282%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.__alloc_file.alloc_empty_file
      0.01 ±133%     +37.6%       0.02 ±120%    +352.3%       0.06 ±209%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.__anon_vma_prepare.do_anonymous_page
      0.03 ±133%    -100.0%       0.00           -62.5%       0.01 ±233%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.__anon_vma_prepare.do_fault
      0.01 ±248%    +545.9%       0.04 ±176%     -24.8%       0.01 ±181%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.__d_alloc.d_alloc
      0.01 ±282%     -59.6%       0.00 ±204%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.__d_alloc.d_alloc_cursor
      0.00        +2.9e+99%       0.00 ±282%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.getname_flags.__x64_sys_mknod
      0.11 ±158%     -68.6%       0.03 ±133%     -94.9%       0.01 ±224%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.getname_flags.do_sys_openat2
      0.01 ±200%     +80.2%       0.02 ±186%    +665.0%       0.10 ±254%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.getname_flags.user_path_at_empty
      0.00 ±282%   +1279.2%       0.04 ±273%    +983.8%       0.03 ±204%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.getname_kernel.open_exec
      0.00 ±282%    +350.0%       0.00 ±282%    +957.5%       0.01 ±299%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.mm_alloc.alloc_bprm
      0.00       +1.3e+103%      13.29 ±282%    +3e+99%       0.00 ±300%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.prepare_creds.copy_creds
      0.00 ±146%    +260.7%       0.01 ±282%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.prepare_creds.do_faccessat
      0.04 ±142%     -78.1%       0.01 ±172%     -76.3%       0.01 ±300%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.proc_alloc_inode.alloc_inode
      0.00       +1.5e+101%       0.15 ±282%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.proc_reg_open.do_dentry_open
      1.04 ±178%     -80.7%       0.20 ± 90%    +102.8%       2.11 ±267%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.security_file_alloc.__alloc_file
      0.00          -100.0%       0.00        +2.1e+99%       0.00 ±299%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.seq_open.do_dentry_open
      0.00       +1.7e+100%       0.02 ±282%  +5.3e+99%       0.01 ±300%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.seq_open.kernfs_fop_open
      0.01 ±282%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.seq_open.proc_reg_open
      0.04 ±222%    +282.7%       0.16 ±113%     -74.6%       0.01 ±202%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.vm_area_alloc.__install_special_mapping
      0.11 ±169%   +3061.3%       3.60 ±225%    +293.5%       0.45 ± 98%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.vm_area_alloc.alloc_bprm
      0.00 ±282%   +1155.6%       0.05 ±187%    +970.0%       0.04 ±300%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.vm_area_alloc.do_brk_flags
      2.32 ±181%     +33.4%       3.10 ±268%     -88.4%       0.27 ±212%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.vm_area_alloc.mmap_region
      0.82 ±233%     -89.5%       0.09 ±196%     -86.9%       0.11 ±199%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.vm_area_dup.__split_vma
     23163 ± 17%     -61.0%       9041 ± 35%      +2.4%      23710 ± 21%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags
      0.01 ±231%    +712.9%       0.06 ±160%     -55.0%       0.00 ±300%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc_trace.alloc_bprm.do_execveat_common
      0.00       +1.5e+100%       0.01 ±167%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc_trace.disk_seqf_start.seq_read_iter
      0.00        +6.7e+98%       0.00 ±282% +9.6e+100%       0.10 ±296%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc_trace.kernfs_fop_open.do_dentry_open
      0.37 ±282%     -92.4%       0.03 ±163%     -95.4%       0.02 ±284%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc_trace.load_elf_binary.exec_binprm
      0.91 ±190%    +261.4%       3.30 ±217%     -70.4%       0.27 ±149%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc_trace.perf_event_mmap.mmap_region
      0.00 ±282%    +166.7%       0.00 ±282%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc_trace.perf_event_mmap.mprotect_fixup
      0.00 ±282%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc_trace.single_open.proc_reg_open
      0.00 ±282%   +1325.0%       0.01 ±202%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc_trace.vmstat_start.seq_read_iter
      0.02 ±267%  +7.3e+06%       1165 ±277%      -3.8%       0.02 ±160%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.migrate_pages.migrate_misplaced_page.do_numa_page
      0.02 ±282%     -86.0%       0.00 ±187%     -24.4%       0.01 ±300%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.mmput.begin_new_exec.load_elf_binary
      0.00        +7.4e+99%       0.01 ±188%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.mmput.do_exit.do_group_exit
      0.00        +4.7e+99%       0.00 ±143%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.mnt_want_write.filename_create.do_mkdirat
      0.00          -100.0%       0.00       +3.8e+100%       0.04 ±300%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.mnt_want_write.filename_create.do_mknodat
      0.00 ±282%   +1116.2%       0.05 ±134%    +401.1%       0.02 ±271%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.move_page_tables.shift_arg_pages.setup_arg_pages
      0.03 ±282%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.__fdget_pos.ksys_write
      0.00       +1.6e+102%       1.59 ±250%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.__perf_event_read_value.perf_read
      0.00        +2.8e+99%       0.00 ±145% +3.5e+101%       0.35 ±287%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.fifo_open.do_dentry_open
      0.08 ±157%     +10.4%       0.09 ±161%     -79.8%       0.02 ±147%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.futex_cleanup_begin.futex_exec_release
      0.01 ±187%    +115.9%       0.03 ±167%    +221.4%       0.04 ±250%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.futex_cleanup_begin.futex_exit_release
      0.00 ±282%   +2604.8%       0.06 ±187%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.kernfs_fop_open.do_dentry_open
      0.00 ±282%     +18.2%       0.00 ±282%     -46.8%       0.00 ±299%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.kernfs_put_open_node.isra
      0.35 ±271%    +390.0%       1.73 ±278%     -77.8%       0.08 ±192%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.kernfs_seq_start.seq_read_iter
    168.35 ±281%    +130.1%     387.30 ±278%     +89.3%     318.62 ±200%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.perf_event_ctx_lock_nested.isra
      0.00       +4.5e+100%       0.04 ±282%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.perf_event_exit_task.do_exit
      0.01 ±227%   +9237.9%       0.90 ±276%    +145.2%       0.02 ±155%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.perf_event_for_each_child._perf_ioctl
      0.00 ±282%   +1260.0%       0.01 ±255%    +494.0%       0.00 ±300%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.perf_read.vfs_read
      0.00 ±282%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.pipe_release.__fput
      0.00 ±282%   +2060.0%       0.01 ±191%   +1322.0%       0.01 ±271%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.pipe_write.new_sync_write
      0.00         +7e+102%       6.97 ±281%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.seq_read_iter.new_sync_read
      0.00        +8.9e+98%       0.00 ±282%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.seq_read_iter.seq_read
      0.00 ±282%    -100.0%       0.00          +118.6%       0.00 ±300%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.slab_start.seq_read_iter
     15118 ± 37%     -54.4%       6897 ± 27%      -1.2%      14941 ± 24%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.unix_stream_read_generic.unix_stream_recvmsg
      0.00        +7.7e+99%       0.01 ±282%  +1.8e+99%       0.00 ±200%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.uprobe_clear_state.mmput
      0.00       +1.6e+100%       0.02 ±282%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.mutex_lock_interruptible.bprm_execve.do_execveat_common
      0.01 ±282%     -67.8%       0.00 ±282%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.pagecache_get_page.shmem_getpage_gfp.shmem_write_begin
      0.00          -100.0%       0.00        +6.4e+99%       0.01 ±300%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.pick_link.step_into.path_openat
      0.02 ±108%  +11711.0%       2.87 ±265%    +308.1%       0.10 ±133%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.put_files_struct.do_exit.do_group_exit
      1.83 ±272%     -20.7%       1.45 ±269%     -96.8%       0.06 ±203%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.remove_vma.__do_munmap.__vm_munmap
      0.07 ±261%   +6213.0%       4.16 ±218%      -2.1%       0.06 ±300%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.remove_vma.__do_munmap.mmap_region
      2.10 ±174%    +798.9%      18.85 ±145%      -2.2%       2.05 ±188%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.remove_vma.exit_mmap.mmput
     15837 ± 56%     -71.5%       4505 ± 68%     -15.0%      13461 ± 71%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.rmap_walk_anon.remove_migration_ptes.migrate_pages
      5802 ±148%     -42.3%       3350 ±111%     +21.3%       7039 ±129%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.rmap_walk_anon.try_to_migrate.migrate_pages
    218.76 ±282%    +325.7%     931.18 ±138%    +449.0%       1201 ±299%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.shrink_dentry_list.shrink_dcache_parent.d_invalidate
      0.00          -100.0%       0.00       +9.6e+103%      95.85 ±299%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork
      9201 ± 98%     -56.0%       4050 ± 95%     -66.8%       3057 ±212%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate
      0.88 ±176%   +2743.1%      25.12 ± 77%   +3245.2%      29.56 ±155%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.sched_exec.bprm_execve
      0.00          -100.0%       0.00        +4.6e+99%       0.00 ±300%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.switch_task_namespaces.do_exit.do_group_exit
      0.02 ±282%     -14.6%       0.02 ±173%     +32.2%       0.03 ±254%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.task_numa_work.task_work_run.exit_to_user_mode_prepare
      0.02 ±179%    +519.1%       0.13 ±281%    +366.8%       0.10 ±204%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.task_work_run.do_exit.do_group_exit
      0.02 ±145%    +289.0%       0.06 ±212%     -65.9%       0.01 ±203%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      1.47 ±216%   +1885.7%      29.13 ±146%    +206.9%       4.50 ±298%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.try_to_migrate_one.rmap_walk_anon.try_to_migrate
      3938 ±139%     -22.0%       3073 ± 49%     -16.9%       3274 ±149%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      2.38 ±176%     +98.9%       4.74 ±268%     +72.1%       4.10 ±286%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.unmap_page_range.unmap_vmas.exit_mmap
      0.01 ±238%    +701.2%       0.08 ±200%    +226.1%       0.03 ±187%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.unmap_page_range.unmap_vmas.unmap_region
      8.27 ±259%     -33.1%       5.53 ±178%     -99.3%       0.05 ±154%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.unmap_vmas.exit_mmap.mmput
      1.44 ±249%     +53.7%       2.21 ±272%     -81.7%       0.26 ±224%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.unmap_vmas.unmap_region.__do_munmap
      0.00       +4.7e+104%     474.02 ±282%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.uprobe_start_dup_mmap.dup_mmap.dup_mm
      8135 ± 36%     -41.5%       4756 ± 60%      -9.1%       7397 ± 35%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr_locked
      9350 ±120%     -48.9%       4774 ± 74%      -1.9%       9174 ±125%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.stop_two_cpus.migrate_swap
     13731 ± 48%     -51.0%       6725 ± 36%     +38.9%      19069 ± 26%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.wait_for_unix_gc.unix_stream_sendmsg.sock_sendmsg
      6227 ±187%     -99.8%      13.51 ±168%     -99.8%      10.91 ±217%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.wp_page_copy.__handle_mm_fault.handle_mm_fault
      3.33 ±146%  +28769.8%     961.65 ±276%     -11.0%       2.96 ±196%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.zap_pte_range.unmap_page_range.unmap_vmas
      1894 ±173%     -30.1%       1323 ± 63%     +24.7%       2362 ±145%  perf-sched.wait_time.max.ms.rcu_gp_kthread.kthread.ret_from_fork
      8884 ±113%     -42.3%       5124 ±104%     +50.0%      13329 ± 61%  perf-sched.wait_time.max.ms.rwsem_down_read_slowpath.page_lock_anon_vma_read.rmap_walk_anon.try_to_migrate
     13550 ± 70%     -58.2%       5663 ± 93%      -2.4%      13225 ± 77%  perf-sched.wait_time.max.ms.rwsem_down_read_slowpath.rmap_walk_anon.remove_migration_ptes.migrate_pages
      5946 ±154%     -65.4%       2056 ±136%     -25.6%       4422 ±166%  perf-sched.wait_time.max.ms.rwsem_down_write_slowpath.__put_anon_vma.unlink_anon_vmas.free_pgtables
     13298 ± 77%     -51.4%       6468 ± 81%     +14.9%      15281 ± 82%  perf-sched.wait_time.max.ms.rwsem_down_write_slowpath.unlink_anon_vmas.free_pgtables.exit_mmap
      1277 ±237%    +278.3%       4833 ± 85%     -25.6%     950.22 ±188%  perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      1223 ±148%    +234.4%       4092 ± 99%    +497.4%       7311 ±128%  perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
      0.04 ±282%     +85.0%       0.08 ±187%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_timeout.__skb_wait_for_more_packets.__unix_dgram_recvmsg.__sys_recvfrom
     13644 ± 70%     -30.2%       9519 ± 20%     -34.2%       8971 ± 89%  perf-sched.wait_time.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
     13.74 ±141%     -32.4%       9.29 ±187%   +3314.0%     469.09 ±300%  perf-sched.wait_time.max.ms.schedule_timeout.msleep.cpuinfo_open.do_dentry_open
      9632 ± 79%     -60.7%       3790 ± 50%     -20.4%       7664 ± 55%  perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     25188 ± 14%     -49.4%      12735 ± 31%      +3.5%      26078 ± 21%  perf-sched.wait_time.max.ms.schedule_timeout.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg
     25508 ± 13%     -52.8%      12033 ± 25%      -0.5%      25380 ± 20%  perf-sched.wait_time.max.ms.schedule_timeout.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      0.00 ±282%     -52.2%       0.00 ±282%     -25.7%       0.00 ±300%  perf-sched.wait_time.max.ms.schedule_timeout.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr_locked
      0.00          -100.0%       0.00       +4.4e+101%       0.44 ±300%  perf-sched.wait_time.max.ms.schedule_timeout.wait_for_completion.rdmsr_safe_on_cpu.msr_read
      0.00       +5.5e+104%     552.86 ±282% +1.1e+101%       0.11 ±300%  perf-sched.wait_time.max.ms.schedule_timeout.wait_for_completion.stop_two_cpus.migrate_swap
     24128 ± 14%     -42.9%      13772 ± 25%      -0.2%      24088 ± 20%  perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.38 ±282%  +1.2e+05%     445.75 ±282%    -100.0%       0.00        perf-sched.wait_time.max.ms.syslog_print.do_syslog.part.0.kmsg_read
     10.31 ±167%    +149.1%      25.69 ±119%    +100.3%      20.65 ±177%  perf-sched.wait_time.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open.isra
     22934 ± 19%     -41.1%      13502 ± 27%      +2.0%      23400 ± 21%  perf-sched.wait_time.max.ms.worker_thread.kthread.ret_from_fork
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.0:IO-APIC.2-edge.timer
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.101:PCI-MSI.57149440-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.102:PCI-MSI.57149441-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.103:PCI-MSI.57149442-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.104:PCI-MSI.57149443-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.105:PCI-MSI.57149444-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.106:PCI-MSI.57149445-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.107:PCI-MSI.57149446-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.108:PCI-MSI.57149447-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.109:PCI-MSI.57149448-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.110:PCI-MSI.57149449-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.111:PCI-MSI.57149450-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.112:PCI-MSI.57149451-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.113:PCI-MSI.57149452-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.114:PCI-MSI.57149453-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.115:PCI-MSI.57149454-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.116:PCI-MSI.57149455-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.117:PCI-MSI.57149456-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.118:PCI-MSI.57149457-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.119:PCI-MSI.57149458-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.120:PCI-MSI.57149459-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.121:PCI-MSI.57149460-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.122:PCI-MSI.57149461-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.123:PCI-MSI.57149462-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.124:PCI-MSI.57149463-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.125:PCI-MSI.57149464-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.126:PCI-MSI.57149465-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.127:PCI-MSI.57149466-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.128:PCI-MSI.57149467-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.129:PCI-MSI.57149468-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.130:PCI-MSI.57149469-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.131:PCI-MSI.57149470-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.132:PCI-MSI.57149471-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.133:PCI-MSI.57149472-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.134:PCI-MSI.57149473-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.135:PCI-MSI.57149474-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.136:PCI-MSI.57149475-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.137:PCI-MSI.57149476-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.138:PCI-MSI.57149477-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.139:PCI-MSI.57149478-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.140:PCI-MSI.57149479-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.141:PCI-MSI.57149480-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.142:PCI-MSI.57149481-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.143:PCI-MSI.57149482-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.144:PCI-MSI.57149483-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.145:PCI-MSI.57149484-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.146:PCI-MSI.57149485-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.147:PCI-MSI.57149486-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.148:PCI-MSI.57149487-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.149:PCI-MSI.57149488-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.150:PCI-MSI.57149489-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.151:PCI-MSI.57149490-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.152:PCI-MSI.57149491-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.153:PCI-MSI.57149492-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.154:PCI-MSI.57149493-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.155:PCI-MSI.57149494-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.156:PCI-MSI.57149495-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.157:PCI-MSI.57149496-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.158:PCI-MSI.57149497-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.159:PCI-MSI.57149498-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.160:PCI-MSI.57149499-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.161:PCI-MSI.57149500-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.162:PCI-MSI.57149501-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.163:PCI-MSI.57149502-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.165:PCI-MSI.327680-edge.xhci_hcd
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.167:PCI-MSI.65536-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.169:PCI-MSI.67584-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.170:PCI-MSI.18874368-edge.nvme0q0
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.170:PCI-MSI.67584-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.170:PCI-MSI.69632-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.171:PCI-MSI.69632-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.171:PCI-MSI.71680-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.172:PCI-MSI.18874368-edge.nvme0q0
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.172:PCI-MSI.67584-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.172:PCI-MSI.71680-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.172:PCI-MSI.73728-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.173:PCI-MSI.69632-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.173:PCI-MSI.71680-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.173:PCI-MSI.73728-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.173:PCI-MSI.75776-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.174:PCI-MSI.18874368-edge.nvme0q0
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.174:PCI-MSI.75776-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.174:PCI-MSI.77824-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.175:PCI-MSI.73728-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.175:PCI-MSI.75776-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.175:PCI-MSI.77824-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.175:PCI-MSI.79872-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.176:PCI-MSI.18874368-edge.nvme0q0
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.176:PCI-MSI.33619968-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.176:PCI-MSI.75776-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.176:PCI-MSI.79872-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.177:PCI-MSI.18874368-edge.nvme0q0
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.177:PCI-MSI.33619968-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.177:PCI-MSI.77824-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.178:PCI-MSI.33619968-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.178:PCI-MSI.79872-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.179:PCI-MSI.18874369-edge.nvme0q1
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.179:PCI-MSI.18874370-edge.nvme0q2
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.179:PCI-MSI.33619968-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.179:PCI-MSI.33622016-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.180:PCI-MSI.18874368-edge.nvme0q0
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.180:PCI-MSI.18874372-edge.nvme0q4
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.180:PCI-MSI.18874376-edge.nvme0q8
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.180:PCI-MSI.33619968-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.180:PCI-MSI.33622016-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.180:PCI-MSI.33624064-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.180:PCI-MSI.33626112-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.180:PCI-MSI.79872-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.181:PCI-MSI.18874368-edge.nvme0q0
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.181:PCI-MSI.18874371-edge.nvme0q3
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.181:PCI-MSI.18874372-edge.nvme0q4
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.181:PCI-MSI.18874376-edge.nvme0q8
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.181:PCI-MSI.33622016-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.181:PCI-MSI.33624064-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.181:PCI-MSI.33626112-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.182:PCI-MSI.18874368-edge.nvme0q0
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.182:PCI-MSI.18874372-edge.nvme0q4
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.182:PCI-MSI.33622016-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.182:PCI-MSI.33626112-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.182:PCI-MSI.33628160-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.183:PCI-MSI.18874368-edge.nvme0q0
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.183:PCI-MSI.18874373-edge.nvme0q5
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.183:PCI-MSI.33622016-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.183:PCI-MSI.33624064-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.183:PCI-MSI.33628160-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.184:PCI-MSI.18874368-edge.nvme0q0
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.184:PCI-MSI.18874374-edge.nvme0q6
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.184:PCI-MSI.18874380-edge.nvme0q12
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.184:PCI-MSI.33626112-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.184:PCI-MSI.33630208-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.184:PCI-MSI.67176448-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.185:PCI-MSI.18874376-edge.nvme0q8
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.185:PCI-MSI.33628160-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.185:PCI-MSI.33630208-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.185:PCI-MSI.33632256-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.186:PCI-MSI.18874371-edge.nvme0q3
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.186:PCI-MSI.33632256-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.186:PCI-MSI.33634304-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.187:PCI-MSI.18874382-edge.nvme0q14
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.187:PCI-MSI.67174400-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.188:PCI-MSI.18874383-edge.nvme0q15
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.188:PCI-MSI.33634304-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.188:PCI-MSI.67174400-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.189:PCI-MSI.18874373-edge.nvme0q5
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.189:PCI-MSI.18874374-edge.nvme0q6
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.189:PCI-MSI.18874384-edge.nvme0q16
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.189:PCI-MSI.67176448-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.190:PCI-MSI.18874368-edge.nvme0q0
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.190:PCI-MSI.18874375-edge.nvme0q7
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.190:PCI-MSI.18874380-edge.nvme0q12
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.190:PCI-MSI.18874382-edge.nvme0q14
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.190:PCI-MSI.67174400-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.190:PCI-MSI.67176448-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.191:PCI-MSI.18874368-edge.nvme0q0
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.191:PCI-MSI.18874386-edge.nvme0q18
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.191:PCI-MSI.67178496-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.192:PCI-MSI.18874368-edge.nvme0q0
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.192:PCI-MSI.67176448-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.192:PCI-MSI.67180544-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.193:PCI-MSI.18874368-edge.nvme0q0
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.193:PCI-MSI.18874378-edge.nvme0q10
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.193:PCI-MSI.18874388-edge.nvme0q20
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.193:PCI-MSI.67178496-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.194:PCI-MSI.18874377-edge.nvme0q9
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.194:PCI-MSI.18874379-edge.nvme0q11
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.194:PCI-MSI.67182592-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.195:PCI-MSI.18874379-edge.nvme0q11
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.195:PCI-MSI.18874390-edge.nvme0q22
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.195:PCI-MSI.18874391-edge.nvme0q23
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.195:PCI-MSI.67184640-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.196:PCI-MSI.67186688-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.197:PCI-MSI.18874381-edge.nvme0q13
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.197:PCI-MSI.18874389-edge.nvme0q21
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.197:PCI-MSI.18874390-edge.nvme0q22
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.197:PCI-MSI.67188736-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.199:PCI-MSI.18874395-edge.nvme0q27
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.200:PCI-MSI.100728832-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.200:PCI-MSI.18874375-edge.nvme0q7
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.200:PCI-MSI.18874391-edge.nvme0q23
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.201:PCI-MSI.100730880-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.202:PCI-MSI.18874394-edge.nvme0q26
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.203:PCI-MSI.18874368-edge.nvme0q0
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.203:PCI-MSI.18874378-edge.nvme0q10
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.203:PCI-MSI.18874387-edge.nvme0q19
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.203:PCI-MSI.18874388-edge.nvme0q20
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.205:PCI-MSI.18874395-edge.nvme0q27
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.205:PCI-MSI.18874400-edge.nvme0q32
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.206:PCI-MSI.18874397-edge.nvme0q29
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.207:PCI-MSI.18874392-edge.nvme0q24
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.207:PCI-MSI.18874397-edge.nvme0q29
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.207:PCI-MSI.18874402-edge.nvme0q34
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.208:PCI-MSI.18874392-edge.nvme0q24
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.208:PCI-MSI.18874401-edge.nvme0q33
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.209:PCI-MSI.18874394-edge.nvme0q26
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.209:PCI-MSI.18874399-edge.nvme0q31
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.209:PCI-MSI.18874404-edge.nvme0q36
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.210:PCI-MSI.18874400-edge.nvme0q32
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.210:PCI-MSI.18874401-edge.nvme0q33
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.210:PCI-MSI.18874405-edge.nvme0q37
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.211:PCI-MSI.18874395-edge.nvme0q27
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.211:PCI-MSI.18874401-edge.nvme0q33
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.212:PCI-MSI.18874396-edge.nvme0q28
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.212:PCI-MSI.18874404-edge.nvme0q36
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.213:PCI-MSI.18874401-edge.nvme0q33
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.213:PCI-MSI.18874403-edge.nvme0q35
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.213:PCI-MSI.18874404-edge.nvme0q36
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.215:PCI-MSI.18874400-edge.nvme0q32
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.215:PCI-MSI.18874406-edge.nvme0q38
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.215:PCI-MSI.18874408-edge.nvme0q40
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.216:PCI-MSI.18874401-edge.nvme0q33
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.216:PCI-MSI.18874411-edge.nvme0q43
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.217:PCI-MSI.18874382-edge.nvme0q14
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.217:PCI-MSI.18874401-edge.nvme0q33
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.217:PCI-MSI.18874402-edge.nvme0q34
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.218:PCI-MSI.18874396-edge.nvme0q28
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.218:PCI-MSI.18874403-edge.nvme0q35
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.218:PCI-MSI.18874406-edge.nvme0q38
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.219:PCI-MSI.18874402-edge.nvme0q34
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.220:PCI-MSI.18874398-edge.nvme0q30
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.220:PCI-MSI.18874403-edge.nvme0q35
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.220:PCI-MSI.18874413-edge.nvme0q45
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.221:PCI-MSI.18874404-edge.nvme0q36
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.221:PCI-MSI.18874413-edge.nvme0q45
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.221:PCI-MSI.18874414-edge.nvme0q46
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.223:PCI-MSI.18874408-edge.nvme0q40
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.223:PCI-MSI.18874410-edge.nvme0q42
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.223:PCI-MSI.18874415-edge.nvme0q47
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.226:PCI-MSI.33628160-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.227:PCI-MSI.18874411-edge.nvme0q43
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.227:PCI-MSI.18874412-edge.nvme0q44
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.227:PCI-MSI.18874415-edge.nvme0q47
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.227:PCI-MSI.18874418-edge.nvme0q50
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.228:PCI-MSI.18874403-edge.nvme0q35
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.228:PCI-MSI.18874416-edge.nvme0q48
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.228:PCI-MSI.18874419-edge.nvme0q51
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.229:PCI-MSI.18874413-edge.nvme0q45
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.229:PCI-MSI.18874422-edge.nvme0q54
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.230:PCI-MSI.18874414-edge.nvme0q46
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.230:PCI-MSI.18874415-edge.nvme0q47
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.230:PCI-MSI.18874422-edge.nvme0q54
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.231:PCI-MSI.18874416-edge.nvme0q48
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.231:PCI-MSI.18874419-edge.nvme0q51
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.231:PCI-MSI.18874422-edge.nvme0q54
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.231:PCI-MSI.18874423-edge.nvme0q55
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.232:PCI-MSI.18874416-edge.nvme0q48
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.232:PCI-MSI.18874417-edge.nvme0q49
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.232:PCI-MSI.18874425-edge.nvme0q57
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.233:PCI-MSI.18874424-edge.nvme0q56
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.234:PCI-MSI.18874409-edge.nvme0q41
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.234:PCI-MSI.18874416-edge.nvme0q48
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.234:PCI-MSI.18874419-edge.nvme0q51
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.235:PCI-MSI.18874417-edge.nvme0q49
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.235:PCI-MSI.18874420-edge.nvme0q52
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.236:PCI-MSI.18874418-edge.nvme0q50
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.236:PCI-MSI.18874428-edge.nvme0q60
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.236:PCI-MSI.33628160-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.237:PCI-MSI.18874412-edge.nvme0q44
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.237:PCI-MSI.18874419-edge.nvme0q51
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.237:PCI-MSI.18874421-edge.nvme0q53
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.237:PCI-MSI.18874425-edge.nvme0q57
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.237:PCI-MSI.18874430-edge.nvme0q62
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.238:PCI-MSI.18874433-edge.nvme0q65
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.239:PCI-MSI.18874414-edge.nvme0q46
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.239:PCI-MSI.18874431-edge.nvme0q63
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.240:PCI-MSI.18874428-edge.nvme0q60
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.241:PCI-MSI.18874423-edge.nvme0q55
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.241:PCI-MSI.18874428-edge.nvme0q60
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.241:PCI-MSI.18874436-edge.nvme0q68
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.242:PCI-MSI.18874424-edge.nvme0q56
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.242:PCI-MSI.18874434-edge.nvme0q66
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.243:PCI-MSI.18874428-edge.nvme0q60
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.243:PCI-MSI.18874434-edge.nvme0q66
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.244:PCI-MSI.18874439-edge.nvme0q71
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.245:PCI-MSI.18874430-edge.nvme0q62
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.245:PCI-MSI.18874433-edge.nvme0q65
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.245:PCI-MSI.18874435-edge.nvme0q67
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.247:PCI-MSI.18874429-edge.nvme0q61
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.248:PCI-MSI.18874433-edge.nvme0q65
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.248:PCI-MSI.18874436-edge.nvme0q68
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.249:PCI-MSI.18874424-edge.nvme0q56
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.250:PCI-MSI.18874443-edge.nvme0q75
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.251:PCI-MSI.18874436-edge.nvme0q68
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.251:PCI-MSI.18874439-edge.nvme0q71
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.251:PCI-MSI.18874441-edge.nvme0q73
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.252:PCI-MSI.18874436-edge.nvme0q68
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.253:PCI-MSI.18874428-edge.nvme0q60
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.253:PCI-MSI.18874435-edge.nvme0q67
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.253:PCI-MSI.18874436-edge.nvme0q68
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.253:PCI-MSI.18874437-edge.nvme0q69
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.253:PCI-MSI.18874441-edge.nvme0q73
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.253:PCI-MSI.18874443-edge.nvme0q75
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.254:PCI-MSI.18874429-edge.nvme0q61
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.254:PCI-MSI.18874436-edge.nvme0q68
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.254:PCI-MSI.18874437-edge.nvme0q69
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.254:PCI-MSI.18874438-edge.nvme0q70
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.254:PCI-MSI.18874442-edge.nvme0q74
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.255:PCI-MSI.18874443-edge.nvme0q75
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.256:PCI-MSI.18874431-edge.nvme0q63
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.256:PCI-MSI.18874447-edge.nvme0q79
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.257:PCI-MSI.18874444-edge.nvme0q76
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.257:PCI-MSI.18874450-edge.nvme0q82
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.259:PCI-MSI.18874434-edge.nvme0q66
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.259:PCI-MSI.18874437-edge.nvme0q69
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.260:PCI-MSI.18874435-edge.nvme0q67
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.261:PCI-MSI.18874445-edge.nvme0q77
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.261:PCI-MSI.18874446-edge.nvme0q78
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.265:PCI-MSI.18874450-edge.nvme0q82
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.265:PCI-MSI.18874457-edge.nvme0q89
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.265:PCI-MSI.18874458-edge.nvme0q90
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.266:PCI-MSI.18874441-edge.nvme0q73
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.266:PCI-MSI.18874449-edge.nvme0q81
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.267:PCI-MSI.18874442-edge.nvme0q74
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.267:PCI-MSI.18874451-edge.nvme0q83
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.267:PCI-MSI.18874457-edge.nvme0q89
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.268:PCI-MSI.18874433-edge.nvme0q65
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.268:PCI-MSI.18874443-edge.nvme0q75
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.268:PCI-MSI.18874458-edge.nvme0q90
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.269:PCI-MSI.18874457-edge.nvme0q89
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.269:PCI-MSI.18874462-edge.nvme0q94
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.269:PCI-MSI.18874464-edge.nvme0q96
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.269:PCI-MSI.18874465-edge.nvme0q97
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.270:PCI-MSI.18874446-edge.nvme0q78
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.270:PCI-MSI.18874455-edge.nvme0q87
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.270:PCI-MSI.18874460-edge.nvme0q92
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.270:PCI-MSI.18874462-edge.nvme0q94
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.270:PCI-MSI.18874465-edge.nvme0q97
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.270:PCI-MSI.18874466-edge.nvme0q98
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.271:PCI-MSI.18874455-edge.nvme0q87
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.271:PCI-MSI.18874466-edge.nvme0q98
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.271:PCI-MSI.18874467-edge.nvme0q99
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.273:PCI-MSI.18874458-edge.nvme0q90
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.273:PCI-MSI.18874465-edge.nvme0q97
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.273:PCI-MSI.18874468-edge.nvme0q100
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.274:PCI-MSI.18874464-edge.nvme0q96
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.274:PCI-MSI.18874466-edge.nvme0q98
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.275:PCI-MSI.18874465-edge.nvme0q97
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.275:PCI-MSI.18874466-edge.nvme0q98
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.275:PCI-MSI.33628160-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.276:PCI-MSI.18874466-edge.nvme0q98
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.276:PCI-MSI.18874468-edge.nvme0q100
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.276:PCI-MSI.18874471-edge.nvme0q103
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.276:PCI-MSI.18874472-edge.nvme0q104
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.277:PCI-MSI.18874465-edge.nvme0q97
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.278:PCI-MSI.18874465-edge.nvme0q97
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.278:PCI-MSI.18874473-edge.nvme0q105
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.279:PCI-MSI.18874466-edge.nvme0q98
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.279:PCI-MSI.18874467-edge.nvme0q99
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.279:PCI-MSI.18874469-edge.nvme0q101
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.279:PCI-MSI.18874471-edge.nvme0q103
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.279:PCI-MSI.18874474-edge.nvme0q106
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.280:PCI-MSI.18874465-edge.nvme0q97
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.280:PCI-MSI.18874468-edge.nvme0q100
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.280:PCI-MSI.18874475-edge.nvme0q107
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.280:PCI-MSI.18874476-edge.nvme0q108
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.281:PCI-MSI.18874456-edge.nvme0q88
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.281:PCI-MSI.18874464-edge.nvme0q96
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.281:PCI-MSI.18874466-edge.nvme0q98
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.281:PCI-MSI.18874468-edge.nvme0q100
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.281:PCI-MSI.18874469-edge.nvme0q101
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.281:PCI-MSI.18874473-edge.nvme0q105
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.282:PCI-MSI.18874447-edge.nvme0q79
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.282:PCI-MSI.18874467-edge.nvme0q99
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.282:PCI-MSI.18874474-edge.nvme0q106
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.283:PCI-MSI.18874466-edge.nvme0q98
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.283:PCI-MSI.18874468-edge.nvme0q100
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.283:PCI-MSI.18874479-edge.nvme0q111
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.284:PCI-MSI.18874466-edge.nvme0q98
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.284:PCI-MSI.18874467-edge.nvme0q99
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.284:PCI-MSI.18874469-edge.nvme0q101
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.284:PCI-MSI.18874471-edge.nvme0q103
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.284:PCI-MSI.18874472-edge.nvme0q104
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.285:PCI-MSI.18874468-edge.nvme0q100
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.285:PCI-MSI.18874473-edge.nvme0q105
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.285:PCI-MSI.18874480-edge.nvme0q112
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.286:PCI-MSI.18874471-edge.nvme0q103
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.286:PCI-MSI.18874474-edge.nvme0q106
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.286:PCI-MSI.18874476-edge.nvme0q108
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.287:PCI-MSI.18874465-edge.nvme0q97
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.287:PCI-MSI.18874472-edge.nvme0q104
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.287:PCI-MSI.18874475-edge.nvme0q107
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.287:PCI-MSI.18874477-edge.nvme0q109
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.288:PCI-MSI.18874466-edge.nvme0q98
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.288:PCI-MSI.18874473-edge.nvme0q105
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.288:PCI-MSI.18874478-edge.nvme0q110
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.289:PCI-MSI.18874464-edge.nvme0q96
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.289:PCI-MSI.18874465-edge.nvme0q97
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.289:PCI-MSI.18874472-edge.nvme0q104
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.289:PCI-MSI.18874484-edge.nvme0q116
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.290:PCI-MSI.18874465-edge.nvme0q97
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.290:PCI-MSI.18874473-edge.nvme0q105
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.290:PCI-MSI.18874475-edge.nvme0q107
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.290:PCI-MSI.18874478-edge.nvme0q110
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.290:PCI-MSI.18874480-edge.nvme0q112
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.291:PCI-MSI.18874466-edge.nvme0q98
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.291:PCI-MSI.18874469-edge.nvme0q101
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.291:PCI-MSI.18874476-edge.nvme0q108
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.291:PCI-MSI.18874478-edge.nvme0q110
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.291:PCI-MSI.18874481-edge.nvme0q113
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.291:PCI-MSI.18874483-edge.nvme0q115
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.291:PCI-MSI.18874486-edge.nvme0q118
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.292:PCI-MSI.18874467-edge.nvme0q99
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.292:PCI-MSI.18874475-edge.nvme0q107
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.292:PCI-MSI.18874477-edge.nvme0q109
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.292:PCI-MSI.18874480-edge.nvme0q112
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.293:PCI-MSI.18874471-edge.nvme0q103
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.293:PCI-MSI.18874476-edge.nvme0q108
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.293:PCI-MSI.18874481-edge.nvme0q113
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.294:PCI-MSI.18874470-edge.nvme0q102
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.294:PCI-MSI.18874479-edge.nvme0q111
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.294:PCI-MSI.18874481-edge.nvme0q113
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.294:PCI-MSI.18874489-edge.nvme0q121
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.295:PCI-MSI.18874471-edge.nvme0q103
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.295:PCI-MSI.18874478-edge.nvme0q110
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.295:PCI-MSI.18874483-edge.nvme0q115
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.295:PCI-MSI.18874488-edge.nvme0q120
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.296:PCI-MSI.18874479-edge.nvme0q111
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.296:PCI-MSI.18874481-edge.nvme0q113
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.296:PCI-MSI.18874484-edge.nvme0q116
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.297:PCI-MSI.18874472-edge.nvme0q104
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.297:PCI-MSI.18874473-edge.nvme0q105
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.297:PCI-MSI.18874480-edge.nvme0q112
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.297:PCI-MSI.18874482-edge.nvme0q114
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.297:PCI-MSI.18874485-edge.nvme0q117
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.297:PCI-MSI.18874489-edge.nvme0q121
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.298:PCI-MSI.18874482-edge.nvme0q114
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.298:PCI-MSI.18874488-edge.nvme0q120
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.298:PCI-MSI.18874494-edge.nvme0q126
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.299:PCI-MSI.18874484-edge.nvme0q116
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.299:PCI-MSI.18874487-edge.nvme0q119
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.299:PCI-MSI.18874491-edge.nvme0q123
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.300:PCI-MSI.18874465-edge.nvme0q97
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.300:PCI-MSI.18874475-edge.nvme0q107
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.300:PCI-MSI.18874485-edge.nvme0q117
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.300:PCI-MSI.18874487-edge.nvme0q119
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.300:PCI-MSI.18874488-edge.nvme0q120
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.300:PCI-MSI.18874496-edge.nvme0q128
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.301:PCI-MSI.18874466-edge.nvme0q98
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.301:PCI-MSI.18874479-edge.nvme0q111
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.301:PCI-MSI.18874486-edge.nvme0q118
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.301:PCI-MSI.18874488-edge.nvme0q120
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.301:PCI-MSI.18874496-edge.nvme0q128
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.301:PCI-MSI.69632-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.302:PCI-MSI.18874467-edge.nvme0q99
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.302:PCI-MSI.18874478-edge.nvme0q110
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.302:PCI-MSI.18874487-edge.nvme0q119
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.302:PCI-MSI.18874489-edge.nvme0q121
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.302:PCI-MSI.18874490-edge.nvme0q122
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.302:PCI-MSI.71680-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.303:PCI-MSI.18874468-edge.nvme0q100
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.303:PCI-MSI.18874478-edge.nvme0q110
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.303:PCI-MSI.18874491-edge.nvme0q123
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.303:PCI-MSI.18874493-edge.nvme0q125
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.303:PCI-MSI.71680-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.303:PCI-MSI.73728-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.304:PCI-MSI.18874479-edge.nvme0q111
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.304:PCI-MSI.18874480-edge.nvme0q112
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.304:PCI-MSI.18874486-edge.nvme0q118
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.304:PCI-MSI.18874489-edge.nvme0q121
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.304:PCI-MSI.18874494-edge.nvme0q126
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.304:PCI-MSI.73728-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.304:PCI-MSI.75776-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.305:PCI-MSI.18874480-edge.nvme0q112
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.305:PCI-MSI.18874483-edge.nvme0q115
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.305:PCI-MSI.18874488-edge.nvme0q120
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.305:PCI-MSI.18874490-edge.nvme0q122
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.305:PCI-MSI.18874495-edge.nvme0q127
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.305:PCI-MSI.75776-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.305:PCI-MSI.77824-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.306:PCI-MSI.18874491-edge.nvme0q123
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.306:PCI-MSI.18874494-edge.nvme0q126
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.306:PCI-MSI.18874496-edge.nvme0q128
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.306:PCI-MSI.77824-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.306:PCI-MSI.79872-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.307:PCI-MSI.18874495-edge.nvme0q127
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.307:PCI-MSI.79872-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.308:PCI-MSI.18874473-edge.nvme0q105
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.308:PCI-MSI.18874486-edge.nvme0q118
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.308:PCI-MSI.33619968-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.309:PCI-MSI.18874484-edge.nvme0q116
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.309:PCI-MSI.18874485-edge.nvme0q117
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.309:PCI-MSI.18874491-edge.nvme0q123
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.309:PCI-MSI.18874494-edge.nvme0q126
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.309:PCI-MSI.33619968-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.30:PCI-MSI.524288-edge.eth0
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.310:PCI-MSI.18874493-edge.nvme0q125
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.310:PCI-MSI.33622016-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.310:PCI-MSI.33624064-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.311:PCI-MSI.18874476-edge.nvme0q108
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.311:PCI-MSI.18874486-edge.nvme0q118
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.311:PCI-MSI.18874489-edge.nvme0q121
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.311:PCI-MSI.18874494-edge.nvme0q126
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.311:PCI-MSI.18874496-edge.nvme0q128
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.311:PCI-MSI.33622016-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.311:PCI-MSI.33624064-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.312:PCI-MSI.18874477-edge.nvme0q109
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.312:PCI-MSI.18874487-edge.nvme0q119
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.312:PCI-MSI.18874490-edge.nvme0q122
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.312:PCI-MSI.33624064-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.312:PCI-MSI.33626112-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.313:PCI-MSI.18874488-edge.nvme0q120
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.313:PCI-MSI.33626112-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.313:PCI-MSI.33628160-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.314:PCI-MSI.18874489-edge.nvme0q121
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.314:PCI-MSI.18874496-edge.nvme0q128
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.314:PCI-MSI.33628160-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.314:PCI-MSI.33630208-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.315:PCI-MSI.18874490-edge.nvme0q122
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.315:PCI-MSI.33630208-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.315:PCI-MSI.33632256-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.316:PCI-MSI.18874491-edge.nvme0q123
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.316:PCI-MSI.18874492-edge.nvme0q124
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.316:PCI-MSI.33632256-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.316:PCI-MSI.33634304-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.317:PCI-MSI.18874492-edge.nvme0q124
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.317:PCI-MSI.18874493-edge.nvme0q125
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.317:PCI-MSI.33634304-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.318:PCI-MSI.18874493-edge.nvme0q125
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.318:PCI-MSI.67174400-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.319:PCI-MSI.18874484-edge.nvme0q116
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.319:PCI-MSI.67174400-edge.ioat-msix
     23354 ±156%     +25.7%      29351 ±160%    +100.6%      46845 ±111%  interrupts.31:PCI-MSI.524289-edge.eth0-TxRx-0
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.320:PCI-MSI.67176448-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.321:PCI-MSI.18874496-edge.nvme0q128
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.321:PCI-MSI.67176448-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.321:PCI-MSI.67178496-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.322:PCI-MSI.67178496-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.322:PCI-MSI.67180544-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.323:PCI-MSI.67180544-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.323:PCI-MSI.67182592-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.324:PCI-MSI.67182592-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.324:PCI-MSI.67184640-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.325:PCI-MSI.67184640-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.325:PCI-MSI.67186688-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.326:PCI-MSI.18874491-edge.nvme0q123
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.326:PCI-MSI.67186688-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.326:PCI-MSI.67188736-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.327:PCI-MSI.67188736-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.328:PCI-MSI.100728832-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.329:PCI-MSI.100728832-edge.ioat-msix
     32722 ± 88%     -26.8%      23952 ±139%     -79.0%       6873 ±207%  interrupts.32:PCI-MSI.524290-edge.eth0-TxRx-1
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.330:PCI-MSI.100730880-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.331:PCI-MSI.100730880-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.331:PCI-MSI.100732928-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.332:PCI-MSI.100732928-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.333:PCI-MSI.100734976-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.334:PCI-MSI.100737024-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.335:PCI-MSI.100739072-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.336:PCI-MSI.100741120-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.337:PCI-MSI.100743168-edge.ioat-msix
     13213 ±162%      +1.2%      13374 ± 98%    +212.9%      41343 ±197%  interrupts.33:PCI-MSI.524291-edge.eth0-TxRx-2
     20596 ±150%     +19.3%      24575 ±151%     +19.0%      24505 ±151%  interrupts.34:PCI-MSI.524292-edge.eth0-TxRx-3
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.36:PCI-MSI.57147392-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.37:PCI-MSI.57147393-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.38:PCI-MSI.57147394-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.39:PCI-MSI.57147395-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.3:IO-APIC.3-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.40:PCI-MSI.57147396-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.41:PCI-MSI.57147397-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.42:PCI-MSI.57147398-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.43:PCI-MSI.57147399-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.44:PCI-MSI.57147400-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.45:PCI-MSI.57147401-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.46:PCI-MSI.57147402-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.47:PCI-MSI.57147403-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.48:PCI-MSI.57147404-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.49:PCI-MSI.57147405-edge
     49.33 ±  4%      +0.0%      49.33 ±  4%      +0.3%      49.50 ±  4%  interrupts.4:IO-APIC.4-edge.ttyS0
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.50:PCI-MSI.57147406-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.51:PCI-MSI.57147407-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.52:PCI-MSI.57147408-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.53:PCI-MSI.57147409-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.54:PCI-MSI.57147410-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.55:PCI-MSI.57147411-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.56:PCI-MSI.57147412-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.57:PCI-MSI.57147413-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.58:PCI-MSI.57147414-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.59:PCI-MSI.57147415-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.60:PCI-MSI.57147416-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.61:PCI-MSI.57147417-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.62:PCI-MSI.57147418-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.63:PCI-MSI.57147419-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.64:PCI-MSI.57147420-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.65:PCI-MSI.57147421-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.66:PCI-MSI.57147422-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.67:PCI-MSI.57147423-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.68:PCI-MSI.57147424-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.69:PCI-MSI.57147425-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.70:PCI-MSI.57147426-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.71:PCI-MSI.57147427-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.72:PCI-MSI.57147428-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.73:PCI-MSI.57147429-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.74:PCI-MSI.57147430-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.75:PCI-MSI.57147431-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.76:PCI-MSI.57147432-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.77:PCI-MSI.57147433-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.78:PCI-MSI.57147434-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.79:PCI-MSI.57147435-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.80:PCI-MSI.57147436-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.81:PCI-MSI.57147437-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.82:PCI-MSI.57147438-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.83:PCI-MSI.57147439-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.84:PCI-MSI.57147440-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.85:PCI-MSI.57147441-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.86:PCI-MSI.57147442-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.87:PCI-MSI.57147443-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.88:PCI-MSI.57147444-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.89:PCI-MSI.57147445-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.8:IO-APIC.8-edge.rtc0
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.90:PCI-MSI.57147446-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.91:PCI-MSI.57147447-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.92:PCI-MSI.57147448-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.93:PCI-MSI.57147449-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.94:PCI-MSI.57147450-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.95:PCI-MSI.57147451-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.96:PCI-MSI.57147452-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.97:PCI-MSI.57147453-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.98:PCI-MSI.57147454-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.9:IO-APIC.9-fasteoi.acpi
   6630826 ±  9%     -17.7%    5453867 ±  8%      +3.3%    6850206 ± 12%  interrupts.CAL:Function_call_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU0.0:IO-APIC.2-edge.timer
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU0.137:PCI-MSI.57149476-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU0.72:PCI-MSI.57147428-edge
     55399 ± 21%     -29.9%      38815 ± 27%      +2.3%      56685 ± 27%  interrupts.CPU0.CAL:Function_call_interrupts
      5.56 ± 22%     +34.0%       7.44 ± 14%      +8.0%       6.00        interrupts.CPU0.IWI:IRQ_work_interrupts
   1102714           -10.8%     983231 ±  6%      +0.2%    1105120 ±  2%  interrupts.CPU0.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU0.MCP:Machine_check_polls
      7298 ± 28%     +25.0%       9123           +13.1%       8256 ± 16%  interrupts.CPU0.NMI:Non-maskable_interrupts
      7298 ± 28%     +25.0%       9123           +13.1%       8256 ± 16%  interrupts.CPU0.PMI:Performance_monitoring_interrupts
    746123 ±  7%     -26.7%     546957 ±  5%      +1.0%     753556 ±  9%  interrupts.CPU0.RES:Rescheduling_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU0.RTR:APIC_ICR_read_retries
      2.44 ±133%     +27.3%       3.11 ± 80%     -38.6%       1.50 ± 74%  interrupts.CPU0.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU1.138:PCI-MSI.57149477-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU1.73:PCI-MSI.57147429-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU1.9:IO-APIC.9-fasteoi.acpi
     39444 ± 30%     -22.8%      30444 ± 15%      +2.0%      40237 ± 31%  interrupts.CPU1.CAL:Function_call_interrupts
      5.33 ± 24%     +25.0%       6.67 ± 14%      +6.9%       5.70 ± 15%  interrupts.CPU1.IWI:IRQ_work_interrupts
   1102676            -9.7%     995763 ±  4%      +0.2%    1105091 ±  2%  interrupts.CPU1.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU1.MCP:Machine_check_polls
      6815 ± 32%     +11.6%       7603 ± 28%      +8.4%       7389 ± 27%  interrupts.CPU1.NMI:Non-maskable_interrupts
      6815 ± 32%     +11.6%       7603 ± 28%      +8.4%       7389 ± 27%  interrupts.CPU1.PMI:Performance_monitoring_interrupts
    784722 ±  5%     -28.5%     560855 ±  7%      -6.2%     735815 ±  6%  interrupts.CPU1.RES:Rescheduling_interrupts
      2.56 ± 99%      +4.3%       2.67 ± 81%     -41.3%       1.50 ± 80%  interrupts.CPU1.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU10.147:PCI-MSI.57149486-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU10.280:PCI-MSI.18874475-edge.nvme0q107
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU10.287:PCI-MSI.18874475-edge.nvme0q107
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU10.290:PCI-MSI.18874475-edge.nvme0q107
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU10.292:PCI-MSI.18874475-edge.nvme0q107
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU10.300:PCI-MSI.18874475-edge.nvme0q107
     32722 ± 88%     -26.8%      23952 ±139%     -79.0%       6873 ±207%  interrupts.CPU10.32:PCI-MSI.524290-edge.eth0-TxRx-1
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU10.82:PCI-MSI.57147438-edge
     35479 ± 21%     -20.3%      28269 ± 12%     -14.3%      30414 ± 21%  interrupts.CPU10.CAL:Function_call_interrupts
      6.00 ± 15%     +14.8%       6.89 ± 14%      -1.7%       5.90 ± 11%  interrupts.CPU10.IWI:IRQ_work_interrupts
   1102780            -9.7%     995761 ±  4%      +0.2%    1105150 ±  2%  interrupts.CPU10.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU10.MCP:Machine_check_polls
      8265 ± 16%      -1.9%       8107 ± 23%      -5.5%       7809 ± 22%  interrupts.CPU10.NMI:Non-maskable_interrupts
      8265 ± 16%      -1.9%       8107 ± 23%      -5.5%       7809 ± 22%  interrupts.CPU10.PMI:Performance_monitoring_interrupts
    777977 ±  5%     -27.3%     565487 ±  7%      -0.8%     771446 ±  8%  interrupts.CPU10.RES:Rescheduling_interrupts
      2.56 ± 61%     +34.8%       3.44 ± 59%     -33.5%       1.70 ± 26%  interrupts.CPU10.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU100.129:PCI-MSI.57149468-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU100.163:PCI-MSI.57149502-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU100.63:PCI-MSI.57147419-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU100.64:PCI-MSI.57147420-edge
     41145 ± 24%     -11.8%      36292 ± 33%     +24.2%      51092 ± 30%  interrupts.CPU100.CAL:Function_call_interrupts
      6.00 ± 15%     +18.5%       7.11 ± 19%      -3.3%       5.80 ± 10%  interrupts.CPU100.IWI:IRQ_work_interrupts
   1102506            -9.6%     996452 ±  4%      +0.2%    1105035 ±  2%  interrupts.CPU100.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU100.MCP:Machine_check_polls
      8076 ± 17%      +6.2%       8577 ± 16%      -3.9%       7765 ± 22%  interrupts.CPU100.NMI:Non-maskable_interrupts
      8076 ± 17%      +6.2%       8577 ± 16%      -3.9%       7765 ± 22%  interrupts.CPU100.PMI:Performance_monitoring_interrupts
    934275 ±  9%     -31.1%     643337 ± 10%      -0.8%     926464 ±  3%  interrupts.CPU100.RES:Rescheduling_interrupts
      3.67 ± 54%     -12.1%       3.22 ± 56%     -23.6%       2.80 ± 44%  interrupts.CPU100.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU101.128:PCI-MSI.57149467-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU101.130:PCI-MSI.57149469-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU101.202:PCI-MSI.18874394-edge.nvme0q26
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU101.209:PCI-MSI.18874394-edge.nvme0q26
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU101.64:PCI-MSI.57147420-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU101.65:PCI-MSI.57147421-edge
     37832 ± 23%      -5.4%      35794 ± 17%     +24.8%      47203 ± 24%  interrupts.CPU101.CAL:Function_call_interrupts
      6.22 ± 10%     +14.3%       7.11 ± 19%      -6.8%       5.80 ± 10%  interrupts.CPU101.IWI:IRQ_work_interrupts
   1102513            -9.5%     997741 ±  3%      +0.2%    1104972 ±  2%  interrupts.CPU101.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU101.MCP:Machine_check_polls
      8548 ±  2%      +0.4%       8581 ± 16%      -9.1%       7768 ± 22%  interrupts.CPU101.NMI:Non-maskable_interrupts
      8548 ±  2%      +0.4%       8581 ± 16%      -9.1%       7768 ± 22%  interrupts.CPU101.PMI:Performance_monitoring_interrupts
    904681 ±  4%     -29.4%     638559 ±  9%      +1.7%     919740 ±  6%  interrupts.CPU101.RES:Rescheduling_interrupts
      3.56 ± 63%      +3.1%       3.67 ± 56%     -40.9%       2.10 ± 54%  interrupts.CPU101.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU102.129:PCI-MSI.57149468-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU102.131:PCI-MSI.57149470-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU102.199:PCI-MSI.18874395-edge.nvme0q27
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU102.205:PCI-MSI.18874395-edge.nvme0q27
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU102.211:PCI-MSI.18874395-edge.nvme0q27
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU102.65:PCI-MSI.57147421-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU102.66:PCI-MSI.57147422-edge
     49236 ± 35%     -21.1%      38854 ± 23%      -7.3%      45623 ± 27%  interrupts.CPU102.CAL:Function_call_interrupts
      6.22 ± 10%     +14.3%       7.11 ± 19%      -6.8%       5.80 ± 10%  interrupts.CPU102.IWI:IRQ_work_interrupts
   1102502            -9.6%     996451 ±  4%      +0.2%    1105027 ±  2%  interrupts.CPU102.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU102.MCP:Machine_check_polls
      8548 ±  2%      +0.3%       8577 ± 16%      -9.1%       7768 ± 22%  interrupts.CPU102.NMI:Non-maskable_interrupts
      8548 ±  2%      +0.3%       8577 ± 16%      -9.1%       7768 ± 22%  interrupts.CPU102.PMI:Performance_monitoring_interrupts
    910917 ±  5%     -29.3%     644384 ± 11%      +2.0%     929351 ±  6%  interrupts.CPU102.RES:Rescheduling_interrupts
      3.56 ± 49%      -6.2%       3.33 ± 60%     -24.1%       2.70 ± 55%  interrupts.CPU102.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU103.130:PCI-MSI.57149469-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU103.132:PCI-MSI.57149471-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU103.212:PCI-MSI.18874396-edge.nvme0q28
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU103.218:PCI-MSI.18874396-edge.nvme0q28
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU103.66:PCI-MSI.57147422-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU103.67:PCI-MSI.57147423-edge
     39322 ± 30%      -2.8%      38235 ± 18%     +28.2%      50400 ± 25%  interrupts.CPU103.CAL:Function_call_interrupts
      6.00 ± 15%     +18.5%       7.11 ± 19%      -3.3%       5.80 ± 10%  interrupts.CPU103.IWI:IRQ_work_interrupts
   1102502            -9.6%     996442 ±  4%      +0.2%    1105041 ±  2%  interrupts.CPU103.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU103.MCP:Machine_check_polls
      8076 ± 16%      +6.2%       8578 ± 16%      -3.8%       7766 ± 22%  interrupts.CPU103.NMI:Non-maskable_interrupts
      8076 ± 16%      +6.2%       8578 ± 16%      -3.8%       7766 ± 22%  interrupts.CPU103.PMI:Performance_monitoring_interrupts
    906721 ±  6%     -29.9%     635374 ± 10%      +2.7%     931443 ±  4%  interrupts.CPU103.RES:Rescheduling_interrupts
      3.67 ± 69%     +15.2%       4.22 ± 50%     -20.9%       2.90 ± 44%  interrupts.CPU103.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU104.131:PCI-MSI.57149470-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU104.133:PCI-MSI.57149472-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU104.206:PCI-MSI.18874397-edge.nvme0q29
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU104.207:PCI-MSI.18874397-edge.nvme0q29
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU104.67:PCI-MSI.57147423-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU104.68:PCI-MSI.57147424-edge
     36881 ± 19%      -4.5%      35234 ± 21%     +44.0%      53099 ± 24%  interrupts.CPU104.CAL:Function_call_interrupts
      6.00 ± 15%     +18.5%       7.11 ± 19%      -3.3%       5.80 ± 10%  interrupts.CPU104.IWI:IRQ_work_interrupts
   1102523            -9.6%     996181 ±  4%      +0.2%    1104999 ±  2%  interrupts.CPU104.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU104.MCP:Machine_check_polls
      8077 ± 16%      +6.3%       8582 ± 16%      -3.8%       7767 ± 22%  interrupts.CPU104.NMI:Non-maskable_interrupts
      8077 ± 16%      +6.3%       8582 ± 16%      -3.8%       7767 ± 22%  interrupts.CPU104.PMI:Performance_monitoring_interrupts
    904627 ±  5%     -28.9%     642866 ± 10%      +3.0%     931533 ±  7%  interrupts.CPU104.RES:Rescheduling_interrupts
      2.56 ± 78%     +47.8%       3.78 ± 58%     +33.0%       3.40 ± 49%  interrupts.CPU104.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU105.132:PCI-MSI.57149471-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU105.134:PCI-MSI.57149473-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU105.220:PCI-MSI.18874398-edge.nvme0q30
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU105.68:PCI-MSI.57147424-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU105.69:PCI-MSI.57147425-edge
     41642 ± 30%     -15.6%      35148 ± 22%     +16.2%      48373 ± 23%  interrupts.CPU105.CAL:Function_call_interrupts
      6.00 ± 15%     +22.2%       7.33 ± 12%      -3.3%       5.80 ± 10%  interrupts.CPU105.IWI:IRQ_work_interrupts
   1102532            -9.6%     996412 ±  4%      +0.2%    1105029 ±  2%  interrupts.CPU105.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU105.MCP:Machine_check_polls
      8073 ± 16%     +12.6%       9090            -3.8%       7769 ± 22%  interrupts.CPU105.NMI:Non-maskable_interrupts
      8073 ± 16%     +12.6%       9090            -3.8%       7769 ± 22%  interrupts.CPU105.PMI:Performance_monitoring_interrupts
    924656 ±  5%     -30.3%     644349 ± 12%      +1.1%     934848 ±  6%  interrupts.CPU105.RES:Rescheduling_interrupts
      2.78 ± 69%     +40.0%       3.89 ± 52%     +18.8%       3.30 ± 30%  interrupts.CPU105.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU106.133:PCI-MSI.57149472-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU106.135:PCI-MSI.57149474-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU106.209:PCI-MSI.18874399-edge.nvme0q31
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU106.69:PCI-MSI.57147425-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU106.70:PCI-MSI.57147426-edge
     37376 ± 21%      -4.3%      35767 ± 19%     +29.1%      48237 ± 25%  interrupts.CPU106.CAL:Function_call_interrupts
      6.00 ± 15%     +22.2%       7.33 ± 12%      +0.0%       6.00 ± 14%  interrupts.CPU106.IWI:IRQ_work_interrupts
   1102508            -9.6%     996242 ±  4%      +0.2%    1105030 ±  2%  interrupts.CPU106.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU106.MCP:Machine_check_polls
      8075 ± 16%     +12.5%       9088            +1.5%       8198 ± 15%  interrupts.CPU106.NMI:Non-maskable_interrupts
      8075 ± 16%     +12.5%       9088            +1.5%       8198 ± 15%  interrupts.CPU106.PMI:Performance_monitoring_interrupts
    937785 ±  5%     -32.2%     635469 ± 10%      -1.5%     923955 ±  6%  interrupts.CPU106.RES:Rescheduling_interrupts
      3.67 ± 77%      +0.0%       3.67 ± 57%     -40.0%       2.20 ± 63%  interrupts.CPU106.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU107.134:PCI-MSI.57149473-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU107.136:PCI-MSI.57149475-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU107.205:PCI-MSI.18874400-edge.nvme0q32
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU107.210:PCI-MSI.18874400-edge.nvme0q32
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU107.215:PCI-MSI.18874400-edge.nvme0q32
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU107.70:PCI-MSI.57147426-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU107.71:PCI-MSI.57147427-edge
     42184 ± 37%     -14.2%      36187 ± 27%      +3.3%      43587 ± 25%  interrupts.CPU107.CAL:Function_call_interrupts
      5.78 ± 19%     +23.1%       7.11 ± 19%      +3.8%       6.00 ± 14%  interrupts.CPU107.IWI:IRQ_work_interrupts
   1102559            -9.6%     996363 ±  4%      +0.2%    1104999 ±  2%  interrupts.CPU107.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU107.MCP:Machine_check_polls
      7604 ± 23%     +12.9%       8582 ± 16%      +7.8%       8196 ± 15%  interrupts.CPU107.NMI:Non-maskable_interrupts
      7604 ± 23%     +12.9%       8582 ± 16%      +7.8%       8196 ± 15%  interrupts.CPU107.PMI:Performance_monitoring_interrupts
    916061 ±  9%     -30.3%     638941 ± 10%      -0.1%     914783 ±  6%  interrupts.CPU107.RES:Rescheduling_interrupts
      3.78 ± 49%      -8.8%       3.44 ± 58%     -28.5%       2.70 ± 57%  interrupts.CPU107.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU108.208:PCI-MSI.18874401-edge.nvme0q33
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU108.210:PCI-MSI.18874401-edge.nvme0q33
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU108.211:PCI-MSI.18874401-edge.nvme0q33
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU108.213:PCI-MSI.18874401-edge.nvme0q33
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU108.216:PCI-MSI.18874401-edge.nvme0q33
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU108.217:PCI-MSI.18874401-edge.nvme0q33
     82469 ± 29%     -35.4%      53288 ± 21%      -3.1%      79893 ± 45%  interrupts.CPU108.CAL:Function_call_interrupts
      5.78 ± 19%     +23.1%       7.11 ± 19%      +3.8%       6.00 ± 14%  interrupts.CPU108.IWI:IRQ_work_interrupts
   1102561            -9.5%     997567 ±  4%      +0.2%    1104960 ±  2%  interrupts.CPU108.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU108.MCP:Machine_check_polls
      7914 ± 23%      +9.1%       8639 ± 16%      +8.1%       8555 ± 15%  interrupts.CPU108.NMI:Non-maskable_interrupts
      7914 ± 23%      +9.1%       8639 ± 16%      +8.1%       8555 ± 15%  interrupts.CPU108.PMI:Performance_monitoring_interrupts
    915461 ±  9%     -29.7%     643506 ±  8%      -1.5%     901762 ±  5%  interrupts.CPU108.RES:Rescheduling_interrupts
      4.00 ± 56%     +16.7%       4.67 ± 53%     -37.5%       2.50 ± 74%  interrupts.CPU108.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU109.207:PCI-MSI.18874402-edge.nvme0q34
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU109.217:PCI-MSI.18874402-edge.nvme0q34
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU109.219:PCI-MSI.18874402-edge.nvme0q34
     60697 ± 26%     -26.5%      44601 ± 22%     -12.9%      52840 ± 27%  interrupts.CPU109.CAL:Function_call_interrupts
      5.78 ± 19%     +19.2%       6.89 ± 19%      +0.4%       5.80 ± 18%  interrupts.CPU109.IWI:IRQ_work_interrupts
   1102554            -9.5%     997624 ±  4%      +0.2%    1105003 ±  2%  interrupts.CPU109.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU109.MCP:Machine_check_polls
      7912 ± 23%      +2.7%       8126 ± 23%      +2.4%       8099 ± 22%  interrupts.CPU109.NMI:Non-maskable_interrupts
      7912 ± 23%      +2.7%       8126 ± 23%      +2.4%       8099 ± 22%  interrupts.CPU109.PMI:Performance_monitoring_interrupts
    903462 ±  9%     -27.7%     653182 ±  6%      -1.3%     892052 ±  6%  interrupts.CPU109.RES:Rescheduling_interrupts
      3.56 ± 59%     +53.1%       5.44 ± 37%     -49.4%       1.80 ± 48%  interrupts.CPU109.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU11.148:PCI-MSI.57149487-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU11.280:PCI-MSI.18874476-edge.nvme0q108
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU11.286:PCI-MSI.18874476-edge.nvme0q108
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU11.291:PCI-MSI.18874476-edge.nvme0q108
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU11.293:PCI-MSI.18874476-edge.nvme0q108
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU11.311:PCI-MSI.18874476-edge.nvme0q108
     13213 ±162%      +1.2%      13374 ± 98%    +212.9%      41343 ±197%  interrupts.CPU11.33:PCI-MSI.524291-edge.eth0-TxRx-2
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU11.83:PCI-MSI.57147439-edge
     29370 ± 21%      -7.2%      27256 ± 10%     +14.6%      33653 ± 23%  interrupts.CPU11.CAL:Function_call_interrupts
      5.78 ± 19%     +26.9%       7.33 ± 11%      +0.4%       5.80 ± 10%  interrupts.CPU11.IWI:IRQ_work_interrupts
   1102677            -9.7%     995733 ±  4%      +0.2%    1105163 ±  2%  interrupts.CPU11.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU11.MCP:Machine_check_polls
      7799 ± 24%     +10.5%       8617 ± 16%      +0.1%       7806 ± 22%  interrupts.CPU11.NMI:Non-maskable_interrupts
      7799 ± 24%     +10.5%       8617 ± 16%      +0.1%       7806 ± 22%  interrupts.CPU11.PMI:Performance_monitoring_interrupts
    768171 ±  6%     -26.0%     568345 ±  7%      +0.1%     768626 ±  8%  interrupts.CPU11.RES:Rescheduling_interrupts
      2.44 ± 47%      -4.5%       2.33 ± 67%     -50.9%       1.20 ± 97%  interrupts.CPU11.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU110.213:PCI-MSI.18874403-edge.nvme0q35
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU110.218:PCI-MSI.18874403-edge.nvme0q35
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU110.220:PCI-MSI.18874403-edge.nvme0q35
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU110.228:PCI-MSI.18874403-edge.nvme0q35
     58212 ± 52%     -28.7%      41507 ± 23%      -7.1%      54075 ± 39%  interrupts.CPU110.CAL:Function_call_interrupts
      6.00 ± 15%     +14.8%       6.89 ± 19%      -6.7%       5.60 ± 14%  interrupts.CPU110.IWI:IRQ_work_interrupts
   1102572            -9.5%     997700 ±  4%      +0.2%    1105046 ±  2%  interrupts.CPU110.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU110.MCP:Machine_check_polls
      8403 ± 16%      -3.3%       8129 ± 23%      -8.9%       7653 ± 27%  interrupts.CPU110.NMI:Non-maskable_interrupts
      8403 ± 16%      -3.3%       8129 ± 23%      -8.9%       7653 ± 27%  interrupts.CPU110.PMI:Performance_monitoring_interrupts
    919791 ±  7%     -28.4%     658294 ±  8%      +0.5%     924445 ±  4%  interrupts.CPU110.RES:Rescheduling_interrupts
      4.78 ± 61%     -16.3%       4.00 ± 45%     -47.7%       2.50 ± 89%  interrupts.CPU110.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU111.209:PCI-MSI.18874404-edge.nvme0q36
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU111.212:PCI-MSI.18874404-edge.nvme0q36
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU111.213:PCI-MSI.18874404-edge.nvme0q36
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU111.221:PCI-MSI.18874404-edge.nvme0q36
     49580 ± 25%     -16.4%      41464 ± 25%      +9.9%      54464 ± 47%  interrupts.CPU111.CAL:Function_call_interrupts
      6.00 ± 15%     +14.8%       6.89 ± 19%      -3.3%       5.80 ± 10%  interrupts.CPU111.IWI:IRQ_work_interrupts
   1102564            -9.5%     997903 ±  3%      +0.2%    1105042 ±  2%  interrupts.CPU111.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU111.MCP:Machine_check_polls
      8401 ± 16%      -3.3%       8126 ± 23%      -3.4%       8114 ± 22%  interrupts.CPU111.NMI:Non-maskable_interrupts
      8401 ± 16%      -3.3%       8126 ± 23%      -3.4%       8114 ± 22%  interrupts.CPU111.PMI:Performance_monitoring_interrupts
    898192 ±  5%     -28.0%     646582 ±  7%      +3.6%     930140 ±  4%  interrupts.CPU111.RES:Rescheduling_interrupts
      3.44 ± 53%     +48.4%       5.11 ± 29%     -24.5%       2.60 ± 64%  interrupts.CPU111.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU112.228:PCI-MSI.18874419-edge.nvme0q51
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU112.231:PCI-MSI.18874419-edge.nvme0q51
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU112.234:PCI-MSI.18874419-edge.nvme0q51
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU112.237:PCI-MSI.18874419-edge.nvme0q51
     47780 ± 26%     -13.8%      41165 ± 18%      +4.8%      50082 ± 37%  interrupts.CPU112.CAL:Function_call_interrupts
      6.00 ± 15%     +14.8%       6.89 ± 19%      -3.3%       5.80 ± 10%  interrupts.CPU112.IWI:IRQ_work_interrupts
   1102542            -9.6%     996821 ±  4%      +0.2%    1104977 ±  2%  interrupts.CPU112.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU112.MCP:Machine_check_polls
      8403 ± 16%      -3.3%       8127 ± 23%      -3.5%       8111 ± 22%  interrupts.CPU112.NMI:Non-maskable_interrupts
      8403 ± 16%      -3.3%       8127 ± 23%      -3.5%       8111 ± 22%  interrupts.CPU112.PMI:Performance_monitoring_interrupts
    944807 ±  7%     -31.8%     644421 ±  8%      -5.5%     892855 ±  6%  interrupts.CPU112.RES:Rescheduling_interrupts
      3.89 ± 59%     +37.1%       5.33 ± 21%     -35.7%       2.50 ± 62%  interrupts.CPU112.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU113.235:PCI-MSI.18874420-edge.nvme0q52
     46500 ± 18%     -11.8%      41028 ± 22%      +3.2%      48010 ± 37%  interrupts.CPU113.CAL:Function_call_interrupts
      6.00 ± 15%     +14.8%       6.89 ± 19%     -10.0%       5.40 ± 16%  interrupts.CPU113.IWI:IRQ_work_interrupts
   1102537            -9.5%     997780 ±  3%      +0.2%    1105017 ±  2%  interrupts.CPU113.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU113.MCP:Machine_check_polls
      8398 ± 16%      -3.2%       8127 ± 23%     -14.1%       7213 ± 30%  interrupts.CPU113.NMI:Non-maskable_interrupts
      8398 ± 16%      -3.2%       8127 ± 23%     -14.1%       7213 ± 30%  interrupts.CPU113.PMI:Performance_monitoring_interrupts
    918203 ±  5%     -28.9%     652664 ±  7%      -1.2%     906913 ±  6%  interrupts.CPU113.RES:Rescheduling_interrupts
      3.56 ± 49%     +28.1%       4.56 ± 54%     -12.8%       3.10 ± 82%  interrupts.CPU113.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU114.237:PCI-MSI.18874421-edge.nvme0q53
     43378 ± 20%     -16.4%      36276 ± 20%      +9.2%      47386 ± 37%  interrupts.CPU114.CAL:Function_call_interrupts
      6.00 ± 15%     +14.8%       6.89 ± 19%      +0.0%       6.00 ± 14%  interrupts.CPU114.IWI:IRQ_work_interrupts
   1102516            -9.5%     997913 ±  3%      +0.2%    1105014 ±  2%  interrupts.CPU114.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU114.MCP:Machine_check_polls
      8428 ± 17%      -3.6%       8123 ± 23%      +1.5%       8553 ± 15%  interrupts.CPU114.NMI:Non-maskable_interrupts
      8428 ± 17%      -3.6%       8123 ± 23%      +1.5%       8553 ± 15%  interrupts.CPU114.PMI:Performance_monitoring_interrupts
    940077 ±  8%     -29.3%     664222 ±  7%      -0.6%     934759 ±  3%  interrupts.CPU114.RES:Rescheduling_interrupts
      3.78 ± 40%     +26.5%       4.78 ± 48%     -28.5%       2.70 ± 81%  interrupts.CPU114.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU115.229:PCI-MSI.18874422-edge.nvme0q54
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU115.230:PCI-MSI.18874422-edge.nvme0q54
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU115.231:PCI-MSI.18874422-edge.nvme0q54
     57071 ± 38%     -37.2%      35826 ± 19%     -22.2%      44415 ± 31%  interrupts.CPU115.CAL:Function_call_interrupts
      6.00 ± 15%     +14.8%       6.89 ± 19%      -6.7%       5.60 ± 21%  interrupts.CPU115.IWI:IRQ_work_interrupts
   1102559            -9.5%     997983 ±  3%      +0.2%    1105014 ±  2%  interrupts.CPU115.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU115.MCP:Machine_check_polls
      8428 ± 17%      -3.6%       8127 ± 23%      -9.2%       7654 ± 26%  interrupts.CPU115.NMI:Non-maskable_interrupts
      8428 ± 17%      -3.6%       8127 ± 23%      -9.2%       7654 ± 26%  interrupts.CPU115.PMI:Performance_monitoring_interrupts
    947266 ±  6%     -30.0%     663289 ±  8%      -5.5%     895063 ±  4%  interrupts.CPU115.RES:Rescheduling_interrupts
      3.89 ± 54%      -5.7%       3.67 ± 48%     -43.4%       2.20 ± 72%  interrupts.CPU115.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU116.231:PCI-MSI.18874423-edge.nvme0q55
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU116.241:PCI-MSI.18874423-edge.nvme0q55
     55231 ± 31%     -26.5%      40586 ± 23%     -15.9%      46431 ± 28%  interrupts.CPU116.CAL:Function_call_interrupts
      6.22 ± 10%     +10.7%       6.89 ± 19%      -3.6%       6.00 ± 14%  interrupts.CPU116.IWI:IRQ_work_interrupts
   1102529            -9.5%     997730 ±  4%      +0.2%    1104987 ±  2%  interrupts.CPU116.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU116.MCP:Machine_check_polls
      8901 ±  2%      -8.7%       8124 ± 23%      -3.9%       8554 ± 15%  interrupts.CPU116.NMI:Non-maskable_interrupts
      8901 ±  2%      -8.7%       8124 ± 23%      -3.9%       8554 ± 15%  interrupts.CPU116.PMI:Performance_monitoring_interrupts
    947922 ±  8%     -31.9%     645162 ±  6%      -6.0%     891130 ±  5%  interrupts.CPU116.RES:Rescheduling_interrupts
      3.22 ± 66%     +20.7%       3.89 ± 37%     -28.6%       2.30 ± 72%  interrupts.CPU116.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU117.233:PCI-MSI.18874424-edge.nvme0q56
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU117.242:PCI-MSI.18874424-edge.nvme0q56
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU117.249:PCI-MSI.18874424-edge.nvme0q56
     49915 ± 25%     -19.2%      40318 ± 28%     -12.5%      43658 ± 31%  interrupts.CPU117.CAL:Function_call_interrupts
      6.22 ± 10%     +10.7%       6.89 ± 19%      -3.6%       6.00 ± 14%  interrupts.CPU117.IWI:IRQ_work_interrupts
   1102524            -9.5%     997803 ±  3%      +0.2%    1104994 ±  2%  interrupts.CPU117.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU117.MCP:Machine_check_polls
      8903 ±  2%      -8.7%       8124 ± 23%      -3.9%       8554 ± 15%  interrupts.CPU117.NMI:Non-maskable_interrupts
      8903 ±  2%      -8.7%       8124 ± 23%      -3.9%       8554 ± 15%  interrupts.CPU117.PMI:Performance_monitoring_interrupts
    928151 ±  6%     -29.1%     658427 ±  8%      -3.5%     895252 ±  5%  interrupts.CPU117.RES:Rescheduling_interrupts
      4.33 ± 55%      -5.1%       4.11 ± 37%     -40.0%       2.60 ± 64%  interrupts.CPU117.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU118.232:PCI-MSI.18874425-edge.nvme0q57
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU118.237:PCI-MSI.18874425-edge.nvme0q57
     48737 ± 31%     -21.6%      38188 ± 19%      +1.8%      49631 ± 33%  interrupts.CPU118.CAL:Function_call_interrupts
      6.22 ± 10%     +10.7%       6.89 ± 19%      -3.6%       6.00 ± 14%  interrupts.CPU118.IWI:IRQ_work_interrupts
   1102555            -9.5%     997997 ±  3%      +0.2%    1105010 ±  2%  interrupts.CPU118.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU118.MCP:Machine_check_polls
      8902 ±  2%      -8.7%       8126 ± 23%      -3.9%       8554 ± 15%  interrupts.CPU118.NMI:Non-maskable_interrupts
      8902 ±  2%      -8.7%       8126 ± 23%      -3.9%       8554 ± 15%  interrupts.CPU118.PMI:Performance_monitoring_interrupts
    932216 ±  8%     -26.9%     681123 ±  6%      -0.3%     929847 ±  4%  interrupts.CPU118.RES:Rescheduling_interrupts
      3.22 ± 69%     +20.7%       3.89 ± 44%     -16.2%       2.70 ± 46%  interrupts.CPU118.TLB:TLB_shootdowns
     46716 ± 31%     -16.4%      39056 ± 22%     -10.6%      41778 ± 31%  interrupts.CPU119.CAL:Function_call_interrupts
      6.00 ± 15%     +18.5%       7.11 ± 19%      +0.0%       6.00 ± 14%  interrupts.CPU119.IWI:IRQ_work_interrupts
   1102545            -9.5%     997901 ±  3%      +0.2%    1104987 ±  2%  interrupts.CPU119.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU119.MCP:Machine_check_polls
      8428 ± 17%      +2.5%       8636 ± 16%      +1.5%       8553 ± 15%  interrupts.CPU119.NMI:Non-maskable_interrupts
      8428 ± 17%      +2.5%       8636 ± 16%      +1.5%       8553 ± 15%  interrupts.CPU119.PMI:Performance_monitoring_interrupts
    947687 ±  6%     -30.2%     661930 ±  7%      -3.2%     917545 ±  6%  interrupts.CPU119.RES:Rescheduling_interrupts
      3.56 ± 66%     +15.6%       4.11 ± 31%     -35.3%       2.30 ± 75%  interrupts.CPU119.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU12.149:PCI-MSI.57149488-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU12.287:PCI-MSI.18874477-edge.nvme0q109
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU12.292:PCI-MSI.18874477-edge.nvme0q109
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU12.312:PCI-MSI.18874477-edge.nvme0q109
     20596 ±150%     +19.3%      24575 ±151%     +19.0%      24505 ±151%  interrupts.CPU12.34:PCI-MSI.524292-edge.eth0-TxRx-3
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU12.84:PCI-MSI.57147440-edge
     30255 ± 18%     -11.1%      26895 ± 15%      -0.3%      30170 ± 22%  interrupts.CPU12.CAL:Function_call_interrupts
      6.00 ± 15%     +18.5%       7.11 ± 13%      -1.7%       5.90 ± 11%  interrupts.CPU12.IWI:IRQ_work_interrupts
   1102702            -9.7%     995592 ±  4%      +0.2%    1105164 ±  2%  interrupts.CPU12.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU12.MCP:Machine_check_polls
      8268 ± 16%      +4.1%       8609 ± 16%      -5.6%       7806 ± 22%  interrupts.CPU12.NMI:Non-maskable_interrupts
      8268 ± 16%      +4.1%       8609 ± 16%      -5.6%       7806 ± 22%  interrupts.CPU12.PMI:Performance_monitoring_interrupts
    777472 ±  3%     -28.2%     558574 ±  9%      -1.4%     766568 ± 11%  interrupts.CPU12.RES:Rescheduling_interrupts
      3.56 ± 78%     -40.6%       2.11 ± 84%     -46.6%       1.90 ± 76%  interrupts.CPU12.TLB:TLB_shootdowns
     46701 ± 29%     -21.9%      36471 ± 17%      +0.2%      46808 ± 23%  interrupts.CPU120.CAL:Function_call_interrupts
      6.22 ± 10%     +14.3%       7.11 ± 19%      -3.6%       6.00 ± 14%  interrupts.CPU120.IWI:IRQ_work_interrupts
   1102548            -9.5%     997901 ±  3%      +0.2%    1105016 ±  2%  interrupts.CPU120.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU120.MCP:Machine_check_polls
      8901 ±  2%      -3.0%       8638 ± 16%      -3.9%       8554 ± 15%  interrupts.CPU120.NMI:Non-maskable_interrupts
      8901 ±  2%      -3.0%       8638 ± 16%      -3.9%       8554 ± 15%  interrupts.CPU120.PMI:Performance_monitoring_interrupts
    938338 ±  4%     -30.5%     652316 ±  6%      -2.6%     914379 ±  4%  interrupts.CPU120.RES:Rescheduling_interrupts
      3.33 ± 37%     +26.7%       4.22 ± 41%     -31.0%       2.30 ± 51%  interrupts.CPU120.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU121.236:PCI-MSI.18874428-edge.nvme0q60
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU121.240:PCI-MSI.18874428-edge.nvme0q60
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU121.241:PCI-MSI.18874428-edge.nvme0q60
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU121.243:PCI-MSI.18874428-edge.nvme0q60
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU121.253:PCI-MSI.18874428-edge.nvme0q60
     54337 ± 28%     -30.4%      37799 ± 20%     -16.7%      45255 ± 36%  interrupts.CPU121.CAL:Function_call_interrupts
      6.00 ± 15%     +18.5%       7.11 ± 19%      -3.3%       5.80 ± 18%  interrupts.CPU121.IWI:IRQ_work_interrupts
   1102553            -9.5%     997911 ±  3%      +0.2%    1104973 ±  2%  interrupts.CPU121.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU121.MCP:Machine_check_polls
      8428 ± 17%      +2.5%       8636 ± 16%      -3.9%       8097 ± 21%  interrupts.CPU121.NMI:Non-maskable_interrupts
      8428 ± 17%      +2.5%       8636 ± 16%      -3.9%       8097 ± 21%  interrupts.CPU121.PMI:Performance_monitoring_interrupts
    911472 ±  7%     -27.6%     659912 ±  8%      -0.0%     911193 ±  5%  interrupts.CPU121.RES:Rescheduling_interrupts
      4.33 ± 72%     +12.8%       4.89 ± 32%     -37.7%       2.70 ± 55%  interrupts.CPU121.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU122.247:PCI-MSI.18874429-edge.nvme0q61
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU122.254:PCI-MSI.18874429-edge.nvme0q61
     56611 ± 51%     -25.8%      42005 ± 24%     -18.7%      46000 ± 39%  interrupts.CPU122.CAL:Function_call_interrupts
      6.22 ± 10%     +14.3%       7.11 ± 19%      -6.8%       5.80 ± 18%  interrupts.CPU122.IWI:IRQ_work_interrupts
   1102553            -9.5%     997999 ±  3%      +0.2%    1104993 ±  2%  interrupts.CPU122.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU122.MCP:Machine_check_polls
      8902 ±  2%      -3.0%       8637 ± 16%      -9.0%       8097 ± 21%  interrupts.CPU122.NMI:Non-maskable_interrupts
      8902 ±  2%      -3.0%       8637 ± 16%      -9.0%       8097 ± 21%  interrupts.CPU122.PMI:Performance_monitoring_interrupts
    956675 ±  7%     -31.1%     658757 ±  5%      -3.2%     925872 ±  7%  interrupts.CPU122.RES:Rescheduling_interrupts
      3.89 ± 54%     +17.1%       4.56 ± 37%     -46.0%       2.10 ± 68%  interrupts.CPU122.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU123.237:PCI-MSI.18874430-edge.nvme0q62
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU123.245:PCI-MSI.18874430-edge.nvme0q62
     50973 ± 33%     -17.7%      41956 ± 24%      +0.2%      51099 ± 63%  interrupts.CPU123.CAL:Function_call_interrupts
      6.00 ± 15%     +18.5%       7.11 ± 19%      -3.3%       5.80 ± 18%  interrupts.CPU123.IWI:IRQ_work_interrupts
   1102514            -9.5%     998032 ±  3%      +0.2%    1105008 ±  2%  interrupts.CPU123.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU123.MCP:Machine_check_polls
      8428 ± 17%      +2.5%       8639 ± 16%      -3.9%       8098 ± 21%  interrupts.CPU123.NMI:Non-maskable_interrupts
      8428 ± 17%      +2.5%       8639 ± 16%      -3.9%       8098 ± 21%  interrupts.CPU123.PMI:Performance_monitoring_interrupts
    947025 ±  6%     -28.9%     673288 ±  8%      -4.4%     905360 ±  5%  interrupts.CPU123.RES:Rescheduling_interrupts
      3.78 ± 42%     +17.6%       4.44 ± 49%     -47.1%       2.00 ± 74%  interrupts.CPU123.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU124.239:PCI-MSI.18874431-edge.nvme0q63
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU124.256:PCI-MSI.18874431-edge.nvme0q63
     51753 ± 37%     -24.0%      39354 ± 22%     -10.9%      46115 ± 25%  interrupts.CPU124.CAL:Function_call_interrupts
      6.00 ± 15%     +22.2%       7.33 ± 12%      -1.7%       5.90 ± 19%  interrupts.CPU124.IWI:IRQ_work_interrupts
   1102564            -9.5%     997854 ±  3%      +0.2%    1104993 ±  2%  interrupts.CPU124.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU124.MCP:Machine_check_polls
      8429 ± 17%      +8.6%       9151            -3.9%       8100 ± 21%  interrupts.CPU124.NMI:Non-maskable_interrupts
      8429 ± 17%      +8.6%       9151            -3.9%       8100 ± 21%  interrupts.CPU124.PMI:Performance_monitoring_interrupts
    938469 ±  7%     -29.0%     666571 ±  8%      -4.2%     899190 ±  4%  interrupts.CPU124.RES:Rescheduling_interrupts
      4.11 ± 38%     +18.9%       4.89 ± 17%     -46.5%       2.20 ± 78%  interrupts.CPU124.TLB:TLB_shootdowns
     47773 ± 35%     -13.8%      41194 ± 22%      -0.1%      47701 ± 36%  interrupts.CPU125.CAL:Function_call_interrupts
      5.78 ± 19%     +26.9%       7.33 ± 12%      +0.4%       5.80 ± 18%  interrupts.CPU125.IWI:IRQ_work_interrupts
   1102545            -9.5%     998060 ±  3%      +0.2%    1104947 ±  2%  interrupts.CPU125.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU125.MCP:Machine_check_polls
      7927 ± 23%     +15.4%       9149            +2.1%       8096 ± 21%  interrupts.CPU125.NMI:Non-maskable_interrupts
      7927 ± 23%     +15.4%       9149            +2.1%       8096 ± 21%  interrupts.CPU125.PMI:Performance_monitoring_interrupts
    913977 ±  8%     -28.8%     650736 ±  8%      +0.9%     922025 ±  5%  interrupts.CPU125.RES:Rescheduling_interrupts
      4.00 ± 64%     +19.4%       4.78 ± 32%     -40.0%       2.40 ± 59%  interrupts.CPU125.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU126.238:PCI-MSI.18874433-edge.nvme0q65
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU126.245:PCI-MSI.18874433-edge.nvme0q65
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU126.248:PCI-MSI.18874433-edge.nvme0q65
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU126.268:PCI-MSI.18874433-edge.nvme0q65
     75656 ± 29%     -21.5%      59386 ± 26%      +9.2%      82653 ± 34%  interrupts.CPU126.CAL:Function_call_interrupts
      6.00 ± 15%     +20.4%       7.22 ± 15%      -3.3%       5.80 ± 18%  interrupts.CPU126.IWI:IRQ_work_interrupts
   1102677            -9.6%     997140 ±  4%      +0.2%    1104936 ±  2%  interrupts.CPU126.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU126.MCP:Machine_check_polls
      8302 ± 16%      +3.7%       8611 ± 16%      -4.4%       7936 ± 21%  interrupts.CPU126.NMI:Non-maskable_interrupts
      8302 ± 16%      +3.7%       8611 ± 16%      -4.4%       7936 ± 21%  interrupts.CPU126.PMI:Performance_monitoring_interrupts
    876461 ±  4%     -28.0%     630803 ± 12%      -0.9%     868463 ±  4%  interrupts.CPU126.RES:Rescheduling_interrupts
      3.89 ± 58%      +0.0%       3.89 ± 63%     -35.7%       2.50 ± 62%  interrupts.CPU126.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU127.242:PCI-MSI.18874434-edge.nvme0q66
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU127.243:PCI-MSI.18874434-edge.nvme0q66
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU127.259:PCI-MSI.18874434-edge.nvme0q66
     60614 ± 28%     -17.5%      50036 ± 20%      +3.1%      62487 ± 39%  interrupts.CPU127.CAL:Function_call_interrupts
      5.78 ± 19%     +19.2%       6.89 ± 19%      +0.4%       5.80 ± 18%  interrupts.CPU127.IWI:IRQ_work_interrupts
   1102621            -9.6%     997252 ±  4%      +0.2%    1104913 ±  2%  interrupts.CPU127.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU127.MCP:Machine_check_polls
      7814 ± 23%      +3.6%       8095 ± 23%      +1.6%       7935 ± 21%  interrupts.CPU127.NMI:Non-maskable_interrupts
      7814 ± 23%      +3.6%       8095 ± 23%      +1.6%       7935 ± 21%  interrupts.CPU127.PMI:Performance_monitoring_interrupts
    881571 ±  6%     -24.4%     666479 ± 11%      +0.0%     881590 ±  4%  interrupts.CPU127.RES:Rescheduling_interrupts
      4.33 ± 64%      +5.1%       4.56 ± 53%     -53.8%       2.00 ± 63%  interrupts.CPU127.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU128.245:PCI-MSI.18874435-edge.nvme0q67
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU128.253:PCI-MSI.18874435-edge.nvme0q67
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU128.260:PCI-MSI.18874435-edge.nvme0q67
     48925 ± 31%      -8.4%      44808 ± 29%     +13.6%      55598 ± 21%  interrupts.CPU128.CAL:Function_call_interrupts
      5.78 ± 19%     +19.2%       6.89 ± 19%      +3.8%       6.00 ± 14%  interrupts.CPU128.IWI:IRQ_work_interrupts
   1102694            -9.5%     997488 ±  4%      +0.2%    1104911 ±  2%  interrupts.CPU128.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU128.MCP:Machine_check_polls
      7819 ± 23%      +3.5%       8095 ± 23%      +7.1%       8377 ± 15%  interrupts.CPU128.NMI:Non-maskable_interrupts
      7819 ± 23%      +3.5%       8095 ± 23%      +7.1%       8377 ± 15%  interrupts.CPU128.PMI:Performance_monitoring_interrupts
    906589 ±  4%     -28.0%     653179 ± 10%      -0.6%     901046 ±  5%  interrupts.CPU128.RES:Rescheduling_interrupts
      3.33 ± 66%     +13.3%       3.78 ± 55%     -40.0%       2.00 ± 67%  interrupts.CPU128.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU129.241:PCI-MSI.18874436-edge.nvme0q68
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU129.248:PCI-MSI.18874436-edge.nvme0q68
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU129.251:PCI-MSI.18874436-edge.nvme0q68
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU129.252:PCI-MSI.18874436-edge.nvme0q68
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU129.253:PCI-MSI.18874436-edge.nvme0q68
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU129.254:PCI-MSI.18874436-edge.nvme0q68
     46858 ± 28%      -8.0%      43099 ± 27%     +25.1%      58620 ± 31%  interrupts.CPU129.CAL:Function_call_interrupts
      5.78 ± 19%     +23.1%       7.11 ± 13%      +0.4%       5.80 ± 18%  interrupts.CPU129.IWI:IRQ_work_interrupts
   1102636            -9.5%     997376 ±  4%      +0.2%    1104910 ±  2%  interrupts.CPU129.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU129.MCP:Machine_check_polls
      7820 ± 23%     +10.0%       8603 ± 16%      +1.4%       7929 ± 21%  interrupts.CPU129.NMI:Non-maskable_interrupts
      7820 ± 23%     +10.0%       8603 ± 16%      +1.4%       7929 ± 21%  interrupts.CPU129.PMI:Performance_monitoring_interrupts
    902285 ±  5%     -26.3%     664856 ± 12%      -1.5%     889194 ±  7%  interrupts.CPU129.RES:Rescheduling_interrupts
      4.44 ± 64%     -15.0%       3.78 ± 54%     -52.8%       2.10 ± 58%  interrupts.CPU129.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU13.150:PCI-MSI.57149489-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU13.288:PCI-MSI.18874478-edge.nvme0q110
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU13.290:PCI-MSI.18874478-edge.nvme0q110
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU13.291:PCI-MSI.18874478-edge.nvme0q110
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU13.295:PCI-MSI.18874478-edge.nvme0q110
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU13.302:PCI-MSI.18874478-edge.nvme0q110
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU13.303:PCI-MSI.18874478-edge.nvme0q110
     49.33 ±  4%      +0.0%      49.33 ±  4%      +0.3%      49.50 ±  4%  interrupts.CPU13.4:IO-APIC.4-edge.ttyS0
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU13.85:PCI-MSI.57147441-edge
     33514 ± 22%     -19.7%      26901 ±  9%     -19.6%      26933 ± 26%  interrupts.CPU13.CAL:Function_call_interrupts
      6.11 ± 16%     +16.4%       7.11 ± 13%      -1.8%       6.00 ± 14%  interrupts.CPU13.IWI:IRQ_work_interrupts
   1102611            -9.7%     995379 ±  4%      +0.2%    1105051 ±  2%  interrupts.CPU13.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU13.MCP:Machine_check_polls
      8268 ± 16%      +4.2%       8615 ± 16%      -0.5%       8227 ± 15%  interrupts.CPU13.NMI:Non-maskable_interrupts
      8268 ± 16%      +4.2%       8615 ± 16%      -0.5%       8227 ± 15%  interrupts.CPU13.PMI:Performance_monitoring_interrupts
    763486 ±  7%     -26.9%     557852 ±  7%      -3.4%     737639 ±  9%  interrupts.CPU13.RES:Rescheduling_interrupts
      3.00 ± 62%     -11.1%       2.67 ± 61%     -66.7%       1.00 ±126%  interrupts.CPU13.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU130.267:PCI-MSI.18874451-edge.nvme0q83
     47672 ± 36%     -10.3%      42765 ± 28%      +5.4%      50232 ± 32%  interrupts.CPU130.CAL:Function_call_interrupts
      5.78 ± 19%     +19.2%       6.89 ± 19%      +0.4%       5.80 ± 18%  interrupts.CPU130.IWI:IRQ_work_interrupts
   1102625            -9.5%     997413 ±  4%      +0.2%    1104964 ±  2%  interrupts.CPU130.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU130.MCP:Machine_check_polls
      7817 ± 23%      +3.5%       8094 ± 23%      +1.4%       7927 ± 21%  interrupts.CPU130.NMI:Non-maskable_interrupts
      7817 ± 23%      +3.5%       8094 ± 23%      +1.4%       7927 ± 21%  interrupts.CPU130.PMI:Performance_monitoring_interrupts
    911078 ±  3%     -27.8%     658136 ± 11%      +1.3%     922492 ±  6%  interrupts.CPU130.RES:Rescheduling_interrupts
      3.89 ± 52%     +17.1%       4.56 ± 59%     -48.6%       2.00 ± 67%  interrupts.CPU130.TLB:TLB_shootdowns
     40643 ± 34%      -1.1%      40210 ± 32%     +18.3%      48069 ± 24%  interrupts.CPU131.CAL:Function_call_interrupts
      5.78 ± 19%     +15.4%       6.67 ± 24%      +0.4%       5.80 ± 18%  interrupts.CPU131.IWI:IRQ_work_interrupts
   1102682            -9.6%     997366 ±  4%      +0.2%    1104919 ±  2%  interrupts.CPU131.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU131.MCP:Machine_check_polls
      7819 ± 23%      -3.1%       7579 ± 27%      +1.4%       7928 ± 21%  interrupts.CPU131.NMI:Non-maskable_interrupts
      7819 ± 23%      -3.1%       7579 ± 27%      +1.4%       7928 ± 21%  interrupts.CPU131.PMI:Performance_monitoring_interrupts
    919379 ±  3%     -28.9%     653351 ± 11%      -2.5%     896081 ±  6%  interrupts.CPU131.RES:Rescheduling_interrupts
      4.44 ± 47%     +27.5%       5.67 ± 62%     -39.2%       2.70 ± 59%  interrupts.CPU131.TLB:TLB_shootdowns
     49919 ± 43%     -23.9%      37984 ± 25%     -10.1%      44871 ± 31%  interrupts.CPU132.CAL:Function_call_interrupts
      5.56 ± 22%     +24.0%       6.89 ± 19%      +4.4%       5.80 ± 18%  interrupts.CPU132.IWI:IRQ_work_interrupts
   1102653            -9.5%     997513 ±  4%      +0.2%    1104962 ±  2%  interrupts.CPU132.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU132.MCP:Machine_check_polls
      7337 ± 28%     +10.3%       8092 ± 23%      +8.0%       7927 ± 21%  interrupts.CPU132.NMI:Non-maskable_interrupts
      7337 ± 28%     +10.3%       8092 ± 23%      +8.0%       7927 ± 21%  interrupts.CPU132.PMI:Performance_monitoring_interrupts
    915073 ±  5%     -27.9%     659558 ± 10%      +2.7%     939851 ±  8%  interrupts.CPU132.RES:Rescheduling_interrupts
      5.11 ± 74%     -34.8%       3.33 ± 54%     -39.3%       3.10 ± 56%  interrupts.CPU132.TLB:TLB_shootdowns
     45712 ± 27%     -18.2%      37385 ± 19%      +1.3%      46300 ± 28%  interrupts.CPU133.CAL:Function_call_interrupts
      5.56 ± 22%     +32.0%       7.33 ± 12%      +4.4%       5.80 ± 18%  interrupts.CPU133.IWI:IRQ_work_interrupts
   1102635            -9.5%     997515 ±  4%      +0.2%    1104941 ±  2%  interrupts.CPU133.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU133.MCP:Machine_check_polls
      7337 ± 28%     +24.2%       9113            +8.1%       7931 ± 21%  interrupts.CPU133.NMI:Non-maskable_interrupts
      7337 ± 28%     +24.2%       9113            +8.1%       7931 ± 21%  interrupts.CPU133.PMI:Performance_monitoring_interrupts
    916019 ±  7%     -27.8%     661346 ± 10%      -0.4%     912275 ±  5%  interrupts.CPU133.RES:Rescheduling_interrupts
      4.00 ± 47%     -11.1%       3.56 ± 56%     -37.5%       2.50 ± 57%  interrupts.CPU133.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU134.270:PCI-MSI.18874455-edge.nvme0q87
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU134.271:PCI-MSI.18874455-edge.nvme0q87
     46897 ± 37%     -13.0%      40818 ± 29%      -5.7%      44230 ± 20%  interrupts.CPU134.CAL:Function_call_interrupts
      5.78 ± 19%     +23.1%       7.11 ± 19%      +3.8%       6.00 ± 14%  interrupts.CPU134.IWI:IRQ_work_interrupts
   1102663            -9.5%     997627 ±  4%      +0.2%    1104928 ±  2%  interrupts.CPU134.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU134.MCP:Machine_check_polls
      7822 ± 23%     +10.0%       8603 ± 16%      +7.2%       8388 ± 15%  interrupts.CPU134.NMI:Non-maskable_interrupts
      7822 ± 23%     +10.0%       8603 ± 16%      +7.2%       8388 ± 15%  interrupts.CPU134.PMI:Performance_monitoring_interrupts
    927280 ±  4%     -28.7%     661168 ± 10%      -1.0%     917676 ±  4%  interrupts.CPU134.RES:Rescheduling_interrupts
      3.89 ± 52%     +25.7%       4.89 ± 51%     -28.0%       2.80 ± 67%  interrupts.CPU134.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU135.281:PCI-MSI.18874456-edge.nvme0q88
     40611 ± 29%      -8.7%      37080 ± 28%     +16.0%      47116 ± 35%  interrupts.CPU135.CAL:Function_call_interrupts
      5.78 ± 10%     +19.2%       6.89 ± 19%      +0.4%       5.80 ± 18%  interrupts.CPU135.IWI:IRQ_work_interrupts
   1102607            -9.5%     997481 ±  4%      +0.2%    1104948 ±  2%  interrupts.CPU135.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU135.MCP:Machine_check_polls
      7802 ± 23%      +3.7%       8092 ± 23%      +1.9%       7953 ± 22%  interrupts.CPU135.NMI:Non-maskable_interrupts
      7802 ± 23%      +3.7%       8092 ± 23%      +1.9%       7953 ± 22%  interrupts.CPU135.PMI:Performance_monitoring_interrupts
    913768 ±  5%     -28.0%     657743 ± 10%      -1.4%     900856 ±  6%  interrupts.CPU135.RES:Rescheduling_interrupts
      4.00 ± 44%     +19.4%       4.78 ± 52%     -50.0%       2.00 ± 83%  interrupts.CPU135.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU136.265:PCI-MSI.18874457-edge.nvme0q89
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU136.267:PCI-MSI.18874457-edge.nvme0q89
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU136.269:PCI-MSI.18874457-edge.nvme0q89
     46658 ± 38%     -15.6%      39371 ± 23%      -2.6%      45426 ± 25%  interrupts.CPU136.CAL:Function_call_interrupts
      6.00 ± 15%     +16.7%       7.00 ± 19%      -3.3%       5.80 ± 18%  interrupts.CPU136.IWI:IRQ_work_interrupts
   1102636            -9.5%     997335 ±  4%      +0.2%    1104933 ±  2%  interrupts.CPU136.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU136.MCP:Machine_check_polls
      8302 ± 16%      -2.5%       8094 ± 23%      -4.3%       7943 ± 22%  interrupts.CPU136.NMI:Non-maskable_interrupts
      8302 ± 16%      -2.5%       8094 ± 23%      -4.3%       7943 ± 22%  interrupts.CPU136.PMI:Performance_monitoring_interrupts
    928400 ±  4%     -29.3%     656488 ± 10%      -2.9%     901714 ±  7%  interrupts.CPU136.RES:Rescheduling_interrupts
      3.89 ± 63%     +20.0%       4.67 ± 58%     -40.9%       2.30 ± 64%  interrupts.CPU136.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU137.265:PCI-MSI.18874458-edge.nvme0q90
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU137.268:PCI-MSI.18874458-edge.nvme0q90
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU137.273:PCI-MSI.18874458-edge.nvme0q90
     43953 ± 48%      -5.5%      41537 ± 24%      +8.4%      47629 ± 37%  interrupts.CPU137.CAL:Function_call_interrupts
      5.78 ± 19%     +23.1%       7.11 ± 13%      +7.3%       6.20 ±  9%  interrupts.CPU137.IWI:IRQ_work_interrupts
   1102655            -9.5%     997494 ±  4%      +0.2%    1104907 ±  2%  interrupts.CPU137.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU137.MCP:Machine_check_polls
      7834 ± 24%      +9.8%       8602 ± 16%     +12.8%       8836        interrupts.CPU137.NMI:Non-maskable_interrupts
      7834 ± 24%      +9.8%       8602 ± 16%     +12.8%       8836        interrupts.CPU137.PMI:Performance_monitoring_interrupts
    926353 ±  6%     -27.6%     670423 ± 12%      -0.8%     918583 ±  6%  interrupts.CPU137.RES:Rescheduling_interrupts
      4.22 ± 55%      +0.0%       4.22 ± 58%     -36.1%       2.70 ± 66%  interrupts.CPU137.TLB:TLB_shootdowns
     43327 ± 26%     -13.0%      37683 ± 26%      +8.3%      46940 ± 36%  interrupts.CPU138.CAL:Function_call_interrupts
      6.00 ± 15%     +18.5%       7.11 ± 13%      +0.0%       6.00 ± 14%  interrupts.CPU138.IWI:IRQ_work_interrupts
   1102649            -9.6%     997323 ±  4%      +0.2%    1104926 ±  2%  interrupts.CPU138.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU138.MCP:Machine_check_polls
      8305 ± 17%      +3.6%       8603 ± 16%      +1.1%       8395 ± 15%  interrupts.CPU138.NMI:Non-maskable_interrupts
      8305 ± 17%      +3.6%       8603 ± 16%      +1.1%       8395 ± 15%  interrupts.CPU138.PMI:Performance_monitoring_interrupts
    905953 ±  4%     -24.4%     685210 ± 11%      +0.0%     906389 ±  5%  interrupts.CPU138.RES:Rescheduling_interrupts
      3.89 ± 42%      +2.9%       4.00 ± 64%     -28.0%       2.80 ± 38%  interrupts.CPU138.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU139.270:PCI-MSI.18874460-edge.nvme0q92
     40690 ± 27%      -5.9%      38293 ± 28%      +3.4%      42070 ± 22%  interrupts.CPU139.CAL:Function_call_interrupts
      6.00 ± 15%     +18.5%       7.11 ± 19%      +0.0%       6.00 ± 14%  interrupts.CPU139.IWI:IRQ_work_interrupts
   1102668            -9.5%     997412 ±  4%      +0.2%    1104946 ±  2%  interrupts.CPU139.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU139.MCP:Machine_check_polls
      8301 ± 16%      +3.6%       8602 ± 16%      +1.1%       8394 ± 15%  interrupts.CPU139.NMI:Non-maskable_interrupts
      8301 ± 16%      +3.6%       8602 ± 16%      +1.1%       8394 ± 15%  interrupts.CPU139.PMI:Performance_monitoring_interrupts
    907989 ±  3%     -29.3%     641746 ± 10%      -3.1%     879850 ±  5%  interrupts.CPU139.RES:Rescheduling_interrupts
      3.33 ± 61%     +16.7%       3.89 ± 63%     -31.0%       2.30 ± 58%  interrupts.CPU139.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU14.151:PCI-MSI.57149490-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU14.167:PCI-MSI.65536-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU14.283:PCI-MSI.18874479-edge.nvme0q111
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU14.294:PCI-MSI.18874479-edge.nvme0q111
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU14.296:PCI-MSI.18874479-edge.nvme0q111
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU14.301:PCI-MSI.18874479-edge.nvme0q111
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU14.304:PCI-MSI.18874479-edge.nvme0q111
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU14.86:PCI-MSI.57147442-edge
     31565 ± 15%      -9.7%      28504 ± 21%      -0.4%      31429 ± 34%  interrupts.CPU14.CAL:Function_call_interrupts
      6.00 ± 15%     +18.5%       7.11 ± 13%      +3.3%       6.20 ±  9%  interrupts.CPU14.IWI:IRQ_work_interrupts
   1102608            -9.7%     995674 ±  4%      +0.2%    1105071 ±  2%  interrupts.CPU14.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU14.MCP:Machine_check_polls
      8280 ± 17%      +4.0%       8612 ± 16%      +4.8%       8675 ±  2%  interrupts.CPU14.NMI:Non-maskable_interrupts
      8280 ± 17%      +4.0%       8612 ± 16%      +4.8%       8675 ±  2%  interrupts.CPU14.PMI:Performance_monitoring_interrupts
    763051 ±  7%     -25.4%     569448 ±  7%      -0.4%     759933 ±  6%  interrupts.CPU14.RES:Rescheduling_interrupts
      2.22 ± 62%     +30.0%       2.89 ± 64%     -28.0%       1.60 ±108%  interrupts.CPU14.TLB:TLB_shootdowns
     46438 ± 31%     -18.6%      37806 ± 28%      +4.3%      48441 ± 26%  interrupts.CPU140.CAL:Function_call_interrupts
      5.78 ± 19%     +23.1%       7.11 ± 19%      +3.8%       6.00 ± 14%  interrupts.CPU140.IWI:IRQ_work_interrupts
   1102652            -9.5%     997492 ±  4%      +0.2%    1104930 ±  2%  interrupts.CPU140.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU140.MCP:Machine_check_polls
      7822 ± 23%     +10.0%       8604 ± 16%      +7.3%       8391 ± 15%  interrupts.CPU140.NMI:Non-maskable_interrupts
      7822 ± 23%     +10.0%       8604 ± 16%      +7.3%       8391 ± 15%  interrupts.CPU140.PMI:Performance_monitoring_interrupts
    895818 ±  4%     -25.7%     665999 ±  9%      -0.5%     891270 ±  4%  interrupts.CPU140.RES:Rescheduling_interrupts
      4.00 ± 42%     -16.7%       3.33 ± 39%     -42.5%       2.30 ± 51%  interrupts.CPU140.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU141.269:PCI-MSI.18874462-edge.nvme0q94
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU141.270:PCI-MSI.18874462-edge.nvme0q94
     49194 ± 50%     -15.5%      41568 ± 30%      +4.0%      51158 ± 20%  interrupts.CPU141.CAL:Function_call_interrupts
      5.78 ± 19%     +23.1%       7.11 ± 19%      +0.4%       5.80 ± 18%  interrupts.CPU141.IWI:IRQ_work_interrupts
   1102571            -9.5%     997536 ±  4%      +0.2%    1104970 ±  2%  interrupts.CPU141.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU141.MCP:Machine_check_polls
      7818 ± 23%     +10.1%       8604 ± 16%      +1.7%       7955 ± 22%  interrupts.CPU141.NMI:Non-maskable_interrupts
      7818 ± 23%     +10.1%       8604 ± 16%      +1.7%       7955 ± 22%  interrupts.CPU141.PMI:Performance_monitoring_interrupts
    913766 ±  4%     -27.5%     662106 ± 10%      +1.6%     928230 ±  5%  interrupts.CPU141.RES:Rescheduling_interrupts
      4.33 ± 40%     +17.9%       5.11 ± 50%     -49.2%       2.20 ± 44%  interrupts.CPU141.TLB:TLB_shootdowns
     46959 ± 42%     -18.1%      38446 ± 24%      +5.7%      49615 ± 33%  interrupts.CPU142.CAL:Function_call_interrupts
      5.78 ± 19%     +26.9%       7.33 ± 12%      +3.8%       6.00 ± 14%  interrupts.CPU142.IWI:IRQ_work_interrupts
   1102607            -9.5%     997591 ±  4%      +0.2%    1104911 ±  2%  interrupts.CPU142.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU142.MCP:Machine_check_polls
      7818 ± 23%     +16.6%       9117            +7.4%       8395 ± 15%  interrupts.CPU142.NMI:Non-maskable_interrupts
      7818 ± 23%     +16.6%       9117            +7.4%       8395 ± 15%  interrupts.CPU142.PMI:Performance_monitoring_interrupts
    892546 ±  3%     -24.3%     675904 ± 10%      +2.4%     914324 ±  7%  interrupts.CPU142.RES:Rescheduling_interrupts
      3.78 ± 42%     +29.4%       4.89 ± 59%     -20.6%       3.00 ± 49%  interrupts.CPU142.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU143.269:PCI-MSI.18874464-edge.nvme0q96
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU143.274:PCI-MSI.18874464-edge.nvme0q96
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU143.281:PCI-MSI.18874464-edge.nvme0q96
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU143.289:PCI-MSI.18874464-edge.nvme0q96
     44888 ± 29%     -16.2%      37615 ± 30%      +6.3%      47700 ± 38%  interrupts.CPU143.CAL:Function_call_interrupts
      5.78 ± 19%     +23.1%       7.11 ± 13%      +5.6%       6.10 ± 17%  interrupts.CPU143.IWI:IRQ_work_interrupts
   1102662            -9.5%     997455 ±  4%      +0.2%    1104921 ±  2%  interrupts.CPU143.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU143.MCP:Machine_check_polls
      7817 ± 23%     +10.0%       8602 ± 16%      +7.4%       8397 ± 15%  interrupts.CPU143.NMI:Non-maskable_interrupts
      7817 ± 23%     +10.0%       8602 ± 16%      +7.4%       8397 ± 15%  interrupts.CPU143.PMI:Performance_monitoring_interrupts
    895613 ±  3%     -28.8%     638091 ± 10%      -1.1%     885675 ±  5%  interrupts.CPU143.RES:Rescheduling_interrupts
      2.44 ± 51%     +13.6%       2.78 ± 71%     -22.3%       1.90 ± 83%  interrupts.CPU143.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU15.152:PCI-MSI.57149491-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU15.169:PCI-MSI.67584-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU15.285:PCI-MSI.18874480-edge.nvme0q112
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU15.290:PCI-MSI.18874480-edge.nvme0q112
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU15.292:PCI-MSI.18874480-edge.nvme0q112
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU15.297:PCI-MSI.18874480-edge.nvme0q112
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU15.304:PCI-MSI.18874480-edge.nvme0q112
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU15.305:PCI-MSI.18874480-edge.nvme0q112
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU15.87:PCI-MSI.57147443-edge
     32247 ± 35%     -15.4%      27294 ± 13%     -14.8%      27460 ± 12%  interrupts.CPU15.CAL:Function_call_interrupts
      6.00 ± 15%     +11.1%       6.67 ± 14%      +3.3%       6.20 ±  9%  interrupts.CPU15.IWI:IRQ_work_interrupts
   1102633            -9.7%     995574 ±  4%      +0.2%    1105082 ±  2%  interrupts.CPU15.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU15.MCP:Machine_check_polls
      8266 ± 16%      -8.0%       7605 ± 28%      +4.9%       8674 ±  2%  interrupts.CPU15.NMI:Non-maskable_interrupts
      8266 ± 16%      -8.0%       7605 ± 28%      +4.9%       8674 ±  2%  interrupts.CPU15.PMI:Performance_monitoring_interrupts
    766894 ±  3%     -25.7%     570157 ±  6%      -2.6%     746749 ±  8%  interrupts.CPU15.RES:Rescheduling_interrupts
      2.33 ± 72%     -14.3%       2.00 ± 57%     -40.0%       1.40 ± 85%  interrupts.CPU15.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU16.153:PCI-MSI.57149492-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU16.170:PCI-MSI.67584-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU16.170:PCI-MSI.69632-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU16.172:PCI-MSI.67584-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU16.291:PCI-MSI.18874481-edge.nvme0q113
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU16.293:PCI-MSI.18874481-edge.nvme0q113
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU16.294:PCI-MSI.18874481-edge.nvme0q113
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU16.296:PCI-MSI.18874481-edge.nvme0q113
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU16.88:PCI-MSI.57147444-edge
     38035 ± 51%     -29.9%      26647 ± 17%     -28.2%      27307 ± 20%  interrupts.CPU16.CAL:Function_call_interrupts
      5.78 ± 19%     +23.1%       7.11 ± 13%      +3.8%       6.00 ± 14%  interrupts.CPU16.IWI:IRQ_work_interrupts
   1102625            -9.7%     995313 ±  4%      +0.2%    1105036 ±  2%  interrupts.CPU16.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU16.MCP:Machine_check_polls
      7769 ± 23%     +10.8%       8612 ± 16%      +6.0%       8234 ± 15%  interrupts.CPU16.NMI:Non-maskable_interrupts
      7769 ± 23%     +10.8%       8612 ± 16%      +6.0%       8234 ± 15%  interrupts.CPU16.PMI:Performance_monitoring_interrupts
    750637 ±  6%     -25.4%     560046 ±  8%      +4.3%     783025 ±  6%  interrupts.CPU16.RES:Rescheduling_interrupts
      2.67 ± 58%     +45.8%       3.89 ± 58%     -43.8%       1.50 ± 68%  interrupts.CPU16.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU17.154:PCI-MSI.57149493-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU17.170:PCI-MSI.18874368-edge.nvme0q0
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU17.171:PCI-MSI.69632-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU17.171:PCI-MSI.71680-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU17.173:PCI-MSI.69632-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU17.173:PCI-MSI.71680-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU17.297:PCI-MSI.18874482-edge.nvme0q114
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU17.298:PCI-MSI.18874482-edge.nvme0q114
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU17.89:PCI-MSI.57147445-edge
     29590 ± 27%     -11.4%      26228 ± 13%      -9.1%      26888 ± 21%  interrupts.CPU17.CAL:Function_call_interrupts
      6.22 ± 18%     +12.5%       7.00 ± 16%      -5.2%       5.90 ± 22%  interrupts.CPU17.IWI:IRQ_work_interrupts
   1102648            -9.7%     995400 ±  4%      +0.2%    1105087 ±  2%  interrupts.CPU17.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU17.MCP:Machine_check_polls
      8267 ± 16%      -1.9%       8113 ± 23%      -5.9%       7784 ± 21%  interrupts.CPU17.NMI:Non-maskable_interrupts
      8267 ± 16%      -1.9%       8113 ± 23%      -5.9%       7784 ± 21%  interrupts.CPU17.PMI:Performance_monitoring_interrupts
    757138 ±  3%     -25.0%     567699 ±  7%      -0.3%     754990 ±  8%  interrupts.CPU17.RES:Rescheduling_interrupts
      2.33 ± 67%     +19.0%       2.78 ± 55%     -40.0%       1.40 ± 72%  interrupts.CPU17.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU18.101:PCI-MSI.57149440-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU18.135:PCI-MSI.57149474-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU18.36:PCI-MSI.57147392-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU18.71:PCI-MSI.57147427-edge
    109217 ± 35%     -25.3%      81594 ± 19%      -2.2%     106846 ± 30%  interrupts.CPU18.CAL:Function_call_interrupts
      6.22 ± 10%     +14.3%       7.11 ± 13%     -10.0%       5.60 ± 21%  interrupts.CPU18.IWI:IRQ_work_interrupts
   1102575            -9.6%     996356 ±  4%      +0.2%    1105026 ±  2%  interrupts.CPU18.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU18.MCP:Machine_check_polls
      8543 ±  2%      +0.5%       8582 ± 16%     -13.9%       7355 ± 27%  interrupts.CPU18.NMI:Non-maskable_interrupts
      8543 ±  2%      +0.5%       8582 ± 16%     -13.9%       7355 ± 27%  interrupts.CPU18.PMI:Performance_monitoring_interrupts
    852148 ±  8%     -27.8%     614872 ±  8%      +3.0%     877944 ±  5%  interrupts.CPU18.RES:Rescheduling_interrupts
      2.78 ± 62%     +24.0%       3.44 ± 56%     -20.8%       2.20 ± 63%  interrupts.CPU18.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU19.101:PCI-MSI.57149440-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU19.102:PCI-MSI.57149441-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU19.136:PCI-MSI.57149475-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU19.176:PCI-MSI.33619968-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU19.177:PCI-MSI.33619968-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU19.178:PCI-MSI.33619968-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU19.179:PCI-MSI.33619968-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU19.180:PCI-MSI.33619968-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU19.308:PCI-MSI.33619968-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU19.309:PCI-MSI.33619968-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU19.36:PCI-MSI.57147392-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU19.37:PCI-MSI.57147393-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU19.72:PCI-MSI.57147428-edge
     63596 ± 32%     -16.9%      52854 ± 19%      +3.6%      65885 ± 22%  interrupts.CPU19.CAL:Function_call_interrupts
      6.22 ± 10%     +14.3%       7.11 ± 13%      -3.6%       6.00 ± 14%  interrupts.CPU19.IWI:IRQ_work_interrupts
   1102547            -9.6%     996237 ±  4%      +0.2%    1105017 ±  2%  interrupts.CPU19.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU19.MCP:Machine_check_polls
      8545 ±  2%      +0.4%       8581 ± 16%      -3.9%       8210 ± 16%  interrupts.CPU19.NMI:Non-maskable_interrupts
      8545 ±  2%      +0.4%       8581 ± 16%      -3.9%       8210 ± 16%  interrupts.CPU19.PMI:Performance_monitoring_interrupts
    904135 ±  5%     -29.5%     637100 ± 10%      +2.2%     923926 ±  5%  interrupts.CPU19.RES:Rescheduling_interrupts
      2.56 ± 80%      +0.0%       2.56 ± 45%      -6.1%       2.40 ± 81%  interrupts.CPU19.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU2.139:PCI-MSI.57149478-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU2.74:PCI-MSI.57147430-edge
     34356 ± 28%     -21.7%      26897 ± 10%      +5.5%      36229 ± 35%  interrupts.CPU2.CAL:Function_call_interrupts
      5.89 ± 20%      +9.4%       6.44 ± 12%      -4.9%       5.60 ± 21%  interrupts.CPU2.IWI:IRQ_work_interrupts
   1102671            -9.7%     995758 ±  4%      +0.2%    1105057 ±  2%  interrupts.CPU2.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU2.MCP:Machine_check_polls
      7770 ± 23%      -8.6%       7098 ± 32%      -5.1%       7376 ± 27%  interrupts.CPU2.NMI:Non-maskable_interrupts
      7770 ± 23%      -8.6%       7098 ± 32%      -5.1%       7376 ± 27%  interrupts.CPU2.PMI:Performance_monitoring_interrupts
    767594 ±  3%     -26.6%     563496 ±  9%      +1.2%     776979 ±  7%  interrupts.CPU2.RES:Rescheduling_interrupts
      3.00 ± 75%     -14.8%       2.56 ± 45%     -33.3%       2.00 ± 54%  interrupts.CPU2.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU20.102:PCI-MSI.57149441-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU20.103:PCI-MSI.57149442-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU20.137:PCI-MSI.57149476-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU20.179:PCI-MSI.33622016-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU20.180:PCI-MSI.33622016-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU20.181:PCI-MSI.33622016-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU20.182:PCI-MSI.33622016-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU20.183:PCI-MSI.33622016-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU20.310:PCI-MSI.33622016-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU20.311:PCI-MSI.33622016-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU20.37:PCI-MSI.57147393-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU20.38:PCI-MSI.57147394-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU20.73:PCI-MSI.57147429-edge
     47890 ± 29%     -13.0%      41649 ± 22%     +35.3%      64786 ± 34%  interrupts.CPU20.CAL:Function_call_interrupts
      6.00 ± 15%     +18.5%       7.11 ± 13%      +0.0%       6.00 ± 14%  interrupts.CPU20.IWI:IRQ_work_interrupts
   1102548            -9.6%     996437 ±  4%      +0.2%    1105031 ±  2%  interrupts.CPU20.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU20.MCP:Machine_check_polls
      8078 ± 17%      +6.2%       8580 ± 16%      +1.6%       8210 ± 16%  interrupts.CPU20.NMI:Non-maskable_interrupts
      8078 ± 17%      +6.2%       8580 ± 16%      +1.6%       8210 ± 16%  interrupts.CPU20.PMI:Performance_monitoring_interrupts
    929661 ±  6%     -30.5%     646450 ±  9%      +1.8%     946568 ±  5%  interrupts.CPU20.RES:Rescheduling_interrupts
      3.00 ± 38%      +0.0%       3.00 ± 52%     +23.3%       3.70 ± 58%  interrupts.CPU20.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU21.103:PCI-MSI.57149442-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU21.104:PCI-MSI.57149443-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU21.138:PCI-MSI.57149477-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU21.180:PCI-MSI.33624064-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU21.181:PCI-MSI.33624064-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU21.183:PCI-MSI.33624064-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU21.310:PCI-MSI.33624064-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU21.311:PCI-MSI.33624064-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU21.312:PCI-MSI.33624064-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU21.38:PCI-MSI.57147394-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU21.39:PCI-MSI.57147395-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU21.74:PCI-MSI.57147430-edge
     54350 ± 35%     -24.0%      41308 ± 28%     +13.9%      61881 ± 29%  interrupts.CPU21.CAL:Function_call_interrupts
      6.00 ± 15%     +18.5%       7.11 ± 13%      +0.0%       6.00 ± 14%  interrupts.CPU21.IWI:IRQ_work_interrupts
   1102545            -9.6%     996373 ±  4%      +0.2%    1105015 ±  2%  interrupts.CPU21.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU21.MCP:Machine_check_polls
      8080 ± 17%      +6.2%       8582 ± 16%      +1.6%       8210 ± 16%  interrupts.CPU21.NMI:Non-maskable_interrupts
      8080 ± 17%      +6.2%       8582 ± 16%      +1.6%       8210 ± 16%  interrupts.CPU21.PMI:Performance_monitoring_interrupts
    945007 ±  5%     -31.7%     645225 ± 10%      -0.4%     940883 ±  4%  interrupts.CPU21.RES:Rescheduling_interrupts
      2.67 ± 61%      +4.2%       2.78 ± 69%     -10.0%       2.40 ± 65%  interrupts.CPU21.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU22.104:PCI-MSI.57149443-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU22.105:PCI-MSI.57149444-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU22.139:PCI-MSI.57149478-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU22.180:PCI-MSI.33626112-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU22.181:PCI-MSI.33626112-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU22.182:PCI-MSI.33626112-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU22.183:PCI-MSI.18874373-edge.nvme0q5
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU22.184:PCI-MSI.33626112-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU22.189:PCI-MSI.18874373-edge.nvme0q5
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU22.312:PCI-MSI.33626112-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU22.313:PCI-MSI.33626112-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU22.39:PCI-MSI.57147395-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU22.40:PCI-MSI.57147396-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU22.75:PCI-MSI.57147431-edge
     43579 ± 22%      -7.4%      40358 ± 25%     +15.9%      50515 ± 28%  interrupts.CPU22.CAL:Function_call_interrupts
      6.00 ± 15%     +22.2%       7.33 ± 12%      +0.0%       6.00 ± 14%  interrupts.CPU22.IWI:IRQ_work_interrupts
   1102568            -9.6%     996434 ±  4%      +0.2%    1105028 ±  2%  interrupts.CPU22.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU22.MCP:Machine_check_polls
      8081 ± 17%     +12.4%       9086            +1.6%       8209 ± 16%  interrupts.CPU22.NMI:Non-maskable_interrupts
      8081 ± 17%     +12.4%       9086            +1.6%       8209 ± 16%  interrupts.CPU22.PMI:Performance_monitoring_interrupts
    940286 ±  5%     -30.1%     656916 ± 11%      +0.2%     941948 ±  4%  interrupts.CPU22.RES:Rescheduling_interrupts
      2.56 ± 76%     +17.4%       3.00 ± 56%      -6.1%       2.40 ± 65%  interrupts.CPU22.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU23.105:PCI-MSI.57149444-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU23.106:PCI-MSI.57149445-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU23.140:PCI-MSI.57149479-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU23.182:PCI-MSI.33628160-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU23.183:PCI-MSI.33628160-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU23.184:PCI-MSI.18874374-edge.nvme0q6
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU23.185:PCI-MSI.33628160-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU23.189:PCI-MSI.18874374-edge.nvme0q6
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU23.226:PCI-MSI.33628160-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU23.236:PCI-MSI.33628160-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU23.275:PCI-MSI.33628160-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU23.313:PCI-MSI.33628160-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU23.314:PCI-MSI.33628160-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU23.40:PCI-MSI.57147396-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU23.41:PCI-MSI.57147397-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU23.76:PCI-MSI.57147432-edge
     44095 ± 30%     -10.0%      39703 ± 24%     +10.9%      48893 ± 23%  interrupts.CPU23.CAL:Function_call_interrupts
      6.00 ± 15%     +22.2%       7.33 ± 12%      -3.3%       5.80 ± 18%  interrupts.CPU23.IWI:IRQ_work_interrupts
   1102535            -9.6%     996370 ±  4%      +0.2%    1105015 ±  2%  interrupts.CPU23.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU23.MCP:Machine_check_polls
      8082 ± 17%     +12.4%       9086            -3.7%       7786 ± 22%  interrupts.CPU23.NMI:Non-maskable_interrupts
      8082 ± 17%     +12.4%       9086            -3.7%       7786 ± 22%  interrupts.CPU23.PMI:Performance_monitoring_interrupts
    912167 ±  4%     -28.5%     651864 ±  9%      +1.1%     922557 ±  4%  interrupts.CPU23.RES:Rescheduling_interrupts
      2.78 ± 75%      -4.0%       2.67 ± 49%     -17.2%       2.30 ± 82%  interrupts.CPU23.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU24.106:PCI-MSI.57149445-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU24.107:PCI-MSI.57149446-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU24.141:PCI-MSI.57149480-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU24.184:PCI-MSI.33630208-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU24.185:PCI-MSI.33630208-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU24.190:PCI-MSI.18874375-edge.nvme0q7
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU24.200:PCI-MSI.18874375-edge.nvme0q7
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU24.314:PCI-MSI.33630208-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU24.315:PCI-MSI.33630208-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU24.41:PCI-MSI.57147397-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU24.42:PCI-MSI.57147398-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU24.77:PCI-MSI.57147433-edge
     42496 ± 29%     -16.7%      35399 ± 21%     +24.3%      52832 ± 41%  interrupts.CPU24.CAL:Function_call_interrupts
      6.22 ± 10%     +14.3%       7.11 ± 19%      -0.4%       6.20 ±  9%  interrupts.CPU24.IWI:IRQ_work_interrupts
   1102552            -9.6%     996387 ±  4%      +0.2%    1104996 ±  2%  interrupts.CPU24.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU24.MCP:Machine_check_polls
      8545 ±  2%      +0.6%       8598 ± 16%      +1.0%       8631        interrupts.CPU24.NMI:Non-maskable_interrupts
      8545 ±  2%      +0.6%       8598 ± 16%      +1.0%       8631        interrupts.CPU24.PMI:Performance_monitoring_interrupts
    949990 ±  6%     -31.8%     648351 ±  9%      +0.6%     955543 ±  4%  interrupts.CPU24.RES:Rescheduling_interrupts
      3.22 ± 71%     -10.3%       2.89 ± 62%     -19.3%       2.60 ± 64%  interrupts.CPU24.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU25.107:PCI-MSI.57149446-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU25.108:PCI-MSI.57149447-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU25.142:PCI-MSI.57149481-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU25.180:PCI-MSI.18874376-edge.nvme0q8
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU25.181:PCI-MSI.18874376-edge.nvme0q8
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU25.185:PCI-MSI.18874376-edge.nvme0q8
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU25.185:PCI-MSI.33632256-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU25.186:PCI-MSI.33632256-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU25.315:PCI-MSI.33632256-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU25.316:PCI-MSI.33632256-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU25.42:PCI-MSI.57147398-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU25.43:PCI-MSI.57147399-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU25.78:PCI-MSI.57147434-edge
     44621 ± 29%     -13.8%      38479 ± 33%     +12.5%      50205 ± 30%  interrupts.CPU25.CAL:Function_call_interrupts
      6.00 ± 15%     +14.8%       6.89 ± 19%      +0.0%       6.00 ± 14%  interrupts.CPU25.IWI:IRQ_work_interrupts
   1102533            -9.6%     996362 ±  4%      +0.2%    1104981 ±  2%  interrupts.CPU25.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU25.MCP:Machine_check_polls
      8081 ± 17%      -0.1%       8070 ± 23%      +1.6%       8207 ± 16%  interrupts.CPU25.NMI:Non-maskable_interrupts
      8081 ± 17%      -0.1%       8070 ± 23%      +1.6%       8207 ± 16%  interrupts.CPU25.PMI:Performance_monitoring_interrupts
    930169 ±  6%     -29.3%     657616 ± 10%      +0.1%     930812 ±  5%  interrupts.CPU25.RES:Rescheduling_interrupts
      3.22 ± 66%      +0.0%       3.22 ± 74%     -31.7%       2.20 ± 78%  interrupts.CPU25.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU26.108:PCI-MSI.57149447-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU26.109:PCI-MSI.57149448-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU26.143:PCI-MSI.57149482-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU26.186:PCI-MSI.33634304-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU26.188:PCI-MSI.33634304-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU26.194:PCI-MSI.18874377-edge.nvme0q9
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU26.316:PCI-MSI.33634304-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU26.317:PCI-MSI.33634304-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU26.43:PCI-MSI.57147399-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU26.44:PCI-MSI.57147400-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU26.79:PCI-MSI.57147435-edge
     46230 ± 29%     -23.7%      35254 ± 25%     +18.6%      54817 ± 30%  interrupts.CPU26.CAL:Function_call_interrupts
      6.22 ± 10%     +10.7%       6.89 ± 19%      -0.4%       6.20 ±  9%  interrupts.CPU26.IWI:IRQ_work_interrupts
   1102527            -9.6%     996369 ±  4%      +0.2%    1105005 ±  2%  interrupts.CPU26.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU26.MCP:Machine_check_polls
      8543 ±  2%      -5.5%       8072 ± 23%      +1.1%       8632        interrupts.CPU26.NMI:Non-maskable_interrupts
      8543 ±  2%      -5.5%       8072 ± 23%      +1.1%       8632        interrupts.CPU26.PMI:Performance_monitoring_interrupts
    929484 ±  5%     -29.1%     659280 ±  9%      +1.8%     946243 ±  6%  interrupts.CPU26.RES:Rescheduling_interrupts
      2.56 ± 94%      -4.3%       2.44 ± 61%     -45.2%       1.40 ±120%  interrupts.CPU26.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU27.109:PCI-MSI.57149448-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU27.110:PCI-MSI.57149449-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU27.144:PCI-MSI.57149483-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU27.193:PCI-MSI.18874378-edge.nvme0q10
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU27.203:PCI-MSI.18874378-edge.nvme0q10
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU27.44:PCI-MSI.57147400-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU27.45:PCI-MSI.57147401-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU27.80:PCI-MSI.57147436-edge
     44078 ± 31%     -14.6%      37654 ± 25%     +13.3%      49954 ± 24%  interrupts.CPU27.CAL:Function_call_interrupts
      6.22 ± 10%     +12.5%       7.00 ± 21%      -3.6%       6.00 ± 14%  interrupts.CPU27.IWI:IRQ_work_interrupts
   1102533            -9.6%     996388 ±  4%      +0.2%    1105006 ±  2%  interrupts.CPU27.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU27.MCP:Machine_check_polls
      8545 ±  2%      -5.5%       8076 ± 23%      -3.9%       8210 ± 16%  interrupts.CPU27.NMI:Non-maskable_interrupts
      8545 ±  2%      -5.5%       8076 ± 23%      -3.9%       8210 ± 16%  interrupts.CPU27.PMI:Performance_monitoring_interrupts
    930352 ±  7%     -29.9%     651711 ±  8%      +0.5%     934876 ±  6%  interrupts.CPU27.RES:Rescheduling_interrupts
      3.22 ± 58%     +20.7%       3.89 ± 74%     -31.7%       2.20 ± 72%  interrupts.CPU27.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU28.110:PCI-MSI.57149449-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU28.111:PCI-MSI.57149450-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU28.145:PCI-MSI.57149484-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU28.194:PCI-MSI.18874379-edge.nvme0q11
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU28.195:PCI-MSI.18874379-edge.nvme0q11
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU28.45:PCI-MSI.57147401-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU28.46:PCI-MSI.57147402-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU28.81:PCI-MSI.57147437-edge
     42345 ± 27%     -13.6%      36594 ± 27%     +14.3%      48413 ± 27%  interrupts.CPU28.CAL:Function_call_interrupts
      6.44 ± 12%      +3.4%       6.67 ± 19%      -3.8%       6.20 ±  9%  interrupts.CPU28.IWI:IRQ_work_interrupts
   1102530            -9.6%     996319 ±  4%      +0.2%    1105027 ±  2%  interrupts.CPU28.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU28.MCP:Machine_check_polls
      8548 ±  2%     -11.5%       7563 ± 28%      +1.0%       8632        interrupts.CPU28.NMI:Non-maskable_interrupts
      8548 ±  2%     -11.5%       7563 ± 28%      +1.0%       8632        interrupts.CPU28.PMI:Performance_monitoring_interrupts
    928411 ±  6%     -29.6%     653510 ±  8%      +0.7%     934806 ±  6%  interrupts.CPU28.RES:Rescheduling_interrupts
      2.56 ± 37%     +30.4%       3.33 ± 61%      -2.2%       2.50 ± 69%  interrupts.CPU28.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU29.111:PCI-MSI.57149450-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU29.112:PCI-MSI.57149451-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU29.146:PCI-MSI.57149485-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU29.184:PCI-MSI.18874380-edge.nvme0q12
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU29.190:PCI-MSI.18874380-edge.nvme0q12
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU29.46:PCI-MSI.57147402-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU29.47:PCI-MSI.57147403-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU29.82:PCI-MSI.57147438-edge
     38926 ± 23%     -11.7%      34372 ± 20%     +21.1%      47134 ± 29%  interrupts.CPU29.CAL:Function_call_interrupts
      6.22 ± 10%      +7.1%       6.67 ± 19%      -0.4%       6.20 ±  9%  interrupts.CPU29.IWI:IRQ_work_interrupts
   1102600           -10.0%     992294 ±  4%      +0.2%    1105023 ±  2%  interrupts.CPU29.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU29.MCP:Machine_check_polls
      8546 ±  2%     -11.5%       7566 ± 28%      +1.0%       8633        interrupts.CPU29.NMI:Non-maskable_interrupts
      8546 ±  2%     -11.5%       7566 ± 28%      +1.0%       8633        interrupts.CPU29.PMI:Performance_monitoring_interrupts
    929004 ±  5%     -29.7%     653460 ±  8%      +2.6%     953500 ±  5%  interrupts.CPU29.RES:Rescheduling_interrupts
      2.89 ± 66%     +26.9%       3.67 ± 40%     -10.0%       2.60 ± 75%  interrupts.CPU29.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU3.140:PCI-MSI.57149479-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU3.75:PCI-MSI.57147431-edge
     29963 ± 18%      -8.4%      27460 ± 11%     +10.8%      33208 ± 16%  interrupts.CPU3.CAL:Function_call_interrupts
      6.11 ± 16%     +12.7%       6.89 ± 19%     -11.6%       5.40 ± 16%  interrupts.CPU3.IWI:IRQ_work_interrupts
   1102652            -9.7%     995633 ±  4%      +0.2%    1105112 ±  2%  interrupts.CPU3.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU3.MCP:Machine_check_polls
      8269 ± 16%      -8.0%       7609 ± 28%     -16.1%       6934 ± 30%  interrupts.CPU3.NMI:Non-maskable_interrupts
      8269 ± 16%      -8.0%       7609 ± 28%     -16.1%       6934 ± 30%  interrupts.CPU3.PMI:Performance_monitoring_interrupts
    756310 ±  4%     -26.3%     557263 ±  8%      +2.5%     775446 ±  7%  interrupts.CPU3.RES:Rescheduling_interrupts
      2.67 ± 68%      -8.3%       2.44 ± 72%     -40.0%       1.60 ± 75%  interrupts.CPU3.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU30.112:PCI-MSI.57149451-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU30.113:PCI-MSI.57149452-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU30.147:PCI-MSI.57149486-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU30.197:PCI-MSI.18874381-edge.nvme0q13
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU30.47:PCI-MSI.57147403-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU30.48:PCI-MSI.57147404-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU30.83:PCI-MSI.57147439-edge
     41537 ± 22%     -13.9%      35782 ± 25%     +13.8%      47288 ± 27%  interrupts.CPU30.CAL:Function_call_interrupts
      6.22 ± 10%     +10.7%       6.89 ± 14%      -0.4%       6.20 ±  9%  interrupts.CPU30.IWI:IRQ_work_interrupts
   1102547            -9.6%     996319 ±  4%      +0.2%    1105045 ±  2%  interrupts.CPU30.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU30.MCP:Machine_check_polls
      8545 ±  2%      -5.6%       8067 ± 23%      +1.0%       8632        interrupts.CPU30.NMI:Non-maskable_interrupts
      8545 ±  2%      -5.6%       8067 ± 23%      +1.0%       8632        interrupts.CPU30.PMI:Performance_monitoring_interrupts
    961823 ±  5%     -32.0%     653992 ± 10%      +1.9%     980143 ±  6%  interrupts.CPU30.RES:Rescheduling_interrupts
      2.22 ± 72%     +45.0%       3.22 ± 72%      -1.0%       2.20 ± 80%  interrupts.CPU30.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU31.113:PCI-MSI.57149452-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU31.114:PCI-MSI.57149453-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU31.148:PCI-MSI.57149487-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU31.187:PCI-MSI.18874382-edge.nvme0q14
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU31.190:PCI-MSI.18874382-edge.nvme0q14
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU31.217:PCI-MSI.18874382-edge.nvme0q14
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU31.48:PCI-MSI.57147404-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU31.49:PCI-MSI.57147405-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU31.84:PCI-MSI.57147440-edge
     38603 ± 25%      -6.8%      35982 ± 14%     +42.6%      55030 ± 38%  interrupts.CPU31.CAL:Function_call_interrupts
      6.22 ± 10%     +17.9%       7.33 ± 12%      -0.4%       6.20 ±  9%  interrupts.CPU31.IWI:IRQ_work_interrupts
   1102535            -9.6%     996385 ±  4%      +0.2%    1105028 ±  2%  interrupts.CPU31.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU31.MCP:Machine_check_polls
      8545 ±  2%      +6.3%       9086            +1.0%       8632        interrupts.CPU31.NMI:Non-maskable_interrupts
      8545 ±  2%      +6.3%       9086            +1.0%       8632        interrupts.CPU31.PMI:Performance_monitoring_interrupts
    934373 ±  6%     -29.7%     656631 ± 11%      +0.3%     937453 ±  3%  interrupts.CPU31.RES:Rescheduling_interrupts
      2.67 ± 68%     +12.5%       3.00 ± 58%     +12.5%       3.00 ± 49%  interrupts.CPU31.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU32.114:PCI-MSI.57149453-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU32.115:PCI-MSI.57149454-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU32.149:PCI-MSI.57149488-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU32.188:PCI-MSI.18874383-edge.nvme0q15
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU32.49:PCI-MSI.57147405-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU32.50:PCI-MSI.57147406-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU32.85:PCI-MSI.57147441-edge
     37838 ± 20%      +0.1%      37866 ± 21%     +38.7%      52490 ± 30%  interrupts.CPU32.CAL:Function_call_interrupts
      6.22 ± 10%     +17.9%       7.33 ± 12%      -0.4%       6.20 ±  9%  interrupts.CPU32.IWI:IRQ_work_interrupts
   1102554            -9.6%     996253 ±  4%      +0.2%    1105020 ±  2%  interrupts.CPU32.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU32.MCP:Machine_check_polls
      8546 ±  2%      +6.3%       9088            +1.0%       8632        interrupts.CPU32.NMI:Non-maskable_interrupts
      8546 ±  2%      +6.3%       9088            +1.0%       8632        interrupts.CPU32.PMI:Performance_monitoring_interrupts
    921335 ±  5%     -29.0%     654589 ± 10%      +2.6%     945697 ±  4%  interrupts.CPU32.RES:Rescheduling_interrupts
      2.33 ± 63%     +61.9%       3.78 ± 40%     +28.6%       3.00 ± 47%  interrupts.CPU32.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU33.115:PCI-MSI.57149454-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU33.116:PCI-MSI.57149455-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU33.150:PCI-MSI.57149489-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU33.189:PCI-MSI.18874384-edge.nvme0q16
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU33.50:PCI-MSI.57147406-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU33.51:PCI-MSI.57147407-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU33.86:PCI-MSI.57147442-edge
     42145 ± 30%     -13.9%      36298 ± 23%     +30.1%      54836 ± 22%  interrupts.CPU33.CAL:Function_call_interrupts
      6.22 ± 10%     +21.4%       7.56 ± 16%      -2.0%       6.10 ± 18%  interrupts.CPU33.IWI:IRQ_work_interrupts
   1102549            -9.6%     996198 ±  4%      +0.2%    1105059 ±  2%  interrupts.CPU33.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU33.MCP:Machine_check_polls
      8542 ±  2%      +6.4%       9093            -3.9%       8213 ± 16%  interrupts.CPU33.NMI:Non-maskable_interrupts
      8542 ±  2%      +6.4%       9093            -3.9%       8213 ± 16%  interrupts.CPU33.PMI:Performance_monitoring_interrupts
    939422 ±  7%     -29.9%     658464 ±  9%      +3.5%     972291 ±  5%  interrupts.CPU33.RES:Rescheduling_interrupts
      4.67 ± 46%     -31.0%       3.22 ± 52%     -44.3%       2.60 ± 54%  interrupts.CPU33.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU34.116:PCI-MSI.57149455-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU34.117:PCI-MSI.57149456-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU34.151:PCI-MSI.57149490-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU34.51:PCI-MSI.57147407-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU34.52:PCI-MSI.57147408-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU34.87:PCI-MSI.57147443-edge
     35211 ± 11%      +6.3%      37426 ± 15%     +48.6%      52315 ± 32%  interrupts.CPU34.CAL:Function_call_interrupts
      6.22 ± 10%     +14.3%       7.11 ± 19%      -3.6%       6.00 ± 14%  interrupts.CPU34.IWI:IRQ_work_interrupts
   1102542            -9.7%     996129 ±  4%      +0.2%    1105047 ±  2%  interrupts.CPU34.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU34.MCP:Machine_check_polls
      8544 ±  2%      +0.5%       8584 ± 16%      -3.9%       8207 ± 16%  interrupts.CPU34.NMI:Non-maskable_interrupts
      8544 ±  2%      +0.5%       8584 ± 16%      -3.9%       8207 ± 16%  interrupts.CPU34.PMI:Performance_monitoring_interrupts
    943540 ±  8%     -31.7%     644830 ±  9%      -0.7%     936883 ±  4%  interrupts.CPU34.RES:Rescheduling_interrupts
      4.44 ± 85%     -25.0%       3.33 ± 64%     -16.8%       3.70 ± 90%  interrupts.CPU34.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU35.117:PCI-MSI.57149456-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU35.118:PCI-MSI.57149457-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU35.152:PCI-MSI.57149491-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU35.191:PCI-MSI.18874386-edge.nvme0q18
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU35.52:PCI-MSI.57147408-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU35.53:PCI-MSI.57147409-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU35.88:PCI-MSI.57147444-edge
     43324 ± 28%     -12.5%      37915 ± 23%      -1.2%      42790 ± 26%  interrupts.CPU35.CAL:Function_call_interrupts
      6.22 ± 10%     +10.7%       6.89 ± 19%      -6.8%       5.80 ± 18%  interrupts.CPU35.IWI:IRQ_work_interrupts
   1102571            -9.7%     996119 ±  4%      +0.2%    1105073 ±  2%  interrupts.CPU35.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU35.MCP:Machine_check_polls
      8543 ±  2%      -5.5%       8076 ± 23%      -8.9%       7783 ± 22%  interrupts.CPU35.NMI:Non-maskable_interrupts
      8543 ±  2%      -5.5%       8076 ± 23%      -8.9%       7783 ± 22%  interrupts.CPU35.PMI:Performance_monitoring_interrupts
    908486 ±  6%     -28.9%     645739 ±  9%      +2.3%     929393 ±  4%  interrupts.CPU35.RES:Rescheduling_interrupts
      2.67 ± 79%     +33.3%       3.56 ± 51%      -6.2%       2.50 ± 44%  interrupts.CPU35.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU36.155:PCI-MSI.57149494-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU36.187:PCI-MSI.67174400-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU36.188:PCI-MSI.67174400-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU36.190:PCI-MSI.67174400-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU36.318:PCI-MSI.67174400-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU36.319:PCI-MSI.67174400-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU36.90:PCI-MSI.57147446-edge
     99541 ± 24%     -27.6%      72053 ± 30%     +11.0%     110456 ± 42%  interrupts.CPU36.CAL:Function_call_interrupts
      6.22 ± 10%     +10.7%       6.89 ± 19%      -6.8%       5.80 ± 18%  interrupts.CPU36.IWI:IRQ_work_interrupts
   1102574            -9.5%     997760 ±  3%      +0.2%    1104954 ±  2%  interrupts.CPU36.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU36.MCP:Machine_check_polls
      8906 ±  2%      -8.7%       8135 ± 23%      -9.0%       8102 ± 22%  interrupts.CPU36.NMI:Non-maskable_interrupts
      8906 ±  2%      -8.7%       8135 ± 23%      -9.0%       8102 ± 22%  interrupts.CPU36.PMI:Performance_monitoring_interrupts
    913254 ±  6%     -28.6%     652460 ±  6%      -3.0%     886257 ±  7%  interrupts.CPU36.RES:Rescheduling_interrupts
      2.33 ± 69%     +57.1%       3.67 ± 40%     -14.3%       2.00 ± 89%  interrupts.CPU36.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU37.156:PCI-MSI.57149495-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU37.184:PCI-MSI.67176448-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU37.189:PCI-MSI.67176448-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU37.190:PCI-MSI.67176448-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU37.192:PCI-MSI.67176448-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU37.320:PCI-MSI.67176448-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU37.321:PCI-MSI.67176448-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU37.91:PCI-MSI.57147447-edge
     67779 ± 20%     -27.2%      49344 ± 20%      +1.6%      68861 ± 35%  interrupts.CPU37.CAL:Function_call_interrupts
      6.00 ± 15%     +18.5%       7.11 ± 19%      +0.0%       6.00 ± 14%  interrupts.CPU37.IWI:IRQ_work_interrupts
   1102517            -9.5%     997822 ±  3%      +0.2%    1105032 ±  2%  interrupts.CPU37.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU37.MCP:Machine_check_polls
      8427 ± 17%      +2.6%       8644 ± 16%      +1.5%       8557 ± 15%  interrupts.CPU37.NMI:Non-maskable_interrupts
      8427 ± 17%      +2.6%       8644 ± 16%      +1.5%       8557 ± 15%  interrupts.CPU37.PMI:Performance_monitoring_interrupts
    913107 ±  8%     -26.3%     672925 ±  8%      -1.7%     897975 ±  5%  interrupts.CPU37.RES:Rescheduling_interrupts
      2.56 ± 76%     +39.1%       3.56 ± 29%     -29.6%       1.80 ± 73%  interrupts.CPU37.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU38.157:PCI-MSI.57149496-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU38.191:PCI-MSI.67178496-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU38.193:PCI-MSI.67178496-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU38.321:PCI-MSI.67178496-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU38.322:PCI-MSI.67178496-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU38.92:PCI-MSI.57147448-edge
     64396 ± 41%     -34.6%      42098 ± 19%      -6.5%      60185 ± 39%  interrupts.CPU38.CAL:Function_call_interrupts
      6.00 ± 15%     +18.5%       7.11 ± 19%      +3.3%       6.20 ±  9%  interrupts.CPU38.IWI:IRQ_work_interrupts
   1102553            -9.5%     997769 ±  3%      +0.2%    1105061 ±  2%  interrupts.CPU38.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU38.MCP:Machine_check_polls
      8401 ± 16%      +2.9%       8646 ± 16%      +7.2%       9006        interrupts.CPU38.NMI:Non-maskable_interrupts
      8401 ± 16%      +2.9%       8646 ± 16%      +7.2%       9006        interrupts.CPU38.PMI:Performance_monitoring_interrupts
    946901 ±  6%     -29.5%     667302 ±  7%      +0.8%     954276 ±  6%  interrupts.CPU38.RES:Rescheduling_interrupts
      2.89 ± 82%     +57.7%       4.56 ± 42%     -27.3%       2.10 ± 72%  interrupts.CPU38.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU39.158:PCI-MSI.57149497-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU39.192:PCI-MSI.67180544-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU39.322:PCI-MSI.67180544-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU39.323:PCI-MSI.67180544-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU39.93:PCI-MSI.57147449-edge
     53536 ± 32%     -17.2%      44303 ± 22%      +0.8%      53942 ± 20%  interrupts.CPU39.CAL:Function_call_interrupts
      6.22 ± 10%      +7.1%       6.67 ± 19%      -3.6%       6.00 ± 14%  interrupts.CPU39.IWI:IRQ_work_interrupts
   1102584            -9.5%     998030 ±  3%      +0.2%    1105023 ±  2%  interrupts.CPU39.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU39.MCP:Machine_check_polls
      8904           -14.3%       7628 ± 28%      -3.9%       8558 ± 15%  interrupts.CPU39.NMI:Non-maskable_interrupts
      8904           -14.3%       7628 ± 28%      -3.9%       8558 ± 15%  interrupts.CPU39.PMI:Performance_monitoring_interrupts
    932267 ±  6%     -27.6%     675066 ±  9%      -1.4%     918898 ±  4%  interrupts.CPU39.RES:Rescheduling_interrupts
      2.44 ± 88%     +77.3%       4.33 ± 44%     -10.0%       2.20 ± 90%  interrupts.CPU39.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU4.141:PCI-MSI.57149480-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU4.279:PCI-MSI.18874469-edge.nvme0q101
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU4.281:PCI-MSI.18874469-edge.nvme0q101
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU4.284:PCI-MSI.18874469-edge.nvme0q101
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU4.291:PCI-MSI.18874469-edge.nvme0q101
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU4.76:PCI-MSI.57147432-edge
     29412 ± 25%      -4.8%      27987 ± 13%      -6.4%      27537 ± 18%  interrupts.CPU4.CAL:Function_call_interrupts
      5.78 ± 19%     +25.0%       7.22 ± 12%      +0.4%       5.80 ± 18%  interrupts.CPU4.IWI:IRQ_work_interrupts
   1102627            -9.7%     995688 ±  4%      +0.2%    1105053 ±  2%  interrupts.CPU4.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU4.MCP:Machine_check_polls
      7788 ± 23%     +10.7%       8619 ± 16%      -0.1%       7783 ± 21%  interrupts.CPU4.NMI:Non-maskable_interrupts
      7788 ± 23%     +10.7%       8619 ± 16%      -0.1%       7783 ± 21%  interrupts.CPU4.PMI:Performance_monitoring_interrupts
    768622 ±  7%     -26.9%     562164 ±  8%      -0.1%     768224 ±  7%  interrupts.CPU4.RES:Rescheduling_interrupts
      3.00 ± 52%     -25.9%       2.22 ± 69%     -43.3%       1.70 ± 59%  interrupts.CPU4.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU40.159:PCI-MSI.57149498-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU40.194:PCI-MSI.67182592-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU40.210:PCI-MSI.18874405-edge.nvme0q37
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU40.323:PCI-MSI.67182592-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU40.324:PCI-MSI.67182592-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU40.94:PCI-MSI.57147450-edge
     49320 ± 31%     -14.4%      42196 ± 17%      -1.1%      48800 ± 27%  interrupts.CPU40.CAL:Function_call_interrupts
      6.22 ± 10%     +10.7%       6.89 ± 19%      -6.8%       5.80 ± 18%  interrupts.CPU40.IWI:IRQ_work_interrupts
   1102609            -9.5%     998294 ±  3%      +0.2%    1105010 ±  2%  interrupts.CPU40.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU40.MCP:Machine_check_polls
      8903            -8.7%       8132 ± 23%      -8.9%       8114 ± 22%  interrupts.CPU40.NMI:Non-maskable_interrupts
      8903            -8.7%       8132 ± 23%      -8.9%       8114 ± 22%  interrupts.CPU40.PMI:Performance_monitoring_interrupts
    937428 ±  4%     -28.3%     671758 ±  8%      -2.2%     916926 ±  5%  interrupts.CPU40.RES:Rescheduling_interrupts
      3.33 ± 84%     +33.3%       4.44 ± 60%     -22.0%       2.60 ± 62%  interrupts.CPU40.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU41.160:PCI-MSI.57149499-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU41.195:PCI-MSI.67184640-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU41.215:PCI-MSI.18874406-edge.nvme0q38
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU41.218:PCI-MSI.18874406-edge.nvme0q38
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU41.324:PCI-MSI.67184640-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU41.325:PCI-MSI.67184640-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU41.95:PCI-MSI.57147451-edge
     47369 ± 18%      -9.0%      43118 ± 24%      +1.2%      47917 ± 31%  interrupts.CPU41.CAL:Function_call_interrupts
      6.22 ± 10%      +7.1%       6.67 ± 19%      -0.4%       6.20 ±  9%  interrupts.CPU41.IWI:IRQ_work_interrupts
   1102576            -9.5%     997695 ±  4%      +0.2%    1105039 ±  2%  interrupts.CPU41.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU41.MCP:Machine_check_polls
      8904           -14.4%       7621 ± 28%      +1.2%       9009        interrupts.CPU41.NMI:Non-maskable_interrupts
      8904           -14.4%       7621 ± 28%      +1.2%       9009        interrupts.CPU41.PMI:Performance_monitoring_interrupts
    941540 ±  8%     -28.8%     670065 ±  7%      -2.6%     917490 ±  4%  interrupts.CPU41.RES:Rescheduling_interrupts
      2.56 ± 74%     +60.9%       4.11 ± 40%      -2.2%       2.50 ± 62%  interrupts.CPU41.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU42.161:PCI-MSI.57149500-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU42.196:PCI-MSI.67186688-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU42.325:PCI-MSI.67186688-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU42.326:PCI-MSI.67186688-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU42.96:PCI-MSI.57147452-edge
     45720 ± 25%     -18.0%      37487 ± 19%     +17.6%      53749 ± 59%  interrupts.CPU42.CAL:Function_call_interrupts
      6.00 ± 15%     +11.1%       6.67 ± 19%      +3.3%       6.20 ±  9%  interrupts.CPU42.IWI:IRQ_work_interrupts
   1102568            -9.5%     998025 ±  3%      +0.2%    1105046 ±  2%  interrupts.CPU42.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU42.MCP:Machine_check_polls
      8429 ± 17%      -9.6%       7621 ± 28%      +6.9%       9009        interrupts.CPU42.NMI:Non-maskable_interrupts
      8429 ± 17%      -9.6%       7621 ± 28%      +6.9%       9009        interrupts.CPU42.PMI:Performance_monitoring_interrupts
    951380 ±  7%     -28.7%     678270 ±  8%      -1.5%     937369 ±  4%  interrupts.CPU42.RES:Rescheduling_interrupts
      3.11 ± 73%     +64.3%       5.11 ± 39%     -32.5%       2.10 ± 72%  interrupts.CPU42.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU43.162:PCI-MSI.57149501-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU43.197:PCI-MSI.67188736-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU43.215:PCI-MSI.18874408-edge.nvme0q40
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU43.223:PCI-MSI.18874408-edge.nvme0q40
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU43.326:PCI-MSI.67188736-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU43.327:PCI-MSI.67188736-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU43.97:PCI-MSI.57147453-edge
     50130 ± 31%     -21.6%      39310 ± 18%     -10.5%      44875 ± 37%  interrupts.CPU43.CAL:Function_call_interrupts
      6.22 ± 10%     +10.7%       6.89 ± 19%      -3.6%       6.00 ± 14%  interrupts.CPU43.IWI:IRQ_work_interrupts
   1102599            -9.5%     997911 ±  3%      +0.2%    1104981 ±  2%  interrupts.CPU43.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU43.MCP:Machine_check_polls
      8902 ±  2%      -8.6%       8134 ± 23%      -3.9%       8556 ± 15%  interrupts.CPU43.NMI:Non-maskable_interrupts
      8902 ±  2%      -8.6%       8134 ± 23%      -3.9%       8556 ± 15%  interrupts.CPU43.PMI:Performance_monitoring_interrupts
    949077 ±  5%     -28.7%     676538 ±  7%      -0.0%     948682 ±  4%  interrupts.CPU43.RES:Rescheduling_interrupts
      2.22 ± 72%     +75.0%       3.89 ± 37%      -1.0%       2.20 ± 88%  interrupts.CPU43.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU44.163:PCI-MSI.57149502-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU44.234:PCI-MSI.18874409-edge.nvme0q41
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU44.98:PCI-MSI.57147454-edge
     49661 ± 15%     -23.6%      37959 ± 25%     -10.2%      44598 ± 30%  interrupts.CPU44.CAL:Function_call_interrupts
      6.11 ± 12%     +12.7%       6.89 ± 19%      -1.8%       6.00 ± 14%  interrupts.CPU44.IWI:IRQ_work_interrupts
   1102602            -9.5%     997870 ±  3%      +0.2%    1105052 ±  2%  interrupts.CPU44.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU44.MCP:Machine_check_polls
      8429 ± 17%      -3.5%       8133 ± 23%      +1.5%       8558 ± 15%  interrupts.CPU44.NMI:Non-maskable_interrupts
      8429 ± 17%      -3.5%       8133 ± 23%      +1.5%       8558 ± 15%  interrupts.CPU44.PMI:Performance_monitoring_interrupts
    965483 ±  5%     -31.1%     665255 ±  7%      -4.9%     918370 ±  3%  interrupts.CPU44.RES:Rescheduling_interrupts
      2.78 ± 87%     +40.0%       3.89 ± 50%     -24.4%       2.10 ± 72%  interrupts.CPU44.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU45.223:PCI-MSI.18874410-edge.nvme0q42
     46457 ± 25%     -12.2%      40804 ± 26%      -8.7%      42436 ± 30%  interrupts.CPU45.CAL:Function_call_interrupts
      5.89 ± 16%     +17.0%       6.89 ± 19%      -1.5%       5.80 ± 18%  interrupts.CPU45.IWI:IRQ_work_interrupts
   1102557            -9.5%     997752 ±  4%      +0.2%    1105034 ±  2%  interrupts.CPU45.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU45.MCP:Machine_check_polls
      7931 ± 24%      +2.5%       8132 ± 23%      +2.2%       8106 ± 22%  interrupts.CPU45.NMI:Non-maskable_interrupts
      7931 ± 24%      +2.5%       8132 ± 23%      +2.2%       8106 ± 22%  interrupts.CPU45.PMI:Performance_monitoring_interrupts
    976465 ±  3%     -31.8%     665469 ±  7%      -7.9%     898905 ±  6%  interrupts.CPU45.RES:Rescheduling_interrupts
      3.22 ± 65%     +20.7%       3.89 ± 47%     -34.8%       2.10 ± 83%  interrupts.CPU45.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU46.216:PCI-MSI.18874411-edge.nvme0q43
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU46.227:PCI-MSI.18874411-edge.nvme0q43
     50296 ± 26%     -27.8%      36329 ± 17%      -1.8%      49368 ± 36%  interrupts.CPU46.CAL:Function_call_interrupts
      5.56 ± 14%     +20.0%       6.67 ± 19%      +4.4%       5.80 ± 18%  interrupts.CPU46.IWI:IRQ_work_interrupts
   1102532            -9.5%     997756 ±  3%      +0.2%    1105052 ±  2%  interrupts.CPU46.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU46.MCP:Machine_check_polls
      7427 ± 28%      +2.8%       7632 ± 28%      +9.2%       8107 ± 22%  interrupts.CPU46.NMI:Non-maskable_interrupts
      7427 ± 28%      +2.8%       7632 ± 28%      +9.2%       8107 ± 22%  interrupts.CPU46.PMI:Performance_monitoring_interrupts
    950768 ±  3%     -29.6%     668950 ±  7%      -0.5%     946197 ±  5%  interrupts.CPU46.RES:Rescheduling_interrupts
      2.67 ± 75%     +87.5%       5.00 ± 35%     -28.8%       1.90 ± 79%  interrupts.CPU46.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU47.227:PCI-MSI.18874412-edge.nvme0q44
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU47.237:PCI-MSI.18874412-edge.nvme0q44
     48269 ± 27%     -21.0%      38129 ± 24%     -19.4%      38884 ± 24%  interrupts.CPU47.CAL:Function_call_interrupts
      6.00 ± 15%     +11.1%       6.67 ± 19%      -3.3%       5.80 ± 18%  interrupts.CPU47.IWI:IRQ_work_interrupts
   1102553            -9.5%     997886 ±  3%      +0.2%    1105019 ±  2%  interrupts.CPU47.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU47.MCP:Machine_check_polls
      8402 ± 16%      -9.3%       7620 ± 28%      -3.5%       8106 ± 22%  interrupts.CPU47.NMI:Non-maskable_interrupts
      8402 ± 16%      -9.3%       7620 ± 28%      -3.5%       8106 ± 22%  interrupts.CPU47.PMI:Performance_monitoring_interrupts
    964331 ±  5%     -31.6%     660041 ±  6%      -4.0%     925669 ±  4%  interrupts.CPU47.RES:Rescheduling_interrupts
      2.11 ±110%    +126.3%       4.78 ± 54%      -5.3%       2.00 ± 94%  interrupts.CPU47.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU48.220:PCI-MSI.18874413-edge.nvme0q45
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU48.221:PCI-MSI.18874413-edge.nvme0q45
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU48.229:PCI-MSI.18874413-edge.nvme0q45
     51900 ± 36%     -28.3%      37209 ± 18%     -11.2%      46082 ± 44%  interrupts.CPU48.CAL:Function_call_interrupts
      6.00 ± 15%     +14.8%       6.89 ± 19%      -3.3%       5.80 ± 18%  interrupts.CPU48.IWI:IRQ_work_interrupts
   1102562            -9.5%     998076 ±  3%      +0.2%    1105033 ±  2%  interrupts.CPU48.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU48.MCP:Machine_check_polls
      8428 ± 17%      -3.5%       8131 ± 23%      -3.8%       8107 ± 22%  interrupts.CPU48.NMI:Non-maskable_interrupts
      8428 ± 17%      -3.5%       8131 ± 23%      -3.8%       8107 ± 22%  interrupts.CPU48.PMI:Performance_monitoring_interrupts
    965128 ±  7%     -29.6%     679529 ±  6%      -4.5%     922147 ±  7%  interrupts.CPU48.RES:Rescheduling_interrupts
      2.78 ± 65%     +88.0%       5.22 ± 28%     -13.6%       2.40 ± 65%  interrupts.CPU48.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU49.221:PCI-MSI.18874414-edge.nvme0q46
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU49.230:PCI-MSI.18874414-edge.nvme0q46
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU49.239:PCI-MSI.18874414-edge.nvme0q46
     50702 ± 42%     -26.5%      37254 ± 27%     -10.7%      45293 ± 41%  interrupts.CPU49.CAL:Function_call_interrupts
      6.22 ± 10%     +14.3%       7.11 ± 19%      -6.8%       5.80 ± 18%  interrupts.CPU49.IWI:IRQ_work_interrupts
   1102534            -9.5%     997865 ±  3%      +0.2%    1105028 ±  2%  interrupts.CPU49.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU49.MCP:Machine_check_polls
      8901 ±  2%      -2.9%       8644 ± 16%      -8.9%       8105 ± 22%  interrupts.CPU49.NMI:Non-maskable_interrupts
      8901 ±  2%      -2.9%       8644 ± 16%      -8.9%       8105 ± 22%  interrupts.CPU49.PMI:Performance_monitoring_interrupts
    934380 ±  8%     -29.0%     663157 ±  8%      -2.7%     908785 ±  5%  interrupts.CPU49.RES:Rescheduling_interrupts
      2.78 ± 98%     +44.0%       4.00 ± 33%     -31.6%       1.90 ± 64%  interrupts.CPU49.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU5.142:PCI-MSI.57149481-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU5.165:PCI-MSI.327680-edge.xhci_hcd
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU5.294:PCI-MSI.18874470-edge.nvme0q102
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU5.77:PCI-MSI.57147433-edge
     38645 ± 37%     -31.4%      26503 ± 13%     -13.8%      33315 ± 28%  interrupts.CPU5.CAL:Function_call_interrupts
      5.56 ± 22%     +24.0%       6.89 ± 14%      +0.8%       5.60 ± 21%  interrupts.CPU5.IWI:IRQ_work_interrupts
   1102590            -9.7%     995578 ±  4%      +0.2%    1105085 ±  2%  interrupts.CPU5.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU5.MCP:Machine_check_polls
      7316 ± 29%     +10.9%       8113 ± 23%      +0.7%       7364 ± 26%  interrupts.CPU5.NMI:Non-maskable_interrupts
      7316 ± 29%     +10.9%       8113 ± 23%      +0.7%       7364 ± 26%  interrupts.CPU5.PMI:Performance_monitoring_interrupts
    747494 ±  5%     -25.4%     557817 ±  6%      +2.2%     764033 ±  8%  interrupts.CPU5.RES:Rescheduling_interrupts
      2.00 ± 40%     +38.9%       2.78 ± 58%     -20.0%       1.60 ±101%  interrupts.CPU5.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU50.223:PCI-MSI.18874415-edge.nvme0q47
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU50.227:PCI-MSI.18874415-edge.nvme0q47
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU50.230:PCI-MSI.18874415-edge.nvme0q47
     47910 ± 31%     -16.6%      39966 ± 24%      -7.9%      44148 ± 40%  interrupts.CPU50.CAL:Function_call_interrupts
      5.78 ± 19%     +19.2%       6.89 ± 19%      -3.1%       5.60 ± 21%  interrupts.CPU50.IWI:IRQ_work_interrupts
   1102549            -9.5%     997851 ±  3%      +0.2%    1105013 ±  2%  interrupts.CPU50.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU50.MCP:Machine_check_polls
      7926 ± 23%      +2.6%       8132 ± 23%      -3.5%       7652 ± 26%  interrupts.CPU50.NMI:Non-maskable_interrupts
      7926 ± 23%      +2.6%       8132 ± 23%      -3.5%       7652 ± 26%  interrupts.CPU50.PMI:Performance_monitoring_interrupts
    943585 ±  6%     -29.1%     668549 ±  7%      -1.5%     929744 ±  6%  interrupts.CPU50.RES:Rescheduling_interrupts
      2.22 ± 89%     +80.0%       4.00 ± 26%     -19.0%       1.80 ± 64%  interrupts.CPU50.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU51.228:PCI-MSI.18874416-edge.nvme0q48
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU51.231:PCI-MSI.18874416-edge.nvme0q48
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU51.232:PCI-MSI.18874416-edge.nvme0q48
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU51.234:PCI-MSI.18874416-edge.nvme0q48
     54607 ± 45%     -28.2%      39209 ± 17%     -11.3%      48463 ± 60%  interrupts.CPU51.CAL:Function_call_interrupts
      6.00 ± 15%     +14.8%       6.89 ± 19%      -6.7%       5.60 ± 21%  interrupts.CPU51.IWI:IRQ_work_interrupts
   1102551            -9.5%     997864 ±  3%      +0.2%    1105025 ±  2%  interrupts.CPU51.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU51.MCP:Machine_check_polls
      8432 ± 17%      -3.5%       8133 ± 23%      -9.1%       7662 ± 27%  interrupts.CPU51.NMI:Non-maskable_interrupts
      8432 ± 17%      -3.5%       8133 ± 23%      -9.1%       7662 ± 27%  interrupts.CPU51.PMI:Performance_monitoring_interrupts
    965400 ±  4%     -29.0%     685208 ±  7%      -4.2%     925201 ±  6%  interrupts.CPU51.RES:Rescheduling_interrupts
      3.56 ± 76%     +40.6%       5.00 ± 37%     -40.9%       2.10 ± 78%  interrupts.CPU51.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU52.232:PCI-MSI.18874417-edge.nvme0q49
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU52.235:PCI-MSI.18874417-edge.nvme0q49
     56221 ± 39%     -31.9%      38267 ± 19%     -20.2%      44850 ± 31%  interrupts.CPU52.CAL:Function_call_interrupts
      6.22 ± 10%     +10.7%       6.89 ± 19%      -5.2%       5.90 ± 19%  interrupts.CPU52.IWI:IRQ_work_interrupts
   1102562            -9.5%     997840 ±  3%      +0.2%    1105014 ±  2%  interrupts.CPU52.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU52.MCP:Machine_check_polls
      8903            -8.7%       8133 ± 23%      -8.9%       8108 ± 22%  interrupts.CPU52.NMI:Non-maskable_interrupts
      8903            -8.7%       8133 ± 23%      -8.9%       8108 ± 22%  interrupts.CPU52.PMI:Performance_monitoring_interrupts
    968865 ±  6%     -30.6%     672416 ±  7%      -4.0%     929911 ±  5%  interrupts.CPU52.RES:Rescheduling_interrupts
      2.22 ± 91%     +55.0%       3.44 ± 38%      -5.5%       2.10 ± 68%  interrupts.CPU52.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU53.227:PCI-MSI.18874418-edge.nvme0q50
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU53.236:PCI-MSI.18874418-edge.nvme0q50
     49322 ± 27%     -12.3%      43277 ± 29%      -5.3%      46693 ± 34%  interrupts.CPU53.CAL:Function_call_interrupts
      6.22 ± 10%     +10.7%       6.89 ± 19%      -3.6%       6.00 ± 14%  interrupts.CPU53.IWI:IRQ_work_interrupts
   1102582            -9.5%     997865 ±  3%      +0.2%    1105033 ±  2%  interrupts.CPU53.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU53.MCP:Machine_check_polls
      8903 ±  2%      -8.7%       8132 ± 23%      -3.9%       8556 ± 15%  interrupts.CPU53.NMI:Non-maskable_interrupts
      8903 ±  2%      -8.7%       8132 ± 23%      -3.9%       8556 ± 15%  interrupts.CPU53.PMI:Performance_monitoring_interrupts
    956289 ±  8%     -29.8%     671670 ±  6%      -1.5%     941513 ±  4%  interrupts.CPU53.RES:Rescheduling_interrupts
      3.22 ± 71%     +17.2%       3.78 ± 56%      -6.9%       3.00 ±102%  interrupts.CPU53.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU54.200:PCI-MSI.100728832-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU54.328:PCI-MSI.100728832-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU54.329:PCI-MSI.100728832-edge.ioat-msix
    107164 ± 35%     -14.6%      91519 ± 21%      +9.9%     117729 ± 26%  interrupts.CPU54.CAL:Function_call_interrupts
      6.22 ± 10%     +14.3%       7.11 ± 13%      -0.4%       6.20 ±  9%  interrupts.CPU54.IWI:IRQ_work_interrupts
   1102705            -9.6%     997375 ±  4%      +0.2%    1104960 ±  2%  interrupts.CPU54.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU54.MCP:Machine_check_polls
      8784 ±  2%      -2.0%       8605 ± 16%      +0.6%       8836        interrupts.CPU54.NMI:Non-maskable_interrupts
      8784 ±  2%      -2.0%       8605 ± 16%      +0.6%       8836        interrupts.CPU54.PMI:Performance_monitoring_interrupts
    896525 ±  3%     -28.1%     644676 ±  9%      -5.4%     848111 ±  3%  interrupts.CPU54.RES:Rescheduling_interrupts
      2.89 ± 77%      -3.8%       2.78 ± 79%     -10.0%       2.60 ±109%  interrupts.CPU54.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU55.201:PCI-MSI.100730880-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU55.330:PCI-MSI.100730880-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU55.331:PCI-MSI.100730880-edge.ioat-msix
     63453 ± 23%     -15.3%      53731 ± 25%      +2.6%      65074 ± 27%  interrupts.CPU55.CAL:Function_call_interrupts
      6.22 ± 16%     +17.9%       7.33 ± 12%      -3.6%       6.00 ± 14%  interrupts.CPU55.IWI:IRQ_work_interrupts
   1102671            -9.5%     997410 ±  4%      +0.2%    1105006 ±  2%  interrupts.CPU55.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU55.MCP:Machine_check_polls
      8290 ± 16%     +10.0%       9116            +1.3%       8401 ± 16%  interrupts.CPU55.NMI:Non-maskable_interrupts
      8290 ± 16%     +10.0%       9116            +1.3%       8401 ± 16%  interrupts.CPU55.PMI:Performance_monitoring_interrupts
    909124 ±  5%     -27.4%     660367 ± 10%      -0.3%     906273 ±  4%  interrupts.CPU55.RES:Rescheduling_interrupts
      2.33 ± 49%     +23.8%       2.89 ± 62%     -27.1%       1.70 ± 45%  interrupts.CPU55.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU56.331:PCI-MSI.100732928-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU56.332:PCI-MSI.100732928-edge.ioat-msix
     59367 ± 27%     -18.8%      48196 ± 29%      -1.9%      58210 ± 20%  interrupts.CPU56.CAL:Function_call_interrupts
      6.00 ± 15%     +11.1%       6.67 ± 24%      +3.3%       6.20 ±  9%  interrupts.CPU56.IWI:IRQ_work_interrupts
   1102747            -9.5%     997528 ±  4%      +0.2%    1104966 ±  2%  interrupts.CPU56.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU56.MCP:Machine_check_polls
      8286 ± 16%      -8.4%       7594 ± 28%      +6.6%       8836        interrupts.CPU56.NMI:Non-maskable_interrupts
      8286 ± 16%      -8.4%       7594 ± 28%      +6.6%       8836        interrupts.CPU56.PMI:Performance_monitoring_interrupts
    912698 ±  5%     -26.2%     673259 ± 10%      +2.1%     931866 ±  5%  interrupts.CPU56.RES:Rescheduling_interrupts
      3.00 ± 62%     +40.7%       4.22 ± 52%     -13.3%       2.60 ± 77%  interrupts.CPU56.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU57.333:PCI-MSI.100734976-edge.ioat-msix
     54616 ± 35%     -20.8%      43282 ± 23%      +0.8%      55078 ± 25%  interrupts.CPU57.CAL:Function_call_interrupts
      5.56 ± 14%     +28.0%       7.11 ± 13%     +11.6%       6.20 ±  9%  interrupts.CPU57.IWI:IRQ_work_interrupts
   1102716            -9.6%     997341 ±  4%      +0.2%    1104966 ±  2%  interrupts.CPU57.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU57.MCP:Machine_check_polls
      7301 ± 27%     +18.0%       8615 ± 16%     +21.0%       8836        interrupts.CPU57.NMI:Non-maskable_interrupts
      7301 ± 27%     +18.0%       8615 ± 16%     +21.0%       8836        interrupts.CPU57.PMI:Performance_monitoring_interrupts
    941515 ±  6%     -28.9%     669863 ± 10%      -2.9%     914455 ±  5%  interrupts.CPU57.RES:Rescheduling_interrupts
      2.78 ± 67%     +16.0%       3.22 ± 59%     -35.2%       1.80 ± 92%  interrupts.CPU57.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU58.253:PCI-MSI.18874437-edge.nvme0q69
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU58.254:PCI-MSI.18874437-edge.nvme0q69
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU58.259:PCI-MSI.18874437-edge.nvme0q69
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU58.334:PCI-MSI.100737024-edge.ioat-msix
     44378 ± 30%      -4.4%      42418 ± 29%     +11.8%      49612 ± 30%  interrupts.CPU58.CAL:Function_call_interrupts
      5.33 ± 17%     +33.3%       7.11 ± 13%     +12.5%       6.00 ± 14%  interrupts.CPU58.IWI:IRQ_work_interrupts
   1102679            -9.5%     997477 ±  4%      +0.2%    1104965 ±  2%  interrupts.CPU58.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU58.MCP:Machine_check_polls
      6829 ± 32%     +26.1%       8615 ± 16%     +23.0%       8402 ± 16%  interrupts.CPU58.NMI:Non-maskable_interrupts
      6829 ± 32%     +26.1%       8615 ± 16%     +23.0%       8402 ± 16%  interrupts.CPU58.PMI:Performance_monitoring_interrupts
    914216 ±  3%     -27.4%     663293 ±  9%      -0.9%     905877 ±  4%  interrupts.CPU58.RES:Rescheduling_interrupts
      2.44 ± 54%     +59.1%       3.89 ± 39%     -18.2%       2.00 ± 70%  interrupts.CPU58.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU59.254:PCI-MSI.18874438-edge.nvme0q70
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU59.335:PCI-MSI.100739072-edge.ioat-msix
     43827 ± 29%      -9.9%      39480 ± 28%      -5.9%      41230 ± 20%  interrupts.CPU59.CAL:Function_call_interrupts
      5.56 ± 14%     +28.0%       7.11 ± 13%     +11.6%       6.20 ± 17%  interrupts.CPU59.IWI:IRQ_work_interrupts
   1102656            -9.5%     997430 ±  4%      +0.2%    1104949 ±  2%  interrupts.CPU59.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU59.MCP:Machine_check_polls
      7301 ± 27%     +18.0%       8613 ± 16%     +15.2%       8408 ± 16%  interrupts.CPU59.NMI:Non-maskable_interrupts
      7301 ± 27%     +18.0%       8613 ± 16%     +15.2%       8408 ± 16%  interrupts.CPU59.PMI:Performance_monitoring_interrupts
    928147 ±  3%     -29.0%     659112 ± 10%      -0.3%     925807 ±  5%  interrupts.CPU59.RES:Rescheduling_interrupts
      2.89 ± 66%      +0.0%       2.89 ± 57%     -20.4%       2.30 ± 89%  interrupts.CPU59.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU6.143:PCI-MSI.57149482-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU6.276:PCI-MSI.18874471-edge.nvme0q103
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU6.279:PCI-MSI.18874471-edge.nvme0q103
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU6.284:PCI-MSI.18874471-edge.nvme0q103
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU6.286:PCI-MSI.18874471-edge.nvme0q103
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU6.293:PCI-MSI.18874471-edge.nvme0q103
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU6.295:PCI-MSI.18874471-edge.nvme0q103
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU6.78:PCI-MSI.57147434-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU6.8:IO-APIC.8-edge.rtc0
     28252 ± 29%      -4.2%      27068 ± 13%      +2.8%      29033 ± 32%  interrupts.CPU6.CAL:Function_call_interrupts
      6.33 ± 19%      +8.8%       6.89 ± 14%     -11.6%       5.60 ± 14%  interrupts.CPU6.IWI:IRQ_work_interrupts
   1102594            -9.7%     995636 ±  4%      +0.2%    1105122 ±  2%  interrupts.CPU6.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU6.MCP:Machine_check_polls
      8286 ± 17%      -2.1%       8113 ± 23%     -11.2%       7359 ± 26%  interrupts.CPU6.NMI:Non-maskable_interrupts
      8286 ± 17%      -2.1%       8113 ± 23%     -11.2%       7359 ± 26%  interrupts.CPU6.PMI:Performance_monitoring_interrupts
    750665 ±  6%     -27.1%     547179 ±  7%      -0.2%     749371 ±  7%  interrupts.CPU6.RES:Rescheduling_interrupts
      3.56 ± 91%     -21.9%       2.78 ± 58%     -71.9%       1.00 ± 77%  interrupts.CPU6.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU60.244:PCI-MSI.18874439-edge.nvme0q71
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU60.251:PCI-MSI.18874439-edge.nvme0q71
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU60.336:PCI-MSI.100741120-edge.ioat-msix
     50502 ± 44%     -26.5%      37134 ± 25%     -10.2%      45347 ± 28%  interrupts.CPU60.CAL:Function_call_interrupts
      5.56 ± 14%     +24.0%       6.89 ± 14%      +8.0%       6.00 ± 14%  interrupts.CPU60.IWI:IRQ_work_interrupts
   1102654            -9.5%     997572 ±  4%      +0.2%    1104971 ±  2%  interrupts.CPU60.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU60.MCP:Machine_check_polls
      7302 ± 27%     +11.0%       8102 ± 23%     +15.1%       8402 ± 16%  interrupts.CPU60.NMI:Non-maskable_interrupts
      7302 ± 27%     +11.0%       8102 ± 23%     +15.1%       8402 ± 16%  interrupts.CPU60.PMI:Performance_monitoring_interrupts
    934336 ±  3%     -28.3%     669462 ± 10%      +1.3%     946644 ±  6%  interrupts.CPU60.RES:Rescheduling_interrupts
      2.11 ± 56%     +94.7%       4.11 ± 51%      -0.5%       2.10 ± 54%  interrupts.CPU60.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU61.337:PCI-MSI.100743168-edge.ioat-msix
     46479 ± 29%     -18.4%      37919 ± 23%      +3.3%      48031 ± 31%  interrupts.CPU61.CAL:Function_call_interrupts
      5.33 ± 17%     +33.3%       7.11 ± 13%      +8.8%       5.80 ± 18%  interrupts.CPU61.IWI:IRQ_work_interrupts
   1102697            -9.5%     997453 ±  4%      +0.2%    1104960 ±  2%  interrupts.CPU61.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU61.MCP:Machine_check_polls
      6803 ± 30%     +26.5%       8602 ± 16%     +17.1%       7964 ± 22%  interrupts.CPU61.NMI:Non-maskable_interrupts
      6803 ± 30%     +26.5%       8602 ± 16%     +17.1%       7964 ± 22%  interrupts.CPU61.PMI:Performance_monitoring_interrupts
    953949 ±  3%     -29.4%     673585 ± 11%      -0.6%     948364 ±  5%  interrupts.CPU61.RES:Rescheduling_interrupts
      3.67 ± 56%      +6.1%       3.89 ± 58%     -42.7%       2.10 ± 72%  interrupts.CPU61.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU62.251:PCI-MSI.18874441-edge.nvme0q73
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU62.253:PCI-MSI.18874441-edge.nvme0q73
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU62.266:PCI-MSI.18874441-edge.nvme0q73
     47502 ± 32%     -21.2%      37444 ± 27%      -9.7%      42898 ± 21%  interrupts.CPU62.CAL:Function_call_interrupts
      5.33 ± 17%     +33.3%       7.11 ± 13%     +12.5%       6.00 ± 14%  interrupts.CPU62.IWI:IRQ_work_interrupts
   1102650            -9.5%     997370 ±  4%      +0.2%    1104938 ±  2%  interrupts.CPU62.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU62.MCP:Machine_check_polls
      6804 ± 30%     +26.4%       8600 ± 16%     +23.5%       8404 ± 16%  interrupts.CPU62.NMI:Non-maskable_interrupts
      6804 ± 30%     +26.4%       8600 ± 16%     +23.5%       8404 ± 16%  interrupts.CPU62.PMI:Performance_monitoring_interrupts
    948216 ±  3%     -29.6%     667377 ± 11%      -3.4%     915808 ±  2%  interrupts.CPU62.RES:Rescheduling_interrupts
      4.56 ± 41%     -12.2%       4.00 ± 55%     -60.5%       1.80 ± 69%  interrupts.CPU62.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU63.254:PCI-MSI.18874442-edge.nvme0q74
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU63.267:PCI-MSI.18874442-edge.nvme0q74
     46357 ± 42%     -17.5%      38255 ± 28%      -6.8%      43185 ± 25%  interrupts.CPU63.CAL:Function_call_interrupts
      5.33 ± 17%     +37.5%       7.33 ± 12%     +16.2%       6.20 ±  9%  interrupts.CPU63.IWI:IRQ_work_interrupts
   1102676            -9.6%     997318 ±  4%      +0.2%    1104959 ±  2%  interrupts.CPU63.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU63.MCP:Machine_check_polls
      6803 ± 30%     +34.0%       9114           +29.9%       8836        interrupts.CPU63.NMI:Non-maskable_interrupts
      6803 ± 30%     +34.0%       9114           +29.9%       8836        interrupts.CPU63.PMI:Performance_monitoring_interrupts
    938775 ±  3%     -27.6%     679826 ± 11%      -1.8%     922212 ±  3%  interrupts.CPU63.RES:Rescheduling_interrupts
      3.44 ± 62%      +6.5%       3.67 ± 62%     -27.4%       2.50 ± 60%  interrupts.CPU63.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU64.250:PCI-MSI.18874443-edge.nvme0q75
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU64.253:PCI-MSI.18874443-edge.nvme0q75
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU64.255:PCI-MSI.18874443-edge.nvme0q75
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU64.268:PCI-MSI.18874443-edge.nvme0q75
     43747 ± 34%     -12.2%      38418 ± 21%      -1.1%      43246 ± 22%  interrupts.CPU64.CAL:Function_call_interrupts
      5.11 ± 19%     +43.5%       7.33 ± 12%     +21.3%       6.20 ±  9%  interrupts.CPU64.IWI:IRQ_work_interrupts
   1102664            -9.6%     997260 ±  4%      +0.2%    1104949 ±  2%  interrupts.CPU64.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU64.MCP:Machine_check_polls
      6334 ± 34%     +43.9%       9118           +39.5%       8834        interrupts.CPU64.NMI:Non-maskable_interrupts
      6334 ± 34%     +43.9%       9118           +39.5%       8834        interrupts.CPU64.PMI:Performance_monitoring_interrupts
    922618 ±  5%     -28.5%     659468 ± 10%      -3.4%     891246 ±  6%  interrupts.CPU64.RES:Rescheduling_interrupts
      3.78 ± 64%      -8.8%       3.44 ± 58%     -36.5%       2.40 ± 59%  interrupts.CPU64.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU65.257:PCI-MSI.18874444-edge.nvme0q76
     40107 ± 28%      -4.5%      38303 ± 25%     +21.7%      48806 ± 37%  interrupts.CPU65.CAL:Function_call_interrupts
      5.56 ± 22%     +32.0%       7.33 ± 12%      +8.0%       6.00 ± 14%  interrupts.CPU65.IWI:IRQ_work_interrupts
   1102693            -9.6%     997321 ±  4%      +0.2%    1104921 ±  2%  interrupts.CPU65.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU65.MCP:Machine_check_polls
      7304 ± 27%     +24.8%       9113           +14.9%       8395 ± 15%  interrupts.CPU65.NMI:Non-maskable_interrupts
      7304 ± 27%     +24.8%       9113           +14.9%       8395 ± 15%  interrupts.CPU65.PMI:Performance_monitoring_interrupts
    918276 ±  4%     -25.8%     681207 ± 10%      +0.2%     920099 ±  5%  interrupts.CPU65.RES:Rescheduling_interrupts
      3.22 ± 61%     +44.8%       4.67 ± 44%     -50.3%       1.60 ± 84%  interrupts.CPU65.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU66.261:PCI-MSI.18874445-edge.nvme0q77
     47027 ± 39%     -17.5%      38780 ± 24%      -7.7%      43411 ± 30%  interrupts.CPU66.CAL:Function_call_interrupts
      5.56 ± 22%     +32.0%       7.33 ± 22%      +8.0%       6.00 ± 14%  interrupts.CPU66.IWI:IRQ_work_interrupts
   1102678            -9.5%     997553 ±  4%      +0.2%    1104962 ±  2%  interrupts.CPU66.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU66.MCP:Machine_check_polls
      7319 ± 28%     +17.6%       8611 ± 16%     +14.7%       8394 ± 15%  interrupts.CPU66.NMI:Non-maskable_interrupts
      7319 ± 28%     +17.6%       8611 ± 16%     +14.7%       8394 ± 15%  interrupts.CPU66.PMI:Performance_monitoring_interrupts
    948840 ±  6%     -29.4%     669534 ±  8%      -2.4%     925859 ±  5%  interrupts.CPU66.RES:Rescheduling_interrupts
      3.22 ± 79%     +13.8%       3.67 ± 77%     -41.0%       1.90 ± 68%  interrupts.CPU66.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU67.261:PCI-MSI.18874446-edge.nvme0q78
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU67.270:PCI-MSI.18874446-edge.nvme0q78
     45631 ± 36%     -16.2%      38223 ± 25%      -1.1%      45146 ± 29%  interrupts.CPU67.CAL:Function_call_interrupts
      5.56 ± 22%     +34.0%       7.44 ± 11%      +8.0%       6.00 ± 14%  interrupts.CPU67.IWI:IRQ_work_interrupts
   1102673            -9.6%     997325 ±  4%      +0.2%    1104952 ±  2%  interrupts.CPU67.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU67.MCP:Machine_check_polls
      7316 ± 28%     +24.6%       9119           +14.7%       8394 ± 15%  interrupts.CPU67.NMI:Non-maskable_interrupts
      7316 ± 28%     +24.6%       9119           +14.7%       8394 ± 15%  interrupts.CPU67.PMI:Performance_monitoring_interrupts
    915928 ±  3%     -27.1%     667733 ± 11%      +1.2%     926793 ±  4%  interrupts.CPU67.RES:Rescheduling_interrupts
      3.44 ± 58%     +25.8%       4.33 ± 59%     -44.8%       1.90 ± 54%  interrupts.CPU67.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU68.256:PCI-MSI.18874447-edge.nvme0q79
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU68.282:PCI-MSI.18874447-edge.nvme0q79
     54830 ± 35%     -30.2%      38279 ± 29%     -16.4%      45863 ± 35%  interrupts.CPU68.CAL:Function_call_interrupts
      5.78 ± 19%     +23.1%       7.11 ± 13%      +7.3%       6.20 ±  9%  interrupts.CPU68.IWI:IRQ_work_interrupts
   1102648            -9.6%     997314 ±  4%      +0.2%    1104932 ±  2%  interrupts.CPU68.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU68.MCP:Machine_check_polls
      7788 ± 22%     +10.6%       8614 ± 16%     +13.4%       8834        interrupts.CPU68.NMI:Non-maskable_interrupts
      7788 ± 22%     +10.6%       8614 ± 16%     +13.4%       8834        interrupts.CPU68.PMI:Performance_monitoring_interrupts
    929384 ±  5%     -28.2%     667214 ± 10%      +0.8%     937164 ±  5%  interrupts.CPU68.RES:Rescheduling_interrupts
      4.78 ± 56%      -9.3%       4.33 ± 57%     -58.1%       2.00 ± 77%  interrupts.CPU68.TLB:TLB_shootdowns
     52885 ± 46%     -27.0%      38582 ± 28%     -10.2%      47482 ± 25%  interrupts.CPU69.CAL:Function_call_interrupts
      5.78 ± 19%     +23.1%       7.11 ± 13%      +7.3%       6.20 ±  9%  interrupts.CPU69.IWI:IRQ_work_interrupts
   1102670            -9.5%     997444 ±  4%      +0.2%    1104952 ±  2%  interrupts.CPU69.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU69.MCP:Machine_check_polls
      7815 ± 23%     +10.2%       8614 ± 16%     +13.1%       8836        interrupts.CPU69.NMI:Non-maskable_interrupts
      7815 ± 23%     +10.2%       8614 ± 16%     +13.1%       8836        interrupts.CPU69.PMI:Performance_monitoring_interrupts
    942930 ±  4%     -28.3%     676178 ±  9%      -1.8%     925503 ±  5%  interrupts.CPU69.RES:Rescheduling_interrupts
      3.78 ± 49%     +44.1%       5.44 ± 61%     -36.5%       2.40 ± 77%  interrupts.CPU69.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU7.144:PCI-MSI.57149483-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU7.276:PCI-MSI.18874472-edge.nvme0q104
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU7.284:PCI-MSI.18874472-edge.nvme0q104
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU7.287:PCI-MSI.18874472-edge.nvme0q104
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU7.289:PCI-MSI.18874472-edge.nvme0q104
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU7.297:PCI-MSI.18874472-edge.nvme0q104
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU7.79:PCI-MSI.57147435-edge
     30996 ±  7%     -17.2%      25658 ± 12%      +2.4%      31730 ± 19%  interrupts.CPU7.CAL:Function_call_interrupts
      6.00 ± 15%     +18.5%       7.11 ± 13%     -10.0%       5.40 ± 16%  interrupts.CPU7.IWI:IRQ_work_interrupts
   1102592            -9.7%     995913 ±  4%      +0.2%    1105051 ±  2%  interrupts.CPU7.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU7.MCP:Machine_check_polls
      8282 ± 17%      +4.0%       8615 ± 16%     -16.3%       6934 ± 30%  interrupts.CPU7.NMI:Non-maskable_interrupts
      8282 ± 17%      +4.0%       8615 ± 16%     -16.3%       6934 ± 30%  interrupts.CPU7.PMI:Performance_monitoring_interrupts
    764459 ±  6%     -26.7%     560666 ±  6%      +0.0%     764762 ±  5%  interrupts.CPU7.RES:Rescheduling_interrupts
      2.11 ± 64%     -10.5%       1.89 ± 76%     -38.4%       1.30 ±109%  interrupts.CPU7.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU70.266:PCI-MSI.18874449-edge.nvme0q81
     46191 ± 39%     -14.4%      39544 ± 28%      +0.6%      46460 ± 34%  interrupts.CPU70.CAL:Function_call_interrupts
      6.11 ± 16%     +18.2%       7.22 ± 12%      +1.5%       6.20 ±  9%  interrupts.CPU70.IWI:IRQ_work_interrupts
   1102605            -9.5%     997349 ±  4%      +0.2%    1104966 ±  2%  interrupts.CPU70.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU70.MCP:Machine_check_polls
      8318 ± 17%      +3.6%       8619 ± 16%      +6.2%       8837        interrupts.CPU70.NMI:Non-maskable_interrupts
      8318 ± 17%      +3.6%       8619 ± 16%      +6.2%       8837        interrupts.CPU70.PMI:Performance_monitoring_interrupts
    937300 ±  4%     -28.5%     669744 ± 10%      -0.5%     932779 ±  6%  interrupts.CPU70.RES:Rescheduling_interrupts
      4.22 ± 68%     +18.4%       5.00 ± 53%     -43.2%       2.40 ± 83%  interrupts.CPU70.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU71.257:PCI-MSI.18874450-edge.nvme0q82
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU71.265:PCI-MSI.18874450-edge.nvme0q82
     51612 ± 24%     -12.6%      45095 ± 22%      +1.4%      52332 ± 29%  interrupts.CPU71.CAL:Function_call_interrupts
      5.56 ± 14%     +28.0%       7.11 ± 13%     +13.4%       6.30 ± 10%  interrupts.CPU71.IWI:IRQ_work_interrupts
   1102770            -9.6%     997403 ±  4%      +0.2%    1105016 ±  2%  interrupts.CPU71.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU71.MCP:Machine_check_polls
      7315 ± 28%     +17.8%       8613 ± 16%     +20.8%       8837        interrupts.CPU71.NMI:Non-maskable_interrupts
      7315 ± 28%     +17.8%       8613 ± 16%     +20.8%       8837        interrupts.CPU71.PMI:Performance_monitoring_interrupts
    920036 ±  4%     -26.7%     674372 ± 10%      +0.1%     921058 ±  4%  interrupts.CPU71.RES:Rescheduling_interrupts
      4.00 ± 55%      +5.6%       4.22 ± 45%     -40.0%       2.40 ± 75%  interrupts.CPU71.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU72.172:PCI-MSI.18874368-edge.nvme0q0
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU72.172:PCI-MSI.71680-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU72.172:PCI-MSI.73728-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU72.269:PCI-MSI.18874465-edge.nvme0q97
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU72.270:PCI-MSI.18874465-edge.nvme0q97
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU72.273:PCI-MSI.18874465-edge.nvme0q97
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU72.275:PCI-MSI.18874465-edge.nvme0q97
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU72.277:PCI-MSI.18874465-edge.nvme0q97
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU72.278:PCI-MSI.18874465-edge.nvme0q97
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU72.280:PCI-MSI.18874465-edge.nvme0q97
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU72.287:PCI-MSI.18874465-edge.nvme0q97
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU72.289:PCI-MSI.18874465-edge.nvme0q97
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU72.290:PCI-MSI.18874465-edge.nvme0q97
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU72.300:PCI-MSI.18874465-edge.nvme0q97
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU72.301:PCI-MSI.69632-edge.ioat-msix
     48595 ± 17%     -33.9%      32105 ± 18%      -2.8%      47232 ± 36%  interrupts.CPU72.CAL:Function_call_interrupts
      6.00 ± 15%     +20.4%       7.22 ± 15%      +0.0%       6.00 ± 14%  interrupts.CPU72.IWI:IRQ_work_interrupts
   1102598            -9.6%     996324 ±  4%      +0.2%    1104995 ±  2%  interrupts.CPU72.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU72.MCP:Machine_check_polls
      8257 ± 16%      +4.3%       8609 ± 16%      -0.4%       8225 ± 15%  interrupts.CPU72.NMI:Non-maskable_interrupts
      8257 ± 16%      +4.3%       8609 ± 16%      -0.4%       8225 ± 15%  interrupts.CPU72.PMI:Performance_monitoring_interrupts
    737070 ±  6%     -27.6%     533892 ±  8%      -0.2%     735837 ±  8%  interrupts.CPU72.RES:Rescheduling_interrupts
      3.78 ±100%     +17.6%       4.44 ± 68%     -60.3%       1.50 ± 53%  interrupts.CPU72.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU73.173:PCI-MSI.73728-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU73.173:PCI-MSI.75776-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU73.175:PCI-MSI.73728-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU73.175:PCI-MSI.75776-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU73.270:PCI-MSI.18874466-edge.nvme0q98
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU73.271:PCI-MSI.18874466-edge.nvme0q98
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU73.274:PCI-MSI.18874466-edge.nvme0q98
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU73.275:PCI-MSI.18874466-edge.nvme0q98
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU73.276:PCI-MSI.18874466-edge.nvme0q98
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU73.279:PCI-MSI.18874466-edge.nvme0q98
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU73.281:PCI-MSI.18874466-edge.nvme0q98
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU73.283:PCI-MSI.18874466-edge.nvme0q98
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU73.284:PCI-MSI.18874466-edge.nvme0q98
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU73.288:PCI-MSI.18874466-edge.nvme0q98
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU73.291:PCI-MSI.18874466-edge.nvme0q98
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU73.301:PCI-MSI.18874466-edge.nvme0q98
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU73.302:PCI-MSI.71680-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU73.303:PCI-MSI.71680-edge.ioat-msix
     34380 ± 25%     -20.1%      27476 ± 11%     +19.1%      40956 ± 46%  interrupts.CPU73.CAL:Function_call_interrupts
      5.78 ± 19%     +26.9%       7.33 ± 12%      +2.1%       5.90 ± 19%  interrupts.CPU73.IWI:IRQ_work_interrupts
   1102639            -9.7%     995562 ±  4%      +0.2%    1105028 ±  2%  interrupts.CPU73.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU73.MCP:Machine_check_polls
      7776 ± 23%     +17.2%       9116            +0.2%       7794 ± 21%  interrupts.CPU73.NMI:Non-maskable_interrupts
      7776 ± 23%     +17.2%       9116            +0.2%       7794 ± 21%  interrupts.CPU73.PMI:Performance_monitoring_interrupts
    754086 ±  5%     -28.0%     542917 ±  6%      -1.8%     740283 ±  7%  interrupts.CPU73.RES:Rescheduling_interrupts
      4.11 ± 60%     -35.1%       2.67 ± 70%      -7.6%       3.80 ± 88%  interrupts.CPU73.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU74.174:PCI-MSI.18874368-edge.nvme0q0
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU74.174:PCI-MSI.75776-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU74.174:PCI-MSI.77824-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU74.176:PCI-MSI.75776-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU74.271:PCI-MSI.18874467-edge.nvme0q99
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU74.279:PCI-MSI.18874467-edge.nvme0q99
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU74.282:PCI-MSI.18874467-edge.nvme0q99
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU74.284:PCI-MSI.18874467-edge.nvme0q99
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU74.292:PCI-MSI.18874467-edge.nvme0q99
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU74.302:PCI-MSI.18874467-edge.nvme0q99
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU74.303:PCI-MSI.71680-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU74.303:PCI-MSI.73728-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU74.304:PCI-MSI.73728-edge.ioat-msix
     37357 ± 33%     -25.4%      27866 ±  8%      -6.4%      34950 ± 23%  interrupts.CPU74.CAL:Function_call_interrupts
      5.56 ± 22%     +32.0%       7.33 ± 12%      +8.0%       6.00 ± 14%  interrupts.CPU74.IWI:IRQ_work_interrupts
   1102584            -9.7%     995632 ±  4%      +0.2%    1105026 ±  2%  interrupts.CPU74.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU74.MCP:Machine_check_polls
      7277 ± 27%     +25.2%       9112           +13.1%       8228 ± 15%  interrupts.CPU74.NMI:Non-maskable_interrupts
      7277 ± 27%     +25.2%       9112           +13.1%       8228 ± 15%  interrupts.CPU74.PMI:Performance_monitoring_interrupts
    741780 ±  5%     -27.3%     539018 ±  9%      +0.1%     742346 ±  9%  interrupts.CPU74.RES:Rescheduling_interrupts
      2.78 ± 47%      +0.0%       2.78 ± 77%     -53.2%       1.30 ±109%  interrupts.CPU74.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU75.172:PCI-MSI.18874368-edge.nvme0q0
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU75.174:PCI-MSI.18874368-edge.nvme0q0
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU75.175:PCI-MSI.77824-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU75.175:PCI-MSI.79872-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU75.176:PCI-MSI.18874368-edge.nvme0q0
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU75.177:PCI-MSI.77824-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU75.273:PCI-MSI.18874468-edge.nvme0q100
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU75.276:PCI-MSI.18874468-edge.nvme0q100
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU75.280:PCI-MSI.18874468-edge.nvme0q100
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU75.281:PCI-MSI.18874468-edge.nvme0q100
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU75.283:PCI-MSI.18874468-edge.nvme0q100
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU75.285:PCI-MSI.18874468-edge.nvme0q100
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU75.303:PCI-MSI.18874468-edge.nvme0q100
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU75.304:PCI-MSI.73728-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU75.304:PCI-MSI.75776-edge.ioat-msix
     32580 ± 24%     -11.0%      29007 ± 14%     +11.1%      36208 ± 32%  interrupts.CPU75.CAL:Function_call_interrupts
      5.56 ± 22%     +40.0%       7.78 ± 10%     +13.4%       6.30 ± 12%  interrupts.CPU75.IWI:IRQ_work_interrupts
   1102550            -9.7%     995615 ±  4%      +0.2%    1105065 ±  2%  interrupts.CPU75.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU75.MCP:Machine_check_polls
      7266 ± 27%     +25.6%       9129           +13.3%       8230 ± 15%  interrupts.CPU75.NMI:Non-maskable_interrupts
      7266 ± 27%     +25.6%       9129           +13.3%       8230 ± 15%  interrupts.CPU75.PMI:Performance_monitoring_interrupts
    721170 ±  4%     -24.5%     544262 ±  7%      +2.2%     736853 ±  6%  interrupts.CPU75.RES:Rescheduling_interrupts
      3.22 ± 63%     -27.6%       2.33 ± 67%     -72.1%       0.90 ±152%  interrupts.CPU75.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU76.176:PCI-MSI.79872-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU76.177:PCI-MSI.77824-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU76.178:PCI-MSI.79872-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU76.180:PCI-MSI.79872-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU76.181:PCI-MSI.18874368-edge.nvme0q0
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU76.291:PCI-MSI.18874483-edge.nvme0q115
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU76.295:PCI-MSI.18874483-edge.nvme0q115
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU76.305:PCI-MSI.18874483-edge.nvme0q115
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU76.305:PCI-MSI.75776-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU76.305:PCI-MSI.77824-edge.ioat-msix
     26468 ± 20%      +4.3%      27609 ± 17%     +12.7%      29833 ± 24%  interrupts.CPU76.CAL:Function_call_interrupts
      5.33 ± 24%     +37.5%       7.33 ± 12%     +18.1%       6.30 ± 10%  interrupts.CPU76.IWI:IRQ_work_interrupts
   1102598            -9.7%     995551 ±  4%      +0.2%    1105094 ±  2%  interrupts.CPU76.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU76.MCP:Machine_check_polls
      6778 ± 30%     +34.4%       9112           +28.0%       8679 ±  2%  interrupts.CPU76.NMI:Non-maskable_interrupts
      6778 ± 30%     +34.4%       9112           +28.0%       8679 ±  2%  interrupts.CPU76.PMI:Performance_monitoring_interrupts
    723926           -24.3%     547989 ±  7%      +3.8%     751294 ± 10%  interrupts.CPU76.RES:Rescheduling_interrupts
      2.56 ± 61%      +8.7%       2.78 ± 58%     -49.1%       1.30 ± 77%  interrupts.CPU76.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU77.176:PCI-MSI.18874368-edge.nvme0q0
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU77.177:PCI-MSI.18874368-edge.nvme0q0
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU77.180:PCI-MSI.18874368-edge.nvme0q0
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU77.181:PCI-MSI.18874368-edge.nvme0q0
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU77.182:PCI-MSI.18874368-edge.nvme0q0
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU77.184:PCI-MSI.18874368-edge.nvme0q0
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU77.190:PCI-MSI.18874368-edge.nvme0q0
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU77.191:PCI-MSI.18874368-edge.nvme0q0
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU77.192:PCI-MSI.18874368-edge.nvme0q0
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU77.289:PCI-MSI.18874484-edge.nvme0q116
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU77.296:PCI-MSI.18874484-edge.nvme0q116
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU77.299:PCI-MSI.18874484-edge.nvme0q116
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU77.306:PCI-MSI.77824-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU77.306:PCI-MSI.79872-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU77.309:PCI-MSI.18874484-edge.nvme0q116
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU77.319:PCI-MSI.18874484-edge.nvme0q116
     32538 ± 28%     -21.0%      25720 ± 11%      +1.1%      32891 ± 35%  interrupts.CPU77.CAL:Function_call_interrupts
      5.56 ± 22%     +28.0%       7.11 ± 19%     +11.6%       6.20 ±  9%  interrupts.CPU77.IWI:IRQ_work_interrupts
   1102611            -9.7%     995304 ±  4%      +0.2%    1105095 ±  2%  interrupts.CPU77.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU77.MCP:Machine_check_polls
      7265 ± 27%     +18.5%       8607 ± 16%     +19.4%       8676 ±  2%  interrupts.CPU77.NMI:Non-maskable_interrupts
      7265 ± 27%     +18.5%       8607 ± 16%     +19.4%       8676 ±  2%  interrupts.CPU77.PMI:Performance_monitoring_interrupts
    720791 ±  5%     -25.4%     537537 ±  8%      +4.4%     752531 ±  9%  interrupts.CPU77.RES:Rescheduling_interrupts
      3.22 ± 63%      -6.9%       3.00 ± 44%     -53.4%       1.50 ±120%  interrupts.CPU77.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU78.180:PCI-MSI.18874368-edge.nvme0q0
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU78.181:PCI-MSI.18874368-edge.nvme0q0
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU78.182:PCI-MSI.18874368-edge.nvme0q0
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU78.183:PCI-MSI.18874368-edge.nvme0q0
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU78.193:PCI-MSI.18874368-edge.nvme0q0
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU78.203:PCI-MSI.18874368-edge.nvme0q0
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU78.297:PCI-MSI.18874485-edge.nvme0q117
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU78.300:PCI-MSI.18874485-edge.nvme0q117
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU78.307:PCI-MSI.79872-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU78.309:PCI-MSI.18874485-edge.nvme0q117
     30667 ± 23%     -14.3%      26271 ± 17%      -4.6%      29271 ± 26%  interrupts.CPU78.CAL:Function_call_interrupts
      5.33 ± 24%     +37.5%       7.33 ± 12%     +16.2%       6.20 ±  9%  interrupts.CPU78.IWI:IRQ_work_interrupts
   1102669            -9.7%     995488 ±  4%      +0.2%    1105062 ±  2%  interrupts.CPU78.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU78.MCP:Machine_check_polls
      6781 ± 30%     +34.4%       9113           +27.9%       8672 ±  2%  interrupts.CPU78.NMI:Non-maskable_interrupts
      6781 ± 30%     +34.4%       9113           +27.9%       8672 ±  2%  interrupts.CPU78.PMI:Performance_monitoring_interrupts
    761786 ±  7%     -27.7%     550677 ±  7%      -1.5%     750256 ±  8%  interrupts.CPU78.RES:Rescheduling_interrupts
      3.44 ± 56%     -35.5%       2.22 ± 66%     -47.7%       1.80 ±101%  interrupts.CPU78.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU79.291:PCI-MSI.18874486-edge.nvme0q118
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU79.301:PCI-MSI.18874486-edge.nvme0q118
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU79.304:PCI-MSI.18874486-edge.nvme0q118
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU79.308:PCI-MSI.18874486-edge.nvme0q118
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU79.311:PCI-MSI.18874486-edge.nvme0q118
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU79.3:IO-APIC.3-edge
     29526 ± 25%     -11.2%      26219 ±  9%      +1.7%      30041 ± 20%  interrupts.CPU79.CAL:Function_call_interrupts
      5.67 ± 26%     +21.6%       6.89 ± 14%      +9.4%       6.20 ± 17%  interrupts.CPU79.IWI:IRQ_work_interrupts
   1102596            -9.7%     995700 ±  4%      +0.2%    1105061 ±  2%  interrupts.CPU79.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU79.MCP:Machine_check_polls
      7280 ± 27%     +11.4%       8108 ± 23%     +13.3%       8250 ± 16%  interrupts.CPU79.NMI:Non-maskable_interrupts
      7280 ± 27%     +11.4%       8108 ± 23%     +13.3%       8250 ± 16%  interrupts.CPU79.PMI:Performance_monitoring_interrupts
    730407 ±  5%     -23.7%     557609 ±  6%      +1.5%     741379 ±  8%  interrupts.CPU79.RES:Rescheduling_interrupts
      2.56 ± 74%     +17.4%       3.00 ± 52%     -21.7%       2.00 ± 77%  interrupts.CPU79.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU8.145:PCI-MSI.57149484-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU8.278:PCI-MSI.18874473-edge.nvme0q105
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU8.281:PCI-MSI.18874473-edge.nvme0q105
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU8.285:PCI-MSI.18874473-edge.nvme0q105
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU8.288:PCI-MSI.18874473-edge.nvme0q105
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU8.290:PCI-MSI.18874473-edge.nvme0q105
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU8.297:PCI-MSI.18874473-edge.nvme0q105
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU8.308:PCI-MSI.18874473-edge.nvme0q105
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU8.30:PCI-MSI.524288-edge.eth0
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU8.80:PCI-MSI.57147436-edge
     28971 ± 19%      -7.2%      26898 ±  8%      +2.0%      29557 ± 19%  interrupts.CPU8.CAL:Function_call_interrupts
      6.22 ± 10%     +10.7%       6.89 ± 14%     -13.2%       5.40 ± 16%  interrupts.CPU8.IWI:IRQ_work_interrupts
   1102596            -9.7%     995621 ±  4%      +0.2%    1105096 ±  2%  interrupts.CPU8.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU8.MCP:Machine_check_polls
      8753 ±  2%      -7.3%       8115 ± 23%     -20.8%       6931 ± 30%  interrupts.CPU8.NMI:Non-maskable_interrupts
      8753 ±  2%      -7.3%       8115 ± 23%     -20.8%       6931 ± 30%  interrupts.CPU8.PMI:Performance_monitoring_interrupts
    769541 ±  5%     -28.2%     552881 ±  6%      -1.3%     759434 ±  6%  interrupts.CPU8.RES:Rescheduling_interrupts
      2.11 ± 64%     +63.2%       3.44 ± 54%     -24.2%       1.60 ± 75%  interrupts.CPU8.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU80.299:PCI-MSI.18874487-edge.nvme0q119
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU80.300:PCI-MSI.18874487-edge.nvme0q119
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU80.302:PCI-MSI.18874487-edge.nvme0q119
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU80.312:PCI-MSI.18874487-edge.nvme0q119
     30701 ± 29%     -12.1%      26981 ±  7%     +11.2%      34134 ± 36%  interrupts.CPU80.CAL:Function_call_interrupts
      5.78 ± 19%     +23.1%       7.11 ± 19%      +7.3%       6.20 ±  9%  interrupts.CPU80.IWI:IRQ_work_interrupts
   1102620            -9.7%     995507 ±  4%      +0.2%    1105070 ±  2%  interrupts.CPU80.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU80.MCP:Machine_check_polls
      7764 ± 22%     +10.8%       8606 ± 16%     +11.7%       8674 ±  2%  interrupts.CPU80.NMI:Non-maskable_interrupts
      7764 ± 22%     +10.8%       8606 ± 16%     +11.7%       8674 ±  2%  interrupts.CPU80.PMI:Performance_monitoring_interrupts
    743959 ±  4%     -25.8%     551875 ±  9%      +0.5%     747738 ±  7%  interrupts.CPU80.RES:Rescheduling_interrupts
      2.67 ± 68%     +29.2%       3.44 ± 56%     -21.2%       2.10 ± 91%  interrupts.CPU80.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU81.295:PCI-MSI.18874488-edge.nvme0q120
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU81.298:PCI-MSI.18874488-edge.nvme0q120
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU81.300:PCI-MSI.18874488-edge.nvme0q120
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU81.301:PCI-MSI.18874488-edge.nvme0q120
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU81.305:PCI-MSI.18874488-edge.nvme0q120
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU81.313:PCI-MSI.18874488-edge.nvme0q120
     39391 ± 71%     -32.6%      26548 ± 16%     -13.0%      34262 ± 38%  interrupts.CPU81.CAL:Function_call_interrupts
      6.00 ± 15%     +18.5%       7.11 ± 19%      +1.7%       6.10 ± 15%  interrupts.CPU81.IWI:IRQ_work_interrupts
   1102652            -9.7%     995260 ±  4%      +0.2%    1105104 ±  2%  interrupts.CPU81.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU81.MCP:Machine_check_polls
      8252 ± 16%      +4.3%       8605 ± 16%      -0.0%       8249 ± 16%  interrupts.CPU81.NMI:Non-maskable_interrupts
      8252 ± 16%      +4.3%       8605 ± 16%      -0.0%       8249 ± 16%  interrupts.CPU81.PMI:Performance_monitoring_interrupts
    739970 ±  6%     -26.3%     545494 ±  9%      +2.2%     756604 ± 10%  interrupts.CPU81.RES:Rescheduling_interrupts
      2.22 ± 59%     +45.0%       3.22 ± 58%      -1.0%       2.20 ± 72%  interrupts.CPU81.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU82.294:PCI-MSI.18874489-edge.nvme0q121
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU82.297:PCI-MSI.18874489-edge.nvme0q121
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU82.302:PCI-MSI.18874489-edge.nvme0q121
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU82.304:PCI-MSI.18874489-edge.nvme0q121
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU82.311:PCI-MSI.18874489-edge.nvme0q121
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU82.314:PCI-MSI.18874489-edge.nvme0q121
     32304 ± 18%     -14.8%      27518 ± 15%     +11.0%      35862 ± 59%  interrupts.CPU82.CAL:Function_call_interrupts
      6.00 ± 15%     +18.5%       7.11 ± 19%      +3.3%       6.20 ±  9%  interrupts.CPU82.IWI:IRQ_work_interrupts
   1102562            -9.7%     995642 ±  4%      +0.2%    1105051 ±  2%  interrupts.CPU82.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU82.MCP:Machine_check_polls
      8262 ± 16%      +4.2%       8605 ± 16%      +5.0%       8676 ±  2%  interrupts.CPU82.NMI:Non-maskable_interrupts
      8262 ± 16%      +4.2%       8605 ± 16%      +5.0%       8676 ±  2%  interrupts.CPU82.PMI:Performance_monitoring_interrupts
    732225 ±  4%     -25.8%     543154 ±  7%      +5.4%     771994 ± 10%  interrupts.CPU82.RES:Rescheduling_interrupts
      2.11 ± 75%     +63.2%       3.44 ± 76%     -38.4%       1.30 ±103%  interrupts.CPU82.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU83.302:PCI-MSI.18874490-edge.nvme0q122
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU83.305:PCI-MSI.18874490-edge.nvme0q122
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU83.312:PCI-MSI.18874490-edge.nvme0q122
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU83.315:PCI-MSI.18874490-edge.nvme0q122
     34245 ± 39%     -20.6%      27193 ± 14%     +10.6%      37864 ± 62%  interrupts.CPU83.CAL:Function_call_interrupts
      6.22 ± 16%     +10.7%       6.89 ± 19%      -2.0%       6.10 ± 15%  interrupts.CPU83.IWI:IRQ_work_interrupts
   1102620            -9.7%     995508 ±  4%      +0.2%    1105084 ±  2%  interrupts.CPU83.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU83.MCP:Machine_check_polls
      8271 ± 16%      -2.1%       8100 ± 23%      -0.3%       8250 ± 16%  interrupts.CPU83.NMI:Non-maskable_interrupts
      8271 ± 16%      -2.1%       8100 ± 23%      -0.3%       8250 ± 16%  interrupts.CPU83.PMI:Performance_monitoring_interrupts
    752495 ±  5%     -26.0%     556731 ±  8%      +2.3%     769457 ±  9%  interrupts.CPU83.RES:Rescheduling_interrupts
      2.33 ± 67%     +38.1%       3.22 ± 59%     -48.6%       1.20 ±116%  interrupts.CPU83.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU84.299:PCI-MSI.18874491-edge.nvme0q123
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU84.303:PCI-MSI.18874491-edge.nvme0q123
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU84.306:PCI-MSI.18874491-edge.nvme0q123
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU84.309:PCI-MSI.18874491-edge.nvme0q123
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU84.316:PCI-MSI.18874491-edge.nvme0q123
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU84.326:PCI-MSI.18874491-edge.nvme0q123
     31109 ± 29%     -13.4%      26945 ± 13%      -1.8%      30560 ± 30%  interrupts.CPU84.CAL:Function_call_interrupts
      6.44 ± 12%      +6.9%       6.89 ± 19%      -6.9%       6.00 ± 14%  interrupts.CPU84.IWI:IRQ_work_interrupts
   1102618            -9.7%     995657 ±  4%      +0.2%    1105041 ±  2%  interrupts.CPU84.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU84.MCP:Machine_check_polls
      8760 ±  2%      -7.5%       8099 ± 23%      -5.8%       8255 ± 16%  interrupts.CPU84.NMI:Non-maskable_interrupts
      8760 ±  2%      -7.5%       8099 ± 23%      -5.8%       8255 ± 16%  interrupts.CPU84.PMI:Performance_monitoring_interrupts
    751363 ±  5%     -27.0%     548733 ±  8%      -2.4%     733036 ±  9%  interrupts.CPU84.RES:Rescheduling_interrupts
      2.56 ± 61%      +4.3%       2.67 ± 53%     +13.5%       2.90 ±143%  interrupts.CPU84.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU85.316:PCI-MSI.18874492-edge.nvme0q124
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU85.317:PCI-MSI.18874492-edge.nvme0q124
     31739 ± 45%     -16.1%      26639 ± 13%      -3.1%      30755 ± 31%  interrupts.CPU85.CAL:Function_call_interrupts
      5.56 ± 22%     +28.0%       7.11 ± 19%     +11.6%       6.20 ±  9%  interrupts.CPU85.IWI:IRQ_work_interrupts
   1102578            -9.7%     995476 ±  4%      +0.2%    1105037 ±  2%  interrupts.CPU85.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU85.MCP:Machine_check_polls
      7273 ± 27%     +18.3%       8603 ± 16%     +19.3%       8677 ±  2%  interrupts.CPU85.NMI:Non-maskable_interrupts
      7273 ± 27%     +18.3%       8603 ± 16%     +19.3%       8677 ±  2%  interrupts.CPU85.PMI:Performance_monitoring_interrupts
    708392 ±  4%     -22.6%     548414 ±  8%      +5.4%     746297 ±  8%  interrupts.CPU85.RES:Rescheduling_interrupts
      2.78 ± 75%      +4.0%       2.89 ± 59%     -31.6%       1.90 ± 54%  interrupts.CPU85.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU86.303:PCI-MSI.18874493-edge.nvme0q125
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU86.310:PCI-MSI.18874493-edge.nvme0q125
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU86.317:PCI-MSI.18874493-edge.nvme0q125
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU86.318:PCI-MSI.18874493-edge.nvme0q125
     32038 ± 20%     -15.4%      27090 ± 13%      -5.2%      30371 ± 37%  interrupts.CPU86.CAL:Function_call_interrupts
      6.00 ± 15%     +18.5%       7.11 ± 19%      -1.7%       5.90 ± 11%  interrupts.CPU86.IWI:IRQ_work_interrupts
   1102663            -9.7%     995765 ±  4%      +0.2%    1105048 ±  2%  interrupts.CPU86.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU86.MCP:Machine_check_polls
      8253 ± 16%      +4.3%       8606 ± 16%      -5.1%       7831 ± 23%  interrupts.CPU86.NMI:Non-maskable_interrupts
      8253 ± 16%      +4.3%       8606 ± 16%      -5.1%       7831 ± 23%  interrupts.CPU86.PMI:Performance_monitoring_interrupts
    749937 ±  4%     -26.8%     548828 ±  7%      +0.6%     754335 ±  8%  interrupts.CPU86.RES:Rescheduling_interrupts
      2.56 ± 71%      +8.7%       2.78 ± 50%      -6.1%       2.40 ± 67%  interrupts.CPU86.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU87.298:PCI-MSI.18874494-edge.nvme0q126
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU87.304:PCI-MSI.18874494-edge.nvme0q126
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU87.306:PCI-MSI.18874494-edge.nvme0q126
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU87.309:PCI-MSI.18874494-edge.nvme0q126
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU87.311:PCI-MSI.18874494-edge.nvme0q126
     30543 ± 42%     -11.8%      26936 ±  8%      +1.1%      30882 ± 22%  interrupts.CPU87.CAL:Function_call_interrupts
      5.56 ± 22%     +36.0%       7.56 ± 16%      +8.0%       6.00 ± 14%  interrupts.CPU87.IWI:IRQ_work_interrupts
   1102646            -9.7%     995775 ±  4%      +0.2%    1105033 ±  2%  interrupts.CPU87.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU87.MCP:Machine_check_polls
      7280 ± 27%     +25.2%       9115           +13.3%       8246 ± 16%  interrupts.CPU87.NMI:Non-maskable_interrupts
      7280 ± 27%     +25.2%       9115           +13.3%       8246 ± 16%  interrupts.CPU87.PMI:Performance_monitoring_interrupts
    755675 ±  5%     -27.5%     547616 ±  6%      -0.7%     750075 ± 11%  interrupts.CPU87.RES:Rescheduling_interrupts
      2.78 ± 71%     -24.0%       2.11 ± 64%     -42.4%       1.60 ± 75%  interrupts.CPU87.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU88.305:PCI-MSI.18874495-edge.nvme0q127
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU88.307:PCI-MSI.18874495-edge.nvme0q127
     31789 ± 46%     -14.2%      27272 ± 13%      -6.7%      29661 ± 18%  interrupts.CPU88.CAL:Function_call_interrupts
      5.89 ± 20%     +20.8%       7.11 ± 19%      +5.3%       6.20 ±  9%  interrupts.CPU88.IWI:IRQ_work_interrupts
   1102646            -9.7%     996023 ±  4%      +0.2%    1105077 ±  2%  interrupts.CPU88.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU88.MCP:Machine_check_polls
      7771 ± 23%     +10.8%       8610 ± 16%     +11.7%       8681 ±  2%  interrupts.CPU88.NMI:Non-maskable_interrupts
      7771 ± 23%     +10.8%       8610 ± 16%     +11.7%       8681 ±  2%  interrupts.CPU88.PMI:Performance_monitoring_interrupts
    730343 ±  4%     -25.5%     544318 ±  6%      +5.9%     773447 ±  8%  interrupts.CPU88.RES:Rescheduling_interrupts
      2.89 ± 55%      +0.0%       2.89 ± 50%     -30.8%       2.00 ± 77%  interrupts.CPU88.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU89.300:PCI-MSI.18874496-edge.nvme0q128
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU89.301:PCI-MSI.18874496-edge.nvme0q128
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU89.306:PCI-MSI.18874496-edge.nvme0q128
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU89.311:PCI-MSI.18874496-edge.nvme0q128
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU89.314:PCI-MSI.18874496-edge.nvme0q128
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU89.321:PCI-MSI.18874496-edge.nvme0q128
     29640 ± 18%      -8.6%      27095 ± 17%     -14.7%      25280 ± 21%  interrupts.CPU89.CAL:Function_call_interrupts
      5.56 ± 22%     +34.0%       7.44 ± 14%      +4.4%       5.80 ± 18%  interrupts.CPU89.IWI:IRQ_work_interrupts
   1102625            -9.7%     995907 ±  4%      +0.2%    1105065 ±  2%  interrupts.CPU89.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU89.MCP:Machine_check_polls
      7279 ± 27%     +25.3%       9121            +7.5%       7822 ± 23%  interrupts.CPU89.NMI:Non-maskable_interrupts
      7279 ± 27%     +25.3%       9121            +7.5%       7822 ± 23%  interrupts.CPU89.PMI:Performance_monitoring_interrupts
    732759 ±  4%     -26.5%     538640 ±  8%      -3.0%     710691 ±  7%  interrupts.CPU89.RES:Rescheduling_interrupts
      2.44 ± 69%      +0.0%       2.44 ± 58%     -59.1%       1.00 ±134%  interrupts.CPU89.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU9.146:PCI-MSI.57149485-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU9.279:PCI-MSI.18874474-edge.nvme0q106
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU9.282:PCI-MSI.18874474-edge.nvme0q106
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU9.286:PCI-MSI.18874474-edge.nvme0q106
     23354 ±156%     +25.7%      29351 ±160%    +100.6%      46845 ±111%  interrupts.CPU9.31:PCI-MSI.524289-edge.eth0-TxRx-0
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU9.81:PCI-MSI.57147437-edge
     33466 ± 33%     -17.4%      27649 ± 14%     +14.4%      38274 ± 39%  interrupts.CPU9.CAL:Function_call_interrupts
      5.78 ± 19%     +23.1%       7.11 ± 13%      -1.3%       5.70 ± 15%  interrupts.CPU9.IWI:IRQ_work_interrupts
   1102786            -9.7%     995365 ±  4%      +0.2%    1105206 ±  2%  interrupts.CPU9.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU9.MCP:Machine_check_polls
      7792 ± 23%     +10.5%       8609 ± 16%      -5.5%       7361 ± 26%  interrupts.CPU9.NMI:Non-maskable_interrupts
      7792 ± 23%     +10.5%       8609 ± 16%      -5.5%       7361 ± 26%  interrupts.CPU9.PMI:Performance_monitoring_interrupts
    757271 ±  7%     -27.1%     552370 ±  6%      -0.1%     756263 ±  8%  interrupts.CPU9.RES:Rescheduling_interrupts
      3.11 ± 53%     +14.3%       3.56 ± 75%     -42.1%       1.80 ± 77%  interrupts.CPU9.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU90.118:PCI-MSI.57149457-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU90.119:PCI-MSI.57149458-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU90.153:PCI-MSI.57149492-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU90.179:PCI-MSI.18874369-edge.nvme0q1
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU90.53:PCI-MSI.57147409-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU90.54:PCI-MSI.57147410-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU90.89:PCI-MSI.57147445-edge
     83831 ± 22%     -31.2%      57644 ± 23%      +0.3%      84054 ± 27%  interrupts.CPU90.CAL:Function_call_interrupts
      5.78 ± 19%     +26.9%       7.33 ± 12%      +0.4%       5.80 ± 18%  interrupts.CPU90.IWI:IRQ_work_interrupts
   1102568            -9.6%     996243 ±  4%      +0.2%    1105017 ±  2%  interrupts.CPU90.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU90.MCP:Machine_check_polls
      7604 ± 23%     +19.6%       9092            +1.9%       7751 ± 21%  interrupts.CPU90.NMI:Non-maskable_interrupts
      7604 ± 23%     +19.6%       9092            +1.9%       7751 ± 21%  interrupts.CPU90.PMI:Performance_monitoring_interrupts
    880747 ±  7%     -29.9%     616977 ± 10%      +3.2%     908516 ±  6%  interrupts.CPU90.RES:Rescheduling_interrupts
      3.22 ± 61%     +27.6%       4.11 ± 58%     -19.3%       2.60 ± 60%  interrupts.CPU90.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU91.119:PCI-MSI.57149458-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU91.120:PCI-MSI.57149459-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU91.154:PCI-MSI.57149493-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU91.179:PCI-MSI.18874370-edge.nvme0q2
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU91.54:PCI-MSI.57147410-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU91.55:PCI-MSI.57147411-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU91.90:PCI-MSI.57147446-edge
     53955 ± 26%     -16.5%      45060 ± 19%      +5.5%      56941 ± 27%  interrupts.CPU91.CAL:Function_call_interrupts
      5.78 ± 19%     +26.9%       7.33 ± 12%      +0.4%       5.80 ± 10%  interrupts.CPU91.IWI:IRQ_work_interrupts
   1102535            -9.7%     996024 ±  4%      +0.2%    1104995 ±  2%  interrupts.CPU91.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU91.MCP:Machine_check_polls
      7605 ± 23%     +19.6%       9097            +1.9%       7754 ± 21%  interrupts.CPU91.NMI:Non-maskable_interrupts
      7605 ± 23%     +19.6%       9097            +1.9%       7754 ± 21%  interrupts.CPU91.PMI:Performance_monitoring_interrupts
    900273 ±  7%     -29.8%     632011 ± 10%      -0.4%     896882 ±  4%  interrupts.CPU91.RES:Rescheduling_interrupts
      3.78 ± 58%      +2.9%       3.89 ± 56%     -15.3%       3.20 ± 60%  interrupts.CPU91.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU92.120:PCI-MSI.57149459-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU92.121:PCI-MSI.57149460-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU92.155:PCI-MSI.57149494-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU92.181:PCI-MSI.18874371-edge.nvme0q3
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU92.186:PCI-MSI.18874371-edge.nvme0q3
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU92.55:PCI-MSI.57147411-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU92.56:PCI-MSI.57147412-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU92.91:PCI-MSI.57147447-edge
     50247 ± 22%     -17.6%      41403 ± 25%     +23.2%      61922 ± 29%  interrupts.CPU92.CAL:Function_call_interrupts
      5.33 ± 24%     +35.4%       7.22 ± 15%      +8.8%       5.80 ± 10%  interrupts.CPU92.IWI:IRQ_work_interrupts
   1102513            -9.6%     996389 ±  4%      +0.2%    1105021 ±  2%  interrupts.CPU92.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU92.MCP:Machine_check_polls
      6647 ± 32%     +29.2%       8587 ± 16%     +16.7%       7756 ± 21%  interrupts.CPU92.NMI:Non-maskable_interrupts
      6647 ± 32%     +29.2%       8587 ± 16%     +16.7%       7756 ± 21%  interrupts.CPU92.PMI:Performance_monitoring_interrupts
    927984 ±  8%     -30.2%     647297 ± 10%      +1.6%     943139 ±  6%  interrupts.CPU92.RES:Rescheduling_interrupts
      3.67 ± 61%      -3.0%       3.56 ± 63%     -23.6%       2.80 ± 44%  interrupts.CPU92.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU93.121:PCI-MSI.57149460-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU93.122:PCI-MSI.57149461-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU93.156:PCI-MSI.57149495-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU93.180:PCI-MSI.18874372-edge.nvme0q4
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU93.181:PCI-MSI.18874372-edge.nvme0q4
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU93.182:PCI-MSI.18874372-edge.nvme0q4
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU93.56:PCI-MSI.57147412-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU93.57:PCI-MSI.57147413-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU93.92:PCI-MSI.57147448-edge
     43565 ± 25%      -5.0%      41372 ± 33%     +20.5%      52483 ± 33%  interrupts.CPU93.CAL:Function_call_interrupts
      5.33 ± 24%     +29.2%       6.89 ± 19%      +8.8%       5.80 ± 10%  interrupts.CPU93.IWI:IRQ_work_interrupts
   1102541            -9.6%     996327 ±  4%      +0.2%    1105023 ±  2%  interrupts.CPU93.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU93.MCP:Machine_check_polls
      6649 ± 32%     +21.5%       8077 ± 23%     +16.6%       7755 ± 21%  interrupts.CPU93.NMI:Non-maskable_interrupts
      6649 ± 32%     +21.5%       8077 ± 23%     +16.6%       7755 ± 21%  interrupts.CPU93.PMI:Performance_monitoring_interrupts
    895246 ±  6%     -29.5%     630727 ± 10%      -0.1%     894411 ±  4%  interrupts.CPU93.RES:Rescheduling_interrupts
      3.56 ± 59%     +12.5%       4.00 ± 44%     -12.8%       3.10 ± 39%  interrupts.CPU93.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU94.122:PCI-MSI.57149461-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU94.123:PCI-MSI.57149462-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU94.157:PCI-MSI.57149496-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU94.203:PCI-MSI.18874387-edge.nvme0q19
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU94.57:PCI-MSI.57147413-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU94.58:PCI-MSI.57147414-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU94.93:PCI-MSI.57147449-edge
     41625 ± 14%      -5.1%      39502 ± 30%     +15.4%      48056 ± 21%  interrupts.CPU94.CAL:Function_call_interrupts
      5.56 ± 22%     +26.0%       7.00 ± 21%      +0.8%       5.60 ± 14%  interrupts.CPU94.IWI:IRQ_work_interrupts
   1102544            -9.6%     996184 ±  4%      +0.2%    1105029 ±  2%  interrupts.CPU94.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU94.MCP:Machine_check_polls
      7133 ± 28%     +13.2%       8076 ± 23%      +2.6%       7321 ± 26%  interrupts.CPU94.NMI:Non-maskable_interrupts
      7133 ± 28%     +13.2%       8076 ± 23%      +2.6%       7321 ± 26%  interrupts.CPU94.PMI:Performance_monitoring_interrupts
    916119 ±  5%     -30.3%     638607 ± 10%      +1.6%     930835 ±  6%  interrupts.CPU94.RES:Rescheduling_interrupts
      3.33 ± 74%     +13.3%       3.78 ± 55%     -22.0%       2.60 ± 52%  interrupts.CPU94.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU95.123:PCI-MSI.57149462-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU95.124:PCI-MSI.57149463-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU95.158:PCI-MSI.57149497-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU95.193:PCI-MSI.18874388-edge.nvme0q20
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU95.203:PCI-MSI.18874388-edge.nvme0q20
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU95.58:PCI-MSI.57147414-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU95.59:PCI-MSI.57147415-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU95.94:PCI-MSI.57147450-edge
     39101 ± 19%      -1.8%      38396 ± 28%     +31.1%      51269 ± 19%  interrupts.CPU95.CAL:Function_call_interrupts
      5.67 ± 26%     +21.6%       6.89 ± 19%      -1.2%       5.60 ± 14%  interrupts.CPU95.IWI:IRQ_work_interrupts
   1102539            -9.6%     996307 ±  4%      +0.2%    1105002 ±  2%  interrupts.CPU95.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU95.MCP:Machine_check_polls
      7133 ± 28%     +13.2%       8073 ± 23%      +2.6%       7320 ± 26%  interrupts.CPU95.NMI:Non-maskable_interrupts
      7133 ± 28%     +13.2%       8073 ± 23%      +2.6%       7320 ± 26%  interrupts.CPU95.PMI:Performance_monitoring_interrupts
    937315 ±  7%     -31.9%     638435 ± 10%      -3.0%     909093 ±  5%  interrupts.CPU95.RES:Rescheduling_interrupts
      3.00 ± 60%     +11.1%       3.33 ± 56%      +3.3%       3.10 ± 39%  interrupts.CPU95.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU96.124:PCI-MSI.57149463-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU96.125:PCI-MSI.57149464-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU96.159:PCI-MSI.57149498-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU96.197:PCI-MSI.18874389-edge.nvme0q21
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU96.59:PCI-MSI.57147415-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU96.60:PCI-MSI.57147416-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU96.95:PCI-MSI.57147451-edge
     45159 ± 31%     -21.6%      35419 ± 30%     +26.8%      57259 ± 38%  interrupts.CPU96.CAL:Function_call_interrupts
      5.56 ± 22%     +24.0%       6.89 ± 19%      +0.8%       5.60 ± 14%  interrupts.CPU96.IWI:IRQ_work_interrupts
   1102534            -9.6%     996468 ±  4%      +0.2%    1105034 ±  2%  interrupts.CPU96.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU96.MCP:Machine_check_polls
      7131 ± 28%     +13.3%       8080 ± 23%      +2.6%       7319 ± 26%  interrupts.CPU96.NMI:Non-maskable_interrupts
      7131 ± 28%     +13.3%       8080 ± 23%      +2.6%       7319 ± 26%  interrupts.CPU96.PMI:Performance_monitoring_interrupts
    905292 ±  7%     -29.3%     640407 ± 10%      +1.6%     919776 ±  6%  interrupts.CPU96.RES:Rescheduling_interrupts
      3.78 ± 70%     +14.7%       4.33 ± 52%     -17.9%       3.10 ± 50%  interrupts.CPU96.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU97.125:PCI-MSI.57149464-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU97.126:PCI-MSI.57149465-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU97.160:PCI-MSI.57149499-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU97.195:PCI-MSI.18874390-edge.nvme0q22
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU97.197:PCI-MSI.18874390-edge.nvme0q22
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU97.60:PCI-MSI.57147416-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU97.61:PCI-MSI.57147417-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU97.96:PCI-MSI.57147452-edge
     43228 ± 26%     -14.1%      37142 ± 24%     +22.6%      53010 ± 30%  interrupts.CPU97.CAL:Function_call_interrupts
      5.78 ± 19%     +23.1%       7.11 ± 23%      +2.1%       5.90 ± 11%  interrupts.CPU97.IWI:IRQ_work_interrupts
   1102519            -9.6%     996512 ±  4%      +0.2%    1105009 ±  2%  interrupts.CPU97.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU97.MCP:Machine_check_polls
      7604 ± 23%      +6.2%       8077 ± 23%      +2.1%       7765 ± 22%  interrupts.CPU97.NMI:Non-maskable_interrupts
      7604 ± 23%      +6.2%       8077 ± 23%      +2.1%       7765 ± 22%  interrupts.CPU97.PMI:Performance_monitoring_interrupts
    935366 ±  4%     -31.7%     638976 ± 10%      -2.5%     912301 ±  5%  interrupts.CPU97.RES:Rescheduling_interrupts
      3.44 ± 58%      -6.5%       3.22 ± 61%     -18.7%       2.80 ± 52%  interrupts.CPU97.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU98.126:PCI-MSI.57149465-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU98.127:PCI-MSI.57149466-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU98.161:PCI-MSI.57149500-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU98.195:PCI-MSI.18874391-edge.nvme0q23
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU98.200:PCI-MSI.18874391-edge.nvme0q23
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU98.61:PCI-MSI.57147417-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU98.62:PCI-MSI.57147418-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU98.97:PCI-MSI.57147453-edge
     45486 ± 38%     -20.4%      36195 ± 26%     +13.1%      51458 ± 28%  interrupts.CPU98.CAL:Function_call_interrupts
      5.78 ± 19%     +19.2%       6.89 ± 19%      +0.4%       5.80 ± 10%  interrupts.CPU98.IWI:IRQ_work_interrupts
   1102520            -9.6%     996427 ±  4%      +0.2%    1105034 ±  2%  interrupts.CPU98.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU98.MCP:Machine_check_polls
      7600 ± 23%      +6.2%       8073 ± 23%      +2.2%       7767 ± 22%  interrupts.CPU98.NMI:Non-maskable_interrupts
      7600 ± 23%      +6.2%       8073 ± 23%      +2.2%       7767 ± 22%  interrupts.CPU98.PMI:Performance_monitoring_interrupts
    907673 ±  6%     -30.0%     635429 ±  9%      +2.5%     930115 ±  5%  interrupts.CPU98.RES:Rescheduling_interrupts
      3.56 ± 66%      +9.4%       3.89 ± 47%     -32.5%       2.40 ± 46%  interrupts.CPU98.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU99.127:PCI-MSI.57149466-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU99.128:PCI-MSI.57149467-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU99.162:PCI-MSI.57149501-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU99.207:PCI-MSI.18874392-edge.nvme0q24
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU99.208:PCI-MSI.18874392-edge.nvme0q24
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU99.62:PCI-MSI.57147418-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU99.63:PCI-MSI.57147419-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU99.98:PCI-MSI.57147454-edge
     45437 ± 32%     -18.7%      36924 ± 28%     +20.1%      54555 ± 28%  interrupts.CPU99.CAL:Function_call_interrupts
      6.00 ± 15%     +18.5%       7.11 ± 19%      -3.3%       5.80 ± 10%  interrupts.CPU99.IWI:IRQ_work_interrupts
   1102549            -9.6%     996367 ±  4%      +0.2%    1105036 ±  2%  interrupts.CPU99.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU99.MCP:Machine_check_polls
      8075 ± 17%      +6.3%       8581 ± 16%      -3.8%       7766 ± 22%  interrupts.CPU99.NMI:Non-maskable_interrupts
      8075 ± 17%      +6.3%       8581 ± 16%      -3.8%       7766 ± 22%  interrupts.CPU99.PMI:Performance_monitoring_interrupts
    927790 ±  7%     -31.2%     638519 ± 10%      -0.7%     921457 ±  6%  interrupts.CPU99.RES:Rescheduling_interrupts
      3.78 ± 52%     -11.8%       3.33 ± 50%      -4.7%       3.60 ± 30%  interrupts.CPU99.TLB:TLB_shootdowns
    849.56 ± 12%     +19.7%       1016 ± 14%      +0.6%     854.50 ±  9%  interrupts.IWI:IRQ_work_interrupts
 1.588e+08            -9.6%  1.435e+08 ±  4%      +0.2%  1.591e+08 ±  2%  interrupts.LOC:Local_timer_interrupts
    144.00            +0.0%     144.00            +0.0%     144.00        interrupts.MCP:Machine_check_polls
   1152813 ±  8%      +5.5%    1216021 ±  5%      +2.0%    1175988 ±  4%  interrupts.NMI:Non-maskable_interrupts
   1152813 ±  8%      +5.5%    1216021 ±  5%      +2.0%    1175988 ±  4%  interrupts.PMI:Performance_monitoring_interrupts
 1.271e+08 ±  2%     -28.5%   90866154            -0.5%  1.265e+08 ±  3%  interrupts.RES:Rescheduling_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.RTR:APIC_ICR_read_retries
    463.44 ± 40%     +14.3%     529.89 ± 27%     -30.6%     321.40 ± 31%  interrupts.TLB:TLB_shootdowns


--x+6KMIRAuhnl3hBn--
