Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12A1C41172B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 16:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237708AbhITOgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 10:36:37 -0400
Received: from mga03.intel.com ([134.134.136.65]:26323 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231952AbhITOga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 10:36:30 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10113"; a="223190572"
X-IronPort-AV: E=Sophos;i="5.85,308,1624345200"; 
   d="yaml'?scan'208";a="223190572"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2021 07:35:00 -0700
X-IronPort-AV: E=Sophos;i="5.85,308,1624345200"; 
   d="yaml'?scan'208";a="548812373"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.41])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2021 07:34:56 -0700
Date:   Mon, 20 Sep 2021 22:52:07 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Mike Javorski <mike.javorski@gmail.com>,
        Lothar Paltins <lopa@mailbox.org>,
        Mel Gorman <mgorman@suse.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com
Subject: [SUNRPC]  e38b3f2005:  fsmark.files_per_sec 1857.1% improvement
Message-ID: <20210920145207.GA25459@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit



Greeting,

FYI, we noticed a 1857.1% improvement of fsmark.files_per_sec due to commit:


commit: e38b3f20059426a0adbde014ff71071739ab5226 ("SUNRPC: don't pause on incomplete allocation")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master


in testcase: fsmark
on test machine: 192 threads 4 sockets Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory
with following parameters:

	iterations: 1x
	nr_threads: 1t
	disk: 1BRD_48G
	fs: f2fs
	fs2: nfsv4
	filesize: 4M
	test_size: 24G
	sync_method: NoSync
	cpufreq_governor: performance
	ucode: 0x5003006

test-description: The fsmark is a file system benchmark to test synchronous write workloads, for example, mail servers workload.
test-url: https://sourceforge.net/projects/fsmark/

In addition to that, the commit also has significant impact on the following tests:

+------------------+-------------------------------------------------------------------------------------+
| testcase: change | fsmark: fsmark.files_per_sec 3483.3% improvement                                    |
| test machine     | 192 threads 4 sockets Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory |
| test parameters  | cpufreq_governor=performance                                                        |
|                  | disk=1BRD_48G                                                                       |
|                  | filesize=4M                                                                         |
|                  | fs2=nfsv4                                                                           |
|                  | fs=f2fs                                                                             |
|                  | iterations=1x                                                                       |
|                  | nr_threads=1t                                                                       |
|                  | sync_method=fsyncBeforeClose                                                        |
|                  | test_size=24G                                                                       |
|                  | ucode=0x5003006                                                                     |
+------------------+-------------------------------------------------------------------------------------+
| testcase: change | fsmark: fsmark.files_per_sec 325.8% improvement                                     |
| test machine     | 192 threads 4 sockets Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory |
| test parameters  | cpufreq_governor=performance                                                        |
|                  | disk=1BRD_48G                                                                       |
|                  | filesize=4M                                                                         |
|                  | fs2=nfsv4                                                                           |
|                  | fs=ext4                                                                             |
|                  | iterations=1x                                                                       |
|                  | nr_threads=1t                                                                       |
|                  | sync_method=fsyncBeforeClose                                                        |
|                  | test_size=24G                                                                       |
|                  | ucode=0x5003006                                                                     |
+------------------+-------------------------------------------------------------------------------------+
| testcase: change | fsmark: fsmark.files_per_sec 804.1% improvement                                     |
| test machine     | 192 threads 4 sockets Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory |
| test parameters  | cpufreq_governor=performance                                                        |
|                  | disk=1BRD_48G                                                                       |
|                  | filesize=4M                                                                         |
|                  | fs2=nfsv4                                                                           |
|                  | fs=xfs                                                                              |
|                  | iterations=1x                                                                       |
|                  | nr_threads=1t                                                                       |
|                  | sync_method=fsyncBeforeClose                                                        |
|                  | test_size=24G                                                                       |
|                  | ucode=0x5003006                                                                     |
+------------------+-------------------------------------------------------------------------------------+




Details are as below:
-------------------------------------------------------------------------------------------------->


To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        sudo bin/lkp install job.yaml           # job file is attached in this email
        bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
        sudo bin/lkp run generated-yaml-file

        # if come across any failure that blocks the test,
        # please remove ~/.lkp and /lkp dir to run from a clean state.

=========================================================================================
compiler/cpufreq_governor/disk/filesize/fs2/fs/iterations/kconfig/nr_threads/rootfs/sync_method/tbox_group/test_size/testcase/ucode:
  gcc-9/performance/1BRD_48G/4M/nfsv4/f2fs/1x/x86_64-rhel-8.3/1t/debian-10.4-x86_64-20200603.cgz/NoSync/lkp-csl-2ap2/24G/fsmark/0x5003006

commit: 
  0bcc7ca40b ("nfsd: fix crash on LOCKT on reexported NFSv3")
  e38b3f2005 ("SUNRPC: don't pause on incomplete allocation")

0bcc7ca40bd82319 e38b3f20059426a0adbde014ff7 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
  67406384 ± 35%     -99.5%     303421 ±  6%  fsmark.app_overhead
      7.33 ±111%   +1857.1%     143.43        fsmark.files_per_sec
      1380 ± 36%     -96.8%      44.35        fsmark.time.elapsed_time
      1380 ± 36%     -96.8%      44.35        fsmark.time.elapsed_time.max
      2.00 ±122%   +1985.7%      41.71        fsmark.time.percent_of_cpu_this_job_got
   1051674 ±  4%      +7.6%    1131232        fsmark.time.voluntary_context_switches
 2.566e+11 ± 36%     -96.7%   8.49e+09        cpuidle..time
 4.717e+08 ± 40%     -95.9%   19195923 ±  6%  cpuidle..usage
      1430 ± 35%     -93.3%      95.19        uptime.boot
    267000 ± 35%     -93.6%      17033        uptime.idle
      0.20 ±  3%      -0.2        0.03 ± 14%  mpstat.cpu.all.iowait%
      0.07 ± 79%      +0.7        0.81        mpstat.cpu.all.sys%
      0.01 ± 29%      +0.0        0.05 ± 13%  mpstat.cpu.all.usr%
      1745 ± 82%     +64.8%       2876 ± 47%  numa-meminfo.node0.PageTables
     26322 ± 33%     -82.7%       4550 ± 19%  numa-meminfo.node3.Active(anon)
     34757 ± 25%     -61.5%      13364 ± 50%  numa-meminfo.node3.Shmem
    436.43 ± 82%     +64.7%     719.00 ± 47%  numa-vmstat.node0.nr_page_table_pages
      6579 ± 33%     -82.7%       1137 ± 19%  numa-vmstat.node3.nr_active_anon
      8688 ± 25%     -61.5%       3340 ± 50%  numa-vmstat.node3.nr_shmem
      6579 ± 33%     -82.7%       1137 ± 19%  numa-vmstat.node3.nr_zone_active_anon
      1.40 ±  7%      -0.1        1.26 ±  4%  perf-profile.children.cycles-pp.__alloc_pages
      1.20 ±  8%      -0.1        1.07 ±  4%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.13 ±  9%      +0.0        0.16 ±  6%  perf-profile.children.cycles-pp.call_cpuidle
      0.12 ±  9%      +0.0        0.16 ±  7%  perf-profile.self.cycles-pp.call_cpuidle
     29715 ±109%   +1694.7%     533296        vmstat.io.bo
  44145867 ±  2%     -35.6%   28422442        vmstat.memory.cache
 1.309e+08           +16.9%  1.531e+08        vmstat.memory.free
      0.00       +1.7e+102%       1.71 ± 26%  vmstat.procs.r
      5649 ± 71%   +1119.5%      68890        vmstat.system.cs
     23.14 ± 28%     +82.7%      42.29 ±  8%  turbostat.Avg_MHz
      1086 ± 10%    +100.3%       2175 ±  5%  turbostat.Bzy_MHz
     40.29 ±  2%     +14.9%      46.29 ±  3%  turbostat.CoreTmp
 2.379e+08 ± 41%     -96.0%    9408162        turbostat.IRQ
     40.43 ±  2%     +14.8%      46.43 ±  4%  turbostat.PkgTmp
     16.42 ±159%    +588.3%     113.00 ±  2%  turbostat.PkgWatt
     80922 ± 10%     -57.1%      34680        meminfo.Active
     37328 ± 22%     -82.0%       6718 ±  5%  meminfo.Active(anon)
     43592 ±  2%     -35.9%      27961        meminfo.Active(file)
    266912 ±  4%     -43.7%     150173        meminfo.AnonHugePages
  43878121 ±  2%     -35.7%   28198137        meminfo.Cached
      3749 ± 68%    +633.1%      27485        meminfo.Dirty
  41743815 ±  2%     -37.4%   26130834        meminfo.Inactive
  41395827 ±  2%     -37.8%   25762745        meminfo.Inactive(file)
    296808           -21.1%     234093        meminfo.KReclaimable
 1.309e+08           +17.1%  1.533e+08        meminfo.MemFree
  66827783 ±  2%     -33.6%   44404434        meminfo.Memused
      4164 ±  2%     +17.0%       4871        meminfo.PageTables
    296808           -21.1%     234093        meminfo.SReclaimable
     57605 ± 15%     -54.7%      26096        meminfo.Shmem
    629977 ±  2%     -11.5%     557270        meminfo.Slab
  66901076 ±  2%     -32.6%   45081848        meminfo.max_used_kB
      5071 ±  2%     -36.2%       3234        nfsstat.Client.nfs.v4.access
      5065 ±  2%     -36.3%       3228        nfsstat.Client.nfs.v4.close
      5064 ±  2%     -36.3%       3227        nfsstat.Client.nfs.v4.commit
    814.14 ± 41%    -100.0%       0.00        nfsstat.Client.nfs.v4.delegreturn
     13.86 ± 30%     -78.4%       3.00        nfsstat.Client.nfs.v4.getattr
      5069 ±  2%     -36.2%       3232        nfsstat.Client.nfs.v4.lookup
      5066 ±  2%     -36.3%       3229        nfsstat.Client.nfs.v4.open
     10.29 ± 40%    -100.0%       0.00        nfsstat.Client.nfs.v4.renew
     20262 ±  2%     -36.3%      12913        nfsstat.Client.nfs.v4.write
     46464 ±  2%     -37.4%      29093        nfsstat.Client.rpc.authrefrsh
     46464 ±  2%     -37.4%      29093        nfsstat.Client.rpc.calls
 2.291e+09 ±  4%     -13.5%  1.981e+09        nfsstat.Server.io.write
     46461 ±  2%     -37.4%      29092        nfsstat.Server.nfs.v4.compound
     10137 ±  2%     -36.2%       6464        nfsstat.Server.nfs.v4.operations.access
      5065 ±  2%     -36.3%       3228        nfsstat.Server.nfs.v4.operations.close
      5064 ±  2%     -36.3%       3227        nfsstat.Server.nfs.v4.operations.commit
    814.14 ± 41%    -100.0%       0.00        nfsstat.Server.nfs.v4.operations.delegreturn
     38120 ±  4%     -32.2%      25859        nfsstat.Server.nfs.v4.operations.getattr
     10138 ±  2%     -36.2%       6464        nfsstat.Server.nfs.v4.operations.getfh
      5069 ±  2%     -36.2%       3232        nfsstat.Server.nfs.v4.operations.lookup
      5066 ±  2%     -36.3%       3229        nfsstat.Server.nfs.v4.operations.open
     46444 ±  2%     -37.4%      29086        nfsstat.Server.nfs.v4.operations.putfh
     10.29 ± 40%    -100.0%       0.00        nfsstat.Server.nfs.v4.operations.renew
     20261 ±  2%     -36.3%      12913        nfsstat.Server.nfs.v4.operations.write
     46462 ±  2%     -37.4%      29093        nfsstat.Server.packet.packets
     46462 ±  2%     -37.4%      29093        nfsstat.Server.packet.tcp
     20267 ±  2%     -36.3%      12919        nfsstat.Server.reply.cache.misses
     26194 ±  2%     -38.3%      16173        nfsstat.Server.reply.cache.nocache
     46462 ±  2%     -37.4%      29093        nfsstat.Server.rpc.calls
      9331 ± 22%     -82.0%       1679 ±  5%  proc-vmstat.nr_active_anon
     10897 ±  2%     -35.9%       6990        proc-vmstat.nr_active_file
     82052            +6.4%      87335        proc-vmstat.nr_anon_pages
    129.86 ±  4%     -43.8%      73.00        proc-vmstat.nr_anon_transparent_hugepages
    933.86 ± 69%    +634.5%       6858        proc-vmstat.nr_dirty
   4283653            +3.9%    4452736        proc-vmstat.nr_dirty_background_threshold
   8577780            +3.9%    8916359        proc-vmstat.nr_dirty_threshold
  10969570 ±  2%     -35.7%    7049616        proc-vmstat.nr_file_pages
  32722110           +17.1%   38327560        proc-vmstat.nr_free_pages
     86997            +5.8%      92022        proc-vmstat.nr_inactive_anon
  10348738 ±  2%     -37.8%    6440503        proc-vmstat.nr_inactive_file
     27454 ±  2%      +7.8%      29600        proc-vmstat.nr_kernel_stack
      9081            +4.2%       9461        proc-vmstat.nr_mapped
      1042 ±  2%     +16.8%       1217        proc-vmstat.nr_page_table_pages
     14400 ± 15%     -54.7%       6523        proc-vmstat.nr_shmem
     74201           -21.1%      58523        proc-vmstat.nr_slab_reclaimable
      9331 ± 22%     -82.0%       1679 ±  5%  proc-vmstat.nr_zone_active_anon
     10897 ±  2%     -35.9%       6990        proc-vmstat.nr_zone_active_file
     86997            +5.8%      92022        proc-vmstat.nr_zone_inactive_anon
  10348738 ±  2%     -37.8%    6440503        proc-vmstat.nr_zone_inactive_file
      1164 ± 57%    +521.0%       7228        proc-vmstat.nr_zone_write_pending
   6048818 ± 41%     +77.5%   10737533 ±  8%  proc-vmstat.numa_foreign
      7247 ± 10%     -79.8%       1462 ± 84%  proc-vmstat.numa_hint_faults
      5934 ±  3%     -76.4%       1401 ± 85%  proc-vmstat.numa_hint_faults_local
   6049255 ± 41%     +77.5%   10736274 ±  8%  proc-vmstat.numa_miss
   6309724 ± 39%     +74.0%   10978840 ±  8%  proc-vmstat.numa_other
     15932 ± 12%     -50.8%       7843 ±  2%  proc-vmstat.pgactivate
   4986783 ± 34%     -91.4%     428102        proc-vmstat.pgfault
    329604 ± 35%     -93.3%      22072 ±  3%  proc-vmstat.pgreuse
 3.329e+08 ± 21%    +252.9%  1.175e+09        perf-stat.i.branch-instructions
   3282322 ± 66%    +357.5%   15015299 ±  9%  perf-stat.i.cache-misses
      5636 ± 71%   +1194.7%      72972        perf-stat.i.context-switches
      5.12 ± 51%     -62.6%       1.92 ± 12%  perf-stat.i.cpi
    193.46           +17.5%     227.24        perf-stat.i.cpu-migrations
      4221 ± 33%     -81.4%     786.50 ±  7%  perf-stat.i.cycles-between-cache-misses
 4.542e+08 ± 19%    +250.8%  1.593e+09        perf-stat.i.dTLB-loads
  2.45e+08 ± 19%    +243.0%  8.405e+08        perf-stat.i.dTLB-stores
   1757660 ± 15%     +62.0%    2847900 ± 10%  perf-stat.i.iTLB-load-misses
 1.643e+09 ± 21%    +258.4%   5.89e+09        perf-stat.i.instructions
    907.87 ± 10%    +128.6%       2075 ±  9%  perf-stat.i.instructions-per-iTLB-miss
      0.24 ± 35%    +119.4%       0.54 ± 10%  perf-stat.i.ipc
      0.56 ± 94%    +791.3%       4.99 ± 14%  perf-stat.i.major-faults
      5.24 ± 24%    +260.3%      18.86        perf-stat.i.metric.M/sec
      3559 ±  6%    +105.5%       7316        perf-stat.i.minor-faults
     90.11 ±  2%     -31.7       58.41 ±  5%  perf-stat.i.node-load-miss-rate%
    357462 ± 76%    +379.5%    1713865 ± 21%  perf-stat.i.node-load-misses
     91197 ±107%   +1111.4%    1104735 ±  4%  perf-stat.i.node-loads
     85.26 ±  9%     -40.9       44.39 ±  2%  perf-stat.i.node-store-miss-rate%
    242988 ± 77%    +773.9%    2123454 ±  7%  perf-stat.i.node-store-misses
    203687 ±114%   +1406.9%    3069316 ±  7%  perf-stat.i.node-stores
      3560 ±  6%    +105.6%       7321        perf-stat.i.page-faults
      4.86 ± 51%     -61.3%       1.88 ± 11%  perf-stat.overall.cpi
      3018 ± 40%     -75.5%     738.97 ± 10%  perf-stat.overall.cycles-between-cache-misses
    933.20 ± 12%    +123.7%       2087 ±  9%  perf-stat.overall.instructions-per-iTLB-miss
      0.25 ± 36%    +113.7%       0.54 ± 10%  perf-stat.overall.ipc
     81.60 ±  4%     -21.4       60.18 ±  7%  perf-stat.overall.node-load-miss-rate%
     58.96 ± 10%     -18.0       40.93 ±  6%  perf-stat.overall.node-store-miss-rate%
 3.324e+08 ± 21%    +245.5%  1.149e+09        perf-stat.ps.branch-instructions
   3277080 ± 66%    +348.1%   14686233 ±  9%  perf-stat.ps.cache-misses
      5623 ± 71%   +1168.7%      71340        perf-stat.ps.context-switches
    191772            -2.1%     187751        perf-stat.ps.cpu-clock
    193.22           +15.0%     222.25        perf-stat.ps.cpu-migrations
 4.535e+08 ± 19%    +243.4%  1.557e+09        perf-stat.ps.dTLB-loads
 2.447e+08 ± 19%    +235.8%  8.216e+08        perf-stat.ps.dTLB-stores
   1755335 ± 15%     +58.6%    2783902 ± 10%  perf-stat.ps.iTLB-load-misses
 1.641e+09 ± 21%    +250.8%  5.757e+09        perf-stat.ps.instructions
      0.56 ± 94%    +774.4%       4.88 ± 14%  perf-stat.ps.major-faults
      3553 ±  6%    +100.5%       7125        perf-stat.ps.minor-faults
    356704 ± 76%    +370.2%    1677185 ± 21%  perf-stat.ps.node-load-misses
     90936 ±106%   +1088.0%    1080300 ±  4%  perf-stat.ps.node-loads
    242477 ± 77%    +756.5%    2076729 ±  7%  perf-stat.ps.node-store-misses
    203061 ±114%   +1378.0%    3001278 ±  7%  perf-stat.ps.node-stores
      3553 ±  6%    +100.6%       7130        perf-stat.ps.page-faults
    191772            -2.1%     187751        perf-stat.ps.task-clock
 2.102e+12 ± 33%     -87.7%  2.596e+11        perf-stat.total.instructions
      3255 ± 12%     -45.5%       1772 ±  8%  slabinfo.Acpi-Parse.active_objs
      3255 ± 12%     -45.5%       1772 ±  8%  slabinfo.Acpi-Parse.num_objs
    639.43 ±  9%     -23.9%     486.57 ±  9%  slabinfo.biovec-128.active_objs
    639.43 ±  9%     -23.9%     486.57 ±  9%  slabinfo.biovec-128.num_objs
    246.00 ± 11%     -52.3%     117.29 ±  6%  slabinfo.biovec-max.active_objs
    246.00 ± 11%     -52.3%     117.29 ±  6%  slabinfo.biovec-max.num_objs
      1413 ± 17%     -61.1%     549.71 ± 13%  slabinfo.ext4_extent_status.active_objs
      1413 ± 17%     -61.1%     549.71 ± 13%  slabinfo.ext4_extent_status.num_objs
      5705 ±  2%     -40.7%       3383        slabinfo.ext4_fc_dentry_update.active_objs
      5705 ±  2%     -40.7%       3383        slabinfo.ext4_fc_dentry_update.num_objs
      5879 ±  2%     -42.3%       3394        slabinfo.ext4_io_end.active_objs
      5879 ±  2%     -42.3%       3394        slabinfo.ext4_io_end.num_objs
     12287 ±  4%     -37.2%       7716 ±  2%  slabinfo.ext4_pending_reservation.active_objs
     12287 ±  4%     -37.2%       7716 ±  2%  slabinfo.ext4_pending_reservation.num_objs
     11938 ±  5%     -31.6%       8167 ±  4%  slabinfo.f2fs_free_nid.active_objs
     11938 ±  5%     -31.6%       8167 ±  4%  slabinfo.f2fs_free_nid.num_objs
      5422 ±  2%     -37.9%       3366        slabinfo.f2fs_inode_cache.active_objs
      5422 ±  2%     -37.9%       3366        slabinfo.f2fs_inode_cache.num_objs
    910.86 ± 17%     -57.4%     387.86 ± 12%  slabinfo.f2fs_xattr_entry-1:0.active_objs
    910.86 ± 17%     -57.4%     387.86 ± 12%  slabinfo.f2fs_xattr_entry-1:0.num_objs
      1682 ±  8%     -29.0%       1194 ±  7%  slabinfo.file_lock_cache.active_objs
      1682 ±  8%     -29.0%       1194 ±  7%  slabinfo.file_lock_cache.num_objs
      9109 ±  7%     -26.7%       6674 ±  5%  slabinfo.fsnotify_mark_connector.active_objs
      9109 ±  7%     -26.7%       6674 ±  5%  slabinfo.fsnotify_mark_connector.num_objs
    996.71 ± 17%     -69.1%     308.00 ± 13%  slabinfo.ip6-frags.active_objs
    996.71 ± 17%     -69.1%     308.00 ± 13%  slabinfo.ip6-frags.num_objs
     12349 ±  5%     -19.1%       9996        slabinfo.kmalloc-1k.active_objs
     12535 ±  6%     -19.9%      10043        slabinfo.kmalloc-1k.num_objs
      1422           +10.6%       1573        slabinfo.kmalloc-8k.active_objs
     21916 ±  4%      -8.7%      20017 ±  3%  slabinfo.kmalloc-96.active_objs
     22107 ±  4%      -9.0%      20121 ±  3%  slabinfo.kmalloc-96.num_objs
    542.00 ± 20%     -46.6%     289.29 ± 28%  slabinfo.kmalloc-cg-16.active_objs
    542.00 ± 20%     -46.6%     289.29 ± 28%  slabinfo.kmalloc-cg-16.num_objs
     18253 ±  4%     -20.7%      14473 ±  3%  slabinfo.kmalloc-rcl-64.active_objs
     18256 ±  4%     -20.5%      14505 ±  3%  slabinfo.kmalloc-rcl-64.num_objs
      5697 ±  3%     -38.6%       3500        slabinfo.nfs_inode_cache.active_objs
      5698 ±  3%     -38.3%       3515        slabinfo.nfs_inode_cache.num_objs
      1173 ± 28%    -100.0%       0.00        slabinfo.nfsd4_delegations.active_objs
      1173 ± 28%    -100.0%       0.00        slabinfo.nfsd4_delegations.num_objs
      1152 ± 18%     -71.8%     325.29 ± 17%  slabinfo.nfsd4_files.active_objs
      1152 ± 18%     -71.8%     325.29 ± 17%  slabinfo.nfsd4_files.num_objs
     23033 ±  4%     -10.8%      20551 ±  7%  slabinfo.proc_inode_cache.active_objs
     23119 ±  4%     -11.0%      20577 ±  7%  slabinfo.proc_inode_cache.num_objs
    288478 ±  2%     -33.1%     193089        slabinfo.radix_tree_node.active_objs
      5151 ±  2%     -33.0%       3449        slabinfo.radix_tree_node.active_slabs
    288483 ±  2%     -33.0%     193173        slabinfo.radix_tree_node.num_objs
      5151 ±  2%     -33.0%       3449        slabinfo.radix_tree_node.num_slabs
     11191 ± 20%     -69.2%       3447 ±  7%  slabinfo.skbuff_fclone_cache.active_objs
    178.00 ± 21%     -70.1%      53.29 ±  8%  slabinfo.skbuff_fclone_cache.active_slabs
     11434 ± 21%     -69.9%       3447 ±  7%  slabinfo.skbuff_fclone_cache.num_objs
    178.00 ± 21%     -70.1%      53.29 ±  8%  slabinfo.skbuff_fclone_cache.num_slabs
     32172 ±  2%     -25.2%      24078        slabinfo.vmap_area.active_objs
    519.43 ±  3%     -27.2%     378.00        slabinfo.vmap_area.active_slabs
     33287 ±  3%     -27.2%      24232        slabinfo.vmap_area.num_objs
    519.43 ±  3%     -27.2%     378.00        slabinfo.vmap_area.num_slabs
      2301 ± 10%     -31.1%       1587 ± 10%  slabinfo.xfrm_state.active_objs
      2301 ± 10%     -31.1%       1587 ± 10%  slabinfo.xfrm_state.num_objs
      0.02 ± 28%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.01 ± 42%     -96.0%       0.00 ±244%  perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      0.01 ± 31%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.kthreadd.ret_from_fork
      0.01 ± 40%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.__synchronize_srcu.part
      0.01 ± 61%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork
      0.01 ± 27%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.rpc_wait_bit_killable.__wait_on_bit.out_of_line_wait_on_bit.__rpc_execute
      0.01 ± 58%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.rpc_wait_bit_killable.__wait_on_bit.out_of_line_wait_on_bit.nfs4_do_close
      0.01 ± 28%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.rpc_wait_bit_killable.__wait_on_bit.out_of_line_wait_on_bit.nfs4_run_open_task
      0.01 ± 46%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
      0.01 ±113%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.kthread.ret_from_fork
      0.01 ± 53%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.__break_lease.do_dentry_open.dentry_open
      0.02 ± 27%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.__skb_wait_for_more_packets.unix_dgram_recvmsg.__sys_recvfrom
      0.02 ± 51%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.01 ± 26%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.svc_recv.nfs4_callback_svc.kthread
      0.01 ± 46%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.svc_recv.nfsd.kthread
      0.02 ± 11%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.wait_for_completion_killable.__kthread_create_on_node.kthread_create_on_node
      0.00 ± 11%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open.isra
      0.01 ± 28%    +653.4%       0.09 ± 30%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork
      0.02 ± 52%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.03 ± 52%     -97.8%       0.00 ±244%  perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      0.03 ±108%    -100.0%       0.00        perf-sched.sch_delay.max.ms.io_schedule.wait_on_page_bit.wait_on_page_writeback.__filemap_fdatawait_range
      0.03 ±113%    -100.0%       0.00        perf-sched.sch_delay.max.ms.kthreadd.ret_from_fork
      0.03 ± 66%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.__synchronize_srcu.part
      0.03 ±111%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      0.03 ± 79%    -100.0%       0.00        perf-sched.sch_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork
      0.01 ± 30%    -100.0%       0.00        perf-sched.sch_delay.max.ms.rpc_wait_bit_killable.__wait_on_bit.out_of_line_wait_on_bit.__rpc_execute
      0.01 ±116%    -100.0%       0.00        perf-sched.sch_delay.max.ms.rpc_wait_bit_killable.__wait_on_bit.out_of_line_wait_on_bit.nfs4_do_close
      0.01 ± 26%    -100.0%       0.00        perf-sched.sch_delay.max.ms.rpc_wait_bit_killable.__wait_on_bit.out_of_line_wait_on_bit.nfs4_run_open_task
      0.03 ± 78%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
      0.03 ±132%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_preempt_disabled.kthread.ret_from_fork
      0.03 ± 38%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_timeout.__break_lease.do_dentry_open.dentry_open
      0.02 ± 27%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_timeout.__skb_wait_for_more_packets.unix_dgram_recvmsg.__sys_recvfrom
      0.03 ± 50%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.02 ± 39%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_timeout.svc_recv.nfs4_callback_svc.kthread
      0.18 ±202%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_timeout.svc_recv.nfsd.kthread
      0.03 ± 27%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_timeout.wait_for_completion_killable.__kthread_create_on_node.kthread_create_on_node
      0.02 ± 78%    -100.0%       0.00        perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open.isra
      0.01 ± 45%    +290.2%       0.02 ± 37%  perf-sched.total_sch_delay.average.ms
      3.61 ±  2%    +139.3%       8.64 ± 55%  perf-sched.total_sch_delay.max.ms
    222.14 ±  2%     -99.6%       0.89 ±  7%  perf-sched.total_wait_and_delay.average.ms
     11929 ±  3%     -94.0%     715.57 ±  9%  perf-sched.total_wait_and_delay.count.ms
      9858           -99.8%      16.95 ± 18%  perf-sched.total_wait_and_delay.max.ms
    222.13 ±  2%     -99.6%       0.86 ±  7%  perf-sched.total_wait_time.average.ms
      9858           -99.8%      15.94 ± 20%  perf-sched.total_wait_time.max.ms
    899.39          -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    800.32 ±  5%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
    855.56 ± 33%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.__module_put_and_exit.nfs4_run_state_manager.kthread
    215.33           -99.7%       0.60 ± 44%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      7.02 ± 49%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.io_schedule.wait_on_page_bit.wait_on_page_writeback.__filemap_fdatawait_range
    981.25 ± 31%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.kthreadd.ret_from_fork
     57.85 ±  2%     -98.6%       0.80 ± 41%  perf-sched.wait_and_delay.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      7.76 ± 26%     -99.1%       0.07 ± 76%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      4.55 ±  7%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork
    505.22 ± 29%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
    478.62          -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
     15.01 ± 20%     -76.6%       3.52 ± 23%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
    244.03 ±  3%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_timeout.svc_recv.nfs4_callback_svc.kthread
    419.21 ±  3%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_timeout.svc_recv.nfsd.kthread
    539.42 ± 59%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_timeout.wait_for_completion_killable.__kthread_create_on_node.kthread_create_on_node
    727.39 ±  2%     -99.8%       1.68 ± 13%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.00 ± 11%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open.isra
    307.39 ±  8%     -99.6%       1.35 ± 22%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork
     20.00          -100.0%       0.00        perf-sched.wait_and_delay.count.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     11.29 ±  6%    -100.0%       0.00        perf-sched.wait_and_delay.count.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
     10.00 ± 25%    -100.0%       0.00        perf-sched.wait_and_delay.count.do_task_dead.do_exit.__module_put_and_exit.nfs4_run_state_manager.kthread
    337.43           -87.4%      42.57 ± 24%  perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
    325.57 ±  5%     -89.7%      33.57 ± 27%  perf-sched.wait_and_delay.count.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
    716.14 ± 28%    -100.0%       0.00        perf-sched.wait_and_delay.count.io_schedule.wait_on_page_bit.wait_on_page_writeback.__filemap_fdatawait_range
     10.00 ± 25%    -100.0%       0.00        perf-sched.wait_and_delay.count.kthreadd.ret_from_fork
      3118 ±  2%     -98.8%      37.57 ± 52%  perf-sched.wait_and_delay.count.pipe_read.new_sync_read.vfs_read.ksys_read
      2084 ±  3%     -87.1%     268.29 ±  6%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
    220.43 ± 25%    -100.0%       0.00        perf-sched.wait_and_delay.count.rcu_gp_kthread.kthread.ret_from_fork
     22.86 ±  9%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
     79.43          -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_timeout.kcompactd.kthread.ret_from_fork
    621.71 ± 20%     -99.1%       5.29 ± 24%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
     19.86 ± 25%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_timeout.svc_recv.nfs4_callback_svc.kthread
    168.71 ±  4%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_timeout.svc_recv.nfsd.kthread
     10.00 ± 25%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_timeout.wait_for_completion_killable.__kthread_create_on_node.kthread_create_on_node
      2470 ±  2%     -89.2%     267.86 ±  6%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork
     82.00          -100.0%       0.00        perf-sched.wait_and_delay.count.wait_for_partner.fifo_open.do_dentry_open.do_open.isra
      1233 ± 10%     -96.4%      44.71 ± 40%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork
    999.59          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      1000          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      1347 ± 33%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.__module_put_and_exit.nfs4_run_state_manager.kthread
      1000           -99.4%       5.88 ± 47%  perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     21.30           -87.0%       2.77 ± 75%  perf-sched.wait_and_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
    429.57 ± 13%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.io_schedule.wait_on_page_bit.wait_on_page_writeback.__filemap_fdatawait_range
      1422 ± 30%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.kthreadd.ret_from_fork
      1013           -99.6%       3.99 ± 73%  perf-sched.wait_and_delay.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      7413 ± 54%     -99.9%      10.05 ± 62%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      4.90 ±  6%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork
      3446 ±112%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
    505.03          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
    284.40 ± 20%     -97.7%       6.67 ± 69%  perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
    504.25          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_timeout.svc_recv.nfs4_callback_svc.kthread
    508.18          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_timeout.svc_recv.nfsd.kthread
    918.99 ± 46%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_timeout.wait_for_completion_killable.__kthread_create_on_node.kthread_create_on_node
      1013           -98.7%      13.36 ± 28%  perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.02 ± 78%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open.isra
      7487 ± 12%     -99.9%      10.32 ± 55%  perf-sched.wait_and_delay.max.ms.worker_thread.kthread.ret_from_fork
    899.38          -100.0%       0.00        perf-sched.wait_time.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    800.30 ±  5%    -100.0%       0.00        perf-sched.wait_time.avg.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      1.69 ±  7%     -46.4%       0.91 ± 87%  perf-sched.wait_time.avg.ms.do_syslog.part.0.kmsg_read.vfs_read
    855.56 ± 33%    -100.0%       0.00        perf-sched.wait_time.avg.ms.do_task_dead.do_exit.__module_put_and_exit.nfs4_run_state_manager.kthread
    215.33           -99.7%       0.58 ± 47%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.73 ±  6%     -39.4%       0.44 ± 19%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      7.02 ± 49%    -100.0%       0.00        perf-sched.wait_time.avg.ms.io_schedule.wait_on_page_bit.wait_on_page_writeback.__filemap_fdatawait_range
    981.24 ± 31%    -100.0%       0.00        perf-sched.wait_time.avg.ms.kthreadd.ret_from_fork
     57.85 ±  2%     -98.8%       0.70 ± 34%  perf-sched.wait_time.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
    108.21 ± 38%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.__synchronize_srcu.part
      7.76 ± 26%     -99.1%       0.07 ± 76%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      4.54 ±  7%    -100.0%       0.00        perf-sched.wait_time.avg.ms.rcu_gp_kthread.kthread.ret_from_fork
    117.58 ± 60%    -100.0%       0.00        perf-sched.wait_time.avg.ms.rpc_wait_bit_killable.__wait_on_bit.out_of_line_wait_on_bit.__rpc_execute
    191.32 ± 21%    -100.0%       0.00        perf-sched.wait_time.avg.ms.rpc_wait_bit_killable.__wait_on_bit.out_of_line_wait_on_bit.nfs4_do_close
    115.87 ± 44%    -100.0%       0.00        perf-sched.wait_time.avg.ms.rpc_wait_bit_killable.__wait_on_bit.out_of_line_wait_on_bit.nfs4_run_open_task
    153.66 ± 73%     -99.2%       1.19 ± 31%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
    505.21 ± 29%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
     33.17 ± 71%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_timeout.__break_lease.do_dentry_open.dentry_open
      5.70 ±228%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_timeout.__skb_wait_for_more_packets.unix_dgram_recvmsg.__sys_recvfrom
    478.60          -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.01 ± 37%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_timeout.khugepaged.kthread.ret_from_fork
     14.99 ± 20%     -77.5%       3.37 ± 16%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
    244.02 ±  3%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_timeout.svc_recv.nfs4_callback_svc.kthread
    419.20 ±  3%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_timeout.svc_recv.nfsd.kthread
    539.40 ± 59%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_timeout.wait_for_completion_killable.__kthread_create_on_node.kthread_create_on_node
    727.38 ±  2%     -99.8%       1.67 ± 13%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.00          -100.0%       0.00        perf-sched.wait_time.avg.ms.wait_on_commit.__nfs_commit_inode.nfs_wb_all.nfs4_file_flush
    307.38 ±  8%     -99.6%       1.25 ± 26%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork
    999.57          -100.0%       0.00        perf-sched.wait_time.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      1000          -100.0%       0.00        perf-sched.wait_time.max.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      3.38 ±  7%     -46.4%       1.82 ± 87%  perf-sched.wait_time.max.ms.do_syslog.part.0.kmsg_read.vfs_read
      1347 ± 33%    -100.0%       0.00        perf-sched.wait_time.max.ms.do_task_dead.do_exit.__module_put_and_exit.nfs4_run_state_manager.kthread
      1000           -99.4%       5.88 ± 47%  perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     21.29           -95.1%       1.04 ± 24%  perf-sched.wait_time.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
    429.56 ± 13%    -100.0%       0.00        perf-sched.wait_time.max.ms.io_schedule.wait_on_page_bit.wait_on_page_writeback.__filemap_fdatawait_range
      1422 ± 30%    -100.0%       0.00        perf-sched.wait_time.max.ms.kthreadd.ret_from_fork
      1013           -99.8%       2.19 ± 16%  perf-sched.wait_time.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
    287.97 ± 33%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.__synchronize_srcu.part
      7413 ± 54%     -99.9%      10.05 ± 62%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      4.89 ±  6%    -100.0%       0.00        perf-sched.wait_time.max.ms.rcu_gp_kthread.kthread.ret_from_fork
    428.16 ± 14%    -100.0%       0.00        perf-sched.wait_time.max.ms.rpc_wait_bit_killable.__wait_on_bit.out_of_line_wait_on_bit.__rpc_execute
    434.56 ± 13%    -100.0%       0.00        perf-sched.wait_time.max.ms.rpc_wait_bit_killable.__wait_on_bit.out_of_line_wait_on_bit.nfs4_do_close
    354.26 ± 42%    -100.0%       0.00        perf-sched.wait_time.max.ms.rpc_wait_bit_killable.__wait_on_bit.out_of_line_wait_on_bit.nfs4_run_open_task
      2078 ±109%     -99.8%       4.93 ± 48%  perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      3446 ±112%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
    504.36          -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_timeout.__break_lease.do_dentry_open.dentry_open
      5.70 ±228%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_timeout.__skb_wait_for_more_packets.unix_dgram_recvmsg.__sys_recvfrom
    505.02          -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.01 ± 37%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_timeout.khugepaged.kthread.ret_from_fork
    284.37 ± 20%     -98.0%       5.67 ± 38%  perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
    504.24          -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_timeout.svc_recv.nfs4_callback_svc.kthread
    508.16          -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_timeout.svc_recv.nfsd.kthread
    918.98 ± 46%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_timeout.wait_for_completion_killable.__kthread_create_on_node.kthread_create_on_node
      1013           -98.7%      13.36 ± 28%  perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.00          -100.0%       0.00        perf-sched.wait_time.max.ms.wait_on_commit.__nfs_commit_inode.nfs_wb_all.nfs4_file_flush
      7487 ± 12%     -99.9%      10.32 ± 55%  perf-sched.wait_time.max.ms.worker_thread.kthread.ret_from_fork
     57658 ±122%     -96.3%       2116 ±131%  interrupts.31:PCI-MSI.524289-edge.eth0-TxRx-0
    518770 ±227%     -99.9%     712.71 ±130%  interrupts.32:PCI-MSI.524290-edge.eth0-TxRx-1
     39002 ±141%     -98.4%     643.29 ±165%  interrupts.33:PCI-MSI.524291-edge.eth0-TxRx-2
      2760 ± 36%     -96.7%      91.71        interrupts.9:IO-APIC.9-fasteoi.acpi
   2490412 ± 39%     -96.3%      91324        interrupts.CPU0.LOC:Local_timer_interrupts
    164.29 ± 47%     -94.3%       9.43 ± 39%  interrupts.CPU0.RES:Rescheduling_interrupts
      2760 ± 36%     -96.7%      91.71        interrupts.CPU1.9:IO-APIC.9-fasteoi.acpi
   2496361 ± 39%     -96.4%      91112        interrupts.CPU1.LOC:Local_timer_interrupts
    124.86 ±101%     -95.2%       6.00 ±108%  interrupts.CPU1.RES:Rescheduling_interrupts
     57658 ±122%     -96.3%       2116 ±131%  interrupts.CPU10.31:PCI-MSI.524289-edge.eth0-TxRx-0
   2492693 ± 39%     -96.3%      91329        interrupts.CPU10.LOC:Local_timer_interrupts
   2487825 ± 39%     -96.3%      91334        interrupts.CPU100.LOC:Local_timer_interrupts
   2492435 ± 39%     -96.3%      91272        interrupts.CPU101.LOC:Local_timer_interrupts
     79.71 ± 62%     -94.4%       4.43 ± 91%  interrupts.CPU101.RES:Rescheduling_interrupts
   2488289 ± 39%     -96.3%      91259        interrupts.CPU102.LOC:Local_timer_interrupts
   2492529 ± 39%     -96.3%      91260        interrupts.CPU103.LOC:Local_timer_interrupts
      4886 ±111%     -81.6%     899.57 ±  3%  interrupts.CPU104.CAL:Function_call_interrupts
   2489354 ± 39%     -96.3%      91299        interrupts.CPU104.LOC:Local_timer_interrupts
     67.00 ± 75%     -91.3%       5.86 ±137%  interrupts.CPU104.RES:Rescheduling_interrupts
   2487560 ± 39%     -96.3%      91304        interrupts.CPU105.LOC:Local_timer_interrupts
   2492763 ± 39%     -96.3%      91237        interrupts.CPU106.LOC:Local_timer_interrupts
      4878 ± 99%     -72.9%       1323 ± 64%  interrupts.CPU107.CAL:Function_call_interrupts
   2637385 ± 36%     -96.5%      91309        interrupts.CPU107.LOC:Local_timer_interrupts
   2493801 ± 39%     -96.3%      91298        interrupts.CPU108.LOC:Local_timer_interrupts
   2499207 ± 39%     -96.3%      91242        interrupts.CPU109.LOC:Local_timer_interrupts
    518770 ±227%     -99.9%     712.71 ±130%  interrupts.CPU11.32:PCI-MSI.524290-edge.eth0-TxRx-1
   2637573 ± 36%     -96.5%      91263        interrupts.CPU11.LOC:Local_timer_interrupts
    123.86 ± 91%     -96.7%       4.14 ± 79%  interrupts.CPU11.RES:Rescheduling_interrupts
      5608 ± 92%     -82.6%     973.71 ± 11%  interrupts.CPU110.CAL:Function_call_interrupts
   2489288 ± 39%     -96.3%      91317        interrupts.CPU110.LOC:Local_timer_interrupts
   2487963 ± 39%     -96.3%      91291        interrupts.CPU111.LOC:Local_timer_interrupts
     92.00 ±109%     -96.1%       3.57 ±102%  interrupts.CPU111.RES:Rescheduling_interrupts
      6327 ±159%     -86.6%     850.14 ± 17%  interrupts.CPU112.CAL:Function_call_interrupts
   2489542 ± 39%     -96.3%      91291        interrupts.CPU112.LOC:Local_timer_interrupts
     11220 ±198%     -92.2%     876.29        interrupts.CPU113.CAL:Function_call_interrupts
   2487908 ± 39%     -96.3%      91319        interrupts.CPU113.LOC:Local_timer_interrupts
      6698 ±169%     -87.3%     848.71 ± 17%  interrupts.CPU114.CAL:Function_call_interrupts
   2510705 ± 39%     -96.4%      91150        interrupts.CPU114.LOC:Local_timer_interrupts
      1966 ± 82%     -54.2%     900.29 ±  5%  interrupts.CPU115.CAL:Function_call_interrupts
   2492004 ± 39%     -96.3%      91284        interrupts.CPU115.LOC:Local_timer_interrupts
      4183 ±121%     -78.9%     883.86        interrupts.CPU116.CAL:Function_call_interrupts
   2487622 ± 39%     -96.3%      91277        interrupts.CPU116.LOC:Local_timer_interrupts
      4703 ±177%     -81.1%     889.71 ±  2%  interrupts.CPU117.CAL:Function_call_interrupts
   2504527 ± 39%     -96.4%      91203        interrupts.CPU117.LOC:Local_timer_interrupts
   2488014 ± 39%     -96.3%      91298        interrupts.CPU118.LOC:Local_timer_interrupts
   2489088 ± 39%     -96.3%      91302        interrupts.CPU119.LOC:Local_timer_interrupts
     39002 ±141%     -98.4%     643.29 ±165%  interrupts.CPU12.33:PCI-MSI.524291-edge.eth0-TxRx-2
   2493642 ± 39%     -96.3%      91277        interrupts.CPU12.LOC:Local_timer_interrupts
   2420958 ± 41%     -96.2%      90976        interrupts.CPU120.LOC:Local_timer_interrupts
   2422470 ± 41%     -96.2%      91092        interrupts.CPU121.LOC:Local_timer_interrupts
   2421825 ± 41%     -96.2%      91083        interrupts.CPU122.LOC:Local_timer_interrupts
   2420180 ± 41%     -96.2%      91089        interrupts.CPU123.LOC:Local_timer_interrupts
   2420054 ± 41%     -96.2%      91085        interrupts.CPU124.LOC:Local_timer_interrupts
   2419854 ± 41%     -96.2%      91104        interrupts.CPU125.LOC:Local_timer_interrupts
   2420234 ± 41%     -96.2%      91071        interrupts.CPU126.LOC:Local_timer_interrupts
   2420887 ± 41%     -96.2%      91071        interrupts.CPU127.LOC:Local_timer_interrupts
   2420267 ± 41%     -96.2%      91040        interrupts.CPU128.LOC:Local_timer_interrupts
   2419579 ± 41%     -96.2%      91101        interrupts.CPU129.LOC:Local_timer_interrupts
   2498910 ± 39%     -96.4%      91098        interrupts.CPU13.LOC:Local_timer_interrupts
   2420608 ± 41%     -96.2%      91085        interrupts.CPU130.LOC:Local_timer_interrupts
   2419906 ± 41%     -96.2%      91092        interrupts.CPU131.LOC:Local_timer_interrupts
   2420183 ± 41%     -96.2%      91109        interrupts.CPU132.LOC:Local_timer_interrupts
   2421395 ± 41%     -96.2%      91095        interrupts.CPU133.LOC:Local_timer_interrupts
   2420878 ± 41%     -96.2%      91085        interrupts.CPU134.LOC:Local_timer_interrupts
   2419822 ± 41%     -96.2%      91067        interrupts.CPU135.LOC:Local_timer_interrupts
   2420689 ± 41%     -96.2%      91082        interrupts.CPU136.LOC:Local_timer_interrupts
   2419753 ± 41%     -96.2%      91065        interrupts.CPU137.LOC:Local_timer_interrupts
   2419545 ± 41%     -96.2%      91078        interrupts.CPU138.LOC:Local_timer_interrupts
   2419921 ± 41%     -96.2%      91089        interrupts.CPU139.LOC:Local_timer_interrupts
   2489272 ± 39%     -96.3%      91342        interrupts.CPU14.LOC:Local_timer_interrupts
    323.86 ±170%     -96.7%      10.71 ±175%  interrupts.CPU14.RES:Rescheduling_interrupts
   2419523 ± 41%     -96.2%      91086        interrupts.CPU140.LOC:Local_timer_interrupts
   2419925 ± 41%     -96.2%      91109        interrupts.CPU141.LOC:Local_timer_interrupts
   2419654 ± 41%     -96.2%      91019        interrupts.CPU142.LOC:Local_timer_interrupts
   2420227 ± 41%     -96.2%      91092        interrupts.CPU143.LOC:Local_timer_interrupts
      4371 ±188%     -79.8%     882.00        interrupts.CPU144.CAL:Function_call_interrupts
   2454222 ± 40%     -96.3%      90726        interrupts.CPU144.LOC:Local_timer_interrupts
   2453981 ± 40%     -96.3%      90734        interrupts.CPU145.LOC:Local_timer_interrupts
      2062 ± 80%     -57.3%     879.71        interrupts.CPU146.CAL:Function_call_interrupts
   2453738 ± 40%     -96.3%      90721        interrupts.CPU146.LOC:Local_timer_interrupts
      2058 ±121%     -56.8%     889.71 ±  2%  interrupts.CPU147.CAL:Function_call_interrupts
   2452896 ± 40%     -96.3%      90722        interrupts.CPU147.LOC:Local_timer_interrupts
      1492 ± 65%     -41.1%     879.57        interrupts.CPU148.CAL:Function_call_interrupts
   2452811 ± 40%     -96.3%      90725        interrupts.CPU148.LOC:Local_timer_interrupts
      4539 ±170%     -80.6%     880.29        interrupts.CPU149.CAL:Function_call_interrupts
   2452928 ± 40%     -96.3%      90712        interrupts.CPU149.LOC:Local_timer_interrupts
      3293 ± 81%     -72.1%     917.29 ±  8%  interrupts.CPU15.CAL:Function_call_interrupts
   2487749 ± 39%     -96.3%      91282        interrupts.CPU15.LOC:Local_timer_interrupts
     64.57 ± 63%     -90.9%       5.86 ± 86%  interrupts.CPU15.RES:Rescheduling_interrupts
      8682 ±139%     -89.9%     879.43        interrupts.CPU150.CAL:Function_call_interrupts
   2453268 ± 40%     -96.3%      90706        interrupts.CPU150.LOC:Local_timer_interrupts
      9295 ±126%     -90.5%     879.57        interrupts.CPU151.CAL:Function_call_interrupts
   2453593 ± 40%     -96.3%      90718        interrupts.CPU151.LOC:Local_timer_interrupts
      2527 ± 83%     -65.0%     884.29        interrupts.CPU152.CAL:Function_call_interrupts
   2453359 ± 40%     -96.3%      90679        interrupts.CPU152.LOC:Local_timer_interrupts
      4729 ±135%     -81.4%     879.43        interrupts.CPU153.CAL:Function_call_interrupts
   2453342 ± 40%     -96.3%      90712        interrupts.CPU153.LOC:Local_timer_interrupts
      1297 ± 50%     -33.2%     867.57 ±  3%  interrupts.CPU154.CAL:Function_call_interrupts
   2452929 ± 40%     -96.3%      90735        interrupts.CPU154.LOC:Local_timer_interrupts
      5710 ±192%     -84.6%     880.29        interrupts.CPU155.CAL:Function_call_interrupts
   2453533 ± 40%     -96.3%      90720        interrupts.CPU155.LOC:Local_timer_interrupts
      1468 ± 67%     -40.1%     879.43        interrupts.CPU156.CAL:Function_call_interrupts
   2453761 ± 40%     -96.3%      90723        interrupts.CPU156.LOC:Local_timer_interrupts
      1541 ± 69%     -42.9%     879.57        interrupts.CPU157.CAL:Function_call_interrupts
   2453283 ± 40%     -96.3%      90723        interrupts.CPU157.LOC:Local_timer_interrupts
      1811 ± 92%     -51.5%     879.43        interrupts.CPU158.CAL:Function_call_interrupts
   2453080 ± 40%     -96.3%      90720        interrupts.CPU158.LOC:Local_timer_interrupts
   2453453 ± 40%     -96.3%      90728        interrupts.CPU159.LOC:Local_timer_interrupts
      4315 ±143%     -77.1%     990.29 ± 23%  interrupts.CPU16.CAL:Function_call_interrupts
   2489207 ± 39%     -96.3%      91305        interrupts.CPU16.LOC:Local_timer_interrupts
      3491 ±167%     -74.8%     879.57        interrupts.CPU160.CAL:Function_call_interrupts
   2452919 ± 40%     -96.3%      90723        interrupts.CPU160.LOC:Local_timer_interrupts
      2842 ±114%     -68.5%     895.57 ±  4%  interrupts.CPU161.CAL:Function_call_interrupts
   2452864 ± 40%     -96.3%      90728        interrupts.CPU161.LOC:Local_timer_interrupts
      2162 ± 78%     -59.2%     881.57        interrupts.CPU162.CAL:Function_call_interrupts
   2454093 ± 40%     -96.3%      90753        interrupts.CPU162.LOC:Local_timer_interrupts
   2454141 ± 40%     -96.3%      90708        interrupts.CPU163.LOC:Local_timer_interrupts
    141.14 ±164%     -98.9%       1.57 ±112%  interrupts.CPU163.RES:Rescheduling_interrupts
      3691 ±125%     -76.2%     879.71        interrupts.CPU164.CAL:Function_call_interrupts
   2453980 ± 40%     -96.3%      90715        interrupts.CPU164.LOC:Local_timer_interrupts
      2453 ±133%     -64.1%     879.71        interrupts.CPU165.CAL:Function_call_interrupts
   2453765 ± 40%     -96.3%      90719        interrupts.CPU165.LOC:Local_timer_interrupts
   2453757 ± 40%     -96.3%      90664        interrupts.CPU166.LOC:Local_timer_interrupts
      1220 ± 38%     -27.9%     880.14        interrupts.CPU167.CAL:Function_call_interrupts
   2454203 ± 40%     -96.3%      90731        interrupts.CPU167.LOC:Local_timer_interrupts
   2431097 ± 41%     -96.2%      91228        interrupts.CPU168.LOC:Local_timer_interrupts
   2431590 ± 41%     -96.2%      91231        interrupts.CPU169.LOC:Local_timer_interrupts
     74.71 ± 34%     -89.5%       7.86 ±119%  interrupts.CPU169.RES:Rescheduling_interrupts
      2108 ± 66%     -54.5%     958.43 ± 14%  interrupts.CPU17.CAL:Function_call_interrupts
   2487802 ± 39%     -96.3%      91311        interrupts.CPU17.LOC:Local_timer_interrupts
   2430759 ± 41%     -96.2%      91243        interrupts.CPU170.LOC:Local_timer_interrupts
   2429721 ± 41%     -96.2%      91210        interrupts.CPU171.LOC:Local_timer_interrupts
     89.29 ± 98%     -89.0%       9.86 ±165%  interrupts.CPU171.RES:Rescheduling_interrupts
   2429830 ± 41%     -96.2%      91242        interrupts.CPU172.LOC:Local_timer_interrupts
   2429829 ± 41%     -96.2%      91242        interrupts.CPU173.LOC:Local_timer_interrupts
   2430243 ± 41%     -96.2%      91228        interrupts.CPU174.LOC:Local_timer_interrupts
   2430379 ± 41%     -96.3%      91102        interrupts.CPU175.LOC:Local_timer_interrupts
   2430281 ± 41%     -96.2%      91212        interrupts.CPU176.LOC:Local_timer_interrupts
   2429541 ± 41%     -96.2%      91228        interrupts.CPU177.LOC:Local_timer_interrupts
   2430206 ± 41%     -96.2%      91154        interrupts.CPU178.LOC:Local_timer_interrupts
   2429684 ± 41%     -96.2%      91214        interrupts.CPU179.LOC:Local_timer_interrupts
   2510517 ± 39%     -96.4%      91149        interrupts.CPU18.LOC:Local_timer_interrupts
   2429935 ± 41%     -96.2%      91215        interrupts.CPU180.LOC:Local_timer_interrupts
   2430614 ± 41%     -96.2%      91208        interrupts.CPU181.LOC:Local_timer_interrupts
   2430190 ± 41%     -96.2%      91249        interrupts.CPU182.LOC:Local_timer_interrupts
   2429529 ± 41%     -96.2%      91231        interrupts.CPU183.LOC:Local_timer_interrupts
   2430248 ± 41%     -96.2%      91207        interrupts.CPU184.LOC:Local_timer_interrupts
   2429521 ± 41%     -96.2%      91221        interrupts.CPU185.LOC:Local_timer_interrupts
   2429570 ± 41%     -96.2%      91244        interrupts.CPU186.LOC:Local_timer_interrupts
   2429971 ± 41%     -96.2%      91200        interrupts.CPU187.LOC:Local_timer_interrupts
   2429989 ± 41%     -96.2%      91198        interrupts.CPU188.LOC:Local_timer_interrupts
   2429741 ± 41%     -96.2%      91227        interrupts.CPU189.LOC:Local_timer_interrupts
   2491898 ± 39%     -96.3%      91249        interrupts.CPU19.LOC:Local_timer_interrupts
   2429867 ± 41%     -96.2%      91216        interrupts.CPU190.LOC:Local_timer_interrupts
   2429989 ± 41%     -96.2%      91228        interrupts.CPU191.LOC:Local_timer_interrupts
   2488910 ± 39%     -96.3%      91184        interrupts.CPU2.LOC:Local_timer_interrupts
     75.43 ± 61%     -95.3%       3.57 ±108%  interrupts.CPU2.RES:Rescheduling_interrupts
     10172 ±144%     -91.2%     892.00 ±  3%  interrupts.CPU20.CAL:Function_call_interrupts
   2487584 ± 39%     -96.3%      91321        interrupts.CPU20.LOC:Local_timer_interrupts
      4500 ±177%     -79.4%     928.86 ±  9%  interrupts.CPU21.CAL:Function_call_interrupts
   2504342 ± 39%     -96.4%      91232        interrupts.CPU21.LOC:Local_timer_interrupts
      1194 ± 21%     -28.9%     848.43 ± 13%  interrupts.CPU22.CAL:Function_call_interrupts
   2488071 ± 39%     -96.3%      91276        interrupts.CPU22.LOC:Local_timer_interrupts
      7608 ±178%     -88.4%     885.57 ± 19%  interrupts.CPU23.CAL:Function_call_interrupts
   2489043 ± 39%     -96.3%      91299        interrupts.CPU23.LOC:Local_timer_interrupts
   2420945 ± 41%     -96.2%      91146        interrupts.CPU24.LOC:Local_timer_interrupts
   2422250 ± 41%     -96.2%      91122        interrupts.CPU25.LOC:Local_timer_interrupts
   2421951 ± 41%     -96.2%      91098        interrupts.CPU26.LOC:Local_timer_interrupts
   2420134 ± 41%     -96.2%      90954        interrupts.CPU27.LOC:Local_timer_interrupts
   2420084 ± 41%     -96.2%      91028        interrupts.CPU28.LOC:Local_timer_interrupts
   2419903 ± 41%     -96.2%      91092        interrupts.CPU29.LOC:Local_timer_interrupts
   2487670 ± 39%     -96.3%      91260        interrupts.CPU3.LOC:Local_timer_interrupts
   2420273 ± 41%     -96.2%      91098        interrupts.CPU30.LOC:Local_timer_interrupts
   2420988 ± 41%     -96.2%      91097        interrupts.CPU31.LOC:Local_timer_interrupts
   2420408 ± 41%     -96.2%      90982        interrupts.CPU32.LOC:Local_timer_interrupts
    119.14 ± 86%    +686.7%     937.29 ± 96%  interrupts.CPU32.NMI:Non-maskable_interrupts
    119.14 ± 86%    +686.7%     937.29 ± 96%  interrupts.CPU32.PMI:Performance_monitoring_interrupts
   2419674 ± 41%     -96.2%      91107        interrupts.CPU33.LOC:Local_timer_interrupts
   2420687 ± 41%     -96.2%      91124        interrupts.CPU34.LOC:Local_timer_interrupts
   2419977 ± 41%     -96.2%      91100        interrupts.CPU35.LOC:Local_timer_interrupts
   2420227 ± 41%     -96.2%      91096        interrupts.CPU36.LOC:Local_timer_interrupts
   2421386 ± 41%     -96.2%      91100        interrupts.CPU37.LOC:Local_timer_interrupts
   2420870 ± 41%     -96.2%      91104        interrupts.CPU38.LOC:Local_timer_interrupts
   2419752 ± 41%     -96.2%      91100        interrupts.CPU39.LOC:Local_timer_interrupts
      1911 ± 47%     -53.0%     897.57 ±  5%  interrupts.CPU4.CAL:Function_call_interrupts
   2487885 ± 39%     -96.3%      91286        interrupts.CPU4.LOC:Local_timer_interrupts
    166.43 ± 82%     -98.1%       3.14 ±109%  interrupts.CPU4.RES:Rescheduling_interrupts
   2420690 ± 41%     -96.2%      91102        interrupts.CPU40.LOC:Local_timer_interrupts
   2419764 ± 41%     -96.2%      91080        interrupts.CPU41.LOC:Local_timer_interrupts
   2419514 ± 41%     -96.2%      91095        interrupts.CPU42.LOC:Local_timer_interrupts
   2419976 ± 41%     -96.2%      91040        interrupts.CPU43.LOC:Local_timer_interrupts
   2419550 ± 41%     -96.2%      91137        interrupts.CPU44.LOC:Local_timer_interrupts
   2419782 ± 41%     -96.2%      91100        interrupts.CPU45.LOC:Local_timer_interrupts
   2419629 ± 41%     -96.2%      91056        interrupts.CPU46.LOC:Local_timer_interrupts
   2420134 ± 41%     -96.2%      91103        interrupts.CPU47.LOC:Local_timer_interrupts
   2454071 ± 40%     -96.3%      90705        interrupts.CPU48.LOC:Local_timer_interrupts
   2453685 ± 40%     -96.3%      90676        interrupts.CPU49.LOC:Local_timer_interrupts
      3006 ± 83%     -72.4%     828.71 ± 16%  interrupts.CPU5.CAL:Function_call_interrupts
   2491959 ± 39%     -96.3%      91367        interrupts.CPU5.LOC:Local_timer_interrupts
   2453674 ± 40%     -96.3%      90746        interrupts.CPU50.LOC:Local_timer_interrupts
   2452711 ± 40%     -96.3%      90738        interrupts.CPU51.LOC:Local_timer_interrupts
      3142 ±131%     -71.5%     895.57 ±  4%  interrupts.CPU52.CAL:Function_call_interrupts
   2452719 ± 40%     -96.3%      90770        interrupts.CPU52.LOC:Local_timer_interrupts
      2422 ± 95%     -62.7%     902.29 ±  6%  interrupts.CPU53.CAL:Function_call_interrupts
   2452919 ± 40%     -96.3%      90735        interrupts.CPU53.LOC:Local_timer_interrupts
      1398 ± 30%     -37.2%     878.71        interrupts.CPU54.CAL:Function_call_interrupts
   2453285 ± 40%     -96.3%      90727        interrupts.CPU54.LOC:Local_timer_interrupts
     66.14 ±117%     -99.4%       0.43 ±169%  interrupts.CPU54.RES:Rescheduling_interrupts
      1431 ± 43%     -38.6%     879.14        interrupts.CPU55.CAL:Function_call_interrupts
   2453489 ± 40%     -96.3%      90735        interrupts.CPU55.LOC:Local_timer_interrupts
      2820 ±124%     -68.8%     880.00        interrupts.CPU56.CAL:Function_call_interrupts
   2453306 ± 40%     -96.3%      90744        interrupts.CPU56.LOC:Local_timer_interrupts
     50.71 ± 67%     -98.0%       1.00 ±141%  interrupts.CPU56.RES:Rescheduling_interrupts
     11295 ±198%     -92.2%     879.00        interrupts.CPU57.CAL:Function_call_interrupts
   2453337 ± 40%     -96.3%      90745        interrupts.CPU57.LOC:Local_timer_interrupts
      3630 ±127%     -75.5%     890.29 ±  2%  interrupts.CPU58.CAL:Function_call_interrupts
   2452960 ± 40%     -96.3%      90759        interrupts.CPU58.LOC:Local_timer_interrupts
      5277 ±167%     -83.4%     878.57        interrupts.CPU59.CAL:Function_call_interrupts
   2453482 ± 40%     -96.3%      90752        interrupts.CPU59.LOC:Local_timer_interrupts
      7217 ±104%     -85.0%       1080 ± 45%  interrupts.CPU6.CAL:Function_call_interrupts
   2487868 ± 39%     -96.3%      91314        interrupts.CPU6.LOC:Local_timer_interrupts
      2890 ±140%     -69.6%     879.00        interrupts.CPU60.CAL:Function_call_interrupts
   2453831 ± 40%     -96.3%      90755        interrupts.CPU60.LOC:Local_timer_interrupts
      5076 ±177%     -82.7%     878.71        interrupts.CPU61.CAL:Function_call_interrupts
   2453286 ± 40%     -96.3%      90746        interrupts.CPU61.LOC:Local_timer_interrupts
     10829 ±214%     -91.9%     879.14        interrupts.CPU62.CAL:Function_call_interrupts
   2453090 ± 40%     -96.3%      90741        interrupts.CPU62.LOC:Local_timer_interrupts
      3414 ±118%     -74.2%     879.29        interrupts.CPU63.CAL:Function_call_interrupts
   2453467 ± 40%     -96.3%      90735        interrupts.CPU63.LOC:Local_timer_interrupts
      2710 ±117%     -67.6%     879.14        interrupts.CPU64.CAL:Function_call_interrupts
   2452766 ± 40%     -96.3%      90730        interrupts.CPU64.LOC:Local_timer_interrupts
      3876 ±130%     -77.1%     886.57        interrupts.CPU65.CAL:Function_call_interrupts
   2452894 ± 40%     -96.3%      90728        interrupts.CPU65.LOC:Local_timer_interrupts
   2454104 ± 40%     -96.3%      90773        interrupts.CPU66.LOC:Local_timer_interrupts
      3087 ±108%     -71.5%     879.14        interrupts.CPU67.CAL:Function_call_interrupts
   2454051 ± 40%     -96.3%      90731        interrupts.CPU67.LOC:Local_timer_interrupts
     75.43 ± 88%     -98.5%       1.14 ± 98%  interrupts.CPU67.RES:Rescheduling_interrupts
      2051 ± 97%     -56.9%     884.43        interrupts.CPU68.CAL:Function_call_interrupts
   2453782 ± 40%     -96.3%      90740        interrupts.CPU68.LOC:Local_timer_interrupts
      4559 ±110%     -80.7%     878.86        interrupts.CPU69.CAL:Function_call_interrupts
   2453681 ± 40%     -96.3%      90744        interrupts.CPU69.LOC:Local_timer_interrupts
      6680 ±127%     -75.8%       1613 ± 54%  interrupts.CPU7.CAL:Function_call_interrupts
   2492499 ± 39%     -96.3%      91316        interrupts.CPU7.LOC:Local_timer_interrupts
      2997 ±118%     -70.7%     879.43        interrupts.CPU70.CAL:Function_call_interrupts
   2453660 ± 40%     -96.3%      90716        interrupts.CPU70.LOC:Local_timer_interrupts
      3767 ±157%     -76.7%     879.00        interrupts.CPU71.CAL:Function_call_interrupts
   2454048 ± 40%     -96.3%      90703        interrupts.CPU71.LOC:Local_timer_interrupts
   2430913 ± 41%     -96.2%      91249        interrupts.CPU72.LOC:Local_timer_interrupts
   2431476 ± 41%     -96.2%      91231        interrupts.CPU73.LOC:Local_timer_interrupts
   2430860 ± 41%     -96.2%      91238        interrupts.CPU74.LOC:Local_timer_interrupts
     59.71 ± 40%     -84.4%       9.29 ±120%  interrupts.CPU74.RES:Rescheduling_interrupts
   2429835 ± 41%     -96.2%      91240        interrupts.CPU75.LOC:Local_timer_interrupts
   2430391 ± 41%     -96.2%      91232        interrupts.CPU76.LOC:Local_timer_interrupts
   2430019 ± 41%     -96.2%      91211        interrupts.CPU77.LOC:Local_timer_interrupts
   2430352 ± 41%     -96.2%      91245        interrupts.CPU78.LOC:Local_timer_interrupts
   2430410 ± 41%     -96.2%      91232        interrupts.CPU79.LOC:Local_timer_interrupts
   2489243 ± 39%     -96.3%      91346        interrupts.CPU8.LOC:Local_timer_interrupts
    101.57 ± 72%     -93.7%       6.43 ±117%  interrupts.CPU8.RES:Rescheduling_interrupts
   2430323 ± 41%     -96.2%      91244        interrupts.CPU80.LOC:Local_timer_interrupts
   2429232 ± 41%     -96.2%      91242        interrupts.CPU81.LOC:Local_timer_interrupts
   2430091 ± 41%     -96.2%      91199        interrupts.CPU82.LOC:Local_timer_interrupts
   2429550 ± 41%     -96.2%      91239        interrupts.CPU83.LOC:Local_timer_interrupts
   2429853 ± 41%     -96.2%      91238        interrupts.CPU84.LOC:Local_timer_interrupts
   2430492 ± 41%     -96.2%      91230        interrupts.CPU85.LOC:Local_timer_interrupts
   2430457 ± 41%     -96.2%      91238        interrupts.CPU86.LOC:Local_timer_interrupts
   2429742 ± 41%     -96.2%      91230        interrupts.CPU87.LOC:Local_timer_interrupts
   2430243 ± 41%     -96.2%      91271        interrupts.CPU88.LOC:Local_timer_interrupts
   2429487 ± 41%     -96.2%      91238        interrupts.CPU89.LOC:Local_timer_interrupts
   2487510 ± 39%     -96.3%      91276        interrupts.CPU9.LOC:Local_timer_interrupts
   2429458 ± 41%     -96.2%      91237        interrupts.CPU90.LOC:Local_timer_interrupts
      1328 ± 57%     -33.3%     885.43 ±  2%  interrupts.CPU91.CAL:Function_call_interrupts
   2429837 ± 41%     -96.2%      91257        interrupts.CPU91.LOC:Local_timer_interrupts
    142.29 ± 83%     -97.3%       3.86 ±108%  interrupts.CPU91.RES:Rescheduling_interrupts
      1199 ± 34%     -24.9%     901.00 ±  4%  interrupts.CPU92.CAL:Function_call_interrupts
   2429612 ± 41%     -96.2%      91223        interrupts.CPU92.LOC:Local_timer_interrupts
      1163 ± 28%     -23.8%     887.00        interrupts.CPU93.CAL:Function_call_interrupts
   2429822 ± 41%     -96.2%      91246        interrupts.CPU93.LOC:Local_timer_interrupts
   2429585 ± 41%     -96.2%      91241        interrupts.CPU94.LOC:Local_timer_interrupts
     76.43 ± 89%     -95.0%       3.86 ±176%  interrupts.CPU94.RES:Rescheduling_interrupts
   2430007 ± 41%     -96.2%      91245        interrupts.CPU95.LOC:Local_timer_interrupts
     81.43 ± 56%     -93.5%       5.29 ± 83%  interrupts.CPU95.RES:Rescheduling_interrupts
   2488093 ± 39%     -96.3%      91092        interrupts.CPU96.LOC:Local_timer_interrupts
      4447 ±108%     -80.0%     890.00 ±  3%  interrupts.CPU97.CAL:Function_call_interrupts
   2496116 ± 39%     -96.3%      91159        interrupts.CPU97.LOC:Local_timer_interrupts
    217.71 ± 74%     -54.7%      98.71 ± 37%  interrupts.CPU97.NMI:Non-maskable_interrupts
    217.71 ± 74%     -54.7%      98.71 ± 37%  interrupts.CPU97.PMI:Performance_monitoring_interrupts
   2489043 ± 39%     -96.3%      91270        interrupts.CPU98.LOC:Local_timer_interrupts
      1062 ± 11%     -18.0%     871.00 ±  3%  interrupts.CPU99.CAL:Function_call_interrupts
   2487795 ± 39%     -96.3%      91273        interrupts.CPU99.LOC:Local_timer_interrupts
 4.705e+08 ± 40%     -96.3%   17486659        interrupts.LOC:Local_timer_interrupts
     11333 ± 31%     -79.9%       2273 ±  5%  interrupts.RES:Rescheduling_interrupts
    119702 ± 52%     -92.4%       9149 ± 10%  softirqs.CPU0.RCU
    160399 ± 40%     -92.9%      11372 ±  7%  softirqs.CPU0.SCHED
    116532 ± 51%     -93.9%       7163 ± 13%  softirqs.CPU1.RCU
    171673 ± 34%     -94.5%       9418 ±  9%  softirqs.CPU1.SCHED
    121864 ± 51%     -93.4%       7993 ± 20%  softirqs.CPU10.RCU
    154113 ± 40%     -93.9%       9460 ± 12%  softirqs.CPU10.SCHED
    123186 ± 56%     -94.2%       7149 ± 16%  softirqs.CPU100.RCU
    151768 ± 39%     -94.7%       8119 ±  2%  softirqs.CPU100.SCHED
    123636 ± 54%     -94.4%       6872 ± 13%  softirqs.CPU101.RCU
    166929 ± 37%     -95.1%       8119 ±  3%  softirqs.CPU101.SCHED
    122395 ± 50%     -94.7%       6457 ± 13%  softirqs.CPU102.RCU
    167054 ± 37%     -95.2%       8015 ±  6%  softirqs.CPU102.SCHED
    119644 ± 52%     -94.3%       6856 ± 24%  softirqs.CPU103.RCU
    165880 ± 37%     -95.8%       6914 ± 17%  softirqs.CPU103.SCHED
    115387 ± 46%     -94.3%       6621 ± 18%  softirqs.CPU104.RCU
    144395 ± 47%     -94.8%       7545 ± 13%  softirqs.CPU104.SCHED
    122365 ± 57%     -94.5%       6768 ± 16%  softirqs.CPU105.RCU
    166544 ± 37%     -95.4%       7734 ± 22%  softirqs.CPU105.SCHED
    121202 ± 52%     -94.6%       6548 ± 16%  softirqs.CPU106.RCU
    166573 ± 37%     -95.6%       7264 ± 15%  softirqs.CPU106.SCHED
    110396 ± 40%     -94.0%       6587 ± 16%  softirqs.CPU107.RCU
    166813 ± 37%     -95.4%       7706 ± 11%  softirqs.CPU107.SCHED
    125378 ± 55%     -94.9%       6410 ± 12%  softirqs.CPU108.RCU
    166920 ± 37%     -95.1%       8107 ±  2%  softirqs.CPU108.SCHED
    118421 ± 53%     -95.0%       5942 ± 19%  softirqs.CPU109.RCU
    165030 ± 37%     -95.4%       7591 ± 10%  softirqs.CPU109.SCHED
    109787 ± 40%     -93.7%       6870 ± 25%  softirqs.CPU11.RCU
    169386 ± 37%     -95.1%       8257 ± 19%  softirqs.CPU11.SCHED
    120040 ± 53%     -94.7%       6365 ± 16%  softirqs.CPU110.RCU
    136317 ± 50%     -94.1%       7998 ±  8%  softirqs.CPU110.SCHED
    123438 ± 56%     -94.6%       6642 ± 15%  softirqs.CPU111.RCU
    166550 ± 37%     -95.1%       8097 ±  6%  softirqs.CPU111.SCHED
    106923 ± 45%     -94.9%       5436 ± 16%  softirqs.CPU112.RCU
    166362 ± 37%     -95.2%       8061        softirqs.CPU112.SCHED
      2784 ±192%     -98.9%      29.57 ± 47%  softirqs.CPU112.TIMER
    117543 ± 55%     -94.6%       6380 ± 36%  softirqs.CPU113.RCU
    155415 ± 40%     -94.8%       8079 ±  6%  softirqs.CPU113.SCHED
    117370 ± 51%     -95.1%       5798 ± 17%  softirqs.CPU114.RCU
    158948 ± 44%     -95.1%       7739 ± 12%  softirqs.CPU114.SCHED
    115573 ± 49%     -95.1%       5673 ± 14%  softirqs.CPU115.RCU
    153922 ± 41%     -95.1%       7609 ± 13%  softirqs.CPU115.SCHED
    119361 ± 54%     -95.2%       5733 ± 18%  softirqs.CPU116.RCU
    155165 ± 41%     -95.1%       7639 ± 11%  softirqs.CPU116.SCHED
    114676 ± 49%     -95.1%       5656 ± 16%  softirqs.CPU117.RCU
    166301 ± 37%     -95.1%       8071 ±  4%  softirqs.CPU117.SCHED
    118159 ± 53%     -95.1%       5822 ± 17%  softirqs.CPU118.RCU
    166252 ± 37%     -95.4%       7646 ± 10%  softirqs.CPU118.SCHED
    114761 ± 51%     -95.3%       5429 ± 16%  softirqs.CPU119.RCU
    166103 ± 37%     -95.2%       7909 ±  8%  softirqs.CPU119.SCHED
     21155 ±126%     -98.0%     432.43 ±134%  softirqs.CPU12.NET_RX
    125900 ± 55%     -94.5%       6972 ± 16%  softirqs.CPU12.RCU
    154389 ± 39%     -94.5%       8467 ±  4%  softirqs.CPU12.SCHED
    110413 ± 42%     -95.1%       5436 ± 16%  softirqs.CPU120.RCU
    160031 ± 37%     -94.8%       8302 ± 14%  softirqs.CPU120.SCHED
    103463 ± 42%     -94.8%       5353 ± 11%  softirqs.CPU121.RCU
    160983 ± 36%     -95.0%       8028 ±  4%  softirqs.CPU121.SCHED
    109052 ± 42%     -94.3%       6200 ± 16%  softirqs.CPU122.RCU
    153477 ± 39%     -94.6%       8333 ±  8%  softirqs.CPU122.SCHED
    111626 ± 45%     -94.6%       6071 ± 15%  softirqs.CPU123.RCU
    166662 ± 37%     -95.2%       8042 ±  6%  softirqs.CPU123.SCHED
    112257 ± 44%     -94.7%       5944 ± 17%  softirqs.CPU124.RCU
    166201 ± 37%     -95.3%       7792 ± 10%  softirqs.CPU124.SCHED
    112169 ± 44%     -94.8%       5851 ± 18%  softirqs.CPU125.RCU
    165780 ± 37%     -95.5%       7476 ± 15%  softirqs.CPU125.SCHED
    112317 ± 44%     -94.5%       6154 ± 19%  softirqs.CPU126.RCU
    165674 ± 37%     -95.1%       8122 ±  5%  softirqs.CPU126.SCHED
    109250 ± 43%     -94.7%       5840 ± 15%  softirqs.CPU127.RCU
    164167 ± 37%     -95.3%       7794 ± 11%  softirqs.CPU127.SCHED
    120347 ± 48%     -94.3%       6878 ± 19%  softirqs.CPU128.RCU
    165049 ± 37%     -95.0%       8273        softirqs.CPU128.SCHED
    121487 ± 49%     -94.0%       7279 ± 20%  softirqs.CPU129.RCU
    166343 ± 37%     -95.2%       8012 ±  7%  softirqs.CPU129.SCHED
    117065 ± 53%     -93.6%       7532 ± 16%  softirqs.CPU13.RCU
    167092 ± 37%     -93.9%      10218 ± 38%  softirqs.CPU13.SCHED
    119255 ± 51%     -93.9%       7256 ± 26%  softirqs.CPU130.RCU
    163943 ± 37%     -95.1%       8068 ±  5%  softirqs.CPU130.SCHED
    124398 ± 53%     -94.1%       7342 ± 14%  softirqs.CPU131.RCU
    165474 ± 36%     -95.2%       7962 ±  7%  softirqs.CPU131.SCHED
    125408 ± 53%     -94.2%       7215 ± 14%  softirqs.CPU132.RCU
    165166 ± 37%     -95.0%       8275 ±  8%  softirqs.CPU132.SCHED
    115060 ± 47%     -94.3%       6506 ± 19%  softirqs.CPU133.RCU
    163629 ± 37%     -95.2%       7914 ±  5%  softirqs.CPU133.SCHED
    119809 ± 50%     -94.2%       6987 ± 20%  softirqs.CPU134.RCU
    163258 ± 37%     -95.1%       7995 ±  3%  softirqs.CPU134.SCHED
    124514 ± 53%     -94.1%       7315 ± 14%  softirqs.CPU135.RCU
    165204 ± 37%     -95.1%       8159 ±  3%  softirqs.CPU135.SCHED
    121458 ± 51%     -94.2%       7074 ± 16%  softirqs.CPU136.RCU
    164219 ± 37%     -95.3%       7757 ± 12%  softirqs.CPU136.SCHED
    126330 ± 53%     -94.1%       7495 ± 26%  softirqs.CPU137.RCU
    166079 ± 37%     -95.4%       7697 ± 12%  softirqs.CPU137.SCHED
    125358 ± 53%     -94.3%       7157 ± 21%  softirqs.CPU138.RCU
    165653 ± 37%     -95.3%       7767 ± 10%  softirqs.CPU138.SCHED
    124241 ± 53%     -94.4%       6923 ± 13%  softirqs.CPU139.RCU
    162389 ± 37%     -94.9%       8266 ±  3%  softirqs.CPU139.SCHED
    111943 ± 60%     -93.7%       7051 ± 17%  softirqs.CPU14.RCU
    167389 ± 37%     -95.2%       8069 ± 17%  softirqs.CPU14.SCHED
    125292 ± 53%     -94.5%       6931 ± 18%  softirqs.CPU140.RCU
    165960 ± 37%     -95.2%       7998 ±  4%  softirqs.CPU140.SCHED
    120846 ± 49%     -94.5%       6659 ± 18%  softirqs.CPU141.RCU
    165499 ± 37%     -95.1%       8138 ±  4%  softirqs.CPU141.SCHED
    122098 ± 50%     -94.1%       7216 ± 13%  softirqs.CPU142.RCU
    165835 ± 37%     -94.9%       8455 ±  4%  softirqs.CPU142.SCHED
    120274 ± 49%     -94.1%       7146 ± 13%  softirqs.CPU143.RCU
    164835 ± 37%     -95.0%       8190 ±  6%  softirqs.CPU143.SCHED
    116248 ± 43%     -94.5%       6409 ± 13%  softirqs.CPU144.RCU
    164356 ± 36%     -95.3%       7689 ± 12%  softirqs.CPU144.SCHED
    110707 ± 44%     -94.4%       6215 ± 13%  softirqs.CPU145.RCU
    163094 ± 37%     -95.1%       8014 ±  5%  softirqs.CPU145.SCHED
    113509 ± 43%     -94.6%       6164 ± 13%  softirqs.CPU146.RCU
    165076 ± 37%     -95.2%       7949 ±  4%  softirqs.CPU146.SCHED
    119204 ± 46%     -94.5%       6502 ± 12%  softirqs.CPU147.RCU
    145423 ± 47%     -94.4%       8082        softirqs.CPU147.SCHED
    119333 ± 46%     -94.5%       6517 ± 14%  softirqs.CPU148.RCU
    165485 ± 37%     -95.2%       7992 ±  3%  softirqs.CPU148.SCHED
    119855 ± 46%     -94.5%       6548 ± 15%  softirqs.CPU149.RCU
    165675 ± 37%     -95.3%       7832 ±  3%  softirqs.CPU149.SCHED
    123618 ± 56%     -94.2%       7123 ± 12%  softirqs.CPU15.RCU
    168475 ± 37%     -95.3%       7924 ± 12%  softirqs.CPU15.SCHED
    120798 ± 45%     -94.3%       6941 ± 16%  softirqs.CPU150.RCU
    165536 ± 37%     -95.1%       8063        softirqs.CPU150.SCHED
    116704 ± 47%     -94.6%       6292 ± 13%  softirqs.CPU151.RCU
    163161 ± 37%     -95.2%       7881 ±  3%  softirqs.CPU151.SCHED
    115651 ± 43%     -94.6%       6288 ± 17%  softirqs.CPU152.RCU
    166065 ± 37%     -95.3%       7878 ±  3%  softirqs.CPU152.SCHED
    117055 ± 47%     -94.4%       6501 ± 13%  softirqs.CPU153.RCU
    164965 ± 37%     -95.3%       7744 ±  2%  softirqs.CPU153.SCHED
    110874 ± 46%     -94.1%       6516 ± 14%  softirqs.CPU154.RCU
    168569 ± 37%     -95.3%       7897 ±  3%  softirqs.CPU154.SCHED
    117137 ± 48%     -94.4%       6605 ± 14%  softirqs.CPU155.RCU
    164639 ± 37%     -95.2%       7824 ±  5%  softirqs.CPU155.SCHED
    114288 ± 45%     -94.4%       6386 ± 15%  softirqs.CPU156.RCU
    163354 ± 37%     -95.1%       7954 ±  2%  softirqs.CPU156.SCHED
    116468 ± 46%     -94.6%       6318 ± 13%  softirqs.CPU157.RCU
    163326 ± 37%     -95.2%       7759 ±  5%  softirqs.CPU157.SCHED
    114530 ± 45%     -94.4%       6415 ± 13%  softirqs.CPU158.RCU
    165411 ± 37%     -95.4%       7656 ±  2%  softirqs.CPU158.SCHED
    116651 ± 44%     -94.6%       6320 ± 14%  softirqs.CPU159.RCU
    165126 ± 37%     -95.3%       7682 ±  3%  softirqs.CPU159.SCHED
    110364 ± 43%     -94.7%       5853 ± 11%  softirqs.CPU16.RCU
    168681 ± 37%     -95.2%       8119 ±  3%  softirqs.CPU16.SCHED
    113973 ± 40%     -94.7%       6011 ± 15%  softirqs.CPU160.RCU
    165771 ± 37%     -95.2%       7971 ±  2%  softirqs.CPU160.SCHED
    117516 ± 43%     -94.7%       6178 ± 17%  softirqs.CPU161.RCU
    165499 ± 37%     -95.2%       8004 ±  3%  softirqs.CPU161.SCHED
    107624 ± 41%     -94.6%       5760 ± 19%  softirqs.CPU162.RCU
    162855 ± 37%     -95.3%       7677 ±  4%  softirqs.CPU162.SCHED
    116166 ± 43%     -94.9%       5884 ± 14%  softirqs.CPU163.RCU
    164646 ± 37%     -95.2%       7871 ±  4%  softirqs.CPU163.SCHED
    116766 ± 44%     -94.9%       5972 ± 15%  softirqs.CPU164.RCU
    165910 ± 37%     -95.2%       7910 ±  2%  softirqs.CPU164.SCHED
    116049 ± 43%     -94.8%       6037 ± 15%  softirqs.CPU165.RCU
    165083 ± 37%     -95.2%       7919 ±  4%  softirqs.CPU165.SCHED
    117183 ± 43%     -95.0%       5897 ± 14%  softirqs.CPU166.RCU
    165186 ± 37%     -95.2%       7973 ±  2%  softirqs.CPU166.SCHED
    116072 ± 42%     -94.9%       5895 ± 15%  softirqs.CPU167.RCU
    165208 ± 37%     -95.2%       7939 ±  4%  softirqs.CPU167.SCHED
    111694 ± 47%     -94.4%       6223 ± 13%  softirqs.CPU168.RCU
    154785 ± 43%     -95.0%       7734 ± 20%  softirqs.CPU168.SCHED
    105353 ± 45%     -94.6%       5646 ± 14%  softirqs.CPU169.RCU
    160451 ± 36%     -95.1%       7906 ±  5%  softirqs.CPU169.SCHED
    119889 ± 53%     -94.8%       6236 ± 10%  softirqs.CPU17.RCU
    169650 ± 37%     -95.1%       8373 ± 10%  softirqs.CPU17.SCHED
    108545 ± 47%     -94.8%       5618 ± 11%  softirqs.CPU170.RCU
    161670 ± 36%     -95.2%       7764 ± 10%  softirqs.CPU170.SCHED
    108055 ± 46%     -94.1%       6368 ± 22%  softirqs.CPU171.RCU
    164689 ± 36%     -95.0%       8250 ±  9%  softirqs.CPU171.SCHED
    110028 ± 47%     -94.7%       5814 ± 12%  softirqs.CPU172.RCU
    163886 ± 36%     -95.0%       8142 ±  3%  softirqs.CPU172.SCHED
    109909 ± 47%     -94.7%       5783 ± 10%  softirqs.CPU173.RCU
    162679 ± 36%     -95.1%       8040 ±  5%  softirqs.CPU173.SCHED
    107419 ± 43%     -94.5%       5919 ± 11%  softirqs.CPU174.RCU
    163065 ± 36%     -95.0%       8093 ±  3%  softirqs.CPU174.SCHED
    108407 ± 46%     -94.6%       5861 ±  9%  softirqs.CPU175.RCU
    161080 ± 36%     -95.1%       7943 ±  2%  softirqs.CPU175.SCHED
    113057 ± 48%     -94.6%       6122 ± 13%  softirqs.CPU176.RCU
    161172 ± 36%     -95.3%       7629 ±  9%  softirqs.CPU176.SCHED
    115893 ± 49%     -94.6%       6215 ± 13%  softirqs.CPU177.RCU
    164572 ± 36%     -95.1%       7989 ±  4%  softirqs.CPU177.SCHED
    115545 ± 50%     -94.8%       6043 ± 12%  softirqs.CPU178.RCU
    162046 ± 36%     -95.1%       7970 ±  3%  softirqs.CPU178.SCHED
    119558 ± 51%     -94.8%       6258 ± 15%  softirqs.CPU179.RCU
    163107 ± 36%     -95.0%       8076 ±  2%  softirqs.CPU179.SCHED
    118408 ± 51%     -94.4%       6624 ± 22%  softirqs.CPU18.RCU
    169485 ± 37%     -95.1%       8233 ±  2%  softirqs.CPU18.SCHED
    116174 ± 47%     -94.5%       6350 ± 14%  softirqs.CPU180.RCU
    162547 ± 36%     -95.0%       8049 ±  4%  softirqs.CPU180.SCHED
    112181 ± 48%     -94.3%       6401 ± 17%  softirqs.CPU181.RCU
    160464 ± 36%     -95.0%       8039 ±  2%  softirqs.CPU181.SCHED
    115292 ± 49%     -94.6%       6243 ± 16%  softirqs.CPU182.RCU
    160697 ± 36%     -95.0%       7967 ±  2%  softirqs.CPU182.SCHED
    117009 ± 51%     -94.7%       6151 ± 14%  softirqs.CPU183.RCU
    163514 ± 36%     -95.1%       7949 ±  3%  softirqs.CPU183.SCHED
    118178 ± 51%     -94.7%       6301 ± 14%  softirqs.CPU184.RCU
    161747 ± 36%     -95.2%       7832 ±  5%  softirqs.CPU184.SCHED
    119782 ± 51%     -94.3%       6867 ± 16%  softirqs.CPU185.RCU
    162673 ± 36%     -95.1%       7955 ±  8%  softirqs.CPU185.SCHED
    119444 ± 50%     -94.4%       6724 ± 16%  softirqs.CPU186.RCU
    163291 ± 37%     -95.1%       7995 ±  8%  softirqs.CPU186.SCHED
    118435 ± 50%     -94.6%       6364 ± 18%  softirqs.CPU187.RCU
    162379 ± 36%     -95.2%       7808 ±  6%  softirqs.CPU187.SCHED
    112707 ± 47%     -93.8%       7034 ± 24%  softirqs.CPU188.RCU
    153048 ± 40%     -95.0%       7607 ±  7%  softirqs.CPU188.SCHED
    115997 ± 49%     -94.5%       6397 ± 18%  softirqs.CPU189.RCU
    162596 ± 36%     -95.4%       7519 ± 11%  softirqs.CPU189.SCHED
    115828 ± 49%     -94.9%       5942 ± 12%  softirqs.CPU19.RCU
    168737 ± 37%     -95.2%       8161 ±  3%  softirqs.CPU19.SCHED
    117720 ± 48%     -94.4%       6549 ± 17%  softirqs.CPU190.RCU
    163938 ± 36%     -95.2%       7875 ±  6%  softirqs.CPU190.SCHED
    116056 ± 47%     -94.3%       6649 ± 16%  softirqs.CPU191.RCU
    117007 ± 48%     -94.6%       6335 ± 17%  softirqs.CPU191.SCHED
    117113 ± 57%     -94.1%       6930 ± 11%  softirqs.CPU2.RCU
    157948 ± 40%     -94.3%       8989 ±  9%  softirqs.CPU2.SCHED
    120676 ± 54%     -94.7%       6428 ± 18%  softirqs.CPU20.RCU
    160964 ± 44%     -95.1%       7953 ±  4%  softirqs.CPU20.SCHED
    115909 ± 49%     -94.7%       6141 ± 15%  softirqs.CPU21.RCU
    168625 ± 37%     -95.1%       8283 ±  5%  softirqs.CPU21.SCHED
    119795 ± 52%     -95.0%       6021 ± 13%  softirqs.CPU22.RCU
    168805 ± 37%     -95.2%       8169 ±  2%  softirqs.CPU22.SCHED
    116610 ± 50%     -95.0%       5844 ± 13%  softirqs.CPU23.RCU
    168464 ± 37%     -95.4%       7821 ± 14%  softirqs.CPU23.SCHED
    112666 ± 41%     -93.8%       6972 ± 10%  softirqs.CPU24.RCU
    168253 ± 36%     -95.0%       8420 ±  3%  softirqs.CPU24.SCHED
    105741 ± 41%     -94.4%       5895 ±  8%  softirqs.CPU25.RCU
    167076 ± 36%     -95.1%       8239        softirqs.CPU25.SCHED
    110447 ± 42%     -93.8%       6851 ± 12%  softirqs.CPU26.RCU
    167391 ± 36%     -95.1%       8260 ±  3%  softirqs.CPU26.SCHED
    113207 ± 44%     -94.1%       6632 ± 15%  softirqs.CPU27.RCU
    168484 ± 37%     -95.1%       8212 ±  5%  softirqs.CPU27.SCHED
    113106 ± 43%     -94.2%       6527 ± 13%  softirqs.CPU28.RCU
    168648 ± 36%     -94.8%       8809 ± 15%  softirqs.CPU28.SCHED
    113857 ± 44%     -94.4%       6410 ± 11%  softirqs.CPU29.RCU
    167940 ± 36%     -95.1%       8224        softirqs.CPU29.SCHED
    124005 ± 56%     -94.2%       7154 ± 24%  softirqs.CPU3.RCU
    170142 ± 37%     -93.4%      11262 ± 44%  softirqs.CPU3.SCHED
    113432 ± 44%     -93.8%       6988 ± 11%  softirqs.CPU30.RCU
    168164 ± 36%     -95.0%       8489 ±  5%  softirqs.CPU30.SCHED
    110157 ± 43%     -94.1%       6480 ± 13%  softirqs.CPU31.RCU
    166499 ± 36%     -95.0%       8311 ±  2%  softirqs.CPU31.SCHED
    120703 ± 47%     -93.7%       7589 ± 12%  softirqs.CPU32.RCU
    167573 ± 36%     -95.1%       8148 ± 21%  softirqs.CPU32.SCHED
    123058 ± 47%     -93.9%       7464 ± 11%  softirqs.CPU33.RCU
    169119 ± 36%     -94.8%       8837 ± 14%  softirqs.CPU33.SCHED
    122093 ± 50%     -94.2%       7059 ±  7%  softirqs.CPU34.RCU
    167250 ± 37%     -95.2%       7959 ±  5%  softirqs.CPU34.SCHED
    127900 ± 52%     -94.2%       7396 ± 18%  softirqs.CPU35.RCU
    167921 ± 37%     -95.2%       8044 ±  2%  softirqs.CPU35.SCHED
    129091 ± 52%     -93.9%       7918 ± 13%  softirqs.CPU36.RCU
    167750 ± 36%     -95.0%       8431 ±  6%  softirqs.CPU36.SCHED
    116393 ± 46%     -93.8%       7263 ± 14%  softirqs.CPU37.RCU
    166055 ± 37%     -95.0%       8288 ±  6%  softirqs.CPU37.SCHED
    121039 ± 49%     -94.3%       6944 ± 13%  softirqs.CPU38.RCU
    165679 ± 36%     -95.1%       8196 ±  4%  softirqs.CPU38.SCHED
    127478 ± 51%     -94.2%       7402 ± 13%  softirqs.CPU39.RCU
    167750 ± 36%     -94.9%       8569 ± 12%  softirqs.CPU39.SCHED
    122328 ± 58%     -93.8%       7560 ± 31%  softirqs.CPU4.RCU
    168614 ± 37%     -95.2%       8009 ±  5%  softirqs.CPU4.SCHED
    122929 ± 50%     -94.0%       7332 ± 11%  softirqs.CPU40.RCU
    166776 ± 36%     -95.2%       8076 ±  3%  softirqs.CPU40.SCHED
    130001 ± 52%     -94.1%       7692 ±  9%  softirqs.CPU41.RCU
    168554 ± 37%     -95.2%       8022 ±  6%  softirqs.CPU41.SCHED
    128042 ± 52%     -94.0%       7661 ± 12%  softirqs.CPU42.RCU
    168837 ± 36%     -95.1%       8290 ±  8%  softirqs.CPU42.SCHED
    126322 ± 52%     -94.5%       6988 ± 11%  softirqs.CPU43.RCU
    165608 ± 37%     -95.2%       7883 ±  6%  softirqs.CPU43.SCHED
    127648 ± 52%     -94.2%       7425 ± 11%  softirqs.CPU44.RCU
    168628 ± 37%     -95.0%       8501 ± 13%  softirqs.CPU44.SCHED
    122648 ± 48%     -94.0%       7361 ± 12%  softirqs.CPU45.RCU
    167535 ± 37%     -95.1%       8262        softirqs.CPU45.SCHED
    125362 ± 48%     -93.8%       7753 ± 12%  softirqs.CPU46.RCU
    168461 ± 37%     -95.1%       8196 ±  4%  softirqs.CPU46.SCHED
    122571 ± 47%     -93.6%       7865 ± 17%  softirqs.CPU47.RCU
    168011 ± 36%     -95.4%       7809 ±  6%  softirqs.CPU47.SCHED
    118945 ± 43%     -93.9%       7229 ± 12%  softirqs.CPU48.RCU
    168236 ± 36%     -95.2%       8127 ±  2%  softirqs.CPU48.SCHED
    114294 ± 43%     -94.1%       6715 ± 11%  softirqs.CPU49.RCU
    166867 ± 37%     -95.2%       8066        softirqs.CPU49.SCHED
    124562 ± 57%     -93.8%       7701 ± 23%  softirqs.CPU5.RCU
    168624 ± 37%     -95.3%       7922 ± 16%  softirqs.CPU5.SCHED
    115282 ± 43%     -94.2%       6695 ± 11%  softirqs.CPU50.RCU
    167817 ± 36%     -95.2%       8038 ±  2%  softirqs.CPU50.SCHED
    120527 ± 46%     -94.3%       6885 ± 12%  softirqs.CPU51.RCU
    168612 ± 36%     -95.2%       8120        softirqs.CPU51.SCHED
    119938 ± 45%     -94.3%       6892 ± 13%  softirqs.CPU52.RCU
    168665 ± 36%     -95.3%       8006        softirqs.CPU52.SCHED
    119044 ± 46%     -94.4%       6700 ± 13%  softirqs.CPU53.RCU
    168452 ± 36%     -95.2%       8044 ±  2%  softirqs.CPU53.SCHED
    115871 ± 46%     -94.1%       6833 ± 14%  softirqs.CPU54.RCU
    168385 ± 36%     -95.2%       8030        softirqs.CPU54.SCHED
      5016 ±166%     -99.1%      43.00 ±189%  softirqs.CPU54.TIMER
    118708 ± 46%     -94.3%       6727 ± 13%  softirqs.CPU55.RCU
    152449 ± 39%     -94.8%       7906 ±  3%  softirqs.CPU55.SCHED
    117573 ± 43%     -94.1%       6922 ± 12%  softirqs.CPU56.RCU
    168383 ± 36%     -95.5%       7585 ± 13%  softirqs.CPU56.SCHED
    119077 ± 45%     -94.2%       6884 ± 12%  softirqs.CPU57.RCU
    167846 ± 36%     -95.5%       7607 ± 10%  softirqs.CPU57.SCHED
    112863 ± 43%     -93.8%       6964 ± 13%  softirqs.CPU58.RCU
    168769 ± 36%     -95.3%       7852 ±  3%  softirqs.CPU58.SCHED
    116157 ± 49%     -94.0%       6956 ± 14%  softirqs.CPU59.RCU
    169257 ± 36%     -95.2%       8066        softirqs.CPU59.SCHED
    123302 ± 52%     -94.4%       6860 ± 13%  softirqs.CPU6.RCU
    161145 ± 44%     -95.3%       7620 ± 12%  softirqs.CPU6.SCHED
    116254 ± 45%     -94.4%       6519 ± 13%  softirqs.CPU60.RCU
    166913 ± 36%     -95.2%       8038        softirqs.CPU60.SCHED
    118232 ± 46%     -94.2%       6845 ± 12%  softirqs.CPU61.RCU
    166434 ± 37%     -95.7%       7225 ± 14%  softirqs.CPU61.SCHED
    116696 ± 45%     -94.2%       6810 ± 13%  softirqs.CPU62.RCU
    168386 ± 36%     -95.3%       7988 ±  2%  softirqs.CPU62.SCHED
    114942 ± 44%     -94.1%       6834 ± 12%  softirqs.CPU63.RCU
    168202 ± 36%     -95.3%       7986 ±  2%  softirqs.CPU63.SCHED
      3300 ±234%     -99.7%      10.57 ± 61%  softirqs.CPU63.TIMER
    110018 ± 40%     -94.3%       6241 ± 14%  softirqs.CPU64.RCU
    168400 ± 36%     -95.2%       8055 ±  2%  softirqs.CPU64.SCHED
      3455 ±169%     -99.7%       9.86 ± 38%  softirqs.CPU64.TIMER
    115011 ± 44%     -94.6%       6206 ± 14%  softirqs.CPU65.RCU
    168394 ± 36%     -95.4%       7782 ±  4%  softirqs.CPU65.SCHED
    104571 ± 41%     -94.7%       5554 ± 16%  softirqs.CPU66.RCU
    165696 ± 36%     -95.3%       7834 ±  5%  softirqs.CPU66.SCHED
    113428 ± 44%     -94.2%       6616 ± 23%  softirqs.CPU67.RCU
    167254 ± 36%     -95.3%       7903 ±  3%  softirqs.CPU67.SCHED
    111973 ± 45%     -94.4%       6227 ± 14%  softirqs.CPU68.RCU
    168150 ± 36%     -95.2%       8053 ±  3%  softirqs.CPU68.SCHED
    112364 ± 44%     -94.6%       6105 ± 14%  softirqs.CPU69.RCU
    167535 ± 36%     -95.3%       7837 ±  4%  softirqs.CPU69.SCHED
    120504 ± 52%     -93.9%       7397 ± 25%  softirqs.CPU7.RCU
    145074 ± 47%     -94.5%       8039 ± 10%  softirqs.CPU7.SCHED
    111334 ± 45%     -94.5%       6177 ± 13%  softirqs.CPU70.RCU
    167951 ± 36%     -95.3%       7862 ±  2%  softirqs.CPU70.SCHED
    111722 ± 43%     -94.5%       6155 ± 15%  softirqs.CPU71.RCU
    155941 ± 41%     -95.0%       7838 ± 11%  softirqs.CPU71.SCHED
    110074 ± 48%     -94.0%       6637 ± 15%  softirqs.CPU72.RCU
    164768 ± 36%     -95.0%       8283 ±  2%  softirqs.CPU72.SCHED
    102534 ± 45%     -93.8%       6350 ± 12%  softirqs.CPU73.RCU
    162276 ± 36%     -94.9%       8227 ±  5%  softirqs.CPU73.SCHED
    106608 ± 47%     -94.3%       6038 ± 10%  softirqs.CPU74.RCU
    163306 ± 36%     -95.2%       7874 ±  4%  softirqs.CPU74.SCHED
    105317 ± 48%     -93.9%       6379 ± 14%  softirqs.CPU75.RCU
    165887 ± 35%     -95.2%       7994        softirqs.CPU75.SCHED
    107962 ± 47%     -94.2%       6232 ± 14%  softirqs.CPU76.RCU
    151378 ± 43%     -94.7%       8028 ±  2%  softirqs.CPU76.SCHED
    108874 ± 47%     -94.2%       6274 ± 16%  softirqs.CPU77.RCU
    133388 ± 48%     -94.0%       8061        softirqs.CPU77.SCHED
    104931 ± 44%     -93.7%       6566 ± 14%  softirqs.CPU78.RCU
    164247 ± 36%     -95.2%       7946 ±  4%  softirqs.CPU78.SCHED
    107141 ± 46%     -94.0%       6384 ± 17%  softirqs.CPU79.RCU
    161972 ± 36%     -95.1%       7995 ±  2%  softirqs.CPU79.SCHED
    116913 ± 49%     -94.4%       6561 ± 21%  softirqs.CPU8.RCU
    167457 ± 37%     -95.2%       8066 ± 13%  softirqs.CPU8.SCHED
    111532 ± 48%     -94.1%       6578 ± 16%  softirqs.CPU80.RCU
    162398 ± 36%     -94.9%       8205 ±  6%  softirqs.CPU80.SCHED
    113751 ± 50%     -93.9%       6934 ± 20%  softirqs.CPU81.RCU
    152223 ± 39%     -95.0%       7644 ± 11%  softirqs.CPU81.SCHED
    113065 ± 51%     -94.3%       6435 ± 13%  softirqs.CPU82.RCU
    163200 ± 36%     -95.0%       8129        softirqs.CPU82.SCHED
    117404 ± 52%     -94.1%       6882 ± 15%  softirqs.CPU83.RCU
    163701 ± 36%     -95.1%       8088 ±  2%  softirqs.CPU83.SCHED
    113526 ± 48%     -93.8%       7026 ± 17%  softirqs.CPU84.RCU
    162927 ± 36%     -95.0%       8108        softirqs.CPU84.SCHED
    109221 ± 50%     -93.9%       6687 ± 14%  softirqs.CPU85.RCU
    161401 ± 36%     -95.0%       7989 ±  2%  softirqs.CPU85.SCHED
    111622 ± 50%     -93.7%       6987 ± 16%  softirqs.CPU86.RCU
    162274 ± 36%     -95.1%       8017 ±  4%  softirqs.CPU86.SCHED
    114835 ± 52%     -94.2%       6678 ± 12%  softirqs.CPU87.RCU
    163881 ± 36%     -95.2%       7898 ±  3%  softirqs.CPU87.SCHED
    114318 ± 53%     -93.6%       7353 ± 17%  softirqs.CPU88.RCU
    162001 ± 36%     -95.0%       8155 ±  2%  softirqs.CPU88.SCHED
    117298 ± 51%     -93.7%       7436 ± 20%  softirqs.CPU89.RCU
    164150 ± 36%     -95.0%       8142 ±  3%  softirqs.CPU89.SCHED
    124315 ± 56%     -94.2%       7152 ± 18%  softirqs.CPU9.RCU
    168724 ± 37%     -95.2%       8131 ±  6%  softirqs.CPU9.SCHED
    116492 ± 51%     -93.9%       7074 ± 15%  softirqs.CPU90.RCU
    162939 ± 39%     -95.2%       7810 ±  2%  softirqs.CPU90.SCHED
    113789 ± 52%     -94.0%       6797 ± 14%  softirqs.CPU91.RCU
    151586 ± 40%     -94.9%       7788 ±  3%  softirqs.CPU91.SCHED
    106756 ± 51%     -93.1%       7388 ± 13%  softirqs.CPU92.RCU
    168515 ± 36%     -95.3%       7877        softirqs.CPU92.SCHED
    113053 ± 50%     -94.1%       6686 ± 16%  softirqs.CPU93.RCU
    163920 ± 36%     -95.2%       7878 ±  2%  softirqs.CPU93.SCHED
    114581 ± 50%     -93.9%       6972 ± 18%  softirqs.CPU94.RCU
    165190 ± 36%     -95.2%       7886 ±  2%  softirqs.CPU94.SCHED
    112730 ± 47%     -93.8%       7022 ± 18%  softirqs.CPU95.RCU
     84957 ± 62%     -92.9%       6044 ± 22%  softirqs.CPU95.SCHED
    119447 ± 53%     -94.4%       6663 ± 31%  softirqs.CPU96.RCU
    160393 ± 39%     -95.4%       7450 ± 21%  softirqs.CPU96.SCHED
    117977 ± 51%     -95.0%       5940 ± 17%  softirqs.CPU97.RCU
    151438 ± 39%     -94.6%       8197 ±  6%  softirqs.CPU97.SCHED
    120344 ± 56%     -94.5%       6660 ±  9%  softirqs.CPU98.RCU
    166870 ± 37%     -94.9%       8546 ± 13%  softirqs.CPU98.SCHED
    123602 ± 55%     -94.2%       7180 ± 23%  softirqs.CPU99.RCU
    167683 ± 37%     -95.4%       7688 ± 12%  softirqs.CPU99.SCHED
  22375936 ± 48%     -94.3%    1271019 ± 12%  softirqs.RCU
  31357287 ± 36%     -95.1%    1543135        softirqs.SCHED
    169494 ± 35%     -83.3%      28358 ±  3%  softirqs.TIMER


                                                                                
                     fsmark.time.percent_of_cpu_this_job_got                    
                                                                                
  45 +----------------------------------------------------------------------+   
     |     O                         O               OO OOOOO OOOOO O       |   
  40 |-+                                                                    |   
  35 |-+                                                                    |   
     |                                                                      |   
  30 |-+                                                                    |   
  25 |-+                                                                    |   
     |                                                                      |   
  20 |-+                                                                    |   
  15 |-+                                                                    |   
     |                                                                      |   
  10 |-+       +                          +                                 |   
   5 |-+      ::                   +      :: +                         +    |   
     |        : :                  :+    : : ::                    .+  ::   |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                          perf-sched.total_wait_time.max.ms                     
                                                                                
  10000 +-------------------------------------------------------------------+   
   9000 |-+      +              +   +   :: +                      +      +  |   
        |                               +                                   |   
   8000 |-+                                                                 |   
   7000 |-+                                                                 |   
        |                                                                   |   
   6000 |-+                                                                 |   
   5000 |-+                                                                 |   
   4000 |-+                                                                 |   
        |                                                                   |   
   3000 |-+                                                                 |   
   2000 |-+                                                                 |   
        |                                                                   |   
   1000 |-+                                                                 |   
      0 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                       perf-sched.total_wait_time.average.ms                    
                                                                                
  250 +---------------------------------------------------------------------+   
      |  .+ + ++   +  .+ +  .+   +                 +   ++  +.  + +       .++|   
      |++  + :: +  :++  + ++  + +:                 :: +  ++  ++   + +++++   |   
  200 |-+    +   +:            + :               ++ ++             +        |   
      |           +               :              :                          |   
      |                           :           +  :                          |   
  150 |-+                         :  + +   +  :+:                           |   
      |                           +.+ + +.+ ++  +                           |   
  100 |-+                                                                   |   
      |                                                                     |   
      |                                                                     |   
   50 |-+                                                                   |   
      |                                                                     |   
      |                                                                     |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                      perf-sched.total_wait_and_delay.count.ms                  
                                                                                
  25000 +-------------------------------------------------------------------+   
        |                                  + +                              |   
        |                           ++ +  +: :: +                           |   
  20000 |-+                         : + ++  : + :                           |   
        |                           :       +  ::                           |   
        |                          :           + :                          |   
  15000 |-+       +.+              :             :                 +        |   
        |+++.+ +++   ++++++.++++++.+             +.+++++ .++++++ .+ ++++.+ +|   
  10000 |-+   +                                         +       +         + |   
        |                                                                   |   
        |                                                                   |   
   5000 |-+                                                                 |   
        |                                                                   |   
        |OOO OOOOO  OOOO OO OOOOOO OOOOOOO OOOOOOO O OO                     |   
      0 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                       perf-sched.total_wait_and_delay.max.ms                   
                                                                                
  10000 +-------------------------------------------------------------------+   
   9000 |-+      +              +   +   :: +                      +      +  |   
        |                               +                                   |   
   8000 |-+                                                                 |   
   7000 |-+                                                                 |   
        |                                                                   |   
   6000 |-+                                                                 |   
   5000 |-+                                                                 |   
   4000 |-+                                                                 |   
        |                                                                   |   
   3000 |-+                                                                 |   
   2000 |-+                                                                 |   
        |                                                                   |   
   1000 |-+                                                                 |   
      0 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                    perf-sched.total_wait_and_delay.average.ms                  
                                                                                
  250 +---------------------------------------------------------------------+   
      |  .+ + ++   +  .+ +  .+   +                 +   ++  +.  + +       .++|   
      |++  + :: +  :++  + ++  + +:                 :: +  ++  ++   + +++++   |   
  200 |-+    +   +:            + :               ++ ++             +        |   
      |           +               :              :                          |   
      |                           :           +  :                          |   
  150 |-+                         :  + +   +  :+:                           |   
      |                           +.+ + +.+ ++  +                           |   
  100 |-+                                                                   |   
      |                                                                     |   
      |                                                                     |   
   50 |-+                                                                   |   
      |                                                                     |   
      |                                                                     |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
        perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork     
                                                                                
  9000 +--------------------------------------------------------------------+   
       |                                         +   +                      |   
  8000 |-+                                       :   :                      |   
  7000 |-+                                       :   :                      |   
       |                                 +       :  ::                      |   
  6000 |-+                               :       :  ::                      |   
  5000 |-+                               :       :  ::                      |   
       |                                 :      : : : :                     |   
  4000 |-+                               ::     : : : :                     |   
  3000 |-+                              : :     : : : :                     |   
       |                                : :     : ::  :                     |   
  2000 |-+                              : :     : ::  :           .+        |   
  1000 |++.++++++.++++++.++++++.++++++.++ +++.+++ ++  +++++.++++++  +++++.++|   
       |                                                                    |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
        perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork     
                                                                                
  800 +---------------------------------------------------------------------+   
      |++.++++++.+++++.+++++.++  ++.+++++.+++++.++++++.++ ++.+ +++. +++++.++|   
  700 |-+                      ++                        +    +    +        |   
  600 |-+                                                                   |   
      |                                                                     |   
  500 |-+                                                                   |   
      |                                                                     |   
  400 |-+                                                                   |   
      |                                                                     |   
  300 |-+                                                                   |   
  200 |-+                                                                   |   
      |                                                                     |   
  100 |-+                                                                   |   
      |                                                                     |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
      perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork   
                                                                                
  3000 +--------------------------------------------------------------------+   
       |                                                                    |   
  2500 |++.++ +++.++++++.++++++.+++++ .++++++.  + ++. +++++.++++++.++++++. +|   
       |     +                       +        ++ +   +                    + |   
       |                                                                    |   
  2000 |-+                                                                  |   
       |                                                                    |   
  1500 |-+                                                                  |   
       |                                                                    |   
  1000 |-+                                                                  |   
       |                                                                    |   
       |                                                                    |   
   500 |-+                   O                                              |   
       |OO OOOOOO OOOOOO OOOO O OOOOOO OOOOOO OOOOOO OOOOOO OOOOOO OO       |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
     perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork   
                                                                                
  9000 +--------------------------------------------------------------------+   
       |                                         +   +                      |   
  8000 |-+                                       :   :                      |   
  7000 |-+                                       :   :                      |   
       |                                 +       :  ::                      |   
  6000 |-+                               :       :  ::                      |   
  5000 |-+                               :       :  ::                      |   
       |                                 :      : : : :                     |   
  4000 |-+                               ::     : : : :                     |   
  3000 |-+                              : :     : : : :                     |   
       |                                : :     : ::  :                     |   
  2000 |-+                              : :     : ::  :           .+        |   
  1000 |++.++++++.++++++.++++++.++++++.++ +++.+++ ++  +++++.++++++  +++++.++|   
       |                                                                    |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
     perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork   
                                                                                
  800 +---------------------------------------------------------------------+   
      |++.++++++.+++++.+++++.++  ++.+++++.+++++.++++++.++ ++.+ +++. +++++.++|   
  700 |-+                      ++                        +    +    +        |   
  600 |-+                                                                   |   
      |                                                                     |   
  500 |-+                                                                   |   
      |                                                                     |   
  400 |-+                                                                   |   
      |                                                                     |   
  300 |-+                                                                   |   
  200 |-+                                                                   |   
      |                                                                     |   
  100 |-+                                                                   |   
      |                                                                     |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
           perf-sched.wait_time.max.ms.worker_thread.kthread.ret_from_fork      
                                                                                
  10000 +-------------------------------------------------------------------+   
   9000 |-++    +    + ++ +  ++     +    +.+                         +      |   
        |:: +  +:    ::: ::+ : :+   : + +  : + +           ++   +   +:      |   
   8000 |++  + : :+.: +  +  +  + : : ::::   :::::  ++ ++ .+  :  ::  : :+.+  |   
   7000 |-+   +  :: +            +.+ + +    + + +  :: : +    +++ : :  ::  ++|   
        |        +                              : : : :           ++  +     |   
   6000 |-+                                      ::  :                      |   
   5000 |-+                                      :   :                      |   
   4000 |-+                                      +   +                      |   
        |                                                                   |   
   3000 |-+                                                                 |   
   2000 |-+                                                                 |   
        |                                                                   |   
   1000 |-+                                                                 |   
      0 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
        perf-sched.wait_and_delay.max.ms.worker_thread.kthread.ret_from_fork    
                                                                                
  10000 +-------------------------------------------------------------------+   
   9000 |-++    +    + ++ +  ++     +    +.+                         +      |   
        |:: +  +:    ::: ::+ : :+   : + +  : + +           ++   +   +:      |   
   8000 |++  + : :+.: +  +  +  + : : ::::   :::::  ++ ++ .+  :  ::  : :+.+  |   
   7000 |-+   +  :: +            +.+ + +    + + +  :: : +    +++ : :  ::  ++|   
        |        +                              : : : :           ++  +     |   
   6000 |-+                                      ::  :                      |   
   5000 |-+                                      :   :                      |   
   4000 |-+                                      +   +                      |   
        |                                                                   |   
   3000 |-+                                                                 |   
   2000 |-+                                                                 |   
        |                                                                   |   
   1000 |-+                                                                 |   
      0 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
      perf-sched.wait_time.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read    
                                                                                
  1200 +--------------------------------------------------------------------+   
       |                                                                    |   
  1000 |++.++++++.++++++.++++++.++++++.++++++.++++++.++++++.++++++.++++++.++|   
       |                                                                    |   
       |                                                                    |   
   800 |-+                                                                  |   
       |                                                                    |   
   600 |-+                                                                  |   
       |                                                                    |   
   400 |-+                                                                  |   
       |                                                                    |   
       |                                                                    |   
   200 |-+                                                                  |   
       |                                                                    |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
     perf-sched.wait_time.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read     
                                                                                
  70 +----------------------------------------------------------------------+   
     |                               +.                                     |   
  60 |++.+++++.+++++.+++++.+++++.++++  ++++.+++++.+++++.++++ .+++++. +   .++|   
     |                                                      +       + +++   |   
  50 |-+                                                                    |   
     |                                                                      |   
  40 |-+                                                                    |   
     |                                                                      |   
  30 |-+                                                                    |   
     |                                                                      |   
  20 |-+                                                                    |   
     |                                                                      |   
  10 |-+                                                                    |   
     |                                                                      |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
    perf-sched.wait_and_delay.count.pipe_read.new_sync_read.vfs_read.ksys_read  
                                                                                
  3500 +--------------------------------------------------------------------+   
       |+            +     +                                 +      + +++.  |   
  3000 |-+.++++++.+++ ++.++ +++.++++++.++++++.++++++.++++++.+ ++++.+ +    ++|   
       |                                                                    |   
  2500 |-+                                                                  |   
       |                                                                    |   
  2000 |-+                                                                  |   
       |                                                                    |   
  1500 |-+                                                                  |   
       |                                                                    |   
  1000 |-+                                                                  |   
       |                                                                    |   
   500 |-+                                                                  |   
       |                                                                    |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
    perf-sched.wait_and_delay.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read 
                                                                                
  1200 +--------------------------------------------------------------------+   
       |                                                                    |   
  1000 |++.++++++.++++++.++++++.++++++.++++++.++++++.++++++.++++++.++++++.++|   
       |                                                                    |   
       |                                                                    |   
   800 |-+                                                                  |   
       |                                                                    |   
   600 |-+                                                                  |   
       |                                                                    |   
   400 |-+                                                                  |   
       |                                                                    |   
       |                                                                    |   
   200 |-+                                                                  |   
       |                                                                    |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
   perf-sched.wait_and_delay.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read  
                                                                                
  70 +----------------------------------------------------------------------+   
     |                               +.                                     |   
  60 |++.+++++.+++++.+++++.+++++.++++  ++++.+++++.+++++.++++ .+++++. +   .++|   
     |                                                      +       + +++   |   
  50 |-+                                                                    |   
     |                                                                      |   
  40 |-+                                                                    |   
     |                                                                      |   
  30 |-+                                                                    |   
     |                                                                      |   
  20 |-+                                                                    |   
     |                                                                      |   
  10 |-+                                                                    |   
     |                                                                      |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  8000 +--------------------------------------------------------------------+   
       |                                                        +           |   
  7000 |-+                                                      :           |   
  6000 |-+                                                      :           |   
       |                                                        :           |   
  5000 |-+                                                      :           |   
       |                                                        ::          |   
  4000 |-+                                                     : :          |   
       |                                                       : :          |   
  3000 |-+                                                     : :          |   
  2000 |-+                                                     : :          |   
       |     +                                                 : +.         |   
  1000 |++.++ +++.++++++.++++++.++++++.++++++.++++++.++++++.++++   ++++++.++|   
       |                                                                    |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  250 +---------------------------------------------------------------------+   
      |                                                         +   +       |   
      |++.++++++.+++++.+++++.++++++.+++++.+++++.++++++.+++++.+++ +.+ ++++.++|   
  200 |-+                                                                   |   
      |                                                                     |   
      |                                                                     |   
  150 |-+                                                                   |   
      |                                                                     |   
  100 |-+                                                                   |   
      |                                                                     |   
      |                                                                     |   
   50 |-+                                                                   |   
      |                                                                     |   
      |                                                                     |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  350 +---------------------------------------------------------------------+   
      |++.++++++.+++++.+++++.++++++.+++++.+++++.++++++.+++++.+++++  + + +.++|   
  300 |-+                                                                   |   
      |                                                                     |   
  250 |-+                                                                   |   
      |                                                                     |   
  200 |-+                                                                   |   
      |                                                                     |   
  150 |-+                                                                   |   
      |                                                                     |   
  100 |-+                                                                   |   
      |                                                                     |   
   50 |-O   O  O  O  O  O  O  O         O  OO O   O  O OOOOO OOO O  O       |   
      |O  OO OO  O OO  O OO  O OOOO OOOO  O  O  OO OO           O  O        |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  8000 +--------------------------------------------------------------------+   
       |                                                        +           |   
  7000 |-+                                                      :           |   
  6000 |-+                                                      :           |   
       |                                                        :           |   
  5000 |-+                                                      :           |   
       |                                                        ::          |   
  4000 |-+                                                     : :          |   
       |                                                       : :          |   
  3000 |-+                                                     : :          |   
  2000 |-+                                                     : :          |   
       |     +                                                 : +.         |   
  1000 |++.++ +++.++++++.++++++.++++++.++++++.++++++.++++++.++++   ++++++.++|   
       |                                                                    |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  250 +---------------------------------------------------------------------+   
      |                                                         +   +       |   
      |++.++++++.+++++.+++++.++++++.+++++.+++++.++++++.+++++.+++ +.+ ++++.++|   
  200 |-+                                                                   |   
      |                                                                     |   
      |                                                                     |   
  150 |-+                                                                   |   
      |                                                                     |   
  100 |-+                                                                   |   
      |                                                                     |   
      |                                                                     |   
   50 |-+                                                                   |   
      |                                                                     |   
      |                                                                     |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
  perf-sched.wait_time.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64 
                                                                                
  25 +----------------------------------------------------------------------+   
     |                                                                      |   
     |++.+++++.+++++.+++++.+++++.++++ .++++.+ +++.+++++.+++++. +++ .+++++.++|   
  20 |-+                             +       +                +   +         |   
     |                                                                      |   
     |                                                                      |   
  15 |-+                                                                    |   
     |                                                                      |   
  10 |-+                                                                    |   
     |                                                                      |   
     |                                                                      |   
   5 |-+                                                                    |   
     |                                                                      |   
     |OO O O O OOOOO OOOOO O OO  OOOOO OOOO OOO O OOO O   O   OOO   O       |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
perf-sched.wait_and_delay.count.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_6
                                                                                
  350 +---------------------------------------------------------------------+   
      |++.++ +++.+++++.+++++.+++ ++.+++++.+++ +.++++++.++ ++.+++++.++ + +. +|   
  300 |-+   +                   +            +           +                + |   
      |                                                                     |   
  250 |-+                                                                   |   
      |                                                                     |   
  200 |-+                                                                   |   
      |                                                                     |   
  150 |-+                                                                   |   
      |                                                                     |   
  100 |-+                                                                   |   
      |                                                                     |   
   50 |-+   O                         O    O  O   O            O O          |   
      |OO OO OOO OOOOO OOOOO OOOOOO OO OO O OO  OO OOO OOOOO OO O  OO       |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  25 +----------------------------------------------------------------------+   
     |                                                                      |   
     |++.+++++.+++++.+++++.+++++.++++ .++++.+ +++.+++++.+++++. +++ .+++++.++|   
  20 |-+                             +       +                +   +         |   
     |                                                                      |   
     |                                                                      |   
  15 |-+                                                                    |   
     |                                                                      |   
  10 |-+                                                                    |   
     |                                          O                           |   
     |O                                        O                            |   
   5 |-+        O                       O   O         O  OO O OO    O       |   
     |           O    O O   O      OO               O                       |   
     | O O OOO O  OO O O O O OO  OO  O O OO  OO   OO            O           |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  6000 +--------------------------------------------------------------------+   
       |                                                               +    |   
  5000 |-+                                                             :    |   
       |                                                               :    |   
       |                                                               :    |   
  4000 |-+        +                    +                       +       :    |   
       |          :                 +  :                       :       :    |   
  3000 |-+        :                 :  :                       :       ::   |   
       |         ::                 : ::                       :      : :   |   
  2000 |-+       : :                : : :                     : :     : :   |   
       |         : :               : :: :                     : :     : :   |   
       |         : :               : :: :                     : :+    : :  +|   
  1000 |-+      :  :               : :  :                     + ::+   : :  :|   
       |++.++++++  +++++.++++++.++++ +  +++++.++++++.++++++.++  +  ++++ +.+ |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                               fsmark.files_per_sec                             
                                                                                
  160 +---------------------------------------------------------------------+   
      |                                                 O  O  OOOO          |   
  140 |-+         O  O     O    OO  O               OO O OO  O     OO       |   
  120 |OO OOOOOO O OO  OOOO  OOO  O  OOOO OOOOO OOOO                        |   
      |                                                                     |   
  100 |-+                                                                   |   
      |                                                                     |   
   80 |-+                                                                   |   
      |                                                                     |   
   60 |-+                                                                   |   
   40 |-+                                                                   |   
      |        +                                                            |   
   20 |-+      ::                          + +                         +    |   
      |       : :                  .++     ::::                     +  ::   |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                            nfsstat.Server.packet.packets                       
                                                                                
  55000 +-------------------------------------------------------------------+   
        |                                                                   |   
  50000 |-+                          +                                      |   
        |        +                   :+     + +            + +      +       |   
        |+++.++++ +.+++++++.++++ +.+:  : +. :+ +++. ++ ++.+ + ++ .++ +++.+++|   
  45000 |-+                     +   +  ++  +       +  +         +           |   
        |                                                                   |   
  40000 |-+                                                                 |   
        |                                                                   |   
  35000 |-+                                                                 |   
        |                                                                   |   
        |                                           O                       |   
  30000 |OOO O OOOO OO OOOO OO O O O OOOOO OOOOOOO   O OO OOOOOOO OOO       |   
        |     O       O       O O   O              O  O                     |   
  25000 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                              nfsstat.Server.packet.tcp                         
                                                                                
  55000 +-------------------------------------------------------------------+   
        |                                                                   |   
  50000 |-+                          +                                      |   
        |        +                   :+     + +            + +      +       |   
        |+++.++++ +.+++++++.++++ +.+:  : +. :+ +++. ++ ++.+ + ++ .++ +++.+++|   
  45000 |-+                     +   +  ++  +       +  +         +           |   
        |                                                                   |   
  40000 |-+                                                                 |   
        |                                                                   |   
  35000 |-+                                                                 |   
        |                                                                   |   
        |                                           O                       |   
  30000 |OOO O OOOO OO OOOO OO O O O OOOOO OOOOOOO   O OO OOOOOOO OOO       |   
        |     O       O       O O   O              O  O                     |   
  25000 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                              nfsstat.Server.rpc.calls                          
                                                                                
  55000 +-------------------------------------------------------------------+   
        |                                                                   |   
  50000 |-+                          +                                      |   
        |        +                   :+     + +            + +      +       |   
        |+++.++++ +.+++++++.++++ +.+:  : +. :+ +++. ++ ++.+ + ++ .++ +++.+++|   
  45000 |-+                     +   +  ++  +       +  +         +           |   
        |                                                                   |   
  40000 |-+                                                                 |   
        |                                                                   |   
  35000 |-+                                                                 |   
        |                                                                   |   
        |                                           O                       |   
  30000 |OOO O OOOO OO OOOO OO O O O OOOOO OOOOOOO   O OO OOOOOOO OOO       |   
        |     O       O       O O   O              O  O                     |   
  25000 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                          nfsstat.Server.reply.cache.misses                     
                                                                                
  23000 +-------------------------------------------------------------------+   
  22000 |-+                          +                                      |   
        |        +                   :+     + +            +        +       |   
  21000 |-+ .+ + ::    + +   + +    : :     ::::    +  ++. ::+ +    :: +.   |   
  20000 |+++  + + +.+++ + +.+ + :+.++  : +.: + +++.+ ++   + + + :.++ ++  +++|   
  19000 |-+                     +      ++  +                    +           |   
  18000 |-+                                                                 |   
        |                                                                   |   
  17000 |-+                                                                 |   
  16000 |-+                                                                 |   
  15000 |-+                                                                 |   
  14000 |-+                                                                 |   
        | O    OOOO O   O                       O   O                       |   
  13000 |O+O OO      OOO OO OOOOOO OOOOOOO OOOOO O O OOOO OOOOOOO OOO       |   
  12000 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                         nfsstat.Server.reply.cache.nocache                     
                                                                                
  30000 +-------------------------------------------------------------------+   
        |                                                                   |   
  28000 |-+                          ++                             +       |   
  26000 |+++.+ + +    ++++ .++++     : : +. +++     +  ++.++++ + .+ :+    ++|   
        |     + + +.++    +     ++.++  ++  +   +++.+ ++       + +  +  ++.+  |   
  24000 |-+                                                                 |   
        |                                                                   |   
  22000 |-+                                                                 |   
        |                                                                   |   
  20000 |-+                                                                 |   
  18000 |-+                                                                 |   
        |                                           O                       |   
  16000 |OOO O OOOO OO OOOO OO O O O OOOOO OOOOOOO   O OO OOOOOOO OOO       |   
        |     O       O       O O   O              O  O                     |   
  14000 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                           nfsstat.Server.nfs.v4.compound                       
                                                                                
  55000 +-------------------------------------------------------------------+   
        |                                                                   |   
  50000 |-+                          +                                      |   
        |        +                   :+     + +            + +      +       |   
        |+++.++++ +.+++++++.++++ +.+:  : +. :+ +++. ++ ++.+ + ++ .++ +++.+++|   
  45000 |-+                     +   +  ++  +       +  +         +           |   
        |                                                                   |   
  40000 |-+                                                                 |   
        |                                                                   |   
  35000 |-+                                                                 |   
        |                                                                   |   
        |                                           O                       |   
  30000 |OOO O OOOO OO OOOO OO O O O OOOOO OOOOOOO   O OO OOOOOOO OOO       |   
        |     O       O       O O   O              O  O                     |   
  25000 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                       nfsstat.Server.nfs.v4.operations.access                  
                                                                                
  11500 +-------------------------------------------------------------------+   
  11000 |-+                          +                                      |   
        |        +                   :+     + +            +        +       |   
  10500 |-+ .+ + ::    + +   + +    : :     ::::    +  ++. ::+ +    :: +.   |   
  10000 |+++  + + +.+++ + +.+ + :+.++  : +.: + +++.+ ++   + + + :.++ ++  +++|   
   9500 |-+                     +      ++  +                    +           |   
   9000 |-+                                                                 |   
        |                                                                   |   
   8500 |-+                                                                 |   
   8000 |-+                                                                 |   
   7500 |-+                                                                 |   
   7000 |-+                                                                 |   
        | O    OOOO O   O                       O   O                       |   
   6500 |O+O OO      OOO OO OOOOOO OOOOOOO OOOOO O O OOOO OOOOOOO OOO       |   
   6000 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                      nfsstat.Server.nfs.v4.operations.close                    
                                                                                
  6000 +--------------------------------------------------------------------+   
       |                                                                    |   
  5500 |-+                          +                                       |   
       |        +                   :+     +  +           +         +       |   
       |++.++ + :+   +++.+ ++++    :  :    ::+ :   +.  ++ :+ + +    :: + .+ |   
  5000 |-+   + +  +++     +    + +++  :  ++ +  ++++  ++  +  + + ++.+ ++ +  +|   
       |                        +      ++                                   |   
  4500 |-+                                                                  |   
       |                                                                    |   
  4000 |-+                                                                  |   
       |                                                                    |   
       |                                                                    |   
  3500 |-+             O                           O                        |   
       |OO OOOOOO OOOOO  OOOOOO OOOOOO OOOOOO OOOOO  OOOOOO OOOOOO OO       |   
  3000 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                      nfsstat.Server.nfs.v4.operations.commit                   
                                                                                
  6000 +--------------------------------------------------------------------+   
       |                                                                    |   
  5500 |-+                          +                                       |   
       |        +                   :+     +  +           +         +       |   
       |++.++ + :+   +++.+ ++++    :  :    ::+ :   +.  ++ :+ + +    :: + .+ |   
  5000 |-+   + +  +++     +    + +++  :  ++ +  ++++  ++  +  + + ++.+ ++ +  +|   
       |                        +      ++                                   |   
  4500 |-+                                                                  |   
       |                                                                    |   
  4000 |-+                                                                  |   
       |                                                                    |   
       |                                                                    |   
  3500 |-+             O                           O                        |   
       |OO OOOOOO OOOOO  OOOOOO OOOOOO OOOOOO OOOOO  OOOOOO OOOOOO OO       |   
  3000 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                      nfsstat.Server.nfs.v4.operations.getattr                  
                                                                                
  44000 +-------------------------------------------------------------------+   
  42000 |-+      +                   :+     + +                     +       |   
        |        :                   ::     : :                     :  +    |   
  40000 |-+      :                   ::     ::::           +        :: ::   |   
  38000 |-+ .+ +: :    + +   + +    :  :   : : :        +. ::+ +   : :: :  :|   
        |+ +  + + :.+++ + +.+ + :+.+:  : +.: + +++. ++ +  + + + :.+: ++  +++|   
  36000 |-+       +             +   +  ++  +       +  +         +  +        |   
  34000 |-+                                                                 |   
  32000 |-+                                                                 |   
        |                                                                   |   
  30000 |-+                                                                 |   
  28000 |-+                                                                 |   
        | O    OOOO OO OO    O     O O     O  O O   OO O  OO OO             |   
  26000 |O+O OO       O  OO O OOOO  O OOOO  OO O O O  O O   O  OO OOO       |   
  24000 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                       nfsstat.Server.nfs.v4.operations.getfh                   
                                                                                
  11500 +-------------------------------------------------------------------+   
  11000 |-+                          +                                      |   
        |        +                   :+     + +            +        +       |   
  10500 |-+ .+ + ::    + +   + +    : :     ::::    +  ++. ::+ +    :: +.   |   
  10000 |+++  + + +.+++ + +.+ + :+.++  : +.: + +++.+ ++   + + + :.++ ++  +++|   
   9500 |-+                     +      ++  +                    +           |   
   9000 |-+                                                                 |   
        |                                                                   |   
   8500 |-+                                                                 |   
   8000 |-+                                                                 |   
   7500 |-+                                                                 |   
   7000 |-+                                                                 |   
        | O    OOOO O   O                       O   O                       |   
   6500 |O+O OO      OOO OO OOOOOO OOOOOOO OOOOO O O OOOO OOOOOOO OOO       |   
   6000 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                      nfsstat.Server.nfs.v4.operations.lookup                   
                                                                                
  6000 +--------------------------------------------------------------------+   
       |                                                                    |   
  5500 |-+                          +                                       |   
       |        +                   :+     +  +           +         +       |   
       |++.++ + :+   +++.+ ++++.   :  :    ::+ :   +.  ++ :+ + +    :: + .+ |   
  5000 |-+   + +  +++     +     ++++  :  ++ +  ++++  ++  +  + + ++.+ ++ +  +|   
       |                               ++                                   |   
  4500 |-+                                                                  |   
       |                                                                    |   
  4000 |-+                                                                  |   
       |                                                                    |   
       |                                                                    |   
  3500 |-+     O  O    O                           O                        |   
       |OO OOOO O  OOOO  OOOOOO OOOOOO OOOOOO OOOOO  OOOOOO OOOOOO OO       |   
  3000 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                       nfsstat.Server.nfs.v4.operations.open                    
                                                                                
  6000 +--------------------------------------------------------------------+   
       |                                                                    |   
  5500 |-+                          +                                       |   
       |        +                   :+     +  +           +         +       |   
       |++.++ + :+   +++.+ ++++    :  :    ::+ :   +.  ++ :+ + +    :: + .+ |   
  5000 |-+   + +  +++     +    + +++  :  ++ +  ++++  ++  +  + + ++.+ ++ +  +|   
       |                        +      ++                                   |   
  4500 |-+                                                                  |   
       |                                                                    |   
  4000 |-+                                                                  |   
       |                                                                    |   
       |                                                                    |   
  3500 |-+             O                           O                        |   
       |OO OOOOOO OOOOO  OOOOOO OOOOOO OOOOOO OOOOO  OOOOOO OOOOOO OO       |   
  3000 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                       nfsstat.Server.nfs.v4.operations.putfh                   
                                                                                
  55000 +-------------------------------------------------------------------+   
        |                                                                   |   
  50000 |-+                          +                                      |   
        |        +                   :+     + +            + +      +       |   
        |+++.++++ +.+++++++.++++ +.+:  : +. :+ +++. ++ ++.+ + ++ .++ +++.+++|   
  45000 |-+                     +   +  ++  +       +  +         +           |   
        |                                                                   |   
  40000 |-+                                                                 |   
        |                                                                   |   
  35000 |-+                                                                 |   
        |                                                                   |   
        |                                           O                       |   
  30000 |OOO O OOOO OO OOOO OO O O O OOOOO OOOOOOO   O OO OOOOOOO OOO       |   
        |     O       O       O O   O              O  O                     |   
  25000 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                       nfsstat.Server.nfs.v4.operations.write                   
                                                                                
  23000 +-------------------------------------------------------------------+   
  22000 |-+                          +                                      |   
        |        +                   :+     + +            +        +       |   
  21000 |-+ .+ + ::    + +   + +    : :     ::::    +  ++. ::+ +    :: +.   |   
  20000 |+++  + + +.+++ + +.+ + :+.++  : +.: + +++.+ ++   + + + :.++ ++  +++|   
  19000 |-+                     +      ++  +                    +           |   
  18000 |-+                                                                 |   
        |                                                                   |   
  17000 |-+                                                                 |   
  16000 |-+                                                                 |   
  15000 |-+                                                                 |   
  14000 |-+                                                                 |   
        | O    OOOO O   O                       O   O                       |   
  13000 |O+O OO      OOO OO OOOOOO OOOOOOO OOOOO O O OOOO OOOOOOO OOO       |   
  12000 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                              nfsstat.Client.rpc.calls                          
                                                                                
  55000 +-------------------------------------------------------------------+   
        |                                                                   |   
  50000 |-+                          +                                      |   
        |        +                   :+     + +            + +      +       |   
        |+++.++++ +.+++++++.++++ +.+:  : +. :+ +++. ++ ++.+ + ++ .++ +++.+++|   
  45000 |-+                     +   +  ++  +       +  +         +           |   
        |                                                                   |   
  40000 |-+                                                                 |   
        |                                                                   |   
  35000 |-+                                                                 |   
        |                                                                   |   
        |                                           O                       |   
  30000 |OOO O OOOO OO OOOO OO O O O OOOOO OOOOOOO   O OO OOOOOOO OOO       |   
        |     O       O       O O   O              O  O                     |   
  25000 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                            nfsstat.Client.rpc.authrefrsh                       
                                                                                
  55000 +-------------------------------------------------------------------+   
        |                                                                   |   
  50000 |-+                          +                                      |   
        |        +                   :+     + +            + +      +       |   
        |+++.++++ +.+++++++.++++ +.+:  : +. :+ +++. ++ ++.+ + ++ .++ +++.+++|   
  45000 |-+                     +   +  ++  +       +  +         +           |   
        |                                                                   |   
  40000 |-+                                                                 |   
        |                                                                   |   
  35000 |-+                                                                 |   
        |                                                                   |   
        |                                           O                       |   
  30000 |OOO O OOOO OO OOOO OO O O O OOOOO OOOOOOO   O OO OOOOOOO OOO       |   
        |     O       O       O O   O              O  O                     |   
  25000 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                             nfsstat.Client.nfs.v4.write                        
                                                                                
  23000 +-------------------------------------------------------------------+   
  22000 |-+                          +                                      |   
        |        +                   :+     + +            +        +       |   
  21000 |-+ .+ + ::    + +   + +    : :     ::::    +  ++. ::+ +    :: +.   |   
  20000 |+++  + + +.+++ + +.+ + :+.++  : +.: + +++.+ ++   + + + :.++ ++  +++|   
  19000 |-+                     +      ++  +                    +           |   
  18000 |-+                                                                 |   
        |                                                                   |   
  17000 |-+                                                                 |   
  16000 |-+                                                                 |   
  15000 |-+                                                                 |   
  14000 |-+                                                                 |   
        | O    OOOO O   O                       O   O                       |   
  13000 |O+O OO      OOO OO OOOOOO OOOOOOO OOOOO O O OOOO OOOOOOO OOO       |   
  12000 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                           nfsstat.Client.nfs.v4.commit                         
                                                                                
  6000 +--------------------------------------------------------------------+   
       |                                                                    |   
  5500 |-+                          +                                       |   
       |        +                   :+     +  +           +         +       |   
       |++.++ + :+   +++.+ ++++    :  :    ::+ :   +.  ++ :+ + +    :: + .+ |   
  5000 |-+   + +  +++     +    + +++  :  ++ +  ++++  ++  +  + + ++.+ ++ +  +|   
       |                        +      ++                                   |   
  4500 |-+                                                                  |   
       |                                                                    |   
  4000 |-+                                                                  |   
       |                                                                    |   
       |                                                                    |   
  3500 |-+             O                           O                        |   
       |OO OOOOOO OOOOO  OOOOOO OOOOOO OOOOOO OOOOO  OOOOOO OOOOOO OO       |   
  3000 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                            nfsstat.Client.nfs.v4.open                          
                                                                                
  6000 +--------------------------------------------------------------------+   
       |                                                                    |   
  5500 |-+                          +                                       |   
       |        +                   :+     +  +           +         +       |   
       |++.++ + :+   +++.+ ++++    :  :    ::+ :   +.  ++ :+ + +    :: + .+ |   
  5000 |-+   + +  +++     +    + +++  :  ++ +  ++++  ++  +  + + ++.+ ++ +  +|   
       |                        +      ++                                   |   
  4500 |-+                                                                  |   
       |                                                                    |   
  4000 |-+                                                                  |   
       |                                                                    |   
       |                                                                    |   
  3500 |-+             O                           O                        |   
       |OO OOOOOO OOOOO  OOOOOO OOOOOO OOOOOO OOOOO  OOOOOO OOOOOO OO       |   
  3000 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                            nfsstat.Client.nfs.v4.close                         
                                                                                
  6000 +--------------------------------------------------------------------+   
       |                                                                    |   
  5500 |-+                          +                                       |   
       |        +                   :+     +  +           +         +       |   
       |++.++ + :+   +++.+ ++++    :  :    ::+ :   +.  ++ :+ + +    :: + .+ |   
  5000 |-+   + +  +++     +    + +++  :  ++ +  ++++  ++  +  + + ++.+ ++ +  +|   
       |                        +      ++                                   |   
  4500 |-+                                                                  |   
       |                                                                    |   
  4000 |-+                                                                  |   
       |                                                                    |   
       |                                                                    |   
  3500 |-+             O                           O                        |   
       |OO OOOOOO OOOOO  OOOOOO OOOOOO OOOOOO OOOOO  OOOOOO OOOOOO OO       |   
  3000 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                           nfsstat.Client.nfs.v4.access                         
                                                                                
  6000 +--------------------------------------------------------------------+   
       |                                                                    |   
  5500 |-+                          +                                       |   
       |        +                   :+     +  +           +         +       |   
       |++.++ + :+   +++.+ ++++.   :  :    ::+ :   +.  ++ :+ + +    :: + .+ |   
  5000 |-+   + +  +++     +     ++++  :  ++ +  ++++  ++  +  + + ++.+ ++ +  +|   
       |                               ++                                   |   
  4500 |-+                                                                  |   
       |                                                                    |   
  4000 |-+                                                                  |   
       |                                                                    |   
       |                                                                    |   
  3500 |-+     O  O    O                        O  O                        |   
       |OO OOOO O  OOOO  OOOOOO OOOOOO OOOOOO OO OO  OOOOOO OOOOOO OO       |   
  3000 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                           nfsstat.Client.nfs.v4.lookup                         
                                                                                
  6000 +--------------------------------------------------------------------+   
       |                                                                    |   
  5500 |-+                          +                                       |   
       |        +                   :+     +  +           +         +       |   
       |++.++ + :+   +++.+ ++++.   :  :    ::+ :   +.  ++ :+ + +    :: + .+ |   
  5000 |-+   + +  +++     +     ++++  :  ++ +  ++++  ++  +  + + ++.+ ++ +  +|   
       |                               ++                                   |   
  4500 |-+                                                                  |   
       |                                                                    |   
  4000 |-+                                                                  |   
       |                                                                    |   
       |                                                                    |   
  3500 |-+     O  O    O                           O                        |   
       |OO OOOO O  OOOO  OOOOOO OOOOOO OOOOOO OOOOO  OOOOOO OOOOOO OO       |   
  3000 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  0.05 +--------------------------------------------------------------------+   
       |     :                                                              |   
       |     :                  +                +   +        +           + |   
  0.04 |-+   :     +            :  +             :   :        :    +      : |   
       |     ::    :           ::  :           + :   :        :    :     :: |   
       |    : :    ::          : : ::+         :::  ::        :   ::     :: |   
  0.03 |++  : :   : :+     +   : : :+:        + + : : :     +: :  : :+   : :|   
       |:   : +   + +:    +:   : +:   :  +    :   : : :  +  :: :+ : ::   : :|   
  0.02 |-:  :  : +    :   : : :  ::   : +:   :    : : :  : : : :: : + : :  :|   
       | :.++  ++     :+.+  :++   :    :: :  :    ::  : : :: + + :    : +  :|   
       | +            +     +     +    +  +++     ++  +++ +      +    ++   +|   
  0.01 |-+                                                                  |   
       |             O                                                      |   
       |                                                                    |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  0.025 +-------------------------------------------------------------------+   
        |     +     +               +            +   +        +    +        |   
        |     :     :           ++  :++       ++ :   :    + + :    :      + |   
   0.02 |-+   :    ::           ::  : :       :: ::  :    : : :    :      : |   
        |     ::   : :          : : : :       : : :  :   :: : ::   ::     ::|   
        |    : :   : :         :  ::   :     :  : : : :  : : : :  : :    : :|   
  0.015 |-+  : : + : +    +.   :  ::   :    +:  + : : : +  : : :  : ++  .+ +|   
        |+++.+ ++ :   ++++  ++++   :   +++.+ +     :+ :+   + + ++.+   ++    |   
   0.01 |-+       +                +               +  +                     |   
        |                                                                   |   
        |             O                                                     |   
  0.005 |-+                                                                 |   
        |                                                                   |   
        |                                                                   |   
      0 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  0.08 +--------------------------------------------------------------------+   
       |                                      :  :   :   +                  |   
  0.07 |-+                                    :  :   :   :    +           + |   
  0.06 |-+                                   ::  :   :   :    :           : |   
       |                        +            ::  :  ::   :    :           : |   
  0.05 |-+                      :  +         : : :  ::   :    :          :: |   
       |                       ::  :         : :: : : :  ::   :          :: |   
  0.04 |-+                     : : :         : :: : : : : :  : :         : :|   
       | +  +         +  +  + +  :: :       :  :: : : : : :  : :         : :|   
  0.03 |-:: :+        : : : : :  +: :     + :  :: : : : : :  : :   +    :  :|   
  0.02 |:+::  :   +++: :: +: :    + ++.+  ::+  +: ::  : : :.+: :  + :   :  :|   
       |+  +  ++ +   + +   + +          ++ +    + +:  + + +  + +++  +++++  +|   
  0.01 |-+      +                                  +   +                    |   
       |              O                                                     |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  0.016 +-------------------------------------------------------------------+   
        |                                     +           +               + |   
  0.014 |-+                                   :           :               : |   
  0.012 |-+                     +             :: +   +    :   +           : |   
        |     +                 ::  +         :: :   :   ::   :    +      : |   
   0.01 |-+   :                : +  :++      : + ::  :   : :+ :    :      ::|   
        | +  +:   +.+  + +   + +  +:   :     : :: :  ::  : :: ::   ::    : :|   
  0.008 |-::+  :  :  + :::+  :::   +   +     :  :  :: :  : : : :  : +    : :|   
        |: +   :+ :   : +  +: +         +    +  +  +: + :  + : +  :  +   : +|   
  0.006 |++    + :    +     +            :.++       +  ++    +  +.+   ++.:  |   
  0.004 |-+      +                       +                               +  |   
        |                                                                   |   
  0.002 |-+                                                                 |   
        |                                                                   |   
      0 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  9000 +--------------------------------------------------------------------+   
       |                                                        +           |   
  8000 |-+                                                      :           |   
  7000 |-+                                                      :           |   
       |                                                        :           |   
  6000 |-+                                                      :           |   
  5000 |-+                                                      :           |   
       |                                                        ::          |   
  4000 |-+                                                     : :          |   
  3000 |-+                                                     : :          |   
       |                                                       : :          |   
  2000 |-+                                                     : :          |   
  1000 |-+                                                     : :          |   
       |++.++++ +.++++++.++++++.++++++. +++++.++++++.++++++.+++: +.++++++.++|   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  40 +----------------------------------------------------------------------+   
     |                                                          +           |   
  35 |-+                                                        :           |   
  30 |-+                                                        :           |   
     |                                                          :           |   
  25 |-+                                                        :           |   
     |                                                          :           |   
  20 |-+                                                       : :          |   
     |                                                         : :          |   
  15 |-+                                          +  +         : :      +.  |   
  10 |-+   +   +                          +      ::  :  +  +   : :      : + |   
     |     :+ + :                  +      :+     : :: :: : ::  : :     :   :|   
   5 |++.++  +  + ++.+++++.++++ .++ + .++:  + + +  :+ :: ++ +.++ + .++++   +|   
     |           +             +     +   +   + +   +  +           +         |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  0.14 +--------------------------------------------------------------------+   
       |                                                                    |   
  0.12 |-+                                                         +        |   
       |                                                      +    :        |   
   0.1 |-+                                                    :    :        |   
       |                         +                            :   ::        |   
  0.08 |-+         +             :                            :   ::        |   
       |           :            ::                            ::  ::        |   
  0.06 |-+   +     :            +:            +          +    ::  : :     + |   
       |     :     :            : :           :          :   : :  : :     : |   
  0.04 |-+   :    : :          :  :  +       ::          :   : :  : :    :: |   
       |   +: :   : :  +     + :  : + :      : : +   +  : :  : + :  :    : :|   
  0.02 |-++ : :   : :  :+    ::   :+  :     +  : :: + : : :.+:  ::  :   :  :|   
       |++  + +++.+ +++  ++++ +   +    +++++   ++ ++  +++ +  +  ++  +++++  +|   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  9000 +--------------------------------------------------------------------+   
       |                                                        +           |   
  8000 |-+                                                      :           |   
  7000 |-+                                                      :           |   
       |                                                        :           |   
  6000 |-+                                                      :           |   
  5000 |-+                                                      :           |   
       |                                                        ::          |   
  4000 |-+                                                     : :          |   
  3000 |-+                                                     : :          |   
       |                                                       : :          |   
  2000 |-+                                                     : :          |   
  1000 |-+                                                     : :          |   
       |++.++++ +.++++++.++++++.++++++. +++++.++++++.++++++.+++: +.++++++.++|   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  40 +----------------------------------------------------------------------+   
     |                                                          +           |   
  35 |-+                                                        :           |   
  30 |-+                                                        :           |   
     |                                                          :           |   
  25 |-+                                                        :           |   
     |                                                          :           |   
  20 |-+                                                       : :          |   
     |                                                         : :          |   
  15 |-+                                          +  +         : :      +.  |   
  10 |-+   +   +                          +      ::  :  +  +   : :      : + |   
     |     :+ + :                  +      :+     : :: :: : ::  : :     :   :|   
   5 |++.++  +  + ++.+++++.++++ .++ + .++:  + + +  :+ :: ++ +.++ + .++++   +|   
     |           +             +     +   +   + +   +  +           +         |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
         perf-sched.wait_time.max.ms.rcu_gp_kthread.kthread.ret_from_fork       
                                                                                
  5.2 +---------------------------------------------------------------------+   
      |           +            ++    +                            .+     .+ |   
    5 |++.++++++.+ +++.+++++.++  ++.+ +++.+++++.++++++.+++++  ++++  +++++  +|   
      |                                                    :  :             |   
      |                                                    :  :             |   
  4.8 |-+                                                   : :             |   
      |                                                     : :             |   
  4.6 |-+                                                   : :             |   
      |                                                     : :             |   
  4.4 |-+                                                   ::              |   
      |                                                     ::              |   
      |                                                      :              |   
  4.2 |-+                                                    :              |   
      |                                                      :              |   
    4 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
         perf-sched.wait_time.avg.ms.rcu_gp_kthread.kthread.ret_from_fork       
                                                                                
    5 +---------------------------------------------------------------------+   
      |                                                                     |   
  4.8 |-+    +                 +       +   +       +   +        +     +    +|   
      |    + :  .+ +    ++    +:  +.   ::  ::   +  :  + +       ::  + :++  :|   
      |++. : ::+ : :++. : ++. ::  : + : +.+ +  :: + :+   :     + +  :+  :  :|   
  4.6 |-+ +: ::: : :   +     + : :   :+     :  : :: ::   ++    : :  :    : :|   
      |     : +   ::            :+   +      : +  +  +      :   :  : :    : :|   
  4.4 |-+   :     :             ::           ::            +   :  : :    :: |   
      |     :     :             :            :             :  :   ::     :: |   
  4.2 |-+   +     +             +            +              : :   ::      : |   
      |                                                     : +    :      : |   
      |                                                     : :    +      + |   
    4 |-+                                                   : :             |   
      |                                                      :              |   
  3.8 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
        perf-sched.sch_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork        
                                                                                
  10 +----------------------------------------------------------------------+   
   9 |-+        +                                               :           |   
     |          :                                               :           |   
   8 |-+        :                                               :           |   
   7 |-+        :                                               :           |   
     |          :                                               :           |   
   6 |-+        :                                               :           |   
   5 |-+        :                                               ::          |   
   4 |-+       : :                                             : :          |   
     |         : :                                             : :          |   
   3 |-+       : :                                             : :          |   
   2 |-+       : :                                             : :          |   
     |         : :                                             : :          |   
   1 |-+       : :                                             : :          |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
          perf-sched.sch_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork      
                                                                                
   0.05 +-------------------------------------------------------------------+   
        |                                                       +           |   
  0.045 |-+                                                     :           |   
   0.04 |-+                                                     :           |   
        |                                                       ::          |   
  0.035 |-+                                                     ::          |   
   0.03 |-+         +                                         + ::          |   
        |     +    ::                                         : ::        + |   
  0.025 |-+   :    ::           ++                            :: :        : |   
   0.02 |-+   :   + :           ::   ++       +           + + :: : +      : |   
        |     ::  :  :          : : + :       :+ +   +    : :: :  ::      ::|   
  0.015 |-+  : :  :  :         :  : :  :      :: ::  :   : ::: :  :::    : :|   
   0.01 |-+  : : :   :         :   :   :     :  : : : :  : : : :  : :    : :|   
        |+++.+ +++   ++++++.++++   +   +++.+++  +  ++ +++  + + +  + ++++.+ +|   
  0.005 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
       perf-sched.wait_and_delay.count.rcu_gp_kthread.kthread.ret_from_fork     
                                                                                
  800 +---------------------------------------------------------------------+   
      |                                                                     |   
  700 |-+    +                            +                                 |   
      |      :   +                        :                                 |   
  600 |-+    :   :             +          : +                      +        |   
      |      :   :             :         :: :                      :        |   
  500 |-+    :  ::             :      +  :: :                      :        |   
      |      :: : :           : :     :  :: ::                    ::        |   
  400 |-+   : : : :           : :     :  : :::             +      : :       |   
      |    +: : : :     +     + : +  ::  : : :             ::     : :       |   
  300 |-+  :: ::  +     :     : + :: : ::  : +    +  +   +: :     : :  +    |   
      |  .+ : ::   :  .+ :  .+  : :: + ::  :  :.+ :: :+  :+  :  +:  :  :+   |   
  200 |++   + ++   +++   +++     :  :: :+  :  +  + ++  ++    +++ :  +++  +  |   
      |                          +  +  +   +                     +        ++|   
  100 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
      perf-sched.wait_and_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork     
                                                                                
  10 +----------------------------------------------------------------------+   
     |                                                          :           |   
   9 |-+        +                                               :           |   
     |          :                                               :           |   
     |          :                                               :           |   
   8 |-+        :                                               :           |   
     |          :                                               ::          |   
   7 |-+        ::                                             : :          |   
     |         : :                                             : :          |   
   6 |-+       : :                                             : :          |   
     |         : :                                             : :          |   
     |         : +            ++. +++        +  +.  +    + +  +: :+.     .+ |   
   5 |++.+++++.+  ++.+++++.+++   +   +.++++.+ ++  ++ ++.+ +: : + +  +++++  +|   
     |                                                      ::              |   
   4 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
       perf-sched.wait_and_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork    
                                                                                
    5 +---------------------------------------------------------------------+   
      |                                                                     |   
  4.8 |-+    +                 +       +   +       +   +        +     +    +|   
      | +  + :  .+ + +  ++ +  +:  +.   ::.+ :   +  :  + +       ::  + :++  :|   
      |+ + : ::+ : :+ + : + + ::  : + : +   +  +: + :+   +     + +  :+  :  :|   
  4.6 |-+ +: :+  : :   +     +  ::   :+     : +  :: ::    +    : :  :    : :|   
      |     :     :             :+   +       ::  +  +      +   :  : :    : :|   
  4.4 |-+   :     :             ::           :             :   :  : :    :: |   
      |     :     +             +            +              : :   ::     :: |   
  4.2 |-+   +                                               : :   ::      : |   
      |                                                     : +    :      + |   
      |                                                     : :    +        |   
    4 |-+                                                    ::             |   
      |                                                      :              |   
  3.8 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  600 +---------------------------------------------------------------------+   
      |                                                                     |   
  500 |++.++++++.+++++.+++++.++++++.+++++.+++++.++++++.+++++.+++ +.++++++.++|   
      |                                                        : :          |   
      |                                                        : :          |   
  400 |-+                                                      : :          |   
      |                                                        : :          |   
  300 |-+                                                      : :          |   
      |                                                         ::          |   
  200 |-+                                                       :           |   
      |                                                         :           |   
      |                                                         :           |   
  100 |-+                                                       :           |   
      |                                                         :           |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
   0.03 +-------------------------------------------------------------------+   
        |                                                     +             |   
        |           +                                         :             |   
  0.025 |-+         :           ++                            :           + |   
        |     +     :           ::                            :           : |   
        |     :    ::           ::            +           +   :           : |   
   0.02 |-+   :    ::           : :   +       :+          : + :    +      : |   
        |     :    : :          : :  +:       ::         :: :: :   :      : |   
  0.015 |-+   ::   : :         :  : + :       :: +   +   :: :: :   :     : :|   
        |    : :   : :         :  : :  :     :  :::  :   : ::: :   ::    : :|   
        |    : :  :  :         :   ::  :     :  :::  :: :  : : :  : :    : :|   
   0.01 |-+  : :+ :  :         :   :   :+    :  :  +: + +  : : :  : :    : :|   
        |+++.+ + ++  ++++++.++++   +   + +.+++  +   +  +   + + ++.+ ++++.+ +|   
        |                                                                   |   
  0.005 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
         perf-sched.wait_time.max.ms.schedule_timeout.svc_recv.nfsd.kthread     
                                                                                
  509.5 +-------------------------------------------------------------------+   
        |                                                                   |   
        |     +                                                             |   
    509 |++   : +     +    .+               ++               +              |   
        | :  +: :   ++ : ++  : ++           ::   +   +    ++ : +   +        |   
        | + +  ::: +   + :   + ::    + +   :  :  :+  ::   :: :::  +:      + |   
  508.5 |-++   : :+     +     +  :   :::+  +  :  : +: +  : : :+:  : :+    : |   
        |      + +               +.  :+  :+   + :   +  + :  :  : :  +: +.: :|   
    508 |-+                        + :   +     :+       :   :   ::   : : + +|   
        |                          : :         +        +   :   ::   : :    |   
        |                          ::                       +   :     ::    |   
  507.5 |-+                         :                           +     :     |   
        |                           :                                 :     |   
        |                           :                                 +     |   
    507 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
        perf-sched.wait_time.avg.ms.schedule_timeout.svc_recv.nfsd.kthread      
                                                                                
  500 +---------------------------------------------------------------------+   
      |                                                                     |   
  450 |-+   ++                                                              |   
      |  .+ : +   +   .+    .+      +++  .+ ++    +  +. +  +   +    + +++.++|   
  400 |++  +   +  :+++  ++++  +    +  : + : : +.+ :+ : + + :+ +:    :+      |   
      |        :  :           :   +    :: : :   : :: :    +  +  :+  :       |   
  350 |-+       : :           :   :    +   :     :  :           + +:        |   
      |         : :            :  :        :     +  +              +        |   
  300 |-+       ::             :  :        +                                |   
      |         ::             :  :                                         |   
  250 |-+        :             + :                                          |   
      |          +              ::                                          |   
  200 |-+                       +:                                          |   
      |                          :                                          |   
  150 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
        perf-sched.sch_delay.max.ms.schedule_timeout.svc_recv.nfsd.kthread      
                                                                                
  1.2 +---------------------------------------------------------------------+   
      |                                                                     |   
    1 |-+                                                                 + |   
      |                                                                   : |   
      |                                                                   : |   
  0.8 |-+                                                                 : |   
      |                                                                  :: |   
  0.6 |-+                               +                                :: |   
      |                                 :                                : :|   
  0.4 |-+                               ::                               : :|   
      |                                 ::                               : :|   
      |                                : :                               : :|   
  0.2 |-+                              : :                              :  :|   
      |     +   .++            ++ +.++ :  :  ++.         + +.++   .+  + :  :|   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
         perf-sched.sch_delay.avg.ms.schedule_timeout.svc_recv.nfsd.kthread     
                                                                                
   0.03 +-------------------------------------------------------------------+   
        |     +                                                           : |   
        |     :                                               +           : |   
  0.025 |-+   :     +                                         :           : |   
        |     :     :                         +           +   :           : |   
        |     :     :                ++       ::          : + :           : |   
   0.02 |-+   ::   ::           +    ::       :+         :: : :          : :|   
        |    : :   : :          :   + :       ::         :: :: :         : :|   
  0.015 |-+  : :   : :          ::  :  : +   :  :+   +   : ::: :   +     : :|   
        |    : :   : :         : +  :  : ::  :  :::  :   : : : :   :     : :|   
        |    : :  :  :         :  : :  : ::  :  + : : : :  : : :  : : +  : :|   
   0.01 |+++.+ +++:  ++++++.++++  ::   +:  +++     ++ +++  + + ++.+ ++ +.+ +|   
        |         +                :    +                                   |   
        |                          +                                        |   
  0.005 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
      perf-sched.wait_and_delay.count.schedule_timeout.svc_recv.nfsd.kthread    
                                                                                
  450 +---------------------------------------------------------------------+   
      |                          +                                          |   
  400 |-+                        :                                          |   
      |                         ::                                          |   
      |                         +:                                          |   
  350 |-+                       ::                                          |   
      |          +              ::                                          |   
  300 |-+        :             :  :                                         |   
      |         ::             +  :                                         |   
  250 |-+       ::             :  :                                         |   
      |         : :            :  :                                         |   
      |         : :           :   :    +   +     +  +           +  +        |   
  200 |-+      :  :           :   +.   ::  ::    :: ::    + .+  ::+ :       |   
      |++.++ + +  ++++.+++++.++     +++ +.+ + +.+ ++ +.+++ +  ++ +  +++++.++|   
  150 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
       perf-sched.wait_and_delay.max.ms.schedule_timeout.svc_recv.nfsd.kthread  
                                                                                
  509.5 +-------------------------------------------------------------------+   
        |                                                                   |   
        |     +                                                             |   
    509 |++   : +   + +    .+               ++               +     +        |   
        | :  +: :  : + : ++  : ++           ::   +   +    ++ : +   :      + |   
        | + +  ::: :   + :   + : :   + +   :  :  :+  ::   :: :::  + :     : |   
  508.5 |-++   : :+     +     +  +   :::+  +  : :  ++ ++ : : :+:  : :+    ::|   
        |      + +                +  :+  :+   + +      : :  :  : :  +: +.: :|   
    508 |-+                        + :   +     ::       :   :   ::   : : + +|   
        |                          : :         +        +   :   ::   : :    |   
        |                          ::                       +   :     ::    |   
  507.5 |-+                         :                           +     :     |   
        |                           :                                 :     |   
        |                           :                                 +     |   
    507 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
      perf-sched.wait_and_delay.avg.ms.schedule_timeout.svc_recv.nfsd.kthread   
                                                                                
  500 +---------------------------------------------------------------------+   
      |                                                                     |   
  450 |-+   ++                                                              |   
      |  .+ : +   +   .+    .+      +++  .+ ++    +  +. +  +   +    + +++.++|   
  400 |++  +   +  :+++  ++++  +    +  : + : : +.+ :+ : + + :+ +:    :+      |   
      |        :  :           :   +    :: : :   : :: :    +  +  :+  :       |   
  350 |-+       : :           :   :    +   :     :  :           + +:        |   
      |         : :            :  :        :     +  +              +        |   
  300 |-+       ::             :  :        +                                |   
      |         ::             :  :                                         |   
  250 |-+        :             + :                                          |   
      |          +              ::                                          |   
  200 |-+                       +:                                          |   
      |                          :                                          |   
  150 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
perf-sched.sch_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open.is
                                                                                
   0.007 +------------------------------------------------------------------+   
         |                       :                                          |   
  0.0065 |-+                     :                                          |   
   0.006 |-+                     :                                          |   
         |                       :                                          |   
  0.0055 |-+                     :                                          |   
         |                       :                                          |   
   0.005 |-+                     ::                                         |   
         |                      : :                                         |   
  0.0045 |-+                    : :                                         |   
   0.004 |-+   +                : : +  +                           +        |   
         |     :                : : :  :                           :        |   
  0.0035 |-+   ::               : : ::: :                          ::       |   
         |    : :               : :: :: :                         : :       |   
   0.003 +------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
    perf-sched.wait_time.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
                                                                                
    508 +-------------------------------------------------------------------+   
        |                            +                                      |   
  507.5 |-+                          :                                      |   
        |                            :                                      |   
    507 |-+                          :                                      |   
        |                           ::                                      |   
  506.5 |-+                         ::                                      |   
        |                           + :                                     |   
    506 |-+                         : :                                     |   
        |                           : :                         +           |   
  505.5 |-+                     +  :  :                         ::          |   
        |                       :: :  :                        : :          |   
    505 |+++.++++++.+++++++.++++ +.+  ++++.+++++++.++++++.++++++  ++++++.+++|   
        |                                                                   |   
  504.5 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
    perf-sched.wait_time.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
                                                                                
    479 +-------------------------------------------------------------------+   
        |                                       +                           |   
  478.8 |+++   + ++.+++++ +.+++ ++.++++  +.++++ :+.+++++   ++++++.+ + +  +++|   
        |  :   : :      : :   : :     :  :    : :      :   :      : : :  :  |   
  478.6 |-+:  +: :      : :   : :     : :     : :      :   :      : : :  :  |   
  478.4 |-+ : :: :      : :   : :     : +     : :      :   :      : : :  :  |   
        |   : :: :      : :   : :     : :     : :      :   :       :: : :   |   
  478.2 |-+ : :: :      : :   : :     : :     : :      :   :       :: : :   |   
        |   : : :        :     :       ::      :        :  :       : ::::   |   
    478 |-+ ::  :        :     :       ::      :        : :        : : ::   |   
        |   ::  :        :     :       :       :        : :        + : ::   |   
  477.8 |-+  :  :        :     :       :       :        : :          : ::   |   
  477.6 |-+  :  :        :     :       :       :        : :          : :    |   
        |    +  +        +     +       +       +        : :          : :    |   
  477.4 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
   perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork 
                                                                                
  0.07 +--------------------------------------------------------------------+   
       |     +                                                              |   
  0.06 |-+   :                                                              |   
       |     :                                                              |   
       |     :                                                              |   
  0.05 |-+   :     +            ++                            +           + |   
       |     :     :            ::                          + :           : |   
  0.04 |-+   ::    :            ::   +                   +  : :          :: |   
       |    : :    :           : :   :                   : :: :          :: |   
  0.03 |-+  : :   : :          :  : : :     +. +         : :: ::   +     : :|   
       |    : :   : :          :  :++ :     : +: +   +   ::: : :  +:   + : :|   
       |    : :   : :          :  ::   :   :    ::  ::  : :  : : +  :  ::  :|   
  0.02 |++. : : +.+ +++   +++ :   +    ++  +    + : : : : +  : : :  ++: +  :|   
       |   ++ ++       +.+   ++          ++       ++  +++    + ++     +    +|   
  0.01 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
    perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
                                                                                
  0.035 +-------------------------------------------------------------------+   
        |                                                                   |   
        |                                                                 + |   
   0.03 |-+                                                   +           : |   
        |     +     +                                         :           : |   
        |     :     :                                         :           : |   
  0.025 |-+   :     :           ++                            :           : |   
        |     :    ::           ::            +           + + :    +      : |   
   0.02 |-+   :    ::           : : +++       :+ +   +    : : :    :      ::|   
        |     ::   : :          : : : :       :: :   :   :: :: :   :     : :|   
        |    : :   : :          : : : :       :: ::  :   : ::: :   ::    : :|   
  0.015 |-+  : :  :  :         :  : :  :     :  :::  ::  : : : :  : :    : :|   
        |    : :  :  :         :   :   :     :  :  :: : :  : : :  : :    : :|   
        |+++.: :+++  ++++ +.+++:   :   ++ .+ +  :  +: + +  + : :+.: ++ +.: :|   
   0.01 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  80 +----------------------------------------------------------------------+   
     |   : +: :       : :   : :     :  + :   : :       :  :       :+: : :   |   
     |    :: ::        :     :       :+: :    :        : :        +  : :    |   
  75 |-+  +  +         +     +       + : :    +         ++           + +    |   
     |                                 : :                                  |   
     |                                 : :                                  |   
     |                                 : :                                  |   
  70 |-+                               : :                                  |   
     |                                  :                                   |   
     |                                  :                                   |   
  65 |-+                                :                                   |   
     |                                  :                                   |   
     |                                  :                                   |   
     |                                  :                                   |   
  60 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
perf-sched.wait_and_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_for
                                                                                
    508 +-------------------------------------------------------------------+   
        |                            :                                      |   
  507.5 |-+                          :                                      |   
        |                            :                                      |   
    507 |-+                         ::                                      |   
        |                           ::                                      |   
  506.5 |-+                         : :                                     |   
        |                           + :                                     |   
    506 |-+                         : :                         +           |   
        |                           : :                         ::          |   
  505.5 |-+                     +  :  :                         ::          |   
        |                       :+.:  :                        :  :       + |   
    505 |+++.++++++.+++++++.++++   +  ++++.+++++++.++++++.++++++  ++++++.+ +|   
        |                                                                   |   
  504.5 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
perf-sched.wait_and_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_for
                                                                                
    479 +-------------------------------------------------------------------+   
        |                            +          +                           |   
  478.8 |+++   + ++.+++++ +.+++ ++.++ +  +.++++ :+.+++++   ++++++.+ + +  +++|   
        |  :   : :      : :   : :     :  :    : :      :   :      : : :  :  |   
  478.6 |-+:  +: :      : :   : :     : :     : :      :   :      : : :  :  |   
  478.4 |-+ : :: :      : :   : :     : +     : :      :   :      : : :  :  |   
        |   : :: :      : :   : :     : :     : :      :   :       :: : :   |   
  478.2 |-+ : :: :      : :   : :     : :     : :      :   :       :: : :   |   
        |   : : :        :     :       ::      :        : :        : : ::   |   
    478 |-+ ::  :        :     :       ::      :        : :        : : ::   |   
        |   ::  :        :     :       :       :        : :        + : ::   |   
  477.8 |-+  :  :        :     :       :       :        : :          : ::   |   
  477.6 |-+  :  :        :     :       :       :        : :          : :    |   
        |    +  +        +     +       +       +        :.+          + :    |   
  477.4 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  500 +---------------------------------------------------------------------+   
      |      +   ::            :+  :       +  :+  :: :+ : +:            : : |   
  450 |++    :  : +++    ++    :   :    +. : :  +: +:  + :: :   ++. + +:   :|   
  400 |-+.  ::  :    +.  : +. :     :   : + :+   +  +    +  : + :  + + +   +|   
      |   + + ::       +:    +:     ++  :   +                :: :          :|   
  350 |-+  +  :+        +     +       : :                    + :            |   
  300 |-+     +                       + :                      +            |   
      |                               : :                                   |   
  250 |-+                             ::                                    |   
  200 |-+                             ::                                    |   
      |                                :                                    |   
  150 |-+                              :                                    |   
  100 |-+                              :                                    |   
      |                                +                                    |   
   50 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  0.045 +-------------------------------------------------------------------+   
        |                                                                   |   
   0.04 |-+                           +                                     |   
        |                             :          +   +                      |   
  0.035 |-+                          +:          :   :      + +             |   
        |                            ::          :   :      : :             |   
   0.03 |-+                          ::          ::  :      : :             |   
        |                            ::          ::  :  +   : :             |   
  0.025 |-+     +                   :  :         ::  :: ::  ::::     +      |   
        |    +  :        +     +    :  :        : : : : ::  :: :     :      |   
   0.02 |-+  :+ :   +    :     ::   +  :        : : : : : +: : :   + :    + |   
        |   :  : : +:    :     :++  :  :      ++:  :: ::  :: : :   : ::   : |   
  0.015 |++ :  + :+  :+ : : + :   : :  :      : :  :: ::   : + +   :: :  : :|   
        |:::     ::  :::: :+ ::   ::   :++.+ :  +  +: +:   :    : : : : .+ :|   
   0.01 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  0.022 +-------------------------------------------------------------------+   
        |                             +                                     |   
   0.02 |-+                           :                                     |   
  0.018 |-+                          +:                                     |   
        |     +                      ::                                     |   
  0.016 |-+   :                      ::       +           + + +           + |   
  0.014 |-+   :     +               :  :      :           : : :           : |   
        |    : :    :               :  :      ::         :: : ::   +      : |   
  0.012 |-+  : :   : :              +  :     : : +   +   : ::: :   :     : :|   
   0.01 |++  + +++ : :+  + .+  + +  :  :     : ++ +  :: +  : : +  : :    + :|   
        | + +    : : + + :+  + : :: :  +  .+ +     ++ ++   : + :  + +++ +  +|   
  0.008 |-++      ::    +     + : ::    :+  ::             +    :+     +    |   
  0.006 |-+       :             +  :    +   +                   +           |   
        |         +                +                                        |   
  0.004 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
 perf-sched.wait_time.max.ms.schedule_timeout.svc_recv.nfs4_callback_svc.kthread
                                                                                
  600 +---------------------------------------------------------------------+   
      |                                                                     |   
  500 |++.++++++.+++++.+++++.++++++.+++++.+++++.++++++.+++++.+++ +.++++++.++|   
      |                                                        : :          |   
      |                                                        : :          |   
  400 |-+                                                      : :          |   
      |                                                        : :          |   
  300 |-+                                                      : :          |   
      |                                                         ::          |   
  200 |-+                                                       :           |   
      |                                                         :           |   
      |                                                         :           |   
  100 |-+                                                       :           |   
      |                                                         :           |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
 perf-sched.wait_time.avg.ms.schedule_timeout.svc_recv.nfs4_callback_svc.kthread
                                                                                
  300 +---------------------------------------------------------------------+   
      |                                                                     |   
  250 |-+   +  +   +     +          ++  +.                          ++  +.+ |   
      |++. + ++ + + ++. + ++. +     : + : +++ +.+ ++ +.+++++.+++ +. : ++   +|   
      |   +      +     +     + +   :   +     +   +  +          : : +        |   
  200 |-+                      :   :                           : :          |   
      |                         : +                            : :          |   
  150 |-+                       + :                            : :          |   
      |                          +                             : :          |   
  100 |-+                                                       :           |   
      |                                                         :           |   
      |                                                         :           |   
   50 |-+                                                       :           |   
      |                                                         :           |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
 perf-sched.sch_delay.max.ms.schedule_timeout.svc_recv.nfs4_callback_svc.kthread
                                                                                
   0.05 +-------------------------------------------------------------------+   
        |                                                     +             |   
  0.045 |-+                     +                             :             |   
   0.04 |-+                     :                             :             |   
        |                       :                             :             |   
  0.035 |-+                     ::                        +   :             |   
        |           +           ::                        :   :    +        |   
   0.03 |-+         :           ::                        :   ::   :        |   
        |          ::          : +             + +   +   ::  : :   :        |   
  0.025 |-+   +    ::          : :  +++        : ::  :   : :+: :  ::      + |   
   0.02 |-+   :    : :         :  : : : +      ::::  ::  : ::: :  + :  +  : |   
        |+   : :  :  :+     +  :  : :  ::     : :  :: :  : : : : :  :  :: ::|   
  0.015 |:: .+ : ++  ::: + + : +   :   : :   +: +  +: + :  + : + :  : : :: :|   
        | ++   ++    + ++ +  ++    +   + +.++ +     +  ++    +  +   +++  : +|   
   0.01 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
 perf-sched.sch_delay.avg.ms.schedule_timeout.svc_recv.nfs4_callback_svc.kthread
                                                                                
   0.02 +-------------------------------------------------------------------+   
        |                                                     +             |   
  0.018 |-+                                                   :             |   
  0.016 |-+                                               +   :             |   
        |     +                                           :   :             |   
  0.014 |-+   :                 +   +++        +         ::   :           + |   
        |     :                 :   : :        : +   +   :: +: :   +      : |   
  0.012 |-+   ::                ::  : :        : ::  :   : ::: :   :      : |   
        |    : :               : :  :  :      : :::  ::  : ::: :   ::    : :|   
   0.01 |-+  : :   .+          : +  :  :      : :  +: + :  : : :  : :    : :|   
  0.008 |+++.+ ++++  ++++++.++++  ::   +++.++++ +   +  ++  : + + .+ ++++.+ +|   
        |                         ::                       +    +           |   
  0.006 |-+                        :                                        |   
        |                          +                                        |   
  0.004 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  10000 +-------------------------------------------------------------------+   
        |        +              +   +      +                      +    +.+  |   
   9000 |-+      :              :   :      :                      :    : :  |   
   8000 |-+      :              :   :      :                      :    : :  |   
        |        :              :   :   +  :                      :    : :  |   
   7000 |-+      :              :   :   : ::                     ::    : :  |   
   6000 |-+      :              :   :   : ::                     ::    : :  |   
        |        :              :   :   : ::                     ::    : :  |   
   5000 |-+     : :            : : : :  : : :                    : :  :   : |   
   4000 |-+     : :            : : : :  ::: :                    : :  :   : |   
        |       : :            : : : : : :: :                    : :  :   : |   
   3000 |-+     : :            : : : : : :  :                   :  :  :   : |   
   2000 |-+     : :            : : : : : :  :                   :  :  :   : |   
        |       : :            : : : : : :  :                   :  :  :   : |   
   1000 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  850 +---------------------------------------------------------------------+   
  800 |-+      +               +  +       +                      +      +   |   
      |        :               :  :       :                      :      :   |   
  750 |-+      :               :  :    +  :                      :      :   |   
  700 |-+      ::              :  ::   : ::                      ::    : :  |   
  650 |-+      ::              :  ::   : ::                      ::    + :  |   
  600 |-+      ::              :: ::   : : :                     ::    : :  |   
      |       : :             : :: :   ::: :                    : :    : :  |   
  550 |-+     : :             : :: :  : :: :                    : :    : :  |   
  500 |-+     :  :            : ::  : : :  :                    : :   :   : |   
  450 |-+     :  :            : ::  : : :  :                    :  :  :   : |   
  400 |-+.++++:  ++   .++   .++ ++  ++: +  ++++.++++++.+ +++.  ++  :+ +   ++|   
      |++     +    +++   +++          +                 +    ++    ::::     |   
  350 |-+                                                          + +      |   
  300 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  28 +----------------------------------------------------------------------+   
     |                                                                 :    |   
  27 |-+                                                             + :    |   
     |                                                               : :    |   
  26 |-+                                                          +  : :    |   
     |                                                            :  : ::   |   
  25 |-+                                                          :: : ::   |   
     |                                                            :: :: :   |   
  24 |-+                                                         : :: : :   |   
     |                                                           : :: : :   |   
  23 |++     +.+  ++.+  ++.+  +   +  +.+ +              +   +.+  +  : : +   |   
     |  +    :  : :   : :   : ::  :: :  :::            + :  :  : :  : :  :  |   
  22 |-+ ++ +   ++    ++    ++ +.+ + :  + +.+  +  ++ ++  +++   ++   + +  : +|   
     |     ::                       :        : ::+  ::                    ::|   
  21 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  10000 +-------------------------------------------------------------------+   
        |        +              +   +      +                      +    +.+  |   
   9000 |-+      :              :   :      :                      :    : :  |   
   8000 |-+      :              :   :      :                      :    : :  |   
        |        :              :   :   +  :                      :    : :  |   
   7000 |-+      :              :   :   : ::                     ::    : :  |   
   6000 |-+      :              :   :   : ::                     ::    : :  |   
        |        :              :   :   : ::                     ::    : :  |   
   5000 |-+     : :            : : : :  : : :                    : :  :   : |   
   4000 |-+     : :            : : : :  ::: :                    : :  :   : |   
        |       : :            : : : : : :: :                    : :  :   : |   
   3000 |-+     : :            : : : : : :  :                   :  :  :   : |   
   2000 |-+     : :            : : : : : :  :                   :  :  :   : |   
        |       : :            : : : : : :  :                   :  :  :   : |   
   1000 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  850 +---------------------------------------------------------------------+   
  800 |-+      +               +  +       +                      +      +   |   
      |        :               :  :       :                      :      :   |   
  750 |-+      :               :  :    +  :                      :      :   |   
  700 |-+      ::              :  ::   : ::                      ::    : :  |   
  650 |-+      ::              :  ::   : ::                      ::    + :  |   
  600 |-+      ::              :: ::   : : :                     ::    : :  |   
      |       : :             : :: :   ::: :                    : :    : :  |   
  550 |-+     : :             : :: :  : :: :                    : :    : :  |   
  500 |-+     :  :            : ::  : : :  :                    : :   :   : |   
  450 |-+     :  :            : ::  : : :  :                    :  :  :   : |   
  400 |-+.++++:  ++   .++   .++ ++  ++: +  ++++.++++++.+ +++.  ++  :+ +   ++|   
      |++     +    +++   +++          +                 +    ++    ::::     |   
  350 |-+                                                          + +      |   
  300 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
   999.7 +------------------------------------------------------------------+   
         |                                    +                           : |   
  999.65 |-+                                  :                           : |   
         |                                    ::                          : |   
         |                                    ::   +  +.  ++         +    ::|   
   999.6 |-+                         +        :: + :+ : + ::         ::  : :|   
         |                        ++ :+      : : : :: : : ::  +.  +  :++ : :|   
  999.55 |-+         +  +  + +.   :: : + +   :  :::  :   : :  : + :  :  +: :|   
         | :+.  +  + :: :+ : : +  : :   ::   :  : :  :   :  :+   + ::    + +|   
   999.5 |::  + ::+ : : : + ::  +:  :   +: + +  + +  +   +  ::     +:       |   
         |:   : :+  +  :    :    :  +     ::+               ::      :       |   
         |+    :       +    +    +        ::                :       +       |   
  999.45 |-+   +                          :                 +               |   
         |                                +                                 |   
   999.4 +------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
   899.5 +------------------------------------------------------------------+   
         |                                                                  |   
  899.45 |-+                                                           +    |   
         |                                         +  +    +  +      + :: + |   
         |           +     +                 +     :  :    :  :  +   : :: : |   
   899.4 |-+         ::    :           +     :     :  :: +:: : : ::  : : :: |   
         |:     +    ::   : :         ::    : :    :  :: :+ :+ : :+ : :  + :|   
  899.35 |:+ .+ :: + : :  + :   +  +  : :+  + :.++ :: :: :  ::  : : + :    :|   
         |+++  + + : : +++  ++.+:  : +  :: +  +  :: :: : :  :   + : : :    +|   
   899.3 |-+      +::           : + ::  + ::      : ::  :   +      :: +     |   
         |          :            :: :     +       : ::  :          :        |   
         |          :            :  +             + ++  +          +        |   
  899.25 |-+        +            +                                          |   
         |                                                                  |   
   899.2 +------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
   20.2 +-------------------------------------------------------------------+   
        |                                                                   |   
  20.15 |-+                                                                 |   
   20.1 |-+                                                                 |   
        |                                                                   |   
  20.05 |-+                                                                 |   
        |                                                                   |   
     20 |+++.++++++.+++++++.++++++.+++++++.+++++++.++++++.+++++++.++++++.+++|   
        |                                                                   |   
  19.95 |-+                                                                 |   
   19.9 |-+                                                                 |   
        |                                                                   |   
  19.85 |-+                                                                 |   
        |                                                                   |   
   19.8 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  999.75 +------------------------------------------------------------------+   
         |                                                                + |   
   999.7 |-+                                  +                           : |   
         |                                    :                           : |   
  999.65 |-+                                  ::                          : |   
         |                                    ::   +  +.  ++         +   : :|   
   999.6 |-+                      +  +.      : : + :+ : + ::  +.     ::  : :|   
         |                        :+ : +     : : : :: : : ::  : + +  :++.: :|   
  999.55 |-+       + +  +  + +.   :: :  :+   :  : :  :   :  :+   ::: :   + :|   
         | :+.+ +  :::: :++: : ++:  :   +: + +  + +  +   +  ::   + +:      +|   
   999.5 |:+   ::++ + ::    :    :  +    : :+               :       :       |   
         |+    +       +    +    +        ::                +       +       |   
  999.45 |-+                              :                                 |   
         |                                +                                 |   
   999.4 +------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
   899.5 +------------------------------------------------------------------+   
         |                                                             +    |   
         |                                                    +        :  + |   
  899.45 |-+                                       +  +    +  :      + :: : |   
         |           +     +                 +     :  :    :  :: +   : :: : |   
         |           :     :           +     :     :  :  ++: : : ::  : ::: :|   
   899.4 |-+         ::   ::          ::     ::    :  :: :  :: : :+ :::  : :|   
         |:  .+ +    ::   + :   +     ::    : :  + :  :: :  :+  : : : :  + :|   
  899.35 |:++  ::: + : : +  : .+:  + +  :+ ++ +.+:: :: : :  ::  + : + :    +|   
         |++   + + ::  ++   ++  : +: :  :: :     :: :: ::   +      :: :     |   
         |        +::            :: ::  + :       : ::  :          :: +     |   
   899.3 |-+        :            :: :     +       : ::  :          :        |   
         |          :            :  +             + ++  +          +        |   
         |          +            +                                          |   
  899.25 +------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  0.045 +-------------------------------------------------------------------+   
        |                             +                                     |   
   0.04 |-+                           :                                     |   
  0.035 |-+                           :          +   +      +               |   
        |                             :          :   :      :               |   
   0.03 |-+                           :          :   :      :               |   
        |                            : :      +  ::  :      :               |   
  0.025 |-+                          : :     +: : :  :      ::              |   
        |                            : :     : :: : : :    : :              |   
   0.02 |-+   +     +            +  ++ :     : +: : : :   +: :+    +      + |   
  0.015 |+++  :    +: + +   + + + + :  :    :   +  :: :  ::: +:    :      : |   
        |:::+: :  +  ::::: + ::::  +   ++   :      :: :  : :   :  : :    : :|   
   0.01 |-+  + +++   + + ++  + +         +.++      ++ +++  +   + .+ ++++.+ +|   
        |                                                       +           |   
  0.005 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  0.022 +-------------------------------------------------------------------+   
        |                             +                                     |   
   0.02 |-+                           :       +  +   +      +               |   
  0.018 |-+                          +:       :  :   :      :             + |   
        |                            ::       :  :   :      : +           : |   
  0.016 |-+         +                : :      :: ::  :    + : :           : |   
  0.014 |-+   +     :               :  :     : :: :  :    : :::    +      : |   
        |     :    ::               :  :     : +: : : :  ::: : :   :     : :|   
  0.012 |-+   ::   : :              +  :     :  : : : :  : : : :   ::    : :|   
   0.01 |++   :: +:  :+     +       :  +     +  +  :: :  : : + :  : : + .+ :|   
        |:++ : ++ +  ::++  + ++  +  :   : .++      :+ :+:  :   +  + + :+   +|   
  0.008 |-+ +:       +   :+    : :+:    ++         +  + +  +   : :   +      |   
  0.006 |-+  +           +     ++  +                            ::          |   
        |                                                       +           |   
  0.004 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  0.12 +--------------------------------------------------------------------+   
       |           +                                                        |   
   0.1 |-+         :                                                        |   
       |           :                                                        |   
       |           :             +  ++                                      |   
  0.08 |-+         :             :  ::           +   +      +               |   
       |           :             : + :           :   :      : +             |   
  0.06 |-+   +     ::            : :  :          :   :   +  : :    +      + |   
       |     :    : :            : :  :       ++ :  ::   : :: :    :      : |   
  0.04 |-+   :    : :           : ::  :       :: :: : :  : : ::   ::     :: |   
       |     ::   : :           : :   :      : :: : : :  ::: : :  : :    : :|   
       |    : :+  : :           : :    :     :  : : : : : :: : :  : :    : :|   
  0.02 |-+  : ::: : :           : :    :    :   : ::  : : :  : : :  :   :  :|   
       |++.++ + +.+ ++++.++++++.+ +    ++++++   + ++  +++ +  + +++  +++++  +|   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  0.035 +-------------------------------------------------------------------+   
        |                             +                                     |   
   0.03 |-+                           :                                     |   
        |                            +:                                     |   
  0.025 |-+   +                      ::                                     |   
        |     :                      ::                       +             |   
   0.02 |-+   :                     : :          +   +      + :             |   
        |     :                     :  :         :   :      : :           + |   
  0.015 |-+   ::                    +  :       + ::  :      : :           : |   
        |    : :    +            +  :  :       : ::  ::   + :: :          : |   
   0.01 |-+  : :   ::            :: :  :      + : : : :  ::: : :   +     : :|   
        |    : :++ : :          + ::   :    + : :  :: :  : : : :   ::    : :|   
  0.005 |+++.+ +  +  ++++++.++++   +   +++.+ +  +  ++ +++  + + ++.+ ++++.+ +|   
        |                                                                   |   
      0 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  2200 +--------------------------------------------------------------------+   
       |                          +                                     +.+ |   
  2000 |-+   ++                   :+        +  +  +   +                 : : |   
  1800 |-+   ::                   ::        :  :  :   :     +           :  :|   
       |     ::                  : :        :: :  :   :     :           :  :|   
  1600 |-+   ::                  : :        :: :  :   : +  ::           :  +|   
  1400 |-+  :  :                 +  :      : : ::: : : ::  : :         :   :|   
       |    :  :                 :  :      : :: :: : : ::: : :         :   :|   
  1200 |-+  :  :                :   :      :  : :: : : : ::  :         :    |   
  1000 |++.++  ++.++++++.++++++.+   ++. ++++  : ++ +.+ + ++  +++ +. ++++    |   
       |                               +      +                : : +        |   
   800 |-+                                                      ::          |   
   600 |-+                                                      :           |   
       |                                                        +           |   
   400 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  1600 +--------------------------------------------------------------------+   
       |                                                                    |   
  1400 |-+                                        +   +                 +.  |   
  1200 |-+                                     +  :   :                 : + |   
       |     ++                                :  :   : +   +           : : |   
  1000 |-+   ::                                :  ::  :::   :           :  :|   
       |    :  :                   +    +     :: : : : ::: : :         :   :|   
   800 |++  +  :     +  .+ +  +    ::   : + +.: :: : : : + : : +       :   +|   
       |:+.+   +     :++  ::++ +   :+  : ::+  + :+ +.+ +  +  ++:     + +    |   
   600 |-+      +.+++     +     ++:  +.+ +      ::             : +.+ :+     |   
   400 |-+                        +             +               ::  +       |   
       |                                                        ::          |   
   200 |-+                                                      :           |   
       |                                                        +           |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  2500 +--------------------------------------------------------------------+   
       |                                                                    |   
       |                          +                                         |   
  2000 |-+   ++                   :+        +  +  +   +                 +.+ |   
       |     ::                   ::        :  :  :   :     +           : : |   
       |     ::                  : :        :: :  :   : +   :           :  :|   
  1500 |-+  :  :                 +  :      : : ::: : : ::  : :         :   +|   
       |    :  :                 :  :      : :: :: : : : : : :         :   :|   
  1000 |++.++  ++.++++++.++++++.+   ++. ++++  : ++ +.+ + ++  +++ +. ++++    |   
       |                               +      +                : : +        |   
       |                                                       : :          |   
   500 |-+                                                      ::          |   
       |                                                        :           |   
       |                                                        :           |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  1600 +--------------------------------------------------------------------+   
       |                                                                    |   
  1400 |-+                                        +   +                 +.  |   
  1200 |-+                                     +  :   :                 : + |   
       |     ++                                :  :   : +   +           : : |   
  1000 |-+   ::                                :  ::  :::   :           :  :|   
       |    :  :                   +    +     :: : : : ::: : :         :   :|   
   800 |++  +  :     +  .+ +  +    ::   : + +.: :: : : : + : : +       :   +|   
       |:+.+   +     :++  ::++ +   :+  : ::+  + :+ +.+ +  +  ++:     + +    |   
   600 |-+      +.+++     +     ++:  +.+ +      ::             : +.+ :+     |   
   400 |-+                        +             +              : :  +       |   
       |                                                        ::          |   
   200 |-+                                                      :           |   
       |                                                        :           |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
    perf-sched.sch_delay.max.ms.schedule_preempt_disabled.kthread.ret_from_fork 
                                                                                
  0.12 +--------------------------------------------------------------------+   
       |                                                                    |   
   0.1 |-+                                                    +           + |   
       |                                      +               :           : |   
       |                                      :               :           : |   
  0.08 |-+                      +             :               :          :: |   
       |                        :+           ::               :    +     :: |   
  0.06 |-+         +            ::           ::          +    :    :     :: |   
       |           :           : :           : :         :   : :  ::     : :|   
  0.04 |-+         :           : :           : :         :   : :  ::     : :|   
       |           ::          :  :          : :         ::  : :  : :    : :|   
       |          : :          :  :         :  :        : :  : :  : :   :  :|   
  0.02 |-+        : :         :   :         :  :        : :  : : :  :   :  :|   
       |++.++++++.+ ++++.++++++   ++++.++++++  +++++.++++ +.++ +++  +++++  +|   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
     perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.kthread.ret_from_fork
                                                                                
  0.045 +-------------------------------------------------------------------+   
        |                                                                 : |   
   0.04 |-+                                                               : |   
  0.035 |-+                                                   +           : |   
        |                                                     :           : |   
   0.03 |-+                                                   :           : |   
  0.025 |-+                                               +   :           ::|   
        |                                     +           :   :          : :|   
   0.02 |-+                     +             :          ::  : :         : :|   
  0.015 |-+                     :             :          ::  : :   +     : :|   
        |           +           ::            ::         : : : :   :     : :|   
   0.01 |-+        : :         : +           : :         : : : :   ::    : :|   
  0.005 |-+   +    : +    +.   :  + +++++    : + +.+ ++ :  :++ +  : : ++.+ +|   
        |+++.+ ++++   ++++  ++++   +     +.+++  +   +  ++  +    +.+ ++      |   
      0 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                perf-sched.wait_time.max.ms.kthreadd.ret_from_fork              
                                                                                
  3500 +--------------------------------------------------------------------+   
       |                                                                    |   
  3000 |-+                        +                                         |   
       |                          :                                         |   
       |                          :                                         |   
  2500 |-+                        ::                                        |   
       |                         : :                                        |   
  2000 |-+    +                  : +        +  +  +   +     +           +.+ |   
       |     +:                  : :        :  :  :   :     :           :  :|   
  1500 |-+   ::                  + :        :: :  :   : +  ::    +      :  +|   
       |     : :                 :  :      : :: :: : : ::  : :   ::    :   :|   
       |    :  :   +            :   :      :  : :: : : : ::  :   ::    :    |   
  1000 |++.++  ++.+ ++++.++++++.+   ++.+++++  + ++ +.+ + ++  +++:  +++++    |   
       |                                                        :           |   
   500 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                perf-sched.wait_time.avg.ms.kthreadd.ret_from_fork              
                                                                                
  1600 +--------------------------------------------------------------------+   
       |                                                                +.  |   
  1400 |-+   +                                    +   +                 : + |   
  1200 |-+   ::                                   :   :     +           : : |   
       |     :+                                +  :   : +   :           :  :|   
  1000 |-+  : :                    +           : : : : ::  ::          :   :|   
       |    :  :                   ::   +  +  : :: : : : : : : +       :   +|   
   800 |++.++  ++.   +++.+ ++++.+  :++.+ :+ +.+ :+ +.+ + +:  : : +. +  +    |   
       |          + +     +      ::      +      +         +  ++: : + ++     |   
   600 |-+         +             ++                            : :          |   
   400 |-+                                                      ::          |   
       |                                                        :           |   
   200 |-+                                                      :           |   
       |                                                        +           |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                perf-sched.sch_delay.max.ms.kthreadd.ret_from_fork              
                                                                                
  0.16 +--------------------------------------------------------------------+   
       |                        +                                           |   
  0.14 |-+         +            :             +                             |   
  0.12 |-+         :            :             :          +         +        |   
       |           :            :             :          :         :        |   
   0.1 |-+         :           ::            ::          :         :        |   
       |           :           ::            ::          :        ::        |   
  0.08 |-+         ::          : :           : :         :        ::        |   
       |          : :          : :           : :        : :       : :       |   
  0.06 |-+        : :          : :           : :        : :       : :       |   
  0.04 |-+        : :          : :  +       :  :        : :       : :       |   
       |          : :         :  : + :      :  :        : :      :  :       |   
  0.02 |-+.+ ++   : + ++. + ++:  + : +.  + ++  + +  .+  + +.+ +  :  :    .+ |   
       |+   +  ++.+  +   + +  +   +    ++ +     + ++  ++     + +++  +++++  +|   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                 perf-sched.sch_delay.avg.ms.kthreadd.ret_from_fork             
                                                                                
  0.055 +-------------------------------------------------------------------+   
   0.05 |-+                                               +                 |   
        |                                                 :                 |   
  0.045 |-+                                               :                 |   
   0.04 |-+                                              ::                 |   
        |                                                ::                 |   
  0.035 |-+                                              ::                 |   
   0.03 |-+                     +             +          : :       +        |   
  0.025 |-+         +           :             :          : :       :        |   
        |           :           ::            ::         : :       :        |   
   0.02 |-+   +    : :          ::  +++      : : +   +  :  :  +    ::       |   
  0.015 |-+   ::   : :         : +  :  :     : + :+  :: :  :+ :   : :     + |   
        | ++.: +  :  + ++ +. ++:  : :  +++.+ +  :  ++ +++  ::: :  : : ++.+ +|   
   0.01 |++  +  +++   +  +  +  +  ::        +   +          + + ++.+ ++      |   
  0.005 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
              perf-sched.wait_and_delay.max.ms.kthreadd.ret_from_fork           
                                                                                
  3500 +--------------------------------------------------------------------+   
       |                                                                    |   
  3000 |-+                        +                                         |   
       |                          :                                         |   
  2500 |-+                        ::                                        |   
       |                          ::                                        |   
  2000 |-+   ++                  : +        +  +  +   +     +           +.+ |   
       |     ::                  : :        :: :  :   :     :           :  :|   
  1500 |-+   : :                 +  :       :: :: ::  ::+  : :   +      :  +|   
       |    :  :                 :  :      :  : :: : : ::: : :   :+    :    |   
  1000 |++.++  ++.++++++.++++++.+   ++.+++++  + ++ +.+ + ++  +++ : +++++    |   
       |                                                       : :          |   
   500 |-+                                                      :           |   
       |                                                        :           |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
              perf-sched.wait_and_delay.avg.ms.kthreadd.ret_from_fork           
                                                                                
  1600 +--------------------------------------------------------------------+   
       |                                                                +.  |   
  1400 |-+   +                                    +   +                 : + |   
  1200 |-+   ::                                   :   :     +           : : |   
       |     :+                                +  :   : +   :           :  :|   
  1000 |-+  : :                    +           : : : : ::  ::          :   :|   
       |    :  :                   ::   +  +  : :: : : : : : : +       :   +|   
   800 |++.++  ++.   +++.+ ++++.+  :++.+ :+ +.+ :+ +.+ + +:  : : +. +  +    |   
       |          + +     +      ::      +      +         +  ++: : + ++     |   
   600 |-+         +             ++                            : :          |   
   400 |-+                                                      ::          |   
       |                                                        :           |   
   200 |-+                                                      :           |   
       |                                                        :           |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  3000 +--------------------------------------------------------------------+   
       |                                                                    |   
  2500 |-+                        +                                         |   
       |                          :                                         |   
       |                          :                                         |   
  2000 |-+                        ::                                        |   
       |                         : :                                        |   
  1500 |-+    +                  : +        +  +  +   +     +           +.+ |   
       |     +:                  : :        :: :  :   :     :           :  :|   
  1000 |-+   ::                  + :       + : :  :   : +  ::    +      :  +|   
       |     : :                 :  :      :  : :: : : ::  : :   ::    :   :|   
       |  .+:  :   +   +.    +  :   :     :   + :: : : : ::  :  : :    :    |   
   500 |++  +  ++.+ +++  ++++ +.+   ++.++++     ++ +.+ + ++  ++++  +++++    |   
       |                                                                    |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  1400 +--------------------------------------------------------------------+   
       |                                          +   +                     |   
  1200 |-+                                        :   :                     |   
       |                                          :   :                 +.  |   
  1000 |-+                                     +  :   :                 : + |   
       |     +                                 :  :   :     +           : : |   
   800 |-+   ::                    +           : : : : :    :           : : |   
       |     :+                    :           : : : : :+  ::           :  :|   
   600 |-+   ::                    :          : :: : : ::  : :         :   :|   
       |    :  :                  : :   +  +  : :: : : ::: : : +       :   :|   
   400 |-+.+:  :       +.    + .+++ :   ::+ :.+ :+ :.+ : ::  : : +.    :   +|   
       |++  +  ++.+ +++  ++++ +     ++.+ +  +   +  +   + ++  ++ :: +++++    |   
   200 |-+         ::                                           +           |   
       |           +                                                        |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  0.18 +--------------------------------------------------------------------+   
       |                                                           +        |   
  0.16 |-+                                                         :        |   
  0.14 |-+                                                         :        |   
       |                                                          ::        |   
  0.12 |-+                                                        ::        |   
   0.1 |-+                                                        ::        |   
       |                                                 +        : :       |   
  0.08 |-+                                               :        : :       |   
  0.06 |-+                       +                       :        : :       |   
       |                         :                       ::      :  :       |   
  0.04 |-+   +     +            : :            +        : :.+ +  :  :       |   
  0.02 |++.++ +    :++++.++++++.+ :+++.  + ++.+ ++ +.+ +: +  ::+ +  ++ + .++|   
       |       ++.+               +    ++ +       +   + +    +  +     + +   |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
   0.04 +-------------------------------------------------------------------+   
        |                                                                   |   
  0.035 |-+                                                        +        |   
        |                                                 +        :        |   
   0.03 |-+                                               : +      :        |   
        |     +                                           : :      :        |   
  0.025 |-+   :     +                          +         :: : +    ::       |   
        |     ::    :                +         :         :: : :   : :       |   
   0.02 |-+  : :   : :               :+     + + :        : :::::  : :     + |   
        |+   : +   : :+    .+   ++  +  : +  : : :        : : : :  : :     :+|   
  0.015 |-++.+  :  : + ++++  +++  + :  + :+: :: ++.+++++:  : : +  + ++ +.+  |   
        |       ++:                +    +  + :          +  : + : :    +     |   
   0.01 |-+       +                          +             +    ::          |   
        |                                                       +           |   
  0.005 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  1000.18 +-----------------------------------------------------------------+   
          |                                               +    :            |   
  1000.16 |-+   +                                         :    :   +      + |   
          |     :                                         :    :   :      : |   
  1000.14 |-+   :                                         :   ::   :      : |   
          |    ::                  +                      :   ::   :      : |   
  1000.12 |-+  ::    +             :                      :   : :  ::     : |   
          |    : :   :            ::                     : :  : :  ::     ::|   
   1000.1 |-+  : :   :            : :                    : :  : : : :    : :|   
          |    : :   ::           : :           +        : :  : : : :    : :|   
  1000.08 |-++:  :  : :   +    + :  ++          ::       : : :  : : + +. : :|   
          |+ ::  :  : :+. :: + ::+    ++       + ++ .++ ++ :+:  : :  :: +: :|   
  1000.06 |-+ +  ++++ +  + ++ + +       +++.+++    +   +   + +  +++  +   + +|   
          |                                                                 |   
  1000.04 +-----------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  820 +---------------------------------------------------------------------+   
      |    :  :                      : :  :                      :  : : :   |   
  800 |-+  :  :                      : : :                       :  : : :   |   
      |    :  :                      : : :                       :  : : :   |   
  780 |-+   ::                        : ::                        : : : :   |   
      |     ::                        : ::                        : : : :   |   
  760 |-+   ::                        : :                         : : : :   |   
      |     ++                        + +                         :: : :    |   
  740 |-+                                                         :: : :    |   
      |                                                           :: : :    |   
  720 |-+                                                          : : :    |   
      |                                                            : : :    |   
  700 |-+                                                          : : :    |   
      |                                                            + + +    |   
  680 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
    13 +--------------------------------------------------------------------+   
       |                                                           : : :    |   
       |                                                           : : :    |   
  12.5 |-+                                                         : : :    |   
       |                                                          :: : :    |   
       |                                                          :: : :    |   
       |                                                          :: : :    |   
    12 |-+   ++                        + +                        : :::::   |   
       |     ::                        : :                        : : : :   |   
       |     ::                       :: :                        : : : :   |   
  11.5 |-+   ::                       :: :                        : : : :   |   
       |    :  :                      : : :                      :  : : :   |   
       |    :  :                      : : :                      :  : : :   |   
       |    :  :                     :  : :                      :  : : :   |   
    11 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  1000.22 +-----------------------------------------------------------------+   
          |                                               +    +            |   
   1000.2 |-+                                             :    :            |   
          |     +                                         :    :          + |   
  1000.18 |-+   :                                         :    :   +      : |   
  1000.16 |-+   :                                         :   ::   :      : |   
          |    ::                  +                      :   ::   :      : |   
  1000.14 |-+  ::    +             :                     : :  : :  ::     : |   
          |    : :   :            : :                    : :  : :  ::     ::|   
  1000.12 |-+  : :   :            : ++          +        : :  : : : :    : :|   
          |  + : :   ::   +    + :    :         ::       : :  : : : + +. : :|   
   1000.1 |-+::  :  : :   :    : +    ++       + ++   +  + :+:  : : : : +: :|   
  1000.08 |+: :  :+ : :+.: : +: ::      :    + :   :  :: : :::  : :  :   : :|   
          | + +  + ++ +  + ++ + +       +++.+ +    +.+ ++  + +  +++  +   + +|   
  1000.06 +-----------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  820 +---------------------------------------------------------------------+   
      |    :  :                      : :  :                      :  : : :   |   
  800 |-+  :  :                      : : :                       :  : : :   |   
      |    :  :                      : : :                       :  : : :   |   
  780 |-+   ::                        : ::                        : : : :   |   
      |     ::                        : ::                        : : : :   |   
  760 |-+   ::                        : :                         : : : :   |   
      |     ++                        + +                         :: : :    |   
  740 |-+                                                         :: : :    |   
      |                                                           :: : :    |   
  720 |-+                                                          : : :    |   
      |                                                            : : :    |   
  700 |-+                                                          : : :    |   
      |                                                            + + +    |   
  680 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  0.014 +-------------------------------------------------------------------+   
        |                            :                                      |   
  0.012 |-+                          :                                      |   
        |                            :                                      |   
        |                            ::                                     |   
   0.01 |-+                          ::                                     |   
        |                            ::                                     |   
  0.008 |-+      +                   :+     +                               |   
        |        :                  : :     :                               |   
  0.006 |-+      :                  : :     ::                              |   
        |        :                  : :  +  :+                              |   
        |       : :                 :  : :::  :                             |   
  0.004 |-+     : :                 :  : :::  +                             |   
        |  +.   + :     +     +     :  ::  +   +             +       +      |   
  0.002 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  0.008 +-------------------------------------------------------------------+   
        |                            ::     :                               |   
  0.007 |-+                          :+     :                               |   
        |                            ::     :                               |   
        |                            ::     :                               |   
  0.006 |-+      +                   ::     :                               |   
        |        :                   ::     ::                              |   
  0.005 |-+      :                   ::     ::                              |   
        |        :                  :  :   : :                              |   
  0.004 |-+      :                  :  :   : :                              |   
        |       : :                 :  :   : :                              |   
        |       : :                 :  :   : :                              |   
  0.003 |-+     : :                 :  : + : +                              |   
        |       : :                 :  : :+:  :                             |   
  0.002 +-------------------------------------------------------------------+   
                                                                                
                                                                                
[*] bisect-good sample
[O] bisect-bad  sample

***************************************************************************************************
lkp-csl-2ap2: 192 threads 4 sockets Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory
=========================================================================================
compiler/cpufreq_governor/disk/filesize/fs2/fs/iterations/kconfig/nr_threads/rootfs/sync_method/tbox_group/test_size/testcase/ucode:
  gcc-9/performance/1BRD_48G/4M/nfsv4/f2fs/1x/x86_64-rhel-8.3/1t/debian-10.4-x86_64-20200603.cgz/fsyncBeforeClose/lkp-csl-2ap2/24G/fsmark/0x5003006

commit: 
  0bcc7ca40b ("nfsd: fix crash on LOCKT on reexported NFSv3")
  e38b3f2005 ("SUNRPC: don't pause on incomplete allocation")

0bcc7ca40bd82319 e38b3f20059426a0adbde014ff7 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
         %stddev     %change         %stddev
             \          |                \  
  71053851 ± 17%     -99.6%     314853 ± 16%  fsmark.app_overhead
      3.94 ±  4%   +3483.3%     141.18 ±  2%  fsmark.files_per_sec
      1558 ±  5%     -97.1%      45.04 ±  2%  fsmark.time.elapsed_time
      1558 ±  5%     -97.1%      45.04 ±  2%  fsmark.time.elapsed_time.max
      1.00         +4066.7%      41.67        fsmark.time.percent_of_cpu_this_job_got
   1027670 ±  4%      +8.1%    1111220        fsmark.time.voluntary_context_switches
 2.875e+11 ±  4%     -97.0%  8.627e+09 ±  2%  cpuidle..time
 4.705e+08 ± 27%     -95.8%   19690938 ±  8%  cpuidle..usage
    571087 ± 72%     -98.6%       7809 ± 22%  numa-numastat.node3.local_node
    654031 ± 63%     -85.6%      94384        numa-numastat.node3.numa_hit
      1609 ±  4%     -93.9%      97.64        uptime.boot
    298778 ±  4%     -94.1%      17481        uptime.idle
      0.19 ± 12%      -0.2        0.03 ± 25%  mpstat.cpu.all.iowait%
      2.68 ± 17%      -1.2        1.51 ± 18%  mpstat.cpu.all.irq%
      0.15 ± 11%      -0.0        0.11 ± 18%  mpstat.cpu.all.soft%
      0.04 ±  2%      +0.8        0.81        mpstat.cpu.all.sys%
      0.01 ±  5%      +0.0        0.05 ±  7%  mpstat.cpu.all.usr%
    251504 ±  9%     -52.0%     120727 ± 30%  numa-meminfo.node0.AnonHugePages
     22605 ± 14%     -77.6%       5054 ± 29%  numa-meminfo.node3.Active
     21038 ± 12%     -79.8%       4246 ±  5%  numa-meminfo.node3.Active(anon)
     31506 ± 19%     -44.4%      17506 ± 18%  numa-meminfo.node3.AnonPages.max
     29889 ±  4%     -73.4%       7958 ± 57%  numa-meminfo.node3.Shmem
    122.40 ±  8%     -52.2%      58.50 ± 30%  numa-vmstat.node0.nr_anon_transparent_hugepages
   2208852 ± 81%     -58.4%     919139 ±126%  numa-vmstat.node2.numa_other
      5258 ± 12%     -79.8%       1061 ±  5%  numa-vmstat.node3.nr_active_anon
      7471 ±  4%     -73.4%       1989 ± 57%  numa-vmstat.node3.nr_shmem
      5258 ± 12%     -79.8%       1061 ±  5%  numa-vmstat.node3.nr_zone_active_anon
     16244 ±  5%   +3124.3%     523749 ±  2%  vmstat.io.bo
  43614319           -34.4%   28607503        vmstat.memory.cache
 1.319e+08           +15.8%  1.528e+08        vmstat.memory.free
      0.00       +1.5e+102%       1.50 ± 33%  vmstat.procs.r
      3983 ±  4%   +1578.9%      66872 ±  2%  vmstat.system.cs
      1050 ±  2%     +39.0%       1460 ± 32%  turbostat.Bzy_MHz
 1.047e+08 ±103%     -93.3%    7057176 ± 43%  turbostat.C1E
     40.20 ±  2%     +13.6%      45.67 ±  2%  turbostat.CoreTmp
 2.407e+08 ± 27%     -96.2%    9235259 ±  4%  turbostat.IRQ
     40.80           +13.2%      46.17 ±  2%  turbostat.PkgTmp
     19.01 ±122%    +394.6%      94.02 ± 12%  turbostat.PkgWatt
     83377 ±  2%     -58.1%      34933        meminfo.Active
     40451 ±  4%     -83.1%       6820 ±  2%  meminfo.Active(anon)
     42925           -34.5%      28112        meminfo.Active(file)
    272436           -44.9%     150051 ±  3%  meminfo.AnonHugePages
  43327950           -34.5%   28378989        meminfo.Cached
      2821 ± 13%    +874.0%      27480        meminfo.Dirty
  41118143           -36.2%   26240517        meminfo.Inactive
  40772459           -36.5%   25872490        meminfo.Inactive(file)
    295513           -19.8%     237053        meminfo.KReclaimable
 1.319e+08           +16.0%   1.53e+08        meminfo.MemFree
  65806183           -32.1%   44710478        meminfo.Memused
      2018 ±  9%    -100.0%       0.00        meminfo.Mlocked
      4133           +17.8%       4868        meminfo.PageTables
    295513           -19.8%     237053        meminfo.SReclaimable
     61214 ±  2%     -57.3%      26165        meminfo.Shmem
    631260           -11.0%     561649        meminfo.Slab
  65846158           -31.0%   45457989        meminfo.max_used_kB
      0.79 ± 12%      -0.1        0.66 ±  4%  perf-profile.calltrace.cycles-pp.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      1.45 ± 12%      +0.7        2.12 ± 21%  perf-profile.calltrace.cycles-pp.tick_nohz_get_sleep_length.menu_select.do_idle.cpu_startup_entry.start_secondary
      1.00 ± 20%      +0.7        1.71 ± 27%  perf-profile.calltrace.cycles-pp.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select.do_idle.cpu_startup_entry
      0.47 ± 15%      -0.1        0.33 ± 22%  perf-profile.children.cycles-pp.rcu_idle_exit
      0.31 ± 28%      -0.1        0.16 ± 45%  perf-profile.children.cycles-pp.enqueue_hrtimer
      0.34 ± 12%      -0.1        0.24 ± 20%  perf-profile.children.cycles-pp.rcu_eqs_exit
      0.15 ± 26%      -0.1        0.07 ± 38%  perf-profile.children.cycles-pp.rb_insert_color
      0.25 ± 10%      +0.0        0.30 ±  6%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
      0.28 ± 10%      +0.1        0.34 ±  9%  perf-profile.children.cycles-pp.clear_page_erms
      1.24 ±  7%      +0.1        1.38 ±  8%  perf-profile.children.cycles-pp.__alloc_pages
      0.70 ±  6%      +0.2        0.87 ± 16%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.18 ± 18%      +0.2        0.40 ± 36%  perf-profile.children.cycles-pp.calc_global_load_tick
      1.47 ± 12%      +0.7        2.14 ± 20%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      1.05 ± 19%      +0.7        1.74 ± 26%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.14 ± 25%      -0.1        0.07 ± 40%  perf-profile.self.cycles-pp.rb_insert_color
      0.20 ± 13%      -0.1        0.13 ± 24%  perf-profile.self.cycles-pp.rcu_eqs_exit
      0.25 ± 10%      +0.0        0.30 ±  6%  perf-profile.self.cycles-pp.__intel_pmu_enable_all
      0.27 ± 13%      +0.1        0.34 ±  9%  perf-profile.self.cycles-pp.clear_page_erms
      0.14 ± 16%      +0.1        0.25 ± 27%  perf-profile.self.cycles-pp.tsc_verify_tsc_adjust
      0.65 ±  9%      +0.1        0.78 ±  5%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      4985           -34.7%       3256        nfsstat.Client.nfs.v4.access
      4980           -34.7%       3250        nfsstat.Client.nfs.v4.close
      4979           -34.7%       3250        nfsstat.Client.nfs.v4.commit
    959.40 ±  5%    -100.0%       0.00        nfsstat.Client.nfs.v4.delegreturn
      1.00          -100.0%       0.00        nfsstat.Client.nfs.v4.delegreturn.percent
     15.40 ±  3%     -80.5%       3.00        nfsstat.Client.nfs.v4.getattr
      4984           -34.7%       3254        nfsstat.Client.nfs.v4.lookup
      4980           -34.7%       3251        nfsstat.Client.nfs.v4.open
     11.80 ±  6%    -100.0%       0.00        nfsstat.Client.nfs.v4.renew
     19919           -34.7%      13002        nfsstat.Client.nfs.v4.write
     45841           -36.1%      29293        nfsstat.Client.rpc.authrefrsh
     45841           -36.1%      29293        nfsstat.Client.rpc.calls
     45838           -36.1%      29292        nfsstat.Server.nfs.v4.compound
      9966           -34.7%       6508        nfsstat.Server.nfs.v4.operations.access
      4980           -34.7%       3250        nfsstat.Server.nfs.v4.operations.close
      4979           -34.7%       3249        nfsstat.Server.nfs.v4.operations.commit
    959.00 ±  5%    -100.0%       0.00        nfsstat.Server.nfs.v4.operations.delegreturn
     37002 ±  2%     -29.6%      26036        nfsstat.Server.nfs.v4.operations.getattr
      9966           -34.7%       6508        nfsstat.Server.nfs.v4.operations.getfh
      4983           -34.7%       3254        nfsstat.Server.nfs.v4.operations.lookup
      4980           -34.7%       3251        nfsstat.Server.nfs.v4.operations.open
     45820           -36.1%      29286        nfsstat.Server.nfs.v4.operations.putfh
     11.80 ±  6%    -100.0%       0.00        nfsstat.Server.nfs.v4.operations.renew
     19918           -34.7%      13002        nfsstat.Server.nfs.v4.operations.write
     45839           -36.1%      29293        nfsstat.Server.packet.packets
     45839           -36.1%      29293        nfsstat.Server.packet.tcp
     19924           -34.7%      13008        nfsstat.Server.reply.cache.misses
     25914           -37.2%      16284        nfsstat.Server.reply.cache.nocache
     45839           -36.1%      29293        nfsstat.Server.rpc.calls
     10111 ±  4%     -83.2%       1702 ±  2%  proc-vmstat.nr_active_anon
     10730           -34.7%       7008        proc-vmstat.nr_active_file
     81426            +7.1%      87235        proc-vmstat.nr_anon_pages
    132.60           -45.1%      72.83 ±  3%  proc-vmstat.nr_anon_transparent_hugepages
    708.60 ± 13%    +869.1%       6867        proc-vmstat.nr_dirty
   4293590            +3.6%    4448870        proc-vmstat.nr_dirty_background_threshold
   8597679            +3.6%    8908620        proc-vmstat.nr_dirty_threshold
  10832252           -34.5%    7095640        proc-vmstat.nr_file_pages
  32977403           +16.0%   38260553        proc-vmstat.nr_free_pages
     86420            +6.5%      92012        proc-vmstat.nr_inactive_anon
  10193119           -36.5%    6468775        proc-vmstat.nr_inactive_file
     27150            +8.5%      29459        proc-vmstat.nr_kernel_stack
      9070            +5.4%       9560        proc-vmstat.nr_mapped
    504.20 ±  9%    -100.0%       0.00        proc-vmstat.nr_mlock
      1033           +17.6%       1215        proc-vmstat.nr_page_table_pages
     15302 ±  2%     -57.3%       6539        proc-vmstat.nr_shmem
     73878           -19.8%      59232        proc-vmstat.nr_slab_reclaimable
     10111 ±  4%     -83.2%       1702 ±  2%  proc-vmstat.nr_zone_active_anon
     10730           -34.7%       7008        proc-vmstat.nr_zone_active_file
     86420            +6.5%      92012        proc-vmstat.nr_zone_inactive_anon
  10193119           -36.5%    6468775        proc-vmstat.nr_zone_inactive_file
    917.20 ±  7%    +688.6%       7232        proc-vmstat.nr_zone_write_pending
      7235 ±  8%     -85.5%       1046 ±208%  proc-vmstat.numa_hint_faults
      5707           -83.4%     948.67 ±222%  proc-vmstat.numa_hint_faults_local
      1036 ± 48%     -83.0%     176.00 ±156%  proc-vmstat.numa_pages_migrated
     35613 ± 29%     -91.5%       3020 ±114%  proc-vmstat.numa_pte_updates
     15821 ±  5%     -50.9%       7768        proc-vmstat.pgactivate
   5595724 ±  4%     -92.4%     426401        proc-vmstat.pgfault
      6683 ±148%     -97.4%     176.00 ±156%  proc-vmstat.pgmigrate_success
    381712 ±  5%     -94.2%      22003 ±  2%  proc-vmstat.pgreuse
 2.886e+08 ± 16%    +307.3%  1.175e+09 ±  2%  perf-stat.i.branch-instructions
     10.38 ± 45%      -9.3        1.07 ± 73%  perf-stat.i.branch-miss-rate%
      5.83 ± 70%     +11.1       16.90 ± 31%  perf-stat.i.cache-miss-rate%
   4950996 ± 36%    +217.6%   15723231 ± 20%  perf-stat.i.cache-misses
      3962 ±  4%   +1691.9%      70997 ±  2%  perf-stat.i.context-switches
      8.05 ± 29%     -75.9%       1.94 ± 12%  perf-stat.i.cpi
    191.43           +18.6%     227.00        perf-stat.i.cpu-migrations
      2647 ± 45%     -71.0%     768.82 ± 12%  perf-stat.i.cycles-between-cache-misses
 3.936e+08 ± 14%    +301.3%   1.58e+09 ±  2%  perf-stat.i.dTLB-loads
 2.128e+08 ± 13%    +291.3%  8.328e+08        perf-stat.i.dTLB-stores
   1471478 ± 17%     +99.1%    2929360 ± 10%  perf-stat.i.iTLB-load-misses
   1186319 ± 76%    +144.0%    2894640 ± 16%  perf-stat.i.iTLB-loads
 1.426e+09 ± 16%    +312.8%  5.886e+09 ±  2%  perf-stat.i.instructions
    957.90 ± 15%    +111.2%       2022 ± 10%  perf-stat.i.instructions-per-iTLB-miss
      0.15 ± 47%    +253.6%       0.53 ± 11%  perf-stat.i.ipc
      0.36 ± 20%   +1183.2%       4.59 ±  4%  perf-stat.i.major-faults
      4.34 ± 25%    +332.8%      18.77 ±  2%  perf-stat.i.metric.M/sec
      3458          +105.2%       7097 ±  2%  perf-stat.i.minor-faults
     87.13           -28.3       58.85 ±  8%  perf-stat.i.node-load-miss-rate%
    206038 ± 10%    +757.7%    1767265 ± 43%  perf-stat.i.node-load-misses
     56170 ±  5%   +1889.6%    1117560 ±  7%  perf-stat.i.node-loads
     73.58 ±  5%     -26.9       46.70 ±  5%  perf-stat.i.node-store-miss-rate%
    152927 ± 15%   +1374.0%    2254127 ± 13%  perf-stat.i.node-store-misses
    134787 ±  8%   +2096.9%    2961076 ±  8%  perf-stat.i.node-stores
      3458          +105.4%       7101 ±  2%  perf-stat.i.page-faults
      9.83 ± 44%      -8.7        1.16 ± 65%  perf-stat.overall.branch-miss-rate%
      5.86 ± 70%     +11.0       16.84 ± 32%  perf-stat.overall.cache-miss-rate%
      7.64 ± 28%     -75.1%       1.90 ± 12%  perf-stat.overall.cpi
      2452 ± 37%     -70.2%     729.88 ± 15%  perf-stat.overall.cycles-between-cache-misses
    978.10 ± 14%    +107.8%       2032 ± 10%  perf-stat.overall.instructions-per-iTLB-miss
      0.15 ± 48%    +251.8%       0.53 ± 10%  perf-stat.overall.ipc
     78.47 ±  2%     -19.0       59.44 ± 10%  perf-stat.overall.node-load-miss-rate%
     52.95 ±  8%      -9.8       43.10 ±  7%  perf-stat.overall.node-store-miss-rate%
 2.883e+08 ± 16%    +298.6%  1.149e+09 ±  2%  perf-stat.ps.branch-instructions
   4947844 ± 36%    +210.9%   15383865 ± 20%  perf-stat.ps.cache-misses
      3958 ±  4%   +1654.0%      69432 ±  2%  perf-stat.ps.context-switches
    191876            -2.1%     187803        perf-stat.ps.cpu-clock
    191.31           +16.1%     222.13        perf-stat.ps.cpu-migrations
 3.933e+08 ± 14%    +292.7%  1.545e+09 ±  2%  perf-stat.ps.dTLB-loads
 2.127e+08 ± 13%    +282.9%  8.144e+08        perf-stat.ps.dTLB-stores
   1470487 ± 17%     +94.8%    2864395 ± 10%  perf-stat.ps.iTLB-load-misses
   1185536 ± 76%    +138.8%    2830520 ± 16%  perf-stat.ps.iTLB-loads
 1.425e+09 ± 16%    +304.0%  5.756e+09 ±  2%  perf-stat.ps.instructions
      0.36 ± 20%   +1158.9%       4.51 ±  4%  perf-stat.ps.major-faults
      3454          +100.1%       6912 ±  2%  perf-stat.ps.minor-faults
    206001 ± 10%    +739.9%    1730237 ± 43%  perf-stat.ps.node-load-misses
     56102 ±  4%   +1849.0%    1093424 ±  7%  perf-stat.ps.node-loads
    152916 ± 15%   +1341.8%    2204697 ± 13%  perf-stat.ps.node-store-misses
    134612 ±  8%   +2052.1%    2896944 ±  8%  perf-stat.ps.node-stores
      3454          +100.2%       6917 ±  2%  perf-stat.ps.page-faults
    191876            -2.1%     187803        perf-stat.ps.task-clock
 2.227e+12 ± 18%     -88.2%  2.633e+11 ±  2%  perf-stat.total.instructions
      3803 ±  4%     -50.1%       1898 ±  3%  slabinfo.Acpi-Parse.active_objs
      3803 ±  4%     -50.1%       1898 ±  3%  slabinfo.Acpi-Parse.num_objs
    679.40 ± 10%     -27.2%     494.83 ± 17%  slabinfo.biovec-128.active_objs
    679.40 ± 10%     -27.2%     494.83 ± 17%  slabinfo.biovec-128.num_objs
    275.80 ± 11%     -51.4%     134.17 ± 12%  slabinfo.biovec-max.active_objs
    275.80 ± 11%     -51.4%     134.17 ± 12%  slabinfo.biovec-max.num_objs
      1539 ±  7%     -56.0%     677.83 ± 15%  slabinfo.ext4_extent_status.active_objs
      1539 ±  7%     -56.0%     677.83 ± 15%  slabinfo.ext4_extent_status.num_objs
      5780           -39.7%       3484        slabinfo.ext4_fc_dentry_update.active_objs
      5780           -39.7%       3484        slabinfo.ext4_fc_dentry_update.num_objs
      5994 ±  2%     -41.5%       3509 ±  2%  slabinfo.ext4_io_end.active_objs
      5994 ±  2%     -41.5%       3509 ±  2%  slabinfo.ext4_io_end.num_objs
     12422 ±  2%     -37.1%       7808        slabinfo.ext4_pending_reservation.active_objs
     12422 ±  2%     -37.1%       7808        slabinfo.ext4_pending_reservation.num_objs
     11497 ±  6%     -32.0%       7815 ±  5%  slabinfo.f2fs_free_nid.active_objs
     11497 ±  6%     -32.0%       7815 ±  5%  slabinfo.f2fs_free_nid.num_objs
      5416           -37.2%       3401        slabinfo.f2fs_inode_cache.active_objs
      5416           -37.2%       3401        slabinfo.f2fs_inode_cache.num_objs
      1065 ± 14%     -57.5%     453.00 ± 16%  slabinfo.f2fs_xattr_entry-1:0.active_objs
      1065 ± 14%     -57.5%     453.00 ± 16%  slabinfo.f2fs_xattr_entry-1:0.num_objs
      1869 ±  2%     -36.3%       1191 ± 11%  slabinfo.file_lock_cache.active_objs
      1869 ±  2%     -36.3%       1191 ± 11%  slabinfo.file_lock_cache.num_objs
      9229 ±  3%     -28.4%       6610 ±  2%  slabinfo.fsnotify_mark_connector.active_objs
      9229 ±  3%     -28.4%       6610 ±  2%  slabinfo.fsnotify_mark_connector.num_objs
      1172 ± 15%     -66.2%     396.50 ± 20%  slabinfo.ip6-frags.active_objs
      1172 ± 15%     -66.2%     396.50 ± 20%  slabinfo.ip6-frags.num_objs
     31099           -10.3%      27890        slabinfo.kmalloc-128.num_objs
     13083 ±  4%     -24.0%       9937        slabinfo.kmalloc-1k.active_objs
     13267 ±  4%     -24.7%       9988        slabinfo.kmalloc-1k.num_objs
      1412           +11.5%       1575        slabinfo.kmalloc-8k.active_objs
    516.60 ± 10%     -49.4%     261.33 ±  4%  slabinfo.kmalloc-cg-16.active_objs
    516.60 ± 10%     -49.4%     261.33 ±  4%  slabinfo.kmalloc-cg-16.num_objs
     18666 ±  5%     -20.2%      14902 ±  5%  slabinfo.kmalloc-rcl-64.active_objs
     18667 ±  5%     -19.9%      14944 ±  5%  slabinfo.kmalloc-rcl-64.num_objs
      5597 ±  3%     -36.7%       3541        slabinfo.nfs_inode_cache.active_objs
      5597 ±  3%     -36.5%       3555        slabinfo.nfs_inode_cache.num_objs
      1270 ± 18%     -26.7%     930.83 ±  9%  slabinfo.nfs_read_data.active_objs
      1270 ± 18%     -26.7%     930.83 ±  9%  slabinfo.nfs_read_data.num_objs
      1474 ± 18%    -100.0%       0.00        slabinfo.nfsd4_delegations.active_objs
      1474 ± 18%    -100.0%       0.00        slabinfo.nfsd4_delegations.num_objs
      1377 ± 18%     -69.2%     424.67 ± 22%  slabinfo.nfsd4_files.active_objs
      1377 ± 18%     -69.2%     424.67 ± 22%  slabinfo.nfsd4_files.num_objs
      3249 ± 20%     -29.3%       2299 ± 16%  slabinfo.nfsd_file.active_objs
    285699           -31.7%     195081        slabinfo.radix_tree_node.active_objs
      5101           -31.7%       3484        slabinfo.radix_tree_node.active_slabs
    285709           -31.7%     195172        slabinfo.radix_tree_node.num_objs
      5101           -31.7%       3484        slabinfo.radix_tree_node.num_slabs
      2537 ± 14%     -35.1%       1646 ±  7%  slabinfo.skbuff_ext_cache.active_objs
      2537 ± 14%     -35.1%       1646 ±  7%  slabinfo.skbuff_ext_cache.num_objs
     12344 ± 10%     -71.1%       3565 ±  9%  slabinfo.skbuff_fclone_cache.active_objs
    196.80 ± 10%     -71.9%      55.33 ±  9%  slabinfo.skbuff_fclone_cache.active_slabs
     12619 ± 10%     -71.8%       3565 ±  9%  slabinfo.skbuff_fclone_cache.num_objs
    196.80 ± 10%     -71.9%      55.33 ±  9%  slabinfo.skbuff_fclone_cache.num_slabs
     32579           -25.2%      24375        slabinfo.vmap_area.active_objs
    529.80           -27.6%     383.67        slabinfo.vmap_area.active_slabs
     33948           -27.6%      24584        slabinfo.vmap_area.num_objs
    529.80           -27.6%     383.67        slabinfo.vmap_area.num_slabs
      2079 ±  7%     -19.2%       1680 ± 10%  slabinfo.xfrm_state.active_objs
      2079 ±  7%     -19.2%       1680 ± 10%  slabinfo.xfrm_state.num_objs
      0.02 ± 17%     -93.5%       0.00 ±223%  perf-sched.sch_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.02 ± 27%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      0.02 ± 82%     -77.3%       0.01 ± 20%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.04 ± 64%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.kthreadd.ret_from_fork
      0.02 ± 38%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.__synchronize_srcu.part
      0.03 ± 46%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork
      0.01 ± 18%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.rpc_wait_bit_killable.__wait_on_bit.out_of_line_wait_on_bit.__rpc_execute
      0.01 ± 44%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.rpc_wait_bit_killable.__wait_on_bit.out_of_line_wait_on_bit.nfs4_do_close
      0.01 ± 19%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.rpc_wait_bit_killable.__wait_on_bit.out_of_line_wait_on_bit.nfs4_run_open_task
      0.02 ± 37%     -81.9%       0.00 ± 66%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.01 ± 18%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
      0.02 ± 62%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.kthread.ret_from_fork
      0.02 ± 26%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.__break_lease.do_dentry_open.dentry_open
      0.02 ± 47%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.__skb_wait_for_more_packets.unix_dgram_recvmsg.__sys_recvfrom
      0.02 ± 26%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.02 ± 21%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.svc_recv.nfs4_callback_svc.kthread
      0.02 ± 22%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.svc_recv.nfsd.kthread
      0.03 ± 23%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.wait_for_completion_killable.__kthread_create_on_node.kthread_create_on_node
      0.00 ± 27%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open.isra
      0.02 ± 17%    +376.6%       0.08 ± 14%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork
      0.03 ± 24%     -96.1%       0.00 ±223%  perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.03 ± 33%    -100.0%       0.00        perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      0.03 ±101%     -76.3%       0.01 ± 38%  perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.06 ± 63%    -100.0%       0.00        perf-sched.sch_delay.max.ms.io_schedule.wait_on_page_bit.wait_on_page_writeback.__filemap_fdatawait_range
      0.08 ± 78%    -100.0%       0.00        perf-sched.sch_delay.max.ms.kthreadd.ret_from_fork
      0.04 ±104%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.__synchronize_srcu.part
      0.03 ± 63%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      2.07 ±191%    -100.0%       0.00        perf-sched.sch_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork
      0.02 ± 18%    -100.0%       0.00        perf-sched.sch_delay.max.ms.rpc_wait_bit_killable.__wait_on_bit.out_of_line_wait_on_bit.__rpc_execute
      0.04 ± 64%    -100.0%       0.00        perf-sched.sch_delay.max.ms.rpc_wait_bit_killable.__wait_on_bit.out_of_line_wait_on_bit.nfs4_do_close
      0.02 ± 18%    -100.0%       0.00        perf-sched.sch_delay.max.ms.rpc_wait_bit_killable.__wait_on_bit.out_of_line_wait_on_bit.nfs4_run_open_task
      0.08 ± 50%     -86.6%       0.01 ± 77%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.04 ± 39%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
      0.04 ± 66%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_preempt_disabled.kthread.ret_from_fork
      0.04 ± 25%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_timeout.__break_lease.do_dentry_open.dentry_open
      0.02 ± 47%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_timeout.__skb_wait_for_more_packets.unix_dgram_recvmsg.__sys_recvfrom
      0.03 ± 41%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.03 ± 44%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_timeout.svc_recv.nfs4_callback_svc.kthread
      0.05 ± 24%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_timeout.svc_recv.nfsd.kthread
      0.04 ± 36%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_timeout.wait_for_completion_killable.__kthread_create_on_node.kthread_create_on_node
      0.06 ± 78%    -100.0%       0.00        perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open.isra
      3.27 ±  4%     +10.7%       3.62 ±  3%  perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork
    227.02 ±  3%     -99.5%       1.12 ± 17%  perf-sched.total_wait_and_delay.average.ms
     11592 ±  3%     -93.3%     772.50 ±  4%  perf-sched.total_wait_and_delay.count.ms
      9974           -99.8%      17.31 ± 16%  perf-sched.total_wait_and_delay.max.ms
    227.01 ±  3%     -99.5%       1.11 ± 17%  perf-sched.total_wait_time.average.ms
      9974           -99.8%      17.30 ± 16%  perf-sched.total_wait_time.max.ms
    899.36          -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    790.99 ±  4%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
    939.56 ± 29%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.__module_put_and_exit.nfs4_run_state_manager.kthread
    216.64           -99.8%       0.54 ± 10%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.79 ±  8%     -33.7%       0.52 ±  5%  perf-sched.wait_and_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      7.62 ± 44%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.io_schedule.wait_on_page_bit.wait_on_page_writeback.__filemap_fdatawait_range
      1113 ± 35%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.kthreadd.ret_from_fork
     57.46 ±  2%     -98.8%       0.68 ± 25%  perf-sched.wait_and_delay.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      9.16 ±  2%     -99.3%       0.06 ± 32%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      4.60 ±  2%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork
    411.59 ±  4%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
     38.27 ± 74%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_timeout.__break_lease.do_dentry_open.dentry_open
    478.52          -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
     15.58 ± 12%     -77.4%       3.53 ±  7%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
    247.62 ±  2%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_timeout.svc_recv.nfs4_callback_svc.kthread
    414.99 ±  6%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_timeout.svc_recv.nfsd.kthread
    675.85 ± 63%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_timeout.wait_for_completion_killable.__kthread_create_on_node.kthread_create_on_node
    732.81 ±  2%     -99.7%       2.37 ± 26%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.00 ± 27%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open.isra
    332.95 ± 16%     -99.6%       1.41 ± 19%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork
     20.00          -100.0%       0.00        perf-sched.wait_and_delay.count.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     11.40 ±  4%    -100.0%       0.00        perf-sched.wait_and_delay.count.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      9.20 ± 37%    -100.0%       0.00        perf-sched.wait_and_delay.count.do_task_dead.do_exit.__module_put_and_exit.nfs4_run_state_manager.kthread
    337.00           -84.8%      51.33 ± 11%  perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
    314.60 ±  4%     -87.4%      39.67 ± 12%  perf-sched.wait_and_delay.count.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
    672.20 ± 35%    -100.0%       0.00        perf-sched.wait_and_delay.count.io_schedule.wait_on_page_bit.wait_on_page_writeback.__filemap_fdatawait_range
      9.20 ± 37%    -100.0%       0.00        perf-sched.wait_and_delay.count.kthreadd.ret_from_fork
      3135           -98.8%      38.50 ± 53%  perf-sched.wait_and_delay.count.pipe_read.new_sync_read.vfs_read.ksys_read
      2035 ±  4%     -86.0%     284.33        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
    179.40 ± 15%    -100.0%       0.00        perf-sched.wait_and_delay.count.rcu_gp_kthread.kthread.ret_from_fork
     21.40 ±  2%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
    180.60 ± 64%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_timeout.__break_lease.do_dentry_open.dentry_open
     79.20 ±  2%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_timeout.kcompactd.kthread.ret_from_fork
    595.40 ± 11%     -99.0%       6.17 ± 14%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
     18.00 ± 36%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_timeout.svc_recv.nfs4_callback_svc.kthread
    174.40 ±  4%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_timeout.svc_recv.nfsd.kthread
      9.20 ± 37%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_timeout.wait_for_completion_killable.__kthread_create_on_node.kthread_create_on_node
      2420 ±  3%     -88.3%     283.83        perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork
     82.00          -100.0%       0.00        perf-sched.wait_and_delay.count.wait_for_partner.fifo_open.do_dentry_open.do_open.isra
      1169 ± 14%     -95.8%      49.33 ± 13%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork
    999.56          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      1000          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      1742 ± 38%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.__module_put_and_exit.nfs4_run_state_manager.kthread
      1175 ± 29%     -99.4%       7.10 ± 25%  perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     22.04           -85.5%       3.19 ± 62%  perf-sched.wait_and_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
    456.50 ±  9%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.io_schedule.wait_on_page_bit.wait_on_page_writeback.__filemap_fdatawait_range
      1823 ± 33%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.kthreadd.ret_from_fork
      1018           -99.7%       3.12 ± 51%  perf-sched.wait_and_delay.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      9974           -99.9%      13.36 ± 27%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      6.08 ± 32%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork
      1000          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
    504.19          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_timeout.__break_lease.do_dentry_open.dentry_open
    505.07          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
    273.35 ± 21%     -98.2%       5.02 ± 12%  perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
    504.38          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_timeout.svc_recv.nfs4_callback_svc.kthread
    508.18          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_timeout.svc_recv.nfsd.kthread
      1319 ± 45%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_timeout.wait_for_completion_killable.__kthread_create_on_node.kthread_create_on_node
      1019           -98.5%      15.02 ± 24%  perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.06 ± 78%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open.isra
      8915 ±  5%     -99.9%      12.23 ± 34%  perf-sched.wait_and_delay.max.ms.worker_thread.kthread.ret_from_fork
    899.34          -100.0%       0.00        perf-sched.wait_time.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    790.97 ±  4%    -100.0%       0.00        perf-sched.wait_time.avg.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
    939.56 ± 29%    -100.0%       0.00        perf-sched.wait_time.avg.ms.do_task_dead.do_exit.__module_put_and_exit.nfs4_run_state_manager.kthread
    216.63           -99.8%       0.51 ±  6%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.77 ±  7%     -41.0%       0.45 ± 11%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      7.61 ± 44%    -100.0%       0.00        perf-sched.wait_time.avg.ms.io_schedule.wait_on_page_bit.wait_on_page_writeback.__filemap_fdatawait_range
      1113 ± 35%    -100.0%       0.00        perf-sched.wait_time.avg.ms.kthreadd.ret_from_fork
     57.45 ±  2%     -98.9%       0.64 ± 22%  perf-sched.wait_time.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
    106.99 ± 51%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.__synchronize_srcu.part
      9.16 ±  2%     -99.3%       0.06 ± 32%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      4.58 ±  2%    -100.0%       0.00        perf-sched.wait_time.avg.ms.rcu_gp_kthread.kthread.ret_from_fork
    138.46 ± 53%    -100.0%       0.00        perf-sched.wait_time.avg.ms.rpc_wait_bit_killable.__wait_on_bit.out_of_line_wait_on_bit.__rpc_execute
    246.08 ± 40%    -100.0%       0.00        perf-sched.wait_time.avg.ms.rpc_wait_bit_killable.__wait_on_bit.out_of_line_wait_on_bit.nfs4_do_close
    148.70 ± 49%    -100.0%       0.00        perf-sched.wait_time.avg.ms.rpc_wait_bit_killable.__wait_on_bit.out_of_line_wait_on_bit.nfs4_run_open_task
    140.30 ± 75%     -98.7%       1.79 ± 41%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
    411.57 ±  4%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
     38.25 ± 74%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_timeout.__break_lease.do_dentry_open.dentry_open
      0.46 ± 19%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_timeout.__skb_wait_for_more_packets.unix_dgram_recvmsg.__sys_recvfrom
    478.50          -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.02 ± 38%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_timeout.khugepaged.kthread.ret_from_fork
     15.55 ± 12%     -78.1%       3.41 ±  8%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
    247.60 ±  2%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_timeout.svc_recv.nfs4_callback_svc.kthread
    414.97 ±  6%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_timeout.svc_recv.nfsd.kthread
    675.82 ± 63%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_timeout.wait_for_completion_killable.__kthread_create_on_node.kthread_create_on_node
    732.80 ±  2%     -99.7%       2.36 ± 26%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.00          -100.0%       0.00        perf-sched.wait_time.avg.ms.wait_on_commit.__nfs_commit_inode.nfs_file_fsync.do_fsync
    332.93 ± 16%     -99.6%       1.34 ± 20%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork
    999.54          -100.0%       0.00        perf-sched.wait_time.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      1000          -100.0%       0.00        perf-sched.wait_time.max.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      1742 ± 38%    -100.0%       0.00        perf-sched.wait_time.max.ms.do_task_dead.do_exit.__module_put_and_exit.nfs4_run_state_manager.kthread
      1175 ± 29%     -99.4%       6.84 ± 30%  perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     22.04           -94.5%       1.21 ± 21%  perf-sched.wait_time.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
    456.49 ±  9%    -100.0%       0.00        perf-sched.wait_time.max.ms.io_schedule.wait_on_page_bit.wait_on_page_writeback.__filemap_fdatawait_range
      1823 ± 33%    -100.0%       0.00        perf-sched.wait_time.max.ms.kthreadd.ret_from_fork
      1018           -99.7%       2.95 ± 54%  perf-sched.wait_time.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
    358.79 ± 25%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.__synchronize_srcu.part
      9974           -99.9%      13.36 ± 27%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      5.06          -100.0%       0.00        perf-sched.wait_time.max.ms.rcu_gp_kthread.kthread.ret_from_fork
    458.08 ±  9%    -100.0%       0.00        perf-sched.wait_time.max.ms.rpc_wait_bit_killable.__wait_on_bit.out_of_line_wait_on_bit.__rpc_execute
    464.31 ±  9%    -100.0%       0.00        perf-sched.wait_time.max.ms.rpc_wait_bit_killable.__wait_on_bit.out_of_line_wait_on_bit.nfs4_do_close
    451.28 ± 10%    -100.0%       0.00        perf-sched.wait_time.max.ms.rpc_wait_bit_killable.__wait_on_bit.out_of_line_wait_on_bit.nfs4_run_open_task
    425.95 ± 23%     -97.7%       9.94 ± 63%  perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      1000          -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
    504.17          -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_timeout.__break_lease.do_dentry_open.dentry_open
      0.46 ± 19%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_timeout.__skb_wait_for_more_packets.unix_dgram_recvmsg.__sys_recvfrom
    505.04          -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.02 ± 38%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_timeout.khugepaged.kthread.ret_from_fork
    273.30 ± 21%     -98.2%       5.01 ± 12%  perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
    504.36          -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_timeout.svc_recv.nfs4_callback_svc.kthread
    508.16          -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_timeout.svc_recv.nfsd.kthread
      1319 ± 45%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_timeout.wait_for_completion_killable.__kthread_create_on_node.kthread_create_on_node
      1019           -98.5%      15.01 ± 24%  perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.00 ± 45%    -100.0%       0.00        perf-sched.wait_time.max.ms.wait_on_commit.__nfs_commit_inode.nfs_file_fsync.do_fsync
      8915 ±  5%     -99.9%      12.23 ± 34%  perf-sched.wait_time.max.ms.worker_thread.kthread.ret_from_fork
      6995 ± 74%     -97.6%     168.50 ±121%  interrupts.31:PCI-MSI.524289-edge.eth0-TxRx-0
      8657 ± 48%     -95.1%     423.17 ±194%  interrupts.32:PCI-MSI.524290-edge.eth0-TxRx-1
    479290 ±198%    -100.0%     192.33 ± 68%  interrupts.33:PCI-MSI.524291-edge.eth0-TxRx-2
      3776 ± 49%     -95.9%     154.00 ±136%  interrupts.34:PCI-MSI.524292-edge.eth0-TxRx-3
      3119 ±  5%     -97.0%      93.67 ±  2%  interrupts.9:IO-APIC.9-fasteoi.acpi
   2479136 ± 27%     -96.3%      92643 ±  2%  interrupts.CPU0.LOC:Local_timer_interrupts
    169.20 ± 24%     -91.3%      14.67 ±100%  interrupts.CPU0.RES:Rescheduling_interrupts
      3119 ±  5%     -97.0%      93.67 ±  2%  interrupts.CPU1.9:IO-APIC.9-fasteoi.acpi
   2480043 ± 27%     -96.3%      92623 ±  2%  interrupts.CPU1.LOC:Local_timer_interrupts
      6995 ± 74%     -97.6%     168.50 ±121%  interrupts.CPU10.31:PCI-MSI.524289-edge.eth0-TxRx-0
   2477361 ± 27%     -96.3%      92587 ±  2%  interrupts.CPU10.LOC:Local_timer_interrupts
   2473510 ± 27%     -96.3%      92498 ±  2%  interrupts.CPU100.LOC:Local_timer_interrupts
    120.40 ± 66%     -84.9%      18.17 ±134%  interrupts.CPU100.RES:Rescheduling_interrupts
   2473575 ± 27%     -96.3%      92539 ±  2%  interrupts.CPU101.LOC:Local_timer_interrupts
     85.20 ± 48%     -82.2%      15.17 ±115%  interrupts.CPU101.RES:Rescheduling_interrupts
   2474712 ± 27%     -96.3%      92350        interrupts.CPU102.LOC:Local_timer_interrupts
    158.00 ± 96%     -94.0%       9.50 ±103%  interrupts.CPU102.RES:Rescheduling_interrupts
   2478244 ± 27%     -96.3%      92397        interrupts.CPU103.LOC:Local_timer_interrupts
    149.60 ± 43%     -85.0%      22.50 ±139%  interrupts.CPU103.RES:Rescheduling_interrupts
   2476514 ± 27%     -96.3%      92531 ±  2%  interrupts.CPU104.LOC:Local_timer_interrupts
    104.20 ± 52%     -84.8%      15.83 ±134%  interrupts.CPU104.RES:Rescheduling_interrupts
   2473292 ± 27%     -96.3%      92477 ±  2%  interrupts.CPU105.LOC:Local_timer_interrupts
   2477271 ± 27%     -96.3%      92492 ±  2%  interrupts.CPU106.LOC:Local_timer_interrupts
   2475378 ± 27%     -96.3%      92452 ±  2%  interrupts.CPU107.LOC:Local_timer_interrupts
   2632541 ± 22%     -96.5%      92548 ±  2%  interrupts.CPU108.LOC:Local_timer_interrupts
   2477205 ± 27%     -96.3%      92267 ±  2%  interrupts.CPU109.LOC:Local_timer_interrupts
     68.00 ± 63%     -70.1%      20.33 ±119%  interrupts.CPU109.RES:Rescheduling_interrupts
      8657 ± 48%     -95.1%     423.17 ±194%  interrupts.CPU11.32:PCI-MSI.524290-edge.eth0-TxRx-1
   2475490 ± 27%     -96.3%      92460 ±  2%  interrupts.CPU11.LOC:Local_timer_interrupts
    102.40 ± 62%     -78.7%      21.83 ±133%  interrupts.CPU11.RES:Rescheduling_interrupts
   2475821 ± 27%     -96.3%      92504 ±  2%  interrupts.CPU110.LOC:Local_timer_interrupts
   2474455 ± 27%     -96.3%      92434 ±  2%  interrupts.CPU111.LOC:Local_timer_interrupts
   2474902 ± 27%     -96.3%      92547 ±  2%  interrupts.CPU112.LOC:Local_timer_interrupts
   2473623 ± 27%     -96.3%      92328 ±  2%  interrupts.CPU113.LOC:Local_timer_interrupts
     95.20 ± 83%     -89.7%       9.83 ±122%  interrupts.CPU113.RES:Rescheduling_interrupts
   2473108 ± 27%     -96.3%      92527 ±  2%  interrupts.CPU114.LOC:Local_timer_interrupts
   2474468 ± 27%     -96.3%      92530 ±  2%  interrupts.CPU115.LOC:Local_timer_interrupts
   2473144 ± 27%     -96.3%      92491 ±  2%  interrupts.CPU116.LOC:Local_timer_interrupts
   2473379 ± 27%     -96.3%      92527 ±  2%  interrupts.CPU117.LOC:Local_timer_interrupts
     99.60 ± 66%     -91.8%       8.17 ±126%  interrupts.CPU117.RES:Rescheduling_interrupts
   2473153 ± 27%     -96.3%      92521 ±  2%  interrupts.CPU118.LOC:Local_timer_interrupts
     97.60 ± 69%     -92.0%       7.83 ±120%  interrupts.CPU118.RES:Rescheduling_interrupts
   2474277 ± 27%     -96.3%      92522 ±  2%  interrupts.CPU119.LOC:Local_timer_interrupts
    479290 ±198%    -100.0%     192.33 ± 68%  interrupts.CPU12.33:PCI-MSI.524291-edge.eth0-TxRx-2
   2632272 ± 22%     -96.5%      92364 ±  2%  interrupts.CPU12.LOC:Local_timer_interrupts
   2470989 ± 26%     -96.3%      91642 ±  3%  interrupts.CPU120.LOC:Local_timer_interrupts
   2478895 ± 26%     -96.3%      91656 ±  3%  interrupts.CPU121.LOC:Local_timer_interrupts
    266.60 ±133%     -98.5%       4.00 ±152%  interrupts.CPU121.RES:Rescheduling_interrupts
   2473778 ± 26%     -96.3%      91605 ±  3%  interrupts.CPU122.LOC:Local_timer_interrupts
     95.20 ± 51%     -90.7%       8.83 ±151%  interrupts.CPU122.RES:Rescheduling_interrupts
   2463404 ± 25%     -96.3%      91580 ±  3%  interrupts.CPU123.LOC:Local_timer_interrupts
    112.80 ± 75%     -97.0%       3.33 ±125%  interrupts.CPU123.RES:Rescheduling_interrupts
   2463922 ± 25%     -96.3%      91611 ±  4%  interrupts.CPU124.LOC:Local_timer_interrupts
   2465061 ± 25%     -96.3%      91466 ±  3%  interrupts.CPU125.LOC:Local_timer_interrupts
   2466642 ± 26%     -96.3%      91581 ±  3%  interrupts.CPU126.LOC:Local_timer_interrupts
   2474875 ± 25%     -96.3%      91574 ±  3%  interrupts.CPU127.LOC:Local_timer_interrupts
     65.80 ± 53%     -98.5%       1.00 ±115%  interrupts.CPU127.RES:Rescheduling_interrupts
   2469424 ± 25%     -96.3%      91592 ±  3%  interrupts.CPU128.LOC:Local_timer_interrupts
     73.20 ± 78%     -98.2%       1.33 ±127%  interrupts.CPU128.RES:Rescheduling_interrupts
   2480042 ± 25%     -96.3%      91615 ±  4%  interrupts.CPU129.LOC:Local_timer_interrupts
    176.00 ±111%     -91.3%      15.33 ±130%  interrupts.CPU129.RES:Rescheduling_interrupts
      3776 ± 49%     -95.9%     154.00 ±136%  interrupts.CPU13.34:PCI-MSI.524292-edge.eth0-TxRx-3
   2476972 ± 27%     -96.3%      92434 ±  2%  interrupts.CPU13.LOC:Local_timer_interrupts
   2474515 ± 25%     -96.3%      91586 ±  3%  interrupts.CPU130.LOC:Local_timer_interrupts
    101.40 ± 74%     -97.7%       2.33 ±101%  interrupts.CPU130.RES:Rescheduling_interrupts
   2469974 ± 25%     -96.3%      91614 ±  4%  interrupts.CPU131.LOC:Local_timer_interrupts
     99.40 ± 79%     -80.9%      19.00 ±136%  interrupts.CPU131.RES:Rescheduling_interrupts
     13821 ±104%     -91.3%       1205 ± 59%  interrupts.CPU132.CAL:Function_call_interrupts
   2498907 ± 24%     -96.3%      91639 ±  3%  interrupts.CPU132.LOC:Local_timer_interrupts
     98.20 ± 51%     -94.4%       5.50 ±161%  interrupts.CPU132.RES:Rescheduling_interrupts
   2477558 ± 26%     -96.3%      91585 ±  3%  interrupts.CPU133.LOC:Local_timer_interrupts
     74.60 ± 65%     -88.2%       8.83 ±123%  interrupts.CPU133.RES:Rescheduling_interrupts
   2472793 ± 26%     -96.3%      91599 ±  3%  interrupts.CPU134.LOC:Local_timer_interrupts
   2495309 ± 24%     -96.3%      91585 ±  3%  interrupts.CPU135.LOC:Local_timer_interrupts
     87.60 ± 74%     -95.6%       3.83 ±123%  interrupts.CPU135.RES:Rescheduling_interrupts
   2594196 ± 20%     -96.5%      91573 ±  3%  interrupts.CPU136.LOC:Local_timer_interrupts
   2465460 ± 25%     -96.3%      91625 ±  3%  interrupts.CPU137.LOC:Local_timer_interrupts
   2465830 ± 25%     -96.3%      91471 ±  3%  interrupts.CPU138.LOC:Local_timer_interrupts
   2465784 ± 26%     -96.3%      91625 ±  3%  interrupts.CPU139.LOC:Local_timer_interrupts
   2475863 ± 27%     -96.3%      92536 ±  2%  interrupts.CPU14.LOC:Local_timer_interrupts
     75.20 ± 45%     -84.0%      12.00 ±125%  interrupts.CPU14.RES:Rescheduling_interrupts
   2463344 ± 25%     -96.3%      91589 ±  3%  interrupts.CPU140.LOC:Local_timer_interrupts
   2464911 ± 25%     -96.3%      91575 ±  3%  interrupts.CPU141.LOC:Local_timer_interrupts
   2464351 ± 25%     -96.3%      91570 ±  3%  interrupts.CPU142.LOC:Local_timer_interrupts
   2467088 ± 25%     -96.3%      91632 ±  4%  interrupts.CPU143.LOC:Local_timer_interrupts
   2431084 ± 29%     -96.2%      92525 ±  2%  interrupts.CPU144.LOC:Local_timer_interrupts
    340.20 ± 74%     -95.2%      16.17 ±161%  interrupts.CPU144.RES:Rescheduling_interrupts
   2431023 ± 29%     -96.2%      92639 ±  2%  interrupts.CPU145.LOC:Local_timer_interrupts
   2432583 ± 29%     -96.2%      92561 ±  2%  interrupts.CPU146.LOC:Local_timer_interrupts
    140.00 ± 19%     -81.5%      25.83 ±123%  interrupts.CPU146.RES:Rescheduling_interrupts
   2417131 ± 29%     -96.2%      92584 ±  2%  interrupts.CPU147.LOC:Local_timer_interrupts
    222.40 ± 60%     -92.1%      17.50 ±149%  interrupts.CPU147.RES:Rescheduling_interrupts
   2417350 ± 29%     -96.2%      92586 ±  2%  interrupts.CPU148.LOC:Local_timer_interrupts
   2417460 ± 29%     -96.2%      92493 ±  2%  interrupts.CPU149.LOC:Local_timer_interrupts
   2473686 ± 27%     -96.3%      92474 ±  2%  interrupts.CPU15.LOC:Local_timer_interrupts
   2420957 ± 29%     -96.2%      92643 ±  2%  interrupts.CPU150.LOC:Local_timer_interrupts
   2430780 ± 29%     -96.2%      92552 ±  2%  interrupts.CPU151.LOC:Local_timer_interrupts
   2416301 ± 29%     -96.2%      92550 ±  2%  interrupts.CPU152.LOC:Local_timer_interrupts
   2428594 ± 29%     -96.2%      92602 ±  2%  interrupts.CPU153.LOC:Local_timer_interrupts
   2419468 ± 29%     -96.2%      92568 ±  2%  interrupts.CPU154.LOC:Local_timer_interrupts
   2422569 ± 29%     -96.2%      92637 ±  2%  interrupts.CPU155.LOC:Local_timer_interrupts
   2435950 ± 29%     -96.2%      92635 ±  2%  interrupts.CPU156.LOC:Local_timer_interrupts
   2423355 ± 29%     -96.2%      92583 ±  2%  interrupts.CPU157.LOC:Local_timer_interrupts
   2418634 ± 29%     -96.2%      92568 ±  2%  interrupts.CPU158.LOC:Local_timer_interrupts
   2428961 ± 29%     -96.2%      92596 ±  2%  interrupts.CPU159.LOC:Local_timer_interrupts
   2474750 ± 27%     -96.3%      92544 ±  2%  interrupts.CPU16.LOC:Local_timer_interrupts
   2417812 ± 29%     -96.2%      92605 ±  2%  interrupts.CPU160.LOC:Local_timer_interrupts
   2415950 ± 29%     -96.2%      92618 ±  2%  interrupts.CPU161.LOC:Local_timer_interrupts
   2442055 ± 29%     -96.2%      92624 ±  2%  interrupts.CPU162.LOC:Local_timer_interrupts
   2420436 ± 29%     -96.2%      92620 ±  2%  interrupts.CPU163.LOC:Local_timer_interrupts
   2415654 ± 29%     -96.2%      92569 ±  2%  interrupts.CPU164.LOC:Local_timer_interrupts
   2417173 ± 29%     -96.2%      92576 ±  2%  interrupts.CPU165.LOC:Local_timer_interrupts
   2416624 ± 29%     -96.2%      92594 ±  2%  interrupts.CPU166.LOC:Local_timer_interrupts
   2420804 ± 29%     -96.2%      92619 ±  2%  interrupts.CPU167.LOC:Local_timer_interrupts
   2439050 ± 28%     -96.2%      91480 ±  4%  interrupts.CPU168.LOC:Local_timer_interrupts
    298.20 ± 77%     -99.4%       1.67 ± 56%  interrupts.CPU168.RES:Rescheduling_interrupts
   2454595 ± 29%     -96.3%      91477 ±  4%  interrupts.CPU169.LOC:Local_timer_interrupts
   2473630 ± 27%     -96.3%      92477 ±  2%  interrupts.CPU17.LOC:Local_timer_interrupts
   2442426 ± 29%     -96.3%      91480 ±  4%  interrupts.CPU170.LOC:Local_timer_interrupts
     75.60 ± 44%     -99.3%       0.50 ±152%  interrupts.CPU170.RES:Rescheduling_interrupts
   2416816 ± 28%     -96.2%      91455 ±  4%  interrupts.CPU171.LOC:Local_timer_interrupts
   2416828 ± 28%     -96.2%      91456 ±  4%  interrupts.CPU172.LOC:Local_timer_interrupts
   2418686 ± 28%     -96.2%      91461 ±  4%  interrupts.CPU173.LOC:Local_timer_interrupts
   2422413 ± 28%     -96.2%      91463 ±  4%  interrupts.CPU174.LOC:Local_timer_interrupts
   2438157 ± 29%     -96.2%      91475 ±  4%  interrupts.CPU175.LOC:Local_timer_interrupts
   2426396 ± 29%     -96.2%      91476 ±  4%  interrupts.CPU176.LOC:Local_timer_interrupts
   2415799 ± 28%     -96.2%      91508 ±  4%  interrupts.CPU177.LOC:Local_timer_interrupts
   2434955 ± 29%     -96.2%      91468 ±  4%  interrupts.CPU178.LOC:Local_timer_interrupts
   2420382 ± 28%     -96.2%      91459 ±  4%  interrupts.CPU179.LOC:Local_timer_interrupts
   2473020 ± 27%     -96.3%      92567 ±  2%  interrupts.CPU18.LOC:Local_timer_interrupts
   2425955 ± 28%     -96.2%      91483 ±  4%  interrupts.CPU180.LOC:Local_timer_interrupts
   2446414 ± 29%     -96.3%      91474 ±  4%  interrupts.CPU181.LOC:Local_timer_interrupts
   2440224 ± 29%     -96.3%      91464 ±  4%  interrupts.CPU182.LOC:Local_timer_interrupts
   2420378 ± 28%     -96.2%      91462 ±  4%  interrupts.CPU183.LOC:Local_timer_interrupts
   2435068 ± 29%     -96.2%      91468 ±  4%  interrupts.CPU184.LOC:Local_timer_interrupts
   2418817 ± 28%     -96.2%      91462 ±  4%  interrupts.CPU185.LOC:Local_timer_interrupts
   2416254 ± 28%     -96.2%      91457 ±  4%  interrupts.CPU186.LOC:Local_timer_interrupts
   2424681 ± 29%     -96.2%      91466 ±  4%  interrupts.CPU187.LOC:Local_timer_interrupts
   2415055 ± 28%     -96.2%      91462 ±  4%  interrupts.CPU188.LOC:Local_timer_interrupts
   2417687 ± 28%     -96.2%      91456 ±  4%  interrupts.CPU189.LOC:Local_timer_interrupts
   2474110 ± 27%     -96.3%      92538 ±  2%  interrupts.CPU19.LOC:Local_timer_interrupts
   2416830 ± 28%     -96.2%      91453 ±  4%  interrupts.CPU190.LOC:Local_timer_interrupts
   2426483 ± 28%     -96.2%      91502 ±  4%  interrupts.CPU191.LOC:Local_timer_interrupts
   2478855 ± 27%     -96.3%      92614 ±  2%  interrupts.CPU2.LOC:Local_timer_interrupts
   2473293 ± 27%     -96.3%      92588 ±  2%  interrupts.CPU20.LOC:Local_timer_interrupts
   2473525 ± 27%     -96.3%      92522 ±  2%  interrupts.CPU21.LOC:Local_timer_interrupts
   2473188 ± 27%     -96.3%      92534 ±  2%  interrupts.CPU22.LOC:Local_timer_interrupts
   2474159 ± 27%     -96.3%      92372 ±  2%  interrupts.CPU23.LOC:Local_timer_interrupts
   2470875 ± 26%     -96.3%      91610 ±  3%  interrupts.CPU24.LOC:Local_timer_interrupts
   2478561 ± 26%     -96.3%      91618 ±  3%  interrupts.CPU25.LOC:Local_timer_interrupts
   2473719 ± 26%     -96.3%      91598 ±  3%  interrupts.CPU26.LOC:Local_timer_interrupts
    112.20 ± 72%     -89.0%      12.33 ±115%  interrupts.CPU26.RES:Rescheduling_interrupts
   2463367 ± 25%     -96.3%      91589 ±  3%  interrupts.CPU27.LOC:Local_timer_interrupts
   2463832 ± 25%     -96.3%      91586 ±  3%  interrupts.CPU28.LOC:Local_timer_interrupts
   2465045 ± 25%     -96.3%      91574 ±  3%  interrupts.CPU29.LOC:Local_timer_interrupts
   2473885 ± 27%     -96.3%      92510 ±  2%  interrupts.CPU3.LOC:Local_timer_interrupts
   2466560 ± 26%     -96.3%      91598 ±  3%  interrupts.CPU30.LOC:Local_timer_interrupts
   2474769 ± 25%     -96.3%      91623 ±  3%  interrupts.CPU31.LOC:Local_timer_interrupts
   2469291 ± 25%     -96.3%      91625 ±  3%  interrupts.CPU32.LOC:Local_timer_interrupts
   2480105 ± 25%     -96.3%      91608 ±  4%  interrupts.CPU33.LOC:Local_timer_interrupts
   2474620 ± 25%     -96.3%      91619 ±  3%  interrupts.CPU34.LOC:Local_timer_interrupts
    166.80 ±111%     -87.0%      21.67 ±158%  interrupts.CPU34.RES:Rescheduling_interrupts
   2469982 ± 25%     -96.3%      91583 ±  3%  interrupts.CPU35.LOC:Local_timer_interrupts
   2499017 ± 24%     -96.3%      91621 ±  3%  interrupts.CPU36.LOC:Local_timer_interrupts
    112.60 ± 84%     -77.1%      25.83 ±157%  interrupts.CPU36.RES:Rescheduling_interrupts
   2477210 ± 26%     -96.3%      91640 ±  3%  interrupts.CPU37.LOC:Local_timer_interrupts
   2472582 ± 26%     -96.3%      91600 ±  3%  interrupts.CPU38.LOC:Local_timer_interrupts
   2495199 ± 24%     -96.3%      91591 ±  3%  interrupts.CPU39.LOC:Local_timer_interrupts
   2473223 ± 27%     -96.3%      92536 ±  2%  interrupts.CPU4.LOC:Local_timer_interrupts
    277.40 ±101%     -89.3%      29.67 ±132%  interrupts.CPU4.RES:Rescheduling_interrupts
   2593976 ± 20%     -96.5%      91588 ±  3%  interrupts.CPU40.LOC:Local_timer_interrupts
   2465263 ± 25%     -96.3%      91609 ±  3%  interrupts.CPU41.LOC:Local_timer_interrupts
     72.00 ± 90%     -78.0%      15.83 ±166%  interrupts.CPU41.RES:Rescheduling_interrupts
   2465776 ± 25%     -96.3%      91532 ±  3%  interrupts.CPU42.LOC:Local_timer_interrupts
   2465287 ± 26%     -96.3%      91606 ±  3%  interrupts.CPU43.LOC:Local_timer_interrupts
   2463289 ± 25%     -96.3%      91648 ±  3%  interrupts.CPU44.LOC:Local_timer_interrupts
   2464815 ± 25%     -96.3%      91595 ±  3%  interrupts.CPU45.LOC:Local_timer_interrupts
   2464123 ± 25%     -96.3%      91599 ±  3%  interrupts.CPU46.LOC:Local_timer_interrupts
   2466982 ± 25%     -96.3%      91640 ±  3%  interrupts.CPU47.LOC:Local_timer_interrupts
   2430954 ± 29%     -96.2%      92609 ±  2%  interrupts.CPU48.LOC:Local_timer_interrupts
   2430339 ± 29%     -96.2%      92608 ±  2%  interrupts.CPU49.LOC:Local_timer_interrupts
   2473144 ± 27%     -96.3%      92587 ±  2%  interrupts.CPU5.LOC:Local_timer_interrupts
   2432444 ± 29%     -96.2%      92495 ±  2%  interrupts.CPU50.LOC:Local_timer_interrupts
     68.20 ± 30%     -77.3%      15.50 ± 98%  interrupts.CPU50.RES:Rescheduling_interrupts
   2417079 ± 29%     -96.2%      92640 ±  2%  interrupts.CPU51.LOC:Local_timer_interrupts
   2417394 ± 29%     -96.2%      92511 ±  2%  interrupts.CPU52.LOC:Local_timer_interrupts
   2417419 ± 29%     -96.2%      92609 ±  2%  interrupts.CPU53.LOC:Local_timer_interrupts
   2420917 ± 29%     -96.2%      92597 ±  2%  interrupts.CPU54.LOC:Local_timer_interrupts
   2430695 ± 29%     -96.2%      92576 ±  2%  interrupts.CPU55.LOC:Local_timer_interrupts
   2416299 ± 29%     -96.2%      92641 ±  2%  interrupts.CPU56.LOC:Local_timer_interrupts
   2428557 ± 29%     -96.2%      92600 ±  2%  interrupts.CPU57.LOC:Local_timer_interrupts
   2419441 ± 29%     -96.2%      92621 ±  2%  interrupts.CPU58.LOC:Local_timer_interrupts
   2422669 ± 29%     -96.2%      92602 ±  2%  interrupts.CPU59.LOC:Local_timer_interrupts
   2474476 ± 27%     -96.3%      92515 ±  2%  interrupts.CPU6.LOC:Local_timer_interrupts
   2435703 ± 29%     -96.2%      92623 ±  2%  interrupts.CPU60.LOC:Local_timer_interrupts
   2423257 ± 29%     -96.2%      92621 ±  2%  interrupts.CPU61.LOC:Local_timer_interrupts
    239.60 ±118%     -70.6%      70.50 ± 39%  interrupts.CPU61.NMI:Non-maskable_interrupts
    239.60 ±118%     -70.6%      70.50 ± 39%  interrupts.CPU61.PMI:Performance_monitoring_interrupts
   2418490 ± 29%     -96.2%      92558 ±  2%  interrupts.CPU62.LOC:Local_timer_interrupts
   2428783 ± 29%     -96.2%      92634 ±  2%  interrupts.CPU63.LOC:Local_timer_interrupts
   2417869 ± 29%     -96.2%      92598 ±  2%  interrupts.CPU64.LOC:Local_timer_interrupts
   2415973 ± 29%     -96.2%      92644 ±  2%  interrupts.CPU65.LOC:Local_timer_interrupts
   2442061 ± 29%     -96.2%      92626 ±  2%  interrupts.CPU66.LOC:Local_timer_interrupts
   2420394 ± 29%     -96.2%      92643 ±  2%  interrupts.CPU67.LOC:Local_timer_interrupts
   2415672 ± 29%     -96.2%      92593 ±  2%  interrupts.CPU68.LOC:Local_timer_interrupts
   2417141 ± 29%     -96.2%      92590 ±  2%  interrupts.CPU69.LOC:Local_timer_interrupts
   2477867 ± 27%     -96.3%      92524 ±  2%  interrupts.CPU7.LOC:Local_timer_interrupts
   2416607 ± 29%     -96.2%      92631 ±  2%  interrupts.CPU70.LOC:Local_timer_interrupts
   2420734 ± 29%     -96.2%      92624 ±  2%  interrupts.CPU71.LOC:Local_timer_interrupts
   2438569 ± 28%     -96.2%      91522 ±  4%  interrupts.CPU72.LOC:Local_timer_interrupts
    161.60 ±122%     -98.0%       3.17 ± 33%  interrupts.CPU72.RES:Rescheduling_interrupts
   2454587 ± 29%     -96.3%      91535 ±  4%  interrupts.CPU73.LOC:Local_timer_interrupts
     63.00 ± 47%     -98.7%       0.83 ±107%  interrupts.CPU73.RES:Rescheduling_interrupts
   2442010 ± 29%     -96.3%      91521 ±  4%  interrupts.CPU74.LOC:Local_timer_interrupts
   2416556 ± 28%     -96.2%      91482 ±  4%  interrupts.CPU75.LOC:Local_timer_interrupts
   2416460 ± 28%     -96.2%      91480 ±  4%  interrupts.CPU76.LOC:Local_timer_interrupts
   2418591 ± 28%     -96.2%      91490 ±  4%  interrupts.CPU77.LOC:Local_timer_interrupts
   2422272 ± 28%     -96.2%      91487 ±  4%  interrupts.CPU78.LOC:Local_timer_interrupts
   2438073 ± 29%     -96.2%      91500 ±  4%  interrupts.CPU79.LOC:Local_timer_interrupts
   2476530 ± 27%     -96.3%      92545 ±  2%  interrupts.CPU8.LOC:Local_timer_interrupts
    133.20 ± 66%     -83.2%      22.33 ±110%  interrupts.CPU8.RES:Rescheduling_interrupts
   2426325 ± 29%     -96.2%      91500 ±  4%  interrupts.CPU80.LOC:Local_timer_interrupts
   2415391 ± 28%     -96.2%      91478 ±  4%  interrupts.CPU81.LOC:Local_timer_interrupts
   2434731 ± 29%     -96.2%      91483 ±  4%  interrupts.CPU82.LOC:Local_timer_interrupts
   2419977 ± 28%     -96.2%      91484 ±  4%  interrupts.CPU83.LOC:Local_timer_interrupts
   2425765 ± 28%     -96.2%      91486 ±  4%  interrupts.CPU84.LOC:Local_timer_interrupts
   2446200 ± 29%     -96.3%      91513 ±  4%  interrupts.CPU85.LOC:Local_timer_interrupts
   2440188 ± 29%     -96.3%      91492 ±  4%  interrupts.CPU86.LOC:Local_timer_interrupts
   2419902 ± 28%     -96.2%      91480 ±  4%  interrupts.CPU87.LOC:Local_timer_interrupts
   2435141 ± 29%     -96.2%      91519 ±  4%  interrupts.CPU88.LOC:Local_timer_interrupts
   2418690 ± 28%     -96.2%      91479 ±  4%  interrupts.CPU89.LOC:Local_timer_interrupts
   2473292 ± 27%     -96.3%      92498 ±  2%  interrupts.CPU9.LOC:Local_timer_interrupts
    119.80 ± 54%     -79.3%      24.83 ±123%  interrupts.CPU9.RES:Rescheduling_interrupts
   2416104 ± 28%     -96.2%      91473 ±  4%  interrupts.CPU90.LOC:Local_timer_interrupts
   2424713 ± 29%     -96.2%      91480 ±  4%  interrupts.CPU91.LOC:Local_timer_interrupts
   2414557 ± 28%     -96.2%      91470 ±  4%  interrupts.CPU92.LOC:Local_timer_interrupts
   2417449 ± 28%     -96.2%      91475 ±  4%  interrupts.CPU93.LOC:Local_timer_interrupts
   2416626 ± 28%     -96.2%      91482 ±  4%  interrupts.CPU94.LOC:Local_timer_interrupts
   2426393 ± 28%     -96.2%      91536 ±  4%  interrupts.CPU95.LOC:Local_timer_interrupts
   2479120 ± 27%     -96.3%      92519 ±  2%  interrupts.CPU96.LOC:Local_timer_interrupts
    176.80 ± 95%     -96.6%       6.00 ± 83%  interrupts.CPU96.RES:Rescheduling_interrupts
   2479919 ± 27%     -96.3%      92449 ±  2%  interrupts.CPU97.LOC:Local_timer_interrupts
   2472911 ± 27%     -96.3%      92510 ±  2%  interrupts.CPU98.LOC:Local_timer_interrupts
   2474244 ± 27%     -96.3%      92528 ±  2%  interrupts.CPU99.LOC:Local_timer_interrupts
 4.708e+08 ± 27%     -96.2%   17672599 ±  3%  interrupts.LOC:Local_timer_interrupts
    844.80 ± 11%    -100.0%       0.00        interrupts.MCP:Machine_check_polls
     13739 ± 13%     -83.2%       2305 ±  9%  interrupts.RES:Rescheduling_interrupts
    114639 ± 15%     -91.1%      10256 ± 13%  softirqs.CPU0.RCU
    202352 ±  6%     -93.7%      12707 ±  4%  softirqs.CPU0.SCHED
    115827 ± 20%     -93.6%       7433 ± 25%  softirqs.CPU1.RCU
    200212 ±  7%     -94.1%      11860 ± 28%  softirqs.CPU1.SCHED
    118248 ± 17%     -93.3%       7937 ± 25%  softirqs.CPU10.RCU
    199604 ±  7%     -95.5%       9065 ± 18%  softirqs.CPU10.SCHED
    121607 ± 21%     -93.7%       7631 ± 21%  softirqs.CPU100.RCU
    200147 ±  7%     -96.1%       7828 ± 13%  softirqs.CPU100.SCHED
    122615 ± 21%     -93.6%       7820 ± 28%  softirqs.CPU101.RCU
    200466 ±  7%     -96.0%       8096 ±  6%  softirqs.CPU101.SCHED
    121752 ± 20%     -93.7%       7675 ± 23%  softirqs.CPU102.RCU
    199575 ±  7%     -95.9%       8265 ±  9%  softirqs.CPU102.SCHED
    121229 ± 21%     -93.7%       7615 ± 23%  softirqs.CPU103.RCU
    199073 ±  7%     -96.1%       7705 ± 14%  softirqs.CPU103.SCHED
    121592 ± 21%     -93.8%       7570 ± 20%  softirqs.CPU104.RCU
    198713 ±  8%     -96.2%       7513 ± 11%  softirqs.CPU104.SCHED
    118061 ± 24%     -93.4%       7755 ± 20%  softirqs.CPU105.RCU
    196209 ± 10%     -96.1%       7654 ±  8%  softirqs.CPU105.SCHED
    118745 ± 17%     -93.8%       7382 ± 23%  softirqs.CPU106.RCU
    176665 ± 20%     -95.4%       8204 ±  4%  softirqs.CPU106.SCHED
    119698 ± 17%     -93.7%       7521 ± 23%  softirqs.CPU107.RCU
    200088 ±  7%     -95.9%       8291 ±  3%  softirqs.CPU107.SCHED
    110053 ±  9%     -93.0%       7655 ± 23%  softirqs.CPU108.RCU
    182459 ± 23%     -95.5%       8166 ±  5%  softirqs.CPU108.SCHED
    118259 ± 20%     -93.8%       7326 ± 18%  softirqs.CPU109.RCU
    198136 ±  8%     -96.0%       7891 ±  5%  softirqs.CPU109.SCHED
    118777 ± 17%     -93.7%       7478 ± 20%  softirqs.CPU11.RCU
    200203 ±  7%     -95.7%       8572 ±  8%  softirqs.CPU11.SCHED
      3205 ±111%     -96.0%     127.50 ±117%  softirqs.CPU11.TIMER
    120442 ± 18%     -93.6%       7768 ± 15%  softirqs.CPU110.RCU
    169582 ± 32%     -95.3%       8010 ±  5%  softirqs.CPU110.SCHED
    117929 ± 19%     -92.8%       8519 ± 37%  softirqs.CPU111.RCU
    200456 ±  7%     -95.9%       8156 ±  5%  softirqs.CPU111.SCHED
    104335 ± 17%     -94.0%       6294 ± 15%  softirqs.CPU112.RCU
    199851 ±  7%     -95.9%       8213 ±  4%  softirqs.CPU112.SCHED
    107355 ± 17%     -94.2%       6238 ± 22%  softirqs.CPU113.RCU
    200416 ±  7%     -96.1%       7764 ± 11%  softirqs.CPU113.SCHED
    106762 ± 15%     -93.9%       6464 ± 22%  softirqs.CPU114.RCU
    200283 ±  7%     -95.8%       8415 ±  5%  softirqs.CPU114.SCHED
    103754 ± 17%     -93.2%       7034 ± 23%  softirqs.CPU115.RCU
    196602 ±  7%     -95.8%       8289 ±  6%  softirqs.CPU115.SCHED
    109225 ± 18%     -94.1%       6489 ± 24%  softirqs.CPU116.RCU
    179557 ± 18%     -95.4%       8265 ±  4%  softirqs.CPU116.SCHED
    105415 ± 13%     -93.8%       6585 ± 26%  softirqs.CPU117.RCU
    199671 ±  7%     -96.1%       7705 ± 15%  softirqs.CPU117.SCHED
    109175 ± 18%     -92.6%       8119 ± 37%  softirqs.CPU118.RCU
    200097 ±  7%     -95.9%       8163 ±  6%  softirqs.CPU118.SCHED
    106082 ± 19%     -93.8%       6595 ± 20%  softirqs.CPU119.RCU
    184185 ± 16%     -95.6%       8088 ±  7%  softirqs.CPU119.SCHED
    108809 ± 11%     -92.9%       7759 ± 24%  softirqs.CPU12.RCU
    201639 ±  6%     -96.0%       8015 ± 14%  softirqs.CPU12.SCHED
    115871 ± 21%     -94.1%       6831 ± 22%  softirqs.CPU120.RCU
    187236 ±  6%     -95.4%       8633 ± 10%  softirqs.CPU120.SCHED
    104625 ± 22%     -94.2%       6078 ± 15%  softirqs.CPU121.RCU
    185460 ±  7%     -95.8%       7856 ± 15%  softirqs.CPU121.SCHED
    112112 ± 22%     -94.3%       6384 ± 17%  softirqs.CPU122.RCU
    172296 ± 22%     -95.3%       8132 ±  5%  softirqs.CPU122.SCHED
    113687 ± 20%     -94.2%       6551 ± 21%  softirqs.CPU123.RCU
    189038 ±  6%     -95.7%       8183 ±  4%  softirqs.CPU123.SCHED
    114949 ± 20%     -94.3%       6505 ± 20%  softirqs.CPU124.RCU
    191135 ±  7%     -95.6%       8336 ±  2%  softirqs.CPU124.SCHED
    115576 ± 20%     -94.2%       6709 ± 20%  softirqs.CPU125.RCU
    190280 ±  7%     -95.8%       8070 ±  6%  softirqs.CPU125.SCHED
    115293 ± 20%     -94.2%       6743 ± 21%  softirqs.CPU126.RCU
    189132 ±  7%     -96.0%       7591 ± 18%  softirqs.CPU126.SCHED
    110374 ± 19%     -94.2%       6429 ± 21%  softirqs.CPU127.RCU
    186369 ±  7%     -95.8%       7839 ± 12%  softirqs.CPU127.SCHED
    132501 ± 22%     -94.1%       7813 ± 18%  softirqs.CPU128.RCU
    188067 ±  7%     -96.0%       7607 ± 18%  softirqs.CPU128.SCHED
    133899 ± 20%     -94.2%       7778 ± 22%  softirqs.CPU129.RCU
    191491 ±  7%     -95.7%       8214 ±  2%  softirqs.CPU129.SCHED
    118861 ± 19%     -93.5%       7675 ± 20%  softirqs.CPU13.RCU
    199315 ±  7%     -96.0%       7906 ± 11%  softirqs.CPU13.SCHED
    127851 ± 22%     -93.5%       8323 ± 27%  softirqs.CPU130.RCU
    186929 ±  7%     -95.6%       8279 ±  2%  softirqs.CPU130.SCHED
    131544 ± 16%     -93.7%       8308 ± 20%  softirqs.CPU131.RCU
    189367 ±  7%     -95.4%       8749 ±  5%  softirqs.CPU131.SCHED
    134734 ± 23%     -94.0%       8120 ± 19%  softirqs.CPU132.RCU
    188914 ±  6%     -95.7%       8066 ±  7%  softirqs.CPU132.SCHED
    119525 ± 23%     -93.7%       7520 ± 15%  softirqs.CPU133.RCU
    167534 ± 17%     -95.0%       8421 ± 11%  softirqs.CPU133.SCHED
    125804 ± 23%     -93.4%       8350 ± 24%  softirqs.CPU134.RCU
    186270 ±  7%     -95.6%       8227 ±  6%  softirqs.CPU134.SCHED
    134624 ± 22%     -94.0%       8080 ± 21%  softirqs.CPU135.RCU
    190369 ±  7%     -95.9%       7784 ± 11%  softirqs.CPU135.SCHED
    123685 ± 16%     -93.3%       8271 ± 15%  softirqs.CPU136.RCU
    189047 ±  7%     -95.5%       8469 ±  3%  softirqs.CPU136.SCHED
    135832 ± 19%     -94.0%       8208 ± 16%  softirqs.CPU137.RCU
    189829 ±  7%     -95.8%       7950 ± 14%  softirqs.CPU137.SCHED
    138825 ± 22%     -93.7%       8782 ± 21%  softirqs.CPU138.RCU
    190627 ±  7%     -95.6%       8335 ±  3%  softirqs.CPU138.SCHED
    134603 ± 21%     -94.0%       8023 ± 22%  softirqs.CPU139.RCU
    188583 ±  7%     -95.5%       8397 ±  4%  softirqs.CPU139.SCHED
    117710 ± 18%     -93.7%       7384 ± 24%  softirqs.CPU14.RCU
    198966 ±  7%     -96.0%       8025 ± 15%  softirqs.CPU14.SCHED
    138263 ± 23%     -94.0%       8271 ± 24%  softirqs.CPU140.RCU
    190554 ±  7%     -95.7%       8196 ±  3%  softirqs.CPU140.SCHED
    133088 ± 21%     -94.0%       8015 ± 16%  softirqs.CPU141.RCU
    189689 ±  7%     -96.0%       7550 ± 11%  softirqs.CPU141.SCHED
    137424 ± 24%     -94.2%       8007 ± 19%  softirqs.CPU142.RCU
    190126 ±  7%     -95.9%       7815 ±  3%  softirqs.CPU142.SCHED
    133043 ± 23%     -94.1%       7879 ± 20%  softirqs.CPU143.RCU
    188460 ±  7%     -95.7%       8121 ±  6%  softirqs.CPU143.SCHED
    128064 ± 21%     -94.2%       7393 ± 22%  softirqs.CPU144.RCU
    162010 ± 32%     -95.3%       7680 ± 16%  softirqs.CPU144.SCHED
    123735 ± 21%     -94.3%       7053 ± 15%  softirqs.CPU145.RCU
    186803 ±  7%     -95.5%       8374 ±  2%  softirqs.CPU145.SCHED
    122143 ± 19%     -93.7%       7648 ± 13%  softirqs.CPU146.RCU
    187188 ±  6%     -95.4%       8521 ±  2%  softirqs.CPU146.SCHED
    127379 ± 25%     -93.8%       7880 ± 18%  softirqs.CPU147.RCU
    190123 ±  6%     -96.2%       7249 ± 21%  softirqs.CPU147.SCHED
      3927 ±176%     -99.2%      32.33 ± 70%  softirqs.CPU147.TIMER
    131985 ± 22%     -94.0%       7894 ± 16%  softirqs.CPU148.RCU
    189361 ±  6%     -95.5%       8613 ±  4%  softirqs.CPU148.SCHED
    135826 ± 23%     -94.3%       7800 ± 19%  softirqs.CPU149.RCU
    188769 ±  6%     -95.6%       8365        softirqs.CPU149.SCHED
    119640 ± 18%     -93.5%       7752 ± 19%  softirqs.CPU15.RCU
    182693 ± 19%     -95.4%       8313 ±  5%  softirqs.CPU15.SCHED
    137963 ± 22%     -94.2%       7989 ± 17%  softirqs.CPU150.RCU
    187983 ±  6%     -95.3%       8873 ± 10%  softirqs.CPU150.SCHED
    131531 ± 21%     -94.3%       7520 ± 19%  softirqs.CPU151.RCU
    172595 ± 21%     -95.2%       8344 ±  3%  softirqs.CPU151.SCHED
    135176 ± 24%     -94.4%       7618 ± 14%  softirqs.CPU152.RCU
    189486 ±  6%     -95.5%       8499        softirqs.CPU152.SCHED
    132685 ± 21%     -95.0%       6608 ± 22%  softirqs.CPU153.RCU
    186933 ±  6%     -95.5%       8484        softirqs.CPU153.SCHED
    138226 ± 23%     -94.5%       7615 ± 15%  softirqs.CPU154.RCU
    188551 ±  6%     -95.6%       8242 ±  5%  softirqs.CPU154.SCHED
    139414 ± 23%     -94.4%       7831 ± 17%  softirqs.CPU155.RCU
    187964 ±  6%     -95.6%       8235 ±  7%  softirqs.CPU155.SCHED
    123766 ± 23%     -94.1%       7274 ± 12%  softirqs.CPU156.RCU
    186308 ±  6%     -95.5%       8435        softirqs.CPU156.SCHED
    134065 ± 25%     -94.1%       7969 ± 17%  softirqs.CPU157.RCU
    187777 ±  6%     -95.6%       8239 ±  2%  softirqs.CPU157.SCHED
    132114 ± 25%     -94.2%       7629 ± 15%  softirqs.CPU158.RCU
    189457 ±  6%     -95.6%       8378 ±  2%  softirqs.CPU158.SCHED
    132722 ± 21%     -94.1%       7796 ± 20%  softirqs.CPU159.RCU
    187068 ±  6%     -95.5%       8382 ±  2%  softirqs.CPU159.SCHED
    104880 ± 17%     -93.3%       7056 ± 24%  softirqs.CPU16.RCU
    200874 ±  6%     -95.7%       8583 ±  6%  softirqs.CPU16.SCHED
    119591 ± 18%     -93.9%       7263 ± 10%  softirqs.CPU160.RCU
    188838 ±  6%     -95.5%       8438        softirqs.CPU160.SCHED
    125599 ± 23%     -94.2%       7253 ± 12%  softirqs.CPU161.RCU
    189592 ±  6%     -95.3%       8884 ±  8%  softirqs.CPU161.SCHED
    103701 ± 22%     -93.5%       6762 ± 10%  softirqs.CPU162.RCU
    186093 ±  6%     -95.4%       8491 ±  2%  softirqs.CPU162.SCHED
    122399 ± 24%     -93.9%       7495 ±  7%  softirqs.CPU163.RCU
    187528 ±  6%     -95.4%       8537 ±  2%  softirqs.CPU163.SCHED
    126829 ± 23%     -93.9%       7707 ±  9%  softirqs.CPU164.RCU
    189973 ±  6%     -95.5%       8587 ±  4%  softirqs.CPU164.SCHED
    123103 ± 23%     -94.1%       7262 ± 11%  softirqs.CPU165.RCU
    189130 ±  6%     -95.6%       8402        softirqs.CPU165.SCHED
    125855 ± 24%     -94.2%       7354 ± 12%  softirqs.CPU166.RCU
    189274 ±  6%     -95.5%       8453 ±  2%  softirqs.CPU166.SCHED
    120642 ± 24%     -94.0%       7205 ± 12%  softirqs.CPU167.RCU
    187802 ±  6%     -95.5%       8536        softirqs.CPU167.SCHED
    112570 ± 21%     -94.1%       6646 ± 18%  softirqs.CPU168.RCU
    179101 ±  9%     -95.4%       8232 ±  3%  softirqs.CPU168.SCHED
    103590 ± 22%     -93.8%       6426 ± 13%  softirqs.CPU169.RCU
    171305 ± 16%     -95.2%       8162 ±  5%  softirqs.CPU169.SCHED
    108245 ± 17%     -92.9%       7694 ± 22%  softirqs.CPU17.RCU
    182104 ± 21%     -95.7%       7881 ± 11%  softirqs.CPU17.SCHED
    110575 ± 21%     -94.3%       6250 ± 13%  softirqs.CPU170.RCU
    186410 ±  6%     -95.9%       7613 ± 13%  softirqs.CPU170.SCHED
    112046 ± 22%     -94.3%       6392 ± 17%  softirqs.CPU171.RCU
    190154 ±  5%     -95.7%       8158 ±  3%  softirqs.CPU171.SCHED
    113062 ± 22%     -94.2%       6527 ± 17%  softirqs.CPU172.RCU
    189596 ±  6%     -95.7%       8213 ±  2%  softirqs.CPU172.SCHED
    113073 ± 24%     -94.3%       6393 ± 17%  softirqs.CPU173.RCU
    188326 ±  6%     -95.6%       8229 ±  2%  softirqs.CPU173.SCHED
    113475 ± 24%     -94.3%       6514 ± 18%  softirqs.CPU174.RCU
    187664 ±  6%     -95.7%       8159 ±  2%  softirqs.CPU174.SCHED
    110632 ± 22%     -94.3%       6359 ± 17%  softirqs.CPU175.RCU
    186252 ±  6%     -95.6%       8145 ±  3%  softirqs.CPU175.SCHED
    126075 ± 23%     -94.5%       6924 ± 21%  softirqs.CPU176.RCU
    186379 ±  6%     -95.7%       8046 ±  3%  softirqs.CPU176.SCHED
    128577 ± 23%     -94.5%       7105 ± 25%  softirqs.CPU177.RCU
    189175 ±  6%     -95.7%       8221 ±  2%  softirqs.CPU177.SCHED
    122675 ± 21%     -94.2%       7096 ± 23%  softirqs.CPU178.RCU
    186073 ±  6%     -95.6%       8187 ±  3%  softirqs.CPU178.SCHED
    130297 ± 23%     -94.4%       7273 ± 25%  softirqs.CPU179.RCU
    188311 ±  6%     -95.7%       8030 ±  6%  softirqs.CPU179.SCHED
    108064 ± 16%     -93.6%       6897 ± 23%  softirqs.CPU18.RCU
    200738 ±  6%     -95.8%       8402 ±  2%  softirqs.CPU18.SCHED
    130009 ± 23%     -94.4%       7319 ± 24%  softirqs.CPU180.RCU
    186864 ±  6%     -95.7%       8074 ±  5%  softirqs.CPU180.SCHED
    115469 ± 23%     -94.0%       6916 ± 18%  softirqs.CPU181.RCU
    185364 ±  6%     -95.6%       8238 ±  3%  softirqs.CPU181.SCHED
    119056 ± 21%     -93.9%       7280 ± 20%  softirqs.CPU182.RCU
    186370 ±  6%     -95.7%       8035 ±  5%  softirqs.CPU182.SCHED
    126789 ± 22%     -94.3%       7192 ± 24%  softirqs.CPU183.RCU
    189023 ±  6%     -95.9%       7837 ± 11%  softirqs.CPU183.SCHED
    122064 ± 22%     -94.5%       6738 ± 18%  softirqs.CPU184.RCU
    185917 ±  6%     -95.7%       8063 ±  4%  softirqs.CPU184.SCHED
    129159 ± 22%     -94.4%       7218 ± 23%  softirqs.CPU185.RCU
    188777 ±  6%     -95.7%       8050 ±  5%  softirqs.CPU185.SCHED
    129511 ± 22%     -94.5%       7142 ± 24%  softirqs.CPU186.RCU
    189175 ±  6%     -95.7%       8137 ±  2%  softirqs.CPU186.SCHED
    126435 ± 22%     -94.0%       7578 ± 23%  softirqs.CPU187.RCU
    186969 ±  6%     -95.6%       8169 ±  3%  softirqs.CPU187.SCHED
    128196 ± 24%     -94.2%       7478 ± 21%  softirqs.CPU188.RCU
    189483 ±  6%     -95.7%       8066 ±  3%  softirqs.CPU188.SCHED
    127977 ± 23%     -94.5%       7015 ± 21%  softirqs.CPU189.RCU
    188892 ±  6%     -95.7%       8052 ±  5%  softirqs.CPU189.SCHED
    105983 ± 17%     -93.6%       6768 ± 18%  softirqs.CPU19.RCU
    200958 ±  6%     -95.9%       8268 ±  6%  softirqs.CPU19.SCHED
    128517 ± 24%     -94.4%       7260 ± 23%  softirqs.CPU190.RCU
    189204 ±  6%     -95.7%       8214 ±  2%  softirqs.CPU190.SCHED
    121410 ± 21%     -94.3%       6883 ± 19%  softirqs.CPU191.RCU
    121111 ± 29%     -94.7%       6460 ± 19%  softirqs.CPU191.SCHED
    116473 ± 23%     -93.1%       8064 ± 26%  softirqs.CPU2.RCU
    200706 ±  7%     -94.7%      10551 ± 38%  softirqs.CPU2.SCHED
    109077 ± 17%     -93.5%       7048 ± 21%  softirqs.CPU20.RCU
    200289 ±  7%     -96.0%       8061 ± 13%  softirqs.CPU20.SCHED
    102060 ± 17%     -92.6%       7570 ± 25%  softirqs.CPU21.RCU
    167380 ± 39%     -94.9%       8612 ±  3%  softirqs.CPU21.SCHED
    109115 ± 17%     -93.6%       6947 ± 21%  softirqs.CPU22.RCU
    180286 ± 18%     -95.5%       8126 ± 14%  softirqs.CPU22.SCHED
    105958 ± 19%     -93.6%       6790 ± 21%  softirqs.CPU23.RCU
    174291 ± 34%     -95.2%       8425 ±  4%  softirqs.CPU23.SCHED
    117045 ± 21%     -93.7%       7370 ± 16%  softirqs.CPU24.RCU
    188115 ±  6%     -95.5%       8484 ±  5%  softirqs.CPU24.SCHED
    106355 ± 22%     -93.7%       6662 ± 11%  softirqs.CPU25.RCU
    186764 ±  6%     -95.2%       8957 ± 30%  softirqs.CPU25.SCHED
    113964 ± 21%     -93.9%       6931 ± 12%  softirqs.CPU26.RCU
    187590 ±  6%     -95.6%       8299 ±  3%  softirqs.CPU26.SCHED
    115511 ± 19%     -93.5%       7474 ± 17%  softirqs.CPU27.RCU
    191392 ±  6%     -95.7%       8175 ±  7%  softirqs.CPU27.SCHED
    115620 ± 20%     -93.7%       7301 ± 18%  softirqs.CPU28.RCU
    191543 ±  6%     -95.6%       8398        softirqs.CPU28.SCHED
    115816 ± 19%     -93.8%       7173 ± 16%  softirqs.CPU29.RCU
    191593 ±  6%     -95.9%       7834 ± 12%  softirqs.CPU29.SCHED
    122697 ± 21%     -93.7%       7752 ± 19%  softirqs.CPU3.RCU
    200889 ±  6%     -95.8%       8435 ±  8%  softirqs.CPU3.SCHED
    116350 ± 20%     -94.1%       6921 ± 19%  softirqs.CPU30.RCU
    189992 ±  6%     -94.6%      10354 ± 46%  softirqs.CPU30.SCHED
    112089 ± 19%     -93.8%       6905 ± 15%  softirqs.CPU31.RCU
    187413 ±  6%     -95.6%       8253 ±  3%  softirqs.CPU31.SCHED
    131351 ± 21%     -93.5%       8502 ± 14%  softirqs.CPU32.RCU
    188514 ±  6%     -95.6%       8374 ±  4%  softirqs.CPU32.SCHED
    130731 ± 19%     -93.5%       8556 ± 18%  softirqs.CPU33.RCU
    191602 ±  6%     -96.0%       7701 ± 16%  softirqs.CPU33.SCHED
    128040 ± 21%     -93.5%       8268 ± 19%  softirqs.CPU34.RCU
    187732 ±  6%     -95.6%       8286 ±  2%  softirqs.CPU34.SCHED
    128713 ± 17%     -93.3%       8574 ± 22%  softirqs.CPU35.RCU
    190259 ±  6%     -95.0%       9539 ± 27%  softirqs.CPU35.SCHED
    135395 ± 23%     -93.1%       9287 ± 22%  softirqs.CPU36.RCU
    189879 ±  6%     -95.7%       8213 ±  2%  softirqs.CPU36.SCHED
    117702 ± 24%     -93.3%       7909 ± 13%  softirqs.CPU37.RCU
    186549 ±  6%     -95.6%       8121 ±  5%  softirqs.CPU37.SCHED
    124162 ± 23%     -93.3%       8372 ± 16%  softirqs.CPU38.RCU
    187461 ±  6%     -95.6%       8185 ±  4%  softirqs.CPU38.SCHED
    133167 ± 22%     -93.5%       8616 ± 21%  softirqs.CPU39.RCU
    172271 ± 17%     -95.2%       8295 ±  3%  softirqs.CPU39.SCHED
    103985 ± 38%     -92.3%       7957 ± 18%  softirqs.CPU4.RCU
    201247 ±  6%     -95.8%       8439 ±  9%  softirqs.CPU4.SCHED
    122352 ± 14%     -93.0%       8535 ± 14%  softirqs.CPU40.RCU
    189609 ±  6%     -95.7%       8214 ±  4%  softirqs.CPU40.SCHED
    137533 ± 19%     -93.3%       9280 ± 19%  softirqs.CPU41.RCU
    190741 ±  6%     -95.7%       8242 ±  3%  softirqs.CPU41.SCHED
    140427 ± 23%     -93.8%       8675 ± 18%  softirqs.CPU42.RCU
    192071 ±  6%     -95.7%       8302 ±  2%  softirqs.CPU42.SCHED
    135183 ± 21%     -93.9%       8288 ± 20%  softirqs.CPU43.RCU
    189660 ±  6%     -95.7%       8218 ±  4%  softirqs.CPU43.SCHED
    138147 ± 23%     -93.8%       8611 ± 17%  softirqs.CPU44.RCU
    191362 ±  6%     -95.7%       8174 ±  3%  softirqs.CPU44.SCHED
    131978 ± 22%     -93.7%       8370 ± 17%  softirqs.CPU45.RCU
    190506 ±  6%     -95.8%       8072 ±  6%  softirqs.CPU45.SCHED
    138248 ± 23%     -93.7%       8722 ± 18%  softirqs.CPU46.RCU
    191107 ±  6%     -96.1%       7377 ± 19%  softirqs.CPU46.SCHED
    131901 ± 24%     -93.3%       8797 ± 21%  softirqs.CPU47.RCU
    171141 ± 17%     -95.1%       8433 ±  4%  softirqs.CPU47.SCHED
      3795 ± 93%     -92.5%     285.17 ±178%  softirqs.CPU47.TIMER
    130134 ± 20%     -93.6%       8293 ± 23%  softirqs.CPU48.RCU
    188865 ±  6%     -95.7%       8095 ± 13%  softirqs.CPU48.SCHED
    125517 ± 20%     -93.3%       8445 ± 18%  softirqs.CPU49.RCU
    187911 ±  6%     -95.5%       8473        softirqs.CPU49.SCHED
    122875 ± 21%     -93.1%       8506 ± 28%  softirqs.CPU5.RCU
    182803 ± 23%     -95.3%       8592 ±  6%  softirqs.CPU5.SCHED
    122466 ± 19%     -93.4%       8126 ± 16%  softirqs.CPU50.RCU
    188046 ±  6%     -95.5%       8426 ±  4%  softirqs.CPU50.SCHED
    130272 ± 22%     -93.8%       8058 ± 22%  softirqs.CPU51.RCU
    190822 ±  5%     -95.6%       8446        softirqs.CPU51.SCHED
    131784 ± 22%     -93.5%       8530 ± 18%  softirqs.CPU52.RCU
    189768 ±  5%     -94.9%       9756 ± 31%  softirqs.CPU52.SCHED
    134638 ± 23%     -93.8%       8407 ± 18%  softirqs.CPU53.RCU
    189923 ±  5%     -95.6%       8401        softirqs.CPU53.SCHED
    136817 ± 22%     -94.0%       8264 ± 20%  softirqs.CPU54.RCU
    189113 ±  6%     -95.6%       8299        softirqs.CPU54.SCHED
    131548 ± 21%     -93.8%       8180 ± 14%  softirqs.CPU55.RCU
    186906 ±  6%     -95.7%       8105 ± 13%  softirqs.CPU55.SCHED
    134856 ± 24%     -94.1%       7947 ± 23%  softirqs.CPU56.RCU
    189571 ±  6%     -95.6%       8378        softirqs.CPU56.SCHED
    132354 ± 22%     -94.0%       7988 ± 15%  softirqs.CPU57.RCU
    187567 ±  6%     -95.5%       8366        softirqs.CPU57.SCHED
    137112 ± 23%     -94.0%       8268 ± 15%  softirqs.CPU58.RCU
    189039 ±  5%     -95.5%       8492 ±  2%  softirqs.CPU58.SCHED
    137602 ± 23%     -94.1%       8141 ± 21%  softirqs.CPU59.RCU
    188573 ±  6%     -95.7%       8166 ±  7%  softirqs.CPU59.SCHED
    121579 ± 17%     -93.8%       7524 ± 22%  softirqs.CPU6.RCU
    172169 ± 40%     -95.2%       8184 ±  4%  softirqs.CPU6.SCHED
    124561 ± 24%     -93.2%       8490 ± 19%  softirqs.CPU60.RCU
    186974 ±  6%     -95.5%       8419        softirqs.CPU60.SCHED
    134898 ± 24%     -93.6%       8655 ± 20%  softirqs.CPU61.RCU
    188374 ±  6%     -95.6%       8278 ±  2%  softirqs.CPU61.SCHED
    132602 ± 25%     -93.9%       8143 ± 21%  softirqs.CPU62.RCU
    190136 ±  5%     -95.6%       8282        softirqs.CPU62.SCHED
    132668 ± 21%     -94.0%       7923 ± 17%  softirqs.CPU63.RCU
    188472 ±  6%     -95.6%       8274        softirqs.CPU63.SCHED
    118800 ± 19%     -93.7%       7507 ± 18%  softirqs.CPU64.RCU
    189304 ±  6%     -95.7%       8193 ±  7%  softirqs.CPU64.SCHED
    124284 ± 23%     -93.9%       7520 ± 16%  softirqs.CPU65.RCU
    190189 ±  5%     -95.6%       8317 ±  2%  softirqs.CPU65.SCHED
    101662 ± 21%     -92.6%       7499 ± 19%  softirqs.CPU66.RCU
    186697 ±  6%     -95.7%       7992 ± 12%  softirqs.CPU66.SCHED
    120774 ± 24%     -93.7%       7614 ± 14%  softirqs.CPU67.RCU
    188368 ±  6%     -95.5%       8486 ±  2%  softirqs.CPU67.SCHED
    124635 ± 24%     -93.9%       7547 ± 14%  softirqs.CPU68.RCU
    190561 ±  5%     -95.8%       7956 ± 12%  softirqs.CPU68.SCHED
    117692 ± 17%     -93.4%       7760 ± 22%  softirqs.CPU69.RCU
    190140 ±  5%     -95.5%       8514 ±  2%  softirqs.CPU69.SCHED
    119877 ± 19%     -93.7%       7589 ± 19%  softirqs.CPU7.RCU
    199628 ±  6%     -96.2%       7584 ± 13%  softirqs.CPU7.SCHED
    124976 ± 24%     -93.8%       7734 ± 14%  softirqs.CPU70.RCU
    190431 ±  5%     -95.8%       8076 ±  8%  softirqs.CPU70.SCHED
    119430 ± 25%     -93.7%       7471 ± 13%  softirqs.CPU71.RCU
    188971 ±  6%     -95.5%       8477 ±  2%  softirqs.CPU71.SCHED
    110380 ± 20%     -93.6%       7118 ± 15%  softirqs.CPU72.RCU
    186737 ±  5%     -95.7%       7966 ±  5%  softirqs.CPU72.SCHED
    101590 ± 22%     -93.5%       6647 ± 14%  softirqs.CPU73.RCU
    185379 ±  6%     -95.6%       8136 ±  2%  softirqs.CPU73.SCHED
    109421 ± 22%     -93.8%       6766 ± 13%  softirqs.CPU74.RCU
    170790 ± 18%     -95.3%       8106 ±  3%  softirqs.CPU74.SCHED
    110090 ± 24%     -93.8%       6836 ± 16%  softirqs.CPU75.RCU
    189580 ±  5%     -95.7%       8134 ±  3%  softirqs.CPU75.SCHED
    110373 ± 22%     -93.7%       6914 ± 16%  softirqs.CPU76.RCU
    189601 ±  5%     -95.5%       8480 ±  6%  softirqs.CPU76.SCHED
    112207 ± 24%     -93.9%       6872 ± 17%  softirqs.CPU77.RCU
    187836 ±  6%     -95.7%       8147 ±  2%  softirqs.CPU77.SCHED
    112238 ± 24%     -93.7%       7020 ± 21%  softirqs.CPU78.RCU
    187207 ±  5%     -95.6%       8264 ±  5%  softirqs.CPU78.SCHED
    109314 ± 22%     -93.7%       6855 ± 16%  softirqs.CPU79.RCU
    185670 ±  6%     -95.7%       8043 ±  4%  softirqs.CPU79.SCHED
    121580 ± 21%     -93.2%       8289 ± 28%  softirqs.CPU8.RCU
    199716 ±  7%     -95.7%       8652 ± 11%  softirqs.CPU8.SCHED
    125361 ± 23%     -93.4%       8216 ± 24%  softirqs.CPU80.RCU
    185810 ±  5%     -95.6%       8105 ±  3%  softirqs.CPU80.SCHED
    127029 ± 23%     -94.0%       7562 ± 24%  softirqs.CPU81.RCU
    188383 ±  5%     -95.7%       8172 ±  3%  softirqs.CPU81.SCHED
    122058 ± 22%     -93.7%       7692 ± 20%  softirqs.CPU82.RCU
    184486 ±  6%     -95.6%       8208 ±  5%  softirqs.CPU82.SCHED
    127458 ± 22%     -94.0%       7636 ± 24%  softirqs.CPU83.RCU
    187008 ±  5%     -95.7%       7948 ±  6%  softirqs.CPU83.SCHED
    128454 ± 23%     -94.1%       7615 ± 23%  softirqs.CPU84.RCU
    186529 ±  6%     -95.6%       8144 ±  3%  softirqs.CPU84.SCHED
    113248 ± 24%     -93.7%       7117 ± 26%  softirqs.CPU85.RCU
    184147 ±  5%     -95.4%       8533 ±  9%  softirqs.CPU85.SCHED
    118372 ± 21%     -93.8%       7378 ± 23%  softirqs.CPU86.RCU
    184729 ±  5%     -95.6%       8146 ±  3%  softirqs.CPU86.SCHED
    125614 ± 23%     -93.9%       7660 ± 23%  softirqs.CPU87.RCU
    188067 ±  5%     -95.7%       8106 ±  3%  softirqs.CPU87.SCHED
    120411 ± 23%     -93.9%       7377 ± 18%  softirqs.CPU88.RCU
    185710 ±  6%     -95.6%       8147 ±  2%  softirqs.CPU88.SCHED
    128218 ± 23%     -93.9%       7787 ± 23%  softirqs.CPU89.RCU
    187137 ±  6%     -95.7%       8048 ±  3%  softirqs.CPU89.SCHED
    114794 ± 27%     -93.2%       7826 ± 18%  softirqs.CPU9.RCU
    203815 ±  4%     -95.9%       8381 ± 16%  softirqs.CPU9.SCHED
    128412 ± 23%     -93.9%       7770 ± 23%  softirqs.CPU90.RCU
    187753 ±  5%     -95.7%       8031 ±  5%  softirqs.CPU90.SCHED
    126016 ± 24%     -94.1%       7451 ± 24%  softirqs.CPU91.RCU
    185919 ±  6%     -95.6%       8126 ±  3%  softirqs.CPU91.SCHED
    127029 ± 25%     -94.0%       7570 ± 23%  softirqs.CPU92.RCU
    188340 ±  6%     -95.7%       8178 ±  2%  softirqs.CPU92.SCHED
    126837 ± 25%     -94.1%       7439 ± 21%  softirqs.CPU93.RCU
    188154 ±  5%     -95.7%       8153 ±  3%  softirqs.CPU93.SCHED
    127321 ± 25%     -94.0%       7633 ± 24%  softirqs.CPU94.RCU
    188860 ±  6%     -95.7%       8102 ±  4%  softirqs.CPU94.SCHED
    119046 ± 22%     -93.4%       7836 ± 18%  softirqs.CPU95.RCU
     64151 ± 49%     -90.2%       6306 ± 23%  softirqs.CPU95.SCHED
    110585 ± 15%     -93.7%       6980 ± 15%  softirqs.CPU96.RCU
    173593 ± 17%     -96.3%       6419 ± 23%  softirqs.CPU96.SCHED
    116415 ± 20%     -94.0%       7001 ± 19%  softirqs.CPU97.RCU
    160955 ± 29%     -95.0%       8115 ±  3%  softirqs.CPU97.SCHED
    117838 ± 21%     -94.0%       7032 ± 16%  softirqs.CPU98.RCU
    199645 ±  7%     -96.1%       7714 ± 12%  softirqs.CPU98.SCHED
    121079 ± 21%     -93.6%       7788 ± 17%  softirqs.CPU99.RCU
    200327 ±  7%     -95.8%       8387 ±  3%  softirqs.CPU99.SCHED
  23419727 ± 21%     -93.8%    1450026 ± 17%  softirqs.RCU
  36056621 ±  6%     -95.6%    1584828 ±  2%  softirqs.SCHED
    196051 ± 16%     -85.4%      28651 ±  2%  softirqs.TIMER



***************************************************************************************************
lkp-csl-2ap2: 192 threads 4 sockets Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory
=========================================================================================
compiler/cpufreq_governor/disk/filesize/fs2/fs/iterations/kconfig/nr_threads/rootfs/sync_method/tbox_group/test_size/testcase/ucode:
  gcc-9/performance/1BRD_48G/4M/nfsv4/ext4/1x/x86_64-rhel-8.3/1t/debian-10.4-x86_64-20200603.cgz/fsyncBeforeClose/lkp-csl-2ap2/24G/fsmark/0x5003006

commit: 
  0bcc7ca40b ("nfsd: fix crash on LOCKT on reexported NFSv3")
  e38b3f2005 ("SUNRPC: don't pause on incomplete allocation")

0bcc7ca40bd82319 e38b3f20059426a0adbde014ff7 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
  57065524 ± 70%     -99.5%     293197 ±  6%  fsmark.app_overhead
     30.65 ±143%    +325.8%     130.50        fsmark.files_per_sec
      1216 ± 68%     -96.0%      48.59        fsmark.time.elapsed_time
      1216 ± 68%     -96.0%      48.59        fsmark.time.elapsed_time.max
      8.83 ±146%    +330.2%      38.00        fsmark.time.percent_of_cpu_this_job_got
    936122 ±  5%     +15.1%    1077462 ±  2%  fsmark.time.voluntary_context_switches
 2.254e+11 ± 68%     -95.9%  9.266e+09        cpuidle..time
 3.934e+08 ± 68%     -94.7%   20818841 ±  6%  cpuidle..usage
      0.18 ± 17%      -0.1        0.07 ± 19%  mpstat.cpu.all.iowait%
      0.02 ± 73%      +0.0        0.05 ± 11%  mpstat.cpu.all.usr%
      1266 ± 65%     -92.2%      98.65        uptime.boot
    235659 ± 65%     -92.5%      17658        uptime.idle
    121442 ±139%    +319.8%     509789        vmstat.io.bo
     14732 ±116%    +318.4%      61648 ±  2%  vmstat.system.cs
     42.17 ±  5%     +10.7%      46.67 ±  3%  turbostat.CoreTmp
 2.011e+08 ± 69%     -95.0%   10019978        turbostat.IRQ
     42.50 ±  4%      +9.4%      46.50 ±  3%  turbostat.PkgTmp
     32717 ± 52%     -77.6%       7344 ±  4%  meminfo.Active(anon)
    242389 ± 18%     -36.9%     153056        meminfo.AnonHugePages
      4305 ±  6%     +12.5%       4846        meminfo.PageTables
     52987 ± 33%     -49.7%      26670        meminfo.Shmem
      0.09 ± 20%      +0.0        0.13 ± 22%  perf-profile.children.cycles-pp.memset_erms
      0.03 ±103%      +0.1        0.08 ± 17%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.10 ± 56%      +0.1        0.21 ± 13%  perf-profile.children.cycles-pp.blk_next_bio
      0.10 ± 58%      +0.1        0.21 ± 13%  perf-profile.children.cycles-pp.__blkdev_issue_zero_pages
      0.02 ±143%      +0.1        0.08 ± 19%  perf-profile.self.cycles-pp.cgroup_rstat_updated
     96.33 ±115%   +6948.8%       6790 ±133%  numa-meminfo.node2.Mapped
     18241 ± 38%     -73.9%       4764 ±  7%  numa-meminfo.node3.Active(anon)
     73715 ±101%     -97.0%       2247 ± 77%  numa-meminfo.node3.AnonPages
    101894 ± 78%     -84.6%      15710 ± 11%  numa-meminfo.node3.AnonPages.max
     83928 ± 89%     -88.9%       9303 ± 60%  numa-meminfo.node3.Inactive(anon)
      1498 ± 99%     -83.2%     252.17 ± 44%  numa-meminfo.node3.PageTables
     92500 ± 13%     -29.1%      65571 ± 18%  numa-meminfo.node3.SUnreclaim
     28346 ± 27%     -60.4%      11222 ± 36%  numa-meminfo.node3.Shmem
     23.67 ±116%   +7078.2%       1698 ±133%  numa-vmstat.node2.nr_mapped
      4560 ± 38%     -73.9%       1189 ±  7%  numa-vmstat.node3.nr_active_anon
     18430 ±101%     -96.9%     564.83 ± 77%  numa-vmstat.node3.nr_anon_pages
     20984 ± 89%     -88.9%       2329 ± 60%  numa-vmstat.node3.nr_inactive_anon
    374.67 ± 99%     -83.1%      63.33 ± 43%  numa-vmstat.node3.nr_page_table_pages
      7086 ± 27%     -60.4%       2804 ± 36%  numa-vmstat.node3.nr_shmem
     23128 ± 13%     -29.1%      16396 ± 18%  numa-vmstat.node3.nr_slab_unreclaimable
      4560 ± 38%     -73.9%       1189 ±  7%  numa-vmstat.node3.nr_zone_active_anon
     20983 ± 89%     -88.9%       2329 ± 60%  numa-vmstat.node3.nr_zone_inactive_anon
    239.50 ± 32%     -46.8%     127.33 ± 17%  slabinfo.biovec-max.active_objs
    239.50 ± 32%     -46.8%     127.33 ± 17%  slabinfo.biovec-max.num_objs
      1281 ± 44%     -66.2%     433.17 ± 29%  slabinfo.ext4_allocation_context.active_objs
      1281 ± 44%     -66.2%     433.17 ± 29%  slabinfo.ext4_allocation_context.num_objs
      1454 ± 45%     -66.7%     484.83 ± 29%  slabinfo.ext4_io_end.active_objs
      1454 ± 45%     -66.7%     484.83 ± 29%  slabinfo.ext4_io_end.num_objs
      1019 ± 41%     -61.4%     393.33 ± 23%  slabinfo.ip6-frags.active_objs
      1019 ± 41%     -61.4%     393.33 ± 23%  slabinfo.ip6-frags.num_objs
      1755 ± 39%     -56.8%     758.17 ± 12%  slabinfo.jbd2_journal_head.active_objs
      1755 ± 39%     -56.8%     758.17 ± 12%  slabinfo.jbd2_journal_head.num_objs
      1196 ± 43%     -64.8%     420.83 ± 26%  slabinfo.nfsd4_files.active_objs
      1196 ± 43%     -64.8%     420.83 ± 26%  slabinfo.nfsd4_files.num_objs
      9070 ± 45%     -69.9%       2728 ±  6%  slabinfo.skbuff_fclone_cache.active_objs
    143.50 ± 45%     -70.6%      42.17 ±  6%  slabinfo.skbuff_fclone_cache.active_slabs
      9220 ± 45%     -70.4%       2728 ±  6%  slabinfo.skbuff_fclone_cache.num_objs
    143.50 ± 45%     -70.6%      42.17 ±  6%  slabinfo.skbuff_fclone_cache.num_slabs
      8179 ± 52%     -77.6%       1835 ±  4%  proc-vmstat.nr_active_anon
    117.67 ± 18%     -36.8%      74.33        proc-vmstat.nr_anon_transparent_hugepages
     88013 ±  2%      +4.7%      92153        proc-vmstat.nr_inactive_anon
      9047            +3.8%       9389        proc-vmstat.nr_mapped
      1075 ±  6%     +12.7%       1211        proc-vmstat.nr_page_table_pages
     13246 ± 33%     -49.7%       6667        proc-vmstat.nr_shmem
      8179 ± 52%     -77.6%       1835 ±  4%  proc-vmstat.nr_zone_active_anon
     88013 ±  2%      +4.7%      92153        proc-vmstat.nr_zone_inactive_anon
   5165798 ± 64%    +141.7%   12487608 ±  4%  proc-vmstat.numa_foreign
      6039 ± 44%     -97.2%     170.00 ±130%  proc-vmstat.numa_hint_faults
  28368284 ± 10%     -22.7%   21918559 ±  2%  proc-vmstat.numa_hit
  28157530 ± 10%     -22.8%   21750966 ±  2%  proc-vmstat.numa_local
   5166335 ± 64%    +142.1%   12508135 ±  4%  proc-vmstat.numa_miss
   5426761 ± 61%    +136.7%   12845531 ±  4%  proc-vmstat.numa_other
      1411 ± 76%     -99.1%      12.83 ± 48%  proc-vmstat.numa_pages_migrated
     30316 ± 39%     -71.4%       8661 ±143%  proc-vmstat.numa_pte_updates
   4435363 ± 64%     -90.1%     439520        proc-vmstat.pgfault
      9015 ± 62%     -99.9%      12.83 ± 48%  proc-vmstat.pgmigrate_success
    296130 ± 65%     -92.2%      23086        proc-vmstat.pgreuse
      0.02 ± 93%     -74.5%       0.01 ± 47%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.03 ±112%    +241.2%       0.09 ± 22%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork
      0.02 ± 93%     -68.8%       0.01 ± 36%  perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.19 ±174%     -90.7%       0.02 ± 18%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork
      8318 ± 44%     -99.8%      14.19 ± 19%  perf-sched.total_wait_and_delay.max.ms
      8318 ± 44%     -99.8%      14.19 ± 19%  perf-sched.total_wait_time.max.ms
     49.64 ± 44%     -99.0%       0.50 ± 38%  perf-sched.wait_and_delay.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      7.58 ± 44%     -99.7%       0.02 ± 84%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
    248.10 ± 45%     -99.5%       1.15 ± 11%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork
    288.00 ± 38%     -85.6%      41.50 ± 27%  perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
    279.83 ± 37%     -87.5%      35.00 ± 28%  perf-sched.wait_and_delay.count.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      2536 ± 44%     -98.4%      41.50 ± 62%  perf-sched.wait_and_delay.count.pipe_read.new_sync_read.vfs_read.ksys_read
      1582 ± 50%     -99.7%       4.50 ± 11%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      1071 ± 43%     -96.2%      41.00 ± 24%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork
    834.93 ± 44%     -99.6%       3.72 ± 58%  perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     17.67 ± 41%     -86.9%       2.31 ± 96%  perf-sched.wait_and_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
    846.80 ± 44%     -99.7%       2.20 ± 52%  perf-sched.wait_and_delay.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      8318 ± 44%    -100.0%       3.94 ±118%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
     59.04 ±137%     -91.9%       4.81 ±  7%  perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      5981 ± 49%     -99.9%       6.46 ± 44%  perf-sched.wait_and_delay.max.ms.worker_thread.kthread.ret_from_fork
      0.69 ± 20%     -45.5%       0.37 ± 13%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
     49.60 ± 44%     -99.0%       0.48 ± 38%  perf-sched.wait_time.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      7.58 ± 44%     -99.7%       0.02 ± 84%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
    134.92 ± 67%     -99.4%       0.85 ± 69%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      4.77 ± 23%     -31.5%       3.27 ±  9%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
    248.07 ± 45%     -99.6%       1.06 ± 14%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork
    834.90 ± 44%     -99.6%       3.63 ± 57%  perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     17.66 ± 41%     -95.4%       0.81 ± 18%  perf-sched.wait_time.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
    846.18 ± 44%     -99.7%       2.20 ± 52%  perf-sched.wait_time.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      8318 ± 44%    -100.0%       3.94 ±118%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
    394.95 ± 49%     -99.0%       3.94 ± 82%  perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      5981 ± 49%     -99.9%       6.44 ± 44%  perf-sched.wait_time.max.ms.worker_thread.kthread.ret_from_fork
 4.848e+08 ± 60%    +148.3%  1.204e+09 ±  2%  perf-stat.i.branch-instructions
     15149 ±118%    +327.6%      64781 ±  2%  perf-stat.i.context-switches
      5.11 ± 53%     -61.0%       1.99 ± 10%  perf-stat.i.cpi
    199.68 ±  5%     +12.4%     224.48        perf-stat.i.cpu-migrations
 6.657e+08 ± 58%    +139.8%  1.597e+09        perf-stat.i.dTLB-loads
 3.506e+08 ± 57%    +133.7%  8.193e+08        perf-stat.i.dTLB-stores
   1856294 ± 22%     +53.7%    2852277 ±  9%  perf-stat.i.iTLB-load-misses
 2.412e+09 ± 60%    +148.9%  6.003e+09 ±  2%  perf-stat.i.instructions
      0.26 ± 43%     +96.6%       0.51 ±  9%  perf-stat.i.ipc
      1.51 ±106%    +187.3%       4.33 ±  7%  perf-stat.i.major-faults
      7.68 ± 61%    +146.2%      18.91 ±  2%  perf-stat.i.metric.M/sec
      4197 ± 28%     +64.3%       6897        perf-stat.i.minor-faults
     86.26 ±  6%     -30.0       56.24 ±  5%  perf-stat.i.node-load-miss-rate%
    352440 ±119%    +293.4%    1386564 ±  4%  perf-stat.i.node-loads
    616606 ±134%    +356.4%    2814055 ±  8%  perf-stat.i.node-store-misses
      4199 ± 28%     +64.4%       6902        perf-stat.i.page-faults
      4.82 ± 55%     -59.7%       1.95 ± 10%  perf-stat.overall.cpi
      0.27 ± 44%     +90.7%       0.52 ±  9%  perf-stat.overall.ipc
     78.09 ± 10%     -22.6       55.44 ±  9%  perf-stat.overall.node-load-miss-rate%
 4.804e+08 ± 59%    +145.4%  1.179e+09 ±  2%  perf-stat.ps.branch-instructions
     14950 ±117%    +324.4%      63452 ±  2%  perf-stat.ps.context-switches
    191074            -1.6%     188107        perf-stat.ps.cpu-clock
    198.64 ±  5%     +10.7%     219.98        perf-stat.ps.cpu-migrations
 6.597e+08 ± 57%    +137.0%  1.564e+09        perf-stat.ps.dTLB-loads
 3.475e+08 ± 56%    +130.9%  8.023e+08        perf-stat.ps.dTLB-stores
   1844751 ± 21%     +51.4%    2793320 ±  9%  perf-stat.ps.iTLB-load-misses
 2.389e+09 ± 59%    +146.0%  5.879e+09 ±  2%  perf-stat.ps.instructions
      1.49 ±106%    +185.5%       4.26 ±  7%  perf-stat.ps.major-faults
      4162 ± 27%     +61.7%       6730        perf-stat.ps.minor-faults
    347896 ±118%    +290.5%    1358696 ±  4%  perf-stat.ps.node-loads
    607985 ±133%    +353.1%    2754606 ±  8%  perf-stat.ps.node-store-misses
      4163 ± 27%     +61.7%       6734        perf-stat.ps.page-faults
    191074            -1.6%     188107        perf-stat.ps.task-clock
   1140238 ±120%     -97.9%      23866 ±215%  interrupts.33:PCI-MSI.524291-edge.eth0-TxRx-2
      2436 ± 68%     -95.9%     100.00        interrupts.9:IO-APIC.9-fasteoi.acpi
      4342 ± 51%     -71.5%       1236 ± 87%  interrupts.CPU0.CAL:Function_call_interrupts
   2100028 ± 68%     -95.2%      99837        interrupts.CPU0.LOC:Local_timer_interrupts
      2436 ± 68%     -95.9%     100.00        interrupts.CPU1.9:IO-APIC.9-fasteoi.acpi
      8075 ± 92%     -74.3%       2078 ±118%  interrupts.CPU1.CAL:Function_call_interrupts
   2097314 ± 68%     -95.2%      99739        interrupts.CPU1.LOC:Local_timer_interrupts
   2098661 ± 68%     -95.2%      99843        interrupts.CPU10.LOC:Local_timer_interrupts
   2112462 ± 68%     -95.3%      99864        interrupts.CPU100.LOC:Local_timer_interrupts
   2095771 ± 68%     -95.2%      99776        interrupts.CPU101.LOC:Local_timer_interrupts
   2096850 ± 68%     -95.2%      99804        interrupts.CPU102.LOC:Local_timer_interrupts
   2096021 ± 68%     -95.3%      99551        interrupts.CPU103.LOC:Local_timer_interrupts
   2092695 ± 68%     -95.2%      99769        interrupts.CPU104.LOC:Local_timer_interrupts
   2088717 ± 68%     -95.2%      99720        interrupts.CPU105.LOC:Local_timer_interrupts
   2098184 ± 68%     -95.2%      99767        interrupts.CPU106.LOC:Local_timer_interrupts
   2089283 ± 68%     -95.2%      99778        interrupts.CPU107.LOC:Local_timer_interrupts
   2229573 ± 67%     -95.5%      99730        interrupts.CPU108.LOC:Local_timer_interrupts
   2099911 ± 68%     -95.2%      99787        interrupts.CPU109.LOC:Local_timer_interrupts
   2089455 ± 68%     -95.2%      99874        interrupts.CPU11.LOC:Local_timer_interrupts
   2093829 ± 68%     -95.2%      99851        interrupts.CPU110.LOC:Local_timer_interrupts
   2089886 ± 68%     -95.2%      99738        interrupts.CPU111.LOC:Local_timer_interrupts
   2093078 ± 68%     -95.2%      99757        interrupts.CPU112.LOC:Local_timer_interrupts
   2090014 ± 68%     -95.2%      99716        interrupts.CPU113.LOC:Local_timer_interrupts
   2088634 ± 68%     -95.2%      99761        interrupts.CPU114.LOC:Local_timer_interrupts
   2091386 ± 68%     -95.2%      99767        interrupts.CPU115.LOC:Local_timer_interrupts
   2087898 ± 68%     -95.2%      99784        interrupts.CPU116.LOC:Local_timer_interrupts
      4245 ±166%     -78.7%     906.00 ±  4%  interrupts.CPU117.CAL:Function_call_interrupts
   2087971 ± 68%     -95.2%      99800        interrupts.CPU117.LOC:Local_timer_interrupts
   2089188 ± 68%     -95.2%      99823        interrupts.CPU118.LOC:Local_timer_interrupts
   2091687 ± 68%     -95.2%      99785        interrupts.CPU119.LOC:Local_timer_interrupts
   1140238 ±120%     -97.9%      23866 ±215%  interrupts.CPU12.33:PCI-MSI.524291-edge.eth0-TxRx-2
   2230208 ± 67%     -95.5%      99764        interrupts.CPU12.LOC:Local_timer_interrupts
   2064992 ± 68%     -95.2%      98918        interrupts.CPU120.LOC:Local_timer_interrupts
   2081807 ± 68%     -95.2%      98938        interrupts.CPU121.LOC:Local_timer_interrupts
   2041402 ± 69%     -95.2%      98938        interrupts.CPU122.LOC:Local_timer_interrupts
   2030539 ± 68%     -95.1%      98889        interrupts.CPU123.LOC:Local_timer_interrupts
   2030933 ± 68%     -95.1%      98912        interrupts.CPU124.LOC:Local_timer_interrupts
   2027850 ± 68%     -95.1%      98894        interrupts.CPU125.LOC:Local_timer_interrupts
   2030365 ± 68%     -95.1%      98903        interrupts.CPU126.LOC:Local_timer_interrupts
   2040753 ± 69%     -95.2%      98923        interrupts.CPU127.LOC:Local_timer_interrupts
   2032465 ± 68%     -95.1%      98911        interrupts.CPU128.LOC:Local_timer_interrupts
   2024873 ± 68%     -95.1%      98886        interrupts.CPU129.LOC:Local_timer_interrupts
   2099807 ± 68%     -95.2%      99807        interrupts.CPU13.LOC:Local_timer_interrupts
   2035517 ± 69%     -95.1%      98901        interrupts.CPU130.LOC:Local_timer_interrupts
   2028924 ± 68%     -95.1%      98902        interrupts.CPU131.LOC:Local_timer_interrupts
   2031275 ± 68%     -95.1%      98917        interrupts.CPU132.LOC:Local_timer_interrupts
   2042987 ± 69%     -95.2%      98940        interrupts.CPU133.LOC:Local_timer_interrupts
   2037693 ± 69%     -95.1%      98918        interrupts.CPU134.LOC:Local_timer_interrupts
   2027825 ± 68%     -95.1%      98905        interrupts.CPU135.LOC:Local_timer_interrupts
   2036551 ± 69%     -95.1%      98928        interrupts.CPU136.LOC:Local_timer_interrupts
   2027764 ± 68%     -95.1%      98901        interrupts.CPU137.LOC:Local_timer_interrupts
   2025962 ± 68%     -95.1%      98885        interrupts.CPU138.LOC:Local_timer_interrupts
   2030092 ± 68%     -95.1%      98912        interrupts.CPU139.LOC:Local_timer_interrupts
   2093518 ± 68%     -95.2%      99858        interrupts.CPU14.LOC:Local_timer_interrupts
   2025594 ± 68%     -95.1%      98879        interrupts.CPU140.LOC:Local_timer_interrupts
   2026794 ± 68%     -95.1%      98924        interrupts.CPU141.LOC:Local_timer_interrupts
   2026824 ± 68%     -95.1%      98922        interrupts.CPU142.LOC:Local_timer_interrupts
   2031597 ± 68%     -95.1%      98915        interrupts.CPU143.LOC:Local_timer_interrupts
   2060205 ± 69%     -95.2%      99232        interrupts.CPU144.LOC:Local_timer_interrupts
   2059124 ± 69%     -95.2%      99134        interrupts.CPU145.LOC:Local_timer_interrupts
   2062079 ± 69%     -95.2%      99229        interrupts.CPU146.LOC:Local_timer_interrupts
   2047887 ± 69%     -95.2%      99189        interrupts.CPU147.LOC:Local_timer_interrupts
   2048515 ± 69%     -95.2%      99206        interrupts.CPU148.LOC:Local_timer_interrupts
   2048567 ± 69%     -95.2%      99194        interrupts.CPU149.LOC:Local_timer_interrupts
   2089682 ± 68%     -95.2%      99683        interrupts.CPU15.LOC:Local_timer_interrupts
   2052036 ± 69%     -95.2%      99198        interrupts.CPU150.LOC:Local_timer_interrupts
   2060328 ± 69%     -95.2%      99213        interrupts.CPU151.LOC:Local_timer_interrupts
   2046947 ± 69%     -95.2%      99229        interrupts.CPU152.LOC:Local_timer_interrupts
   2057451 ± 69%     -95.2%      99193        interrupts.CPU153.LOC:Local_timer_interrupts
   2050541 ± 69%     -95.2%      99223        interrupts.CPU154.LOC:Local_timer_interrupts
   2054022 ± 69%     -95.2%      99237        interrupts.CPU155.LOC:Local_timer_interrupts
   2062856 ± 69%     -95.2%      99207        interrupts.CPU156.LOC:Local_timer_interrupts
   2053565 ± 69%     -95.2%      99232        interrupts.CPU157.LOC:Local_timer_interrupts
   2049476 ± 69%     -95.2%      99184        interrupts.CPU158.LOC:Local_timer_interrupts
   2058421 ± 69%     -95.2%      99229        interrupts.CPU159.LOC:Local_timer_interrupts
   2092861 ± 68%     -95.2%      99706        interrupts.CPU16.LOC:Local_timer_interrupts
   2050236 ± 69%     -95.2%      99201        interrupts.CPU160.LOC:Local_timer_interrupts
   2047650 ± 69%     -95.2%      99176        interrupts.CPU161.LOC:Local_timer_interrupts
   2066455 ± 70%     -95.2%      99250        interrupts.CPU162.LOC:Local_timer_interrupts
   2052620 ± 69%     -95.2%      99205        interrupts.CPU163.LOC:Local_timer_interrupts
   2047386 ± 69%     -95.2%      99175        interrupts.CPU164.LOC:Local_timer_interrupts
   2049031 ± 69%     -95.2%      99177        interrupts.CPU165.LOC:Local_timer_interrupts
   2048818 ± 69%     -95.2%      99220        interrupts.CPU166.LOC:Local_timer_interrupts
   2053178 ± 69%     -95.2%      99194        interrupts.CPU167.LOC:Local_timer_interrupts
   2068419 ± 70%     -95.2%      99674        interrupts.CPU168.LOC:Local_timer_interrupts
      1635 ± 82%     -45.8%     886.50        interrupts.CPU169.CAL:Function_call_interrupts
   2077695 ± 70%     -95.2%      99681        interrupts.CPU169.LOC:Local_timer_interrupts
   2089080 ± 68%     -95.2%      99736        interrupts.CPU17.LOC:Local_timer_interrupts
      2970 ±111%     -70.1%     886.83        interrupts.CPU170.CAL:Function_call_interrupts
   2070114 ± 70%     -95.2%      99679        interrupts.CPU170.LOC:Local_timer_interrupts
     89.00 ± 92%     -96.1%       3.50 ±150%  interrupts.CPU170.RES:Rescheduling_interrupts
   2056709 ± 69%     -95.2%      99677        interrupts.CPU171.LOC:Local_timer_interrupts
      1478 ± 70%     -39.5%     894.00 ±  2%  interrupts.CPU172.CAL:Function_call_interrupts
   2057183 ± 69%     -95.2%      99672        interrupts.CPU172.LOC:Local_timer_interrupts
   2058404 ± 69%     -95.2%      99675        interrupts.CPU173.LOC:Local_timer_interrupts
   2060541 ± 70%     -95.2%      99674        interrupts.CPU174.LOC:Local_timer_interrupts
   2069056 ± 70%     -95.2%      99676        interrupts.CPU175.LOC:Local_timer_interrupts
   2064122 ± 70%     -95.2%      99676        interrupts.CPU176.LOC:Local_timer_interrupts
   2056887 ± 69%     -95.2%      99692        interrupts.CPU177.LOC:Local_timer_interrupts
   2067820 ± 70%     -95.2%      99692        interrupts.CPU178.LOC:Local_timer_interrupts
   2059944 ± 70%     -95.2%      99672        interrupts.CPU179.LOC:Local_timer_interrupts
   2088573 ± 68%     -95.2%      99662        interrupts.CPU18.LOC:Local_timer_interrupts
   2063532 ± 70%     -95.2%      99679        interrupts.CPU180.LOC:Local_timer_interrupts
      2829 ±144%     -68.7%     885.33        interrupts.CPU181.CAL:Function_call_interrupts
   2073507 ± 70%     -95.2%      99675        interrupts.CPU181.LOC:Local_timer_interrupts
   2068311 ± 70%     -95.2%      99696        interrupts.CPU182.LOC:Local_timer_interrupts
      1092 ± 18%     -15.9%     918.67 ±  5%  interrupts.CPU183.CAL:Function_call_interrupts
   2059398 ± 69%     -95.2%      99683        interrupts.CPU183.LOC:Local_timer_interrupts
      2072 ±114%     -57.3%     884.17        interrupts.CPU184.CAL:Function_call_interrupts
   2065539 ± 70%     -95.2%      99672        interrupts.CPU184.LOC:Local_timer_interrupts
      1646 ± 86%     -46.2%     885.67        interrupts.CPU185.CAL:Function_call_interrupts
   2058095 ± 69%     -95.2%      99681        interrupts.CPU185.LOC:Local_timer_interrupts
      3547 ±161%     -75.0%     886.33        interrupts.CPU186.CAL:Function_call_interrupts
   2055875 ± 69%     -95.2%      99672        interrupts.CPU186.LOC:Local_timer_interrupts
      1039 ±  9%     -14.5%     888.00        interrupts.CPU187.CAL:Function_call_interrupts
   2060982 ± 70%     -95.2%      99676        interrupts.CPU187.LOC:Local_timer_interrupts
      1033 ±  6%     -13.9%     889.17        interrupts.CPU188.CAL:Function_call_interrupts
   2056314 ± 69%     -95.2%      99674        interrupts.CPU188.LOC:Local_timer_interrupts
      2169 ±120%     -58.9%     891.67        interrupts.CPU189.CAL:Function_call_interrupts
   2057327 ± 69%     -95.2%      99671        interrupts.CPU189.LOC:Local_timer_interrupts
   2091255 ± 68%     -95.2%      99797        interrupts.CPU19.LOC:Local_timer_interrupts
      1695 ± 91%     -47.4%     891.83        interrupts.CPU190.CAL:Function_call_interrupts
   2057192 ± 69%     -95.2%      99669        interrupts.CPU190.LOC:Local_timer_interrupts
   2061851 ± 70%     -95.2%      99699        interrupts.CPU191.LOC:Local_timer_interrupts
   2093578 ± 68%     -95.2%      99730        interrupts.CPU2.LOC:Local_timer_interrupts
   2087463 ± 68%     -95.2%      99741        interrupts.CPU20.LOC:Local_timer_interrupts
   2087891 ± 68%     -95.2%      99715        interrupts.CPU21.LOC:Local_timer_interrupts
   2089131 ± 68%     -95.2%      99835        interrupts.CPU22.LOC:Local_timer_interrupts
   2091320 ± 68%     -95.2%      99717        interrupts.CPU23.LOC:Local_timer_interrupts
   2064771 ± 68%     -95.2%      98969        interrupts.CPU24.LOC:Local_timer_interrupts
   2081155 ± 68%     -95.2%      98983        interrupts.CPU25.LOC:Local_timer_interrupts
     15772 ±126%     -87.4%       1987 ± 78%  interrupts.CPU26.CAL:Function_call_interrupts
   2040961 ± 69%     -95.2%      98959        interrupts.CPU26.LOC:Local_timer_interrupts
   2030449 ± 68%     -95.1%      98911        interrupts.CPU27.LOC:Local_timer_interrupts
   2030721 ± 68%     -95.1%      98916        interrupts.CPU28.LOC:Local_timer_interrupts
   2027785 ± 68%     -95.1%      98914        interrupts.CPU29.LOC:Local_timer_interrupts
   2092187 ± 68%     -95.2%      99840        interrupts.CPU3.LOC:Local_timer_interrupts
   2030224 ± 68%     -95.1%      98921        interrupts.CPU30.LOC:Local_timer_interrupts
   2040483 ± 69%     -95.2%      98961        interrupts.CPU31.LOC:Local_timer_interrupts
   2032323 ± 68%     -95.1%      98946        interrupts.CPU32.LOC:Local_timer_interrupts
   2024764 ± 68%     -95.1%      98921        interrupts.CPU33.LOC:Local_timer_interrupts
   2035419 ± 69%     -95.1%      98925        interrupts.CPU34.LOC:Local_timer_interrupts
   2028753 ± 68%     -95.1%      98937        interrupts.CPU35.LOC:Local_timer_interrupts
   2031115 ± 68%     -95.1%      98928        interrupts.CPU36.LOC:Local_timer_interrupts
   2043047 ± 69%     -95.2%      98945        interrupts.CPU37.LOC:Local_timer_interrupts
   2037353 ± 69%     -95.1%      98957        interrupts.CPU38.LOC:Local_timer_interrupts
   2027700 ± 68%     -95.1%      98914        interrupts.CPU39.LOC:Local_timer_interrupts
     10211 ± 78%     -80.3%       2011 ±110%  interrupts.CPU4.CAL:Function_call_interrupts
   2112270 ± 68%     -95.3%      99784        interrupts.CPU4.LOC:Local_timer_interrupts
   2036383 ± 69%     -95.1%      98939        interrupts.CPU40.LOC:Local_timer_interrupts
   2027843 ± 68%     -95.1%      98912        interrupts.CPU41.LOC:Local_timer_interrupts
   2025954 ± 68%     -95.1%      98897        interrupts.CPU42.LOC:Local_timer_interrupts
   2029862 ± 68%     -95.1%      98933        interrupts.CPU43.LOC:Local_timer_interrupts
   2025304 ± 68%     -95.1%      98936        interrupts.CPU44.LOC:Local_timer_interrupts
   2026821 ± 68%     -95.1%      98920        interrupts.CPU45.LOC:Local_timer_interrupts
   2026833 ± 68%     -95.1%      98905        interrupts.CPU46.LOC:Local_timer_interrupts
   2031427 ± 68%     -95.1%      98920        interrupts.CPU47.LOC:Local_timer_interrupts
   2059834 ± 69%     -95.2%      99158        interrupts.CPU48.LOC:Local_timer_interrupts
   2058619 ± 69%     -95.2%      99218        interrupts.CPU49.LOC:Local_timer_interrupts
   2095504 ± 68%     -95.2%      99770        interrupts.CPU5.LOC:Local_timer_interrupts
   2061737 ± 69%     -95.2%      99231        interrupts.CPU50.LOC:Local_timer_interrupts
   2047787 ± 69%     -95.2%      99237        interrupts.CPU51.LOC:Local_timer_interrupts
   2048008 ± 69%     -95.2%      99186        interrupts.CPU52.LOC:Local_timer_interrupts
   2048467 ± 69%     -95.2%      99219        interrupts.CPU53.LOC:Local_timer_interrupts
   2051933 ± 69%     -95.2%      99210        interrupts.CPU54.LOC:Local_timer_interrupts
   2060054 ± 69%     -95.2%      99227        interrupts.CPU55.LOC:Local_timer_interrupts
   2046815 ± 69%     -95.2%      99234        interrupts.CPU56.LOC:Local_timer_interrupts
   2057397 ± 69%     -95.2%      99217        interrupts.CPU57.LOC:Local_timer_interrupts
   2050367 ± 69%     -95.2%      99220        interrupts.CPU58.LOC:Local_timer_interrupts
   2053809 ± 69%     -95.2%      99213        interrupts.CPU59.LOC:Local_timer_interrupts
      2448 ± 59%     -55.7%       1083 ± 33%  interrupts.CPU6.CAL:Function_call_interrupts
   2096598 ± 68%     -95.2%      99755        interrupts.CPU6.LOC:Local_timer_interrupts
   2062619 ± 69%     -95.2%      99187        interrupts.CPU60.LOC:Local_timer_interrupts
   2053291 ± 69%     -95.2%      99212        interrupts.CPU61.LOC:Local_timer_interrupts
   2048827 ± 69%     -95.2%      99220        interrupts.CPU62.LOC:Local_timer_interrupts
   2058081 ± 69%     -95.2%      99220        interrupts.CPU63.LOC:Local_timer_interrupts
   2049534 ± 69%     -95.2%      99175        interrupts.CPU64.LOC:Local_timer_interrupts
   2047572 ± 69%     -95.2%      99203        interrupts.CPU65.LOC:Local_timer_interrupts
   2066443 ± 70%     -95.2%      99250        interrupts.CPU66.LOC:Local_timer_interrupts
   2052376 ± 69%     -95.2%      99205        interrupts.CPU67.LOC:Local_timer_interrupts
   2046464 ± 69%     -95.2%      99188        interrupts.CPU68.LOC:Local_timer_interrupts
   2048371 ± 69%     -95.2%      99199        interrupts.CPU69.LOC:Local_timer_interrupts
   2095797 ± 68%     -95.2%      99760        interrupts.CPU7.LOC:Local_timer_interrupts
   2048413 ± 69%     -95.2%      99177        interrupts.CPU70.LOC:Local_timer_interrupts
   2052980 ± 69%     -95.2%      99243        interrupts.CPU71.LOC:Local_timer_interrupts
   2068861 ± 70%     -95.2%      99693        interrupts.CPU72.LOC:Local_timer_interrupts
   2077397 ± 70%     -95.2%      99695        interrupts.CPU73.LOC:Local_timer_interrupts
    102.17 ±141%     -97.7%       2.33 ±149%  interrupts.CPU73.RES:Rescheduling_interrupts
   2070033 ± 70%     -95.2%      99694        interrupts.CPU74.LOC:Local_timer_interrupts
   2056606 ± 69%     -95.2%      99688        interrupts.CPU75.LOC:Local_timer_interrupts
   2057110 ± 69%     -95.2%      99691        interrupts.CPU76.LOC:Local_timer_interrupts
   2058435 ± 69%     -95.2%      99693        interrupts.CPU77.LOC:Local_timer_interrupts
   2060739 ± 70%     -95.2%      99694        interrupts.CPU78.LOC:Local_timer_interrupts
   2069334 ± 70%     -95.2%      99698        interrupts.CPU79.LOC:Local_timer_interrupts
   2092727 ± 68%     -95.2%      99811        interrupts.CPU8.LOC:Local_timer_interrupts
   2064295 ± 70%     -95.2%      99706        interrupts.CPU80.LOC:Local_timer_interrupts
   2056376 ± 69%     -95.2%      99693        interrupts.CPU81.LOC:Local_timer_interrupts
   2067695 ± 70%     -95.2%      99699        interrupts.CPU82.LOC:Local_timer_interrupts
   2059976 ± 70%     -95.2%      99696        interrupts.CPU83.LOC:Local_timer_interrupts
   2063632 ± 70%     -95.2%      99701        interrupts.CPU84.LOC:Local_timer_interrupts
   2073507 ± 70%     -95.2%      99704        interrupts.CPU85.LOC:Local_timer_interrupts
   2068044 ± 70%     -95.2%      99695        interrupts.CPU86.LOC:Local_timer_interrupts
   2058936 ± 69%     -95.2%      99690        interrupts.CPU87.LOC:Local_timer_interrupts
      1537 ± 77%     -42.5%     884.67        interrupts.CPU88.CAL:Function_call_interrupts
   2065449 ± 70%     -95.2%      99714        interrupts.CPU88.LOC:Local_timer_interrupts
   2058083 ± 69%     -95.2%      99696        interrupts.CPU89.LOC:Local_timer_interrupts
   2088604 ± 68%     -95.2%      99806        interrupts.CPU9.LOC:Local_timer_interrupts
   2056010 ± 69%     -95.2%      99690        interrupts.CPU90.LOC:Local_timer_interrupts
   2060795 ± 70%     -95.2%      99694        interrupts.CPU91.LOC:Local_timer_interrupts
   2056541 ± 69%     -95.2%      99693        interrupts.CPU92.LOC:Local_timer_interrupts
   2057239 ± 69%     -95.2%      99688        interrupts.CPU93.LOC:Local_timer_interrupts
   2057054 ± 69%     -95.2%      99689        interrupts.CPU94.LOC:Local_timer_interrupts
      1962 ± 90%     -54.3%     897.83 ±  2%  interrupts.CPU95.CAL:Function_call_interrupts
   2061707 ± 70%     -95.2%      99737        interrupts.CPU95.LOC:Local_timer_interrupts
   2092449 ± 68%     -95.2%      99727        interrupts.CPU96.LOC:Local_timer_interrupts
   2097480 ± 68%     -95.2%      99719        interrupts.CPU97.LOC:Local_timer_interrupts
   2094148 ± 68%     -95.2%      99790        interrupts.CPU98.LOC:Local_timer_interrupts
   2092333 ± 68%     -95.2%      99743        interrupts.CPU99.LOC:Local_timer_interrupts
  3.96e+08 ± 69%     -95.2%   19084179        interrupts.LOC:Local_timer_interrupts
    109203 ± 64%     -90.8%      10060 ±  9%  softirqs.CPU1.RCU
    113223 ± 64%     -93.1%       7866 ±  9%  softirqs.CPU100.RCU
    151958 ± 68%     -94.2%       8849 ±  3%  softirqs.CPU100.SCHED
    117243 ± 64%     -92.2%       9087 ± 23%  softirqs.CPU101.RCU
    116184 ± 64%     -92.9%       8232 ±  7%  softirqs.CPU102.RCU
    115692 ± 65%     -93.2%       7858 ±  7%  softirqs.CPU103.RCU
    116355 ± 65%     -93.1%       8003 ± 10%  softirqs.CPU104.RCU
    151113 ± 69%     -94.6%       8167 ± 11%  softirqs.CPU104.SCHED
    116978 ± 65%     -93.2%       7912 ±  9%  softirqs.CPU105.RCU
    141263 ± 76%     -94.2%       8169 ± 12%  softirqs.CPU105.SCHED
    116325 ± 65%     -93.8%       7259 ± 19%  softirqs.CPU106.RCU
    114571 ± 64%     -93.5%       7494 ± 18%  softirqs.CPU107.RCU
    149759 ± 70%     -94.2%       8680 ±  3%  softirqs.CPU108.SCHED
    114093 ± 65%     -93.6%       7284 ±  7%  softirqs.CPU109.RCU
    116629 ± 64%     -92.4%       8870 ± 19%  softirqs.CPU11.RCU
    114404 ± 65%     -93.6%       7368 ±  9%  softirqs.CPU110.RCU
    111229 ± 65%     -92.6%       8191 ± 13%  softirqs.CPU111.RCU
    105951 ± 64%     -93.4%       7038 ± 16%  softirqs.CPU112.RCU
    151312 ± 69%     -94.2%       8835        softirqs.CPU112.SCHED
    110710 ± 63%     -93.1%       7621 ± 11%  softirqs.CPU115.RCU
    151921 ± 69%     -94.9%       7803 ± 17%  softirqs.CPU115.SCHED
    110448 ± 64%     -93.1%       7575 ±  8%  softirqs.CPU116.RCU
    141915 ± 76%     -93.8%       8851 ±  3%  softirqs.CPU116.SCHED
    106739 ± 63%     -92.8%       7650 ±  4%  softirqs.CPU117.RCU
    140493 ± 76%     -93.7%       8855 ±  4%  softirqs.CPU117.SCHED
    110769 ± 64%     -93.1%       7648 ±  9%  softirqs.CPU118.RCU
    108031 ± 81%     -91.7%       8948 ±  2%  softirqs.CPU118.SCHED
    108640 ± 64%     -93.5%       7035 ±  9%  softirqs.CPU119.RCU
    151928 ± 69%     -94.6%       8254 ± 13%  softirqs.CPU119.SCHED
    103250 ± 66%     -90.9%       9425 ± 11%  softirqs.CPU12.RCU
    160789 ± 64%     -94.0%       9618 ±  7%  softirqs.CPU12.SCHED
    110764 ± 64%     -93.4%       7299 ± 16%  softirqs.CPU120.RCU
    149815 ± 67%     -94.1%       8892 ±  3%  softirqs.CPU120.SCHED
    147580 ± 68%     -94.1%       8772 ±  2%  softirqs.CPU121.SCHED
    108745 ± 63%     -93.6%       6961 ± 12%  softirqs.CPU123.RCU
    149424 ± 67%     -94.1%       8825 ±  2%  softirqs.CPU123.SCHED
    111492 ± 66%     -93.6%       7128 ±  9%  softirqs.CPU124.RCU
    149706 ± 68%     -94.1%       8863 ± 10%  softirqs.CPU124.SCHED
    113624 ± 64%     -93.9%       6887 ± 11%  softirqs.CPU125.RCU
    149720 ± 68%     -94.3%       8530 ±  6%  softirqs.CPU125.SCHED
    110642 ± 63%     -93.7%       6924 ± 11%  softirqs.CPU126.RCU
    149225 ± 68%     -94.2%       8704 ±  2%  softirqs.CPU126.SCHED
    112815 ± 64%     -93.9%       6859 ± 13%  softirqs.CPU127.RCU
    148298 ± 68%     -94.2%       8634 ±  5%  softirqs.CPU127.SCHED
    123462 ± 64%     -93.5%       8014 ±  9%  softirqs.CPU128.RCU
    148022 ± 68%     -93.9%       9017 ±  6%  softirqs.CPU128.SCHED
    123593 ± 63%     -93.6%       7896 ±  6%  softirqs.CPU129.RCU
    115226 ± 65%     -92.7%       8394 ± 14%  softirqs.CPU13.RCU
    121612 ± 65%     -93.3%       8147 ± 15%  softirqs.CPU130.RCU
    147624 ± 68%     -94.1%       8668 ±  4%  softirqs.CPU130.SCHED
    129961 ± 65%     -93.8%       8003 ±  8%  softirqs.CPU131.RCU
    148786 ± 68%     -94.1%       8797 ±  9%  softirqs.CPU131.SCHED
    128927 ± 65%     -94.1%       7588 ± 24%  softirqs.CPU132.RCU
    148300 ± 68%     -94.2%       8655 ±  4%  softirqs.CPU132.SCHED
    117562 ± 65%     -94.4%       6612 ± 21%  softirqs.CPU133.RCU
    123568 ± 65%     -93.9%       7588 ±  9%  softirqs.CPU134.RCU
    148036 ± 68%     -94.2%       8653 ±  3%  softirqs.CPU134.SCHED
    129843 ± 65%     -93.8%       8015 ±  7%  softirqs.CPU135.RCU
    149294 ± 68%     -94.2%       8643 ±  5%  softirqs.CPU135.SCHED
    125416 ± 64%     -93.9%       7695 ±  7%  softirqs.CPU136.RCU
    148423 ± 68%     -94.1%       8786        softirqs.CPU136.SCHED
    130767 ± 65%     -93.6%       8364 ± 12%  softirqs.CPU137.RCU
    127821 ± 64%     -93.8%       7981 ±  6%  softirqs.CPU138.RCU
    149725 ± 68%     -94.4%       8431 ±  6%  softirqs.CPU138.SCHED
    127332 ± 66%     -93.8%       7906 ± 13%  softirqs.CPU139.RCU
    147805 ± 68%     -94.2%       8592 ±  6%  softirqs.CPU139.SCHED
    115651 ± 65%     -92.8%       8308 ±  9%  softirqs.CPU14.RCU
    130555 ± 65%     -93.8%       8049 ±  9%  softirqs.CPU140.RCU
    139108 ± 75%     -93.8%       8587 ±  6%  softirqs.CPU140.SCHED
    127257 ± 65%     -93.9%       7743 ±  7%  softirqs.CPU141.RCU
    142016 ± 72%     -93.8%       8738 ± 10%  softirqs.CPU141.SCHED
    126034 ± 63%     -93.8%       7841 ±  9%  softirqs.CPU142.RCU
    149500 ± 68%     -94.2%       8708 ±  3%  softirqs.CPU142.SCHED
    124028 ± 64%     -93.7%       7871 ±  9%  softirqs.CPU143.RCU
    124733 ± 64%     -93.7%       7871 ± 10%  softirqs.CPU144.RCU
    110836 ± 66%     -92.8%       7951 ± 20%  softirqs.CPU144.SCHED
    122713 ± 64%     -93.7%       7768 ± 10%  softirqs.CPU145.RCU
    148298 ± 68%     -94.1%       8702 ±  3%  softirqs.CPU145.SCHED
    120031 ± 64%     -93.6%       7625 ± 11%  softirqs.CPU146.RCU
    126005 ± 64%     -93.8%       7825 ±  8%  softirqs.CPU147.RCU
    149992 ± 68%     -94.4%       8474 ±  6%  softirqs.CPU147.SCHED
    126110 ± 64%     -93.8%       7777 ±  9%  softirqs.CPU148.RCU
    149327 ± 68%     -94.3%       8443 ±  5%  softirqs.CPU148.SCHED
    125409 ± 64%     -93.6%       8054 ±  9%  softirqs.CPU149.RCU
    149733 ± 68%     -94.4%       8395 ±  6%  softirqs.CPU149.SCHED
    104961 ± 67%     -91.3%       9137 ± 19%  softirqs.CPU15.RCU
    127527 ± 63%     -93.8%       7923 ± 12%  softirqs.CPU150.RCU
    122526 ± 64%     -93.5%       7915 ± 11%  softirqs.CPU151.RCU
    146966 ± 68%     -94.3%       8423 ±  5%  softirqs.CPU151.SCHED
    124735 ± 64%     -93.9%       7623 ± 12%  softirqs.CPU152.RCU
    148910 ± 68%     -94.1%       8776 ±  4%  softirqs.CPU152.SCHED
    125755 ± 64%     -94.0%       7554 ± 10%  softirqs.CPU153.RCU
    127455 ± 64%     -93.9%       7798 ± 12%  softirqs.CPU154.RCU
    148528 ± 68%     -94.5%       8179 ± 11%  softirqs.CPU154.SCHED
    129425 ± 64%     -93.9%       7876 ± 12%  softirqs.CPU155.RCU
    148364 ± 68%     -94.4%       8320 ±  8%  softirqs.CPU155.SCHED
    119985 ± 64%     -93.9%       7268 ± 11%  softirqs.CPU156.RCU
    147460 ± 68%     -94.6%       7953 ± 12%  softirqs.CPU156.SCHED
    125097 ± 64%     -94.0%       7509 ± 10%  softirqs.CPU157.RCU
    148368 ± 67%     -94.3%       8507 ±  6%  softirqs.CPU157.SCHED
    125291 ± 64%     -93.8%       7801 ±  9%  softirqs.CPU158.RCU
    123953 ± 63%     -94.0%       7489 ±  9%  softirqs.CPU159.RCU
    108365 ± 64%     -93.2%       7402 ± 15%  softirqs.CPU16.RCU
    153385 ± 68%     -95.0%       7646 ± 21%  softirqs.CPU16.SCHED
    123098 ± 65%     -94.4%       6856 ± 13%  softirqs.CPU160.RCU
    149482 ± 68%     -94.2%       8657 ±  4%  softirqs.CPU160.SCHED
    122537 ± 64%     -94.1%       7274 ± 10%  softirqs.CPU161.RCU
    149805 ± 68%     -94.2%       8651 ±  3%  softirqs.CPU161.SCHED
    147169 ± 68%     -94.1%       8612 ±  5%  softirqs.CPU162.SCHED
    119813 ± 64%     -94.0%       7216 ± 13%  softirqs.CPU163.RCU
    148469 ± 68%     -94.3%       8473 ±  7%  softirqs.CPU163.SCHED
    123977 ± 64%     -94.0%       7433 ± 11%  softirqs.CPU164.RCU
    149938 ± 68%     -94.2%       8683 ±  5%  softirqs.CPU164.SCHED
    121654 ± 64%     -94.1%       7230 ± 11%  softirqs.CPU165.RCU
    149472 ± 68%     -94.3%       8541 ±  5%  softirqs.CPU165.SCHED
    122950 ± 64%     -93.6%       7870 ± 28%  softirqs.CPU166.RCU
    149832 ± 68%     -94.2%       8664 ±  6%  softirqs.CPU166.SCHED
    121048 ± 65%     -94.4%       6728 ± 13%  softirqs.CPU167.RCU
    148706 ± 68%     -94.1%       8739 ±  2%  softirqs.CPU167.SCHED
    114551 ± 62%     -94.0%       6894 ± 16%  softirqs.CPU168.RCU
    122069 ± 79%     -92.9%       8646        softirqs.CPU168.SCHED
    105872 ± 65%     -93.9%       6456 ± 10%  softirqs.CPU169.RCU
    148053 ± 67%     -94.2%       8600 ±  3%  softirqs.CPU169.SCHED
    110118 ± 64%     -93.0%       7673 ± 12%  softirqs.CPU17.RCU
    133781 ± 71%     -93.5%       8740        softirqs.CPU17.SCHED
    111283 ± 63%     -94.2%       6416 ± 12%  softirqs.CPU170.RCU
    111786 ± 63%     -94.2%       6475 ± 11%  softirqs.CPU171.RCU
    150221 ± 68%     -94.3%       8500 ±  4%  softirqs.CPU171.SCHED
    114410 ± 63%     -94.3%       6548 ± 12%  softirqs.CPU172.RCU
    150130 ± 67%     -94.3%       8601 ±  3%  softirqs.CPU172.SCHED
    112976 ± 64%     -94.2%       6581 ± 13%  softirqs.CPU173.RCU
    149208 ± 67%     -94.2%       8627 ±  3%  softirqs.CPU173.SCHED
    113819 ± 64%     -94.3%       6490 ± 13%  softirqs.CPU174.RCU
    149221 ± 67%     -94.3%       8471 ±  4%  softirqs.CPU174.SCHED
    110329 ± 63%     -94.3%       6234 ± 12%  softirqs.CPU175.RCU
    147917 ± 68%     -94.2%       8542 ±  3%  softirqs.CPU175.SCHED
    116639 ± 64%     -93.9%       7071 ± 11%  softirqs.CPU176.RCU
    147299 ± 68%     -94.4%       8264 ±  8%  softirqs.CPU176.SCHED
    119745 ± 63%     -93.9%       7278 ± 12%  softirqs.CPU177.RCU
    149590 ± 67%     -94.2%       8727 ±  9%  softirqs.CPU177.SCHED
    116001 ± 62%     -93.9%       7073 ± 26%  softirqs.CPU178.RCU
    147957 ± 67%     -93.9%       9024 ±  9%  softirqs.CPU178.SCHED
    121235 ± 63%     -93.7%       7643 ± 13%  softirqs.CPU179.RCU
    149512 ± 67%     -94.3%       8468 ±  4%  softirqs.CPU179.SCHED
    108025 ± 64%     -92.2%       8375 ± 11%  softirqs.CPU18.RCU
    118463 ± 63%     -93.8%       7392 ± 11%  softirqs.CPU180.RCU
    148243 ± 67%     -94.3%       8500 ±  4%  softirqs.CPU180.SCHED
    110986 ± 63%     -93.8%       6855 ±  8%  softirqs.CPU181.RCU
    146154 ± 69%     -94.5%       8104 ±  8%  softirqs.CPU181.SCHED
    116419 ± 63%     -94.6%       6318 ± 16%  softirqs.CPU182.RCU
    147850 ± 68%     -94.0%       8827 ±  9%  softirqs.CPU182.SCHED
    118252 ± 64%     -93.6%       7521 ± 14%  softirqs.CPU183.RCU
    149786 ± 67%     -94.3%       8489 ±  6%  softirqs.CPU183.SCHED
    118365 ± 63%     -93.9%       7253 ± 12%  softirqs.CPU184.RCU
    147765 ± 67%     -94.3%       8371 ±  6%  softirqs.CPU184.SCHED
    122383 ± 63%     -94.1%       7271 ± 11%  softirqs.CPU185.RCU
    149394 ± 68%     -94.4%       8356 ±  6%  softirqs.CPU185.SCHED
    120429 ± 62%     -93.7%       7574 ± 12%  softirqs.CPU186.RCU
    149854 ± 67%     -94.4%       8380 ±  5%  softirqs.CPU186.SCHED
    119197 ± 63%     -94.0%       7138 ± 10%  softirqs.CPU187.RCU
    148244 ± 68%     -94.3%       8449 ±  4%  softirqs.CPU187.SCHED
    119404 ± 63%     -93.8%       7419 ± 10%  softirqs.CPU188.RCU
    149632 ± 68%     -94.3%       8530 ±  3%  softirqs.CPU188.SCHED
    120882 ± 64%     -93.8%       7514 ± 15%  softirqs.CPU189.RCU
    149025 ± 68%     -94.1%       8767 ±  2%  softirqs.CPU189.SCHED
    122709 ± 63%     -93.9%       7478 ± 16%  softirqs.CPU190.RCU
    149896 ± 67%     -94.4%       8468 ±  4%  softirqs.CPU190.SCHED
    119663 ± 63%     -93.8%       7369 ± 13%  softirqs.CPU191.RCU
    112674 ± 74%     -94.0%       6733 ± 19%  softirqs.CPU191.SCHED
    112982 ± 63%     -92.2%       8794 ± 14%  softirqs.CPU2.RCU
    154130 ± 68%     -94.2%       8915 ±  6%  softirqs.CPU20.SCHED
    108269 ± 63%     -93.3%       7304 ±  7%  softirqs.CPU21.RCU
    153646 ± 68%     -94.3%       8770 ±  3%  softirqs.CPU23.SCHED
    114483 ± 63%     -93.4%       7594 ±  9%  softirqs.CPU24.RCU
    152410 ± 68%     -92.9%      10804 ± 39%  softirqs.CPU24.SCHED
    149863 ± 67%     -94.1%       8826 ±  2%  softirqs.CPU26.SCHED
    111037 ± 63%     -93.3%       7444 ± 10%  softirqs.CPU27.RCU
    150624 ± 67%     -94.0%       9030 ±  6%  softirqs.CPU27.SCHED
    115159 ± 64%     -93.6%       7358 ± 13%  softirqs.CPU28.RCU
    115304 ± 64%     -93.8%       7140 ± 11%  softirqs.CPU29.RCU
    115840 ± 65%     -92.6%       8543 ± 13%  softirqs.CPU3.RCU
    111988 ± 63%     -93.4%       7380 ±  9%  softirqs.CPU30.RCU
    150325 ± 67%     -93.6%       9646 ± 20%  softirqs.CPU30.SCHED
    113558 ± 64%     -93.5%       7345 ± 10%  softirqs.CPU31.RCU
    149416 ± 67%     -94.6%       7997 ± 21%  softirqs.CPU31.SCHED
    124252 ± 63%     -93.4%       8203 ± 12%  softirqs.CPU32.RCU
    149576 ± 67%     -93.9%       9139 ±  4%  softirqs.CPU32.SCHED
    124998 ± 63%     -93.5%       8137 ± 13%  softirqs.CPU33.RCU
    150841 ± 67%     -93.3%      10037 ± 27%  softirqs.CPU33.SCHED
    124499 ± 64%     -93.6%       7952 ± 10%  softirqs.CPU34.RCU
    148690 ± 68%     -94.1%       8719 ±  2%  softirqs.CPU34.SCHED
    132859 ± 64%     -93.7%       8352 ±  6%  softirqs.CPU35.RCU
    146868 ± 69%     -94.1%       8707 ±  3%  softirqs.CPU35.SCHED
    132598 ± 64%     -93.7%       8339 ±  7%  softirqs.CPU36.RCU
    149836 ± 67%     -94.2%       8758        softirqs.CPU36.SCHED
    119630 ± 64%     -93.4%       7836 ± 15%  softirqs.CPU37.RCU
    148760 ± 67%     -94.2%       8670 ±  5%  softirqs.CPU37.SCHED
    124654 ± 64%     -93.8%       7682 ± 12%  softirqs.CPU38.RCU
    149035 ± 67%     -94.1%       8847 ±  8%  softirqs.CPU38.SCHED
    131082 ± 64%     -93.8%       8149 ±  9%  softirqs.CPU39.RCU
    150449 ± 68%     -94.4%       8492 ±  6%  softirqs.CPU39.SCHED
    105009 ± 66%     -91.6%       8820 ± 18%  softirqs.CPU4.RCU
    154780 ± 67%     -94.2%       8968        softirqs.CPU4.SCHED
     17689 ±118%     -99.6%      72.00 ±101%  softirqs.CPU4.TIMER
    127579 ± 64%     -93.5%       8250 ±  9%  softirqs.CPU40.RCU
    133811 ± 65%     -93.6%       8598 ±  7%  softirqs.CPU41.RCU
    150205 ± 68%     -94.3%       8580 ±  4%  softirqs.CPU41.SCHED
    129041 ± 64%     -93.4%       8566 ±  8%  softirqs.CPU42.RCU
    132080 ± 70%     -93.6%       8505 ±  6%  softirqs.CPU42.SCHED
    128748 ± 64%     -93.5%       8304 ±  8%  softirqs.CPU43.RCU
    131774 ± 64%     -93.6%       8406 ±  7%  softirqs.CPU44.RCU
    151162 ± 67%     -94.2%       8763        softirqs.CPU44.SCHED
    130388 ± 65%     -93.7%       8211 ±  8%  softirqs.CPU45.RCU
    129013 ± 63%     -93.5%       8411 ±  6%  softirqs.CPU46.RCU
    150584 ± 67%     -94.2%       8690 ±  4%  softirqs.CPU46.SCHED
    127214 ± 63%     -93.4%       8448 ±  6%  softirqs.CPU47.RCU
    150102 ± 67%     -94.2%       8695 ±  4%  softirqs.CPU47.SCHED
    129339 ± 63%     -93.3%       8677 ±  9%  softirqs.CPU48.RCU
    149648 ± 67%     -94.1%       8816 ±  2%  softirqs.CPU48.SCHED
    123919 ± 64%     -93.5%       8104 ± 13%  softirqs.CPU49.RCU
    130995 ± 70%     -92.7%       9599 ± 17%  softirqs.CPU49.SCHED
    115696 ± 64%     -92.3%       8857 ± 16%  softirqs.CPU5.RCU
    153724 ± 68%     -94.5%       8460 ± 13%  softirqs.CPU5.SCHED
    122019 ± 64%     -93.4%       8015 ± 10%  softirqs.CPU50.RCU
    149117 ± 67%     -94.2%       8690 ±  3%  softirqs.CPU50.SCHED
    127366 ± 64%     -93.2%       8660 ±  9%  softirqs.CPU51.RCU
    151299 ± 67%     -94.0%       9024 ±  7%  softirqs.CPU51.SCHED
    127290 ± 63%     -93.3%       8523 ± 10%  softirqs.CPU52.RCU
    150552 ± 67%     -94.2%       8700 ±  2%  softirqs.CPU52.SCHED
    125891 ± 63%     -92.8%       9063 ± 19%  softirqs.CPU53.RCU
    150863 ± 67%     -94.3%       8568 ±  3%  softirqs.CPU53.SCHED
    127241 ± 63%     -93.4%       8372 ±  9%  softirqs.CPU54.RCU
    145834 ± 67%     -94.2%       8530 ±  4%  softirqs.CPU54.SCHED
    125112 ± 64%     -93.4%       8278 ± 11%  softirqs.CPU55.RCU
    148711 ± 67%     -94.3%       8423 ±  6%  softirqs.CPU55.SCHED
    127381 ± 63%     -93.7%       8067 ±  9%  softirqs.CPU56.RCU
    150186 ± 67%     -94.4%       8460 ±  5%  softirqs.CPU56.SCHED
    127215 ± 63%     -93.6%       8182 ± 10%  softirqs.CPU57.RCU
    128926 ± 64%     -93.4%       8550 ± 10%  softirqs.CPU58.RCU
    130143 ± 64%     -93.6%       8382 ±  9%  softirqs.CPU59.RCU
    116628 ± 64%     -92.3%       9006 ± 14%  softirqs.CPU6.RCU
    153747 ± 68%     -94.5%       8445 ± 12%  softirqs.CPU6.SCHED
    122775 ± 64%     -93.3%       8180 ± 15%  softirqs.CPU60.RCU
    128062 ± 63%     -93.6%       8172 ±  8%  softirqs.CPU61.RCU
    127079 ± 64%     -93.5%       8265 ±  8%  softirqs.CPU62.RCU
    150289 ± 68%     -94.6%       8171 ± 13%  softirqs.CPU62.SCHED
    125522 ± 63%     -93.5%       8198 ± 10%  softirqs.CPU63.RCU
    121152 ± 64%     -94.1%       7177 ± 13%  softirqs.CPU64.RCU
    150317 ± 68%     -94.3%       8559 ±  5%  softirqs.CPU64.SCHED
    120833 ± 64%     -93.8%       7435 ± 12%  softirqs.CPU65.RCU
    150746 ± 67%     -94.2%       8671 ±  3%  softirqs.CPU65.SCHED
    148502 ± 67%     -94.5%       8153 ± 11%  softirqs.CPU66.SCHED
    118685 ± 63%     -93.7%       7428 ± 12%  softirqs.CPU67.RCU
    149722 ± 68%     -94.3%       8495 ±  6%  softirqs.CPU67.SCHED
    121390 ± 64%     -93.9%       7422 ± 11%  softirqs.CPU68.RCU
    151105 ± 67%     -94.2%       8693 ±  3%  softirqs.CPU68.SCHED
    119472 ± 64%     -93.7%       7566 ± 11%  softirqs.CPU69.RCU
    150496 ± 68%     -94.2%       8688 ±  2%  softirqs.CPU69.SCHED
    154074 ± 67%     -92.4%      11656 ± 56%  softirqs.CPU7.SCHED
    120922 ± 64%     -93.9%       7406 ±  9%  softirqs.CPU70.RCU
    150704 ± 67%     -94.2%       8803 ±  4%  softirqs.CPU70.SCHED
    119375 ± 64%     -93.9%       7263 ± 12%  softirqs.CPU71.RCU
    149863 ± 68%     -94.2%       8664 ±  7%  softirqs.CPU71.SCHED
    111005 ± 63%     -93.7%       6998 ± 11%  softirqs.CPU72.RCU
    150233 ± 67%     -94.2%       8686 ±  4%  softirqs.CPU72.SCHED
    104843 ± 64%     -93.4%       6902 ± 14%  softirqs.CPU73.RCU
    148588 ± 67%     -94.2%       8651 ±  6%  softirqs.CPU73.SCHED
    110154 ± 64%     -93.8%       6868 ± 12%  softirqs.CPU74.RCU
    148798 ± 67%     -94.2%       8556 ±  5%  softirqs.CPU74.SCHED
    110454 ± 63%     -93.7%       6928 ± 13%  softirqs.CPU75.RCU
    150903 ± 67%     -94.4%       8523 ±  2%  softirqs.CPU75.SCHED
    112724 ± 64%     -93.7%       7154 ± 19%  softirqs.CPU76.RCU
    138459 ± 75%     -93.8%       8546 ±  2%  softirqs.CPU76.SCHED
    112104 ± 63%     -93.8%       6914 ± 11%  softirqs.CPU77.RCU
    149101 ± 67%     -94.3%       8513 ±  3%  softirqs.CPU77.SCHED
    112588 ± 63%     -93.9%       6911 ± 13%  softirqs.CPU78.RCU
    149708 ± 67%     -94.4%       8393 ±  4%  softirqs.CPU78.SCHED
    110048 ± 62%     -93.9%       6723 ± 11%  softirqs.CPU79.RCU
    147848 ± 67%     -94.2%       8565 ±  3%  softirqs.CPU79.SCHED
    115855 ± 64%     -92.4%       8807 ± 11%  softirqs.CPU8.RCU
    116494 ± 64%     -93.6%       7491 ± 11%  softirqs.CPU80.RCU
    147359 ± 67%     -94.0%       8814 ±  7%  softirqs.CPU80.SCHED
    118977 ± 64%     -93.4%       7864 ± 14%  softirqs.CPU81.RCU
    132892 ± 72%     -93.3%       8864 ±  9%  softirqs.CPU81.SCHED
    114845 ± 62%     -93.2%       7777 ± 12%  softirqs.CPU82.RCU
    147412 ± 67%     -94.2%       8482 ±  3%  softirqs.CPU82.SCHED
    119020 ± 63%     -93.5%       7737 ± 12%  softirqs.CPU83.RCU
    148764 ± 67%     -94.3%       8505 ±  3%  softirqs.CPU83.SCHED
    117370 ± 63%     -93.0%       8197 ± 15%  softirqs.CPU84.RCU
    148341 ± 67%     -94.4%       8342 ±  6%  softirqs.CPU84.SCHED
    110505 ± 63%     -93.3%       7384 ±  8%  softirqs.CPU85.RCU
    147243 ± 67%     -94.0%       8860 ±  6%  softirqs.CPU85.SCHED
    116180 ± 64%     -93.8%       7241 ±  9%  softirqs.CPU86.RCU
    117479 ± 64%     -92.9%       8352 ± 20%  softirqs.CPU87.RCU
    148839 ± 67%     -94.3%       8503 ±  4%  softirqs.CPU87.SCHED
    117183 ± 63%     -93.4%       7774 ± 14%  softirqs.CPU88.RCU
    147831 ± 67%     -94.2%       8532 ±  4%  softirqs.CPU88.SCHED
    122275 ± 64%     -93.7%       7716 ± 13%  softirqs.CPU89.RCU
    131592 ± 72%     -93.5%       8601 ±  3%  softirqs.CPU89.SCHED
    116874 ± 65%     -92.9%       8272 ±  9%  softirqs.CPU9.RCU
    119581 ± 63%     -93.2%       8090 ± 12%  softirqs.CPU90.RCU
    148439 ± 67%     -94.3%       8409 ±  4%  softirqs.CPU90.SCHED
    118155 ± 64%     -93.5%       7662 ± 12%  softirqs.CPU91.RCU
    148239 ± 67%     -94.4%       8358 ±  5%  softirqs.CPU91.SCHED
    117316 ± 63%     -93.5%       7655 ± 11%  softirqs.CPU92.RCU
    149861 ± 67%     -94.4%       8365 ±  5%  softirqs.CPU92.SCHED
    120225 ± 64%     -93.4%       7924 ± 15%  softirqs.CPU93.RCU
    148019 ± 67%     -94.3%       8453 ±  4%  softirqs.CPU93.SCHED
    121766 ± 63%     -93.5%       7946 ± 11%  softirqs.CPU94.RCU
    149826 ± 67%     -94.3%       8589 ± 12%  softirqs.CPU94.SCHED
    119660 ± 63%     -93.3%       8032 ± 13%  softirqs.CPU95.RCU
     43189 ±103%     -88.1%       5132 ± 19%  softirqs.CPU95.SCHED
    113448 ± 64%     -93.6%       7293 ± 12%  softirqs.CPU96.RCU
    111933 ± 63%     -93.1%       7728 ± 11%  softirqs.CPU97.RCU
    150578 ± 69%     -94.3%       8569 ±  3%  softirqs.CPU97.SCHED
    114746 ± 64%     -93.4%       7593 ±  7%  softirqs.CPU98.RCU
    141568 ± 67%     -93.9%       8571        softirqs.CPU98.SCHED
    115851 ± 65%     -93.5%       7569 ± 10%  softirqs.CPU99.RCU
    152615 ± 68%     -94.6%       8175 ± 13%  softirqs.CPU99.SCHED
  22745357 ± 64%     -93.5%    1483190 ±  7%  softirqs.RCU
  28274266 ± 68%     -94.1%    1669584 ±  2%  softirqs.SCHED
    187310 ± 57%     -82.9%      32111 ±  2%  softirqs.TIMER



***************************************************************************************************
lkp-csl-2ap2: 192 threads 4 sockets Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory
=========================================================================================
compiler/cpufreq_governor/disk/filesize/fs2/fs/iterations/kconfig/nr_threads/rootfs/sync_method/tbox_group/test_size/testcase/ucode:
  gcc-9/performance/1BRD_48G/4M/nfsv4/xfs/1x/x86_64-rhel-8.3/1t/debian-10.4-x86_64-20200603.cgz/fsyncBeforeClose/lkp-csl-2ap2/24G/fsmark/0x5003006

commit: 
  0bcc7ca40b ("nfsd: fix crash on LOCKT on reexported NFSv3")
  e38b3f2005 ("SUNRPC: don't pause on incomplete allocation")

0bcc7ca40bd82319 e38b3f20059426a0adbde014ff7 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 1.013e+08 ± 70%     -99.7%     325230 ± 12%  fsmark.app_overhead
     16.76 ±104%    +804.1%     151.55        fsmark.files_per_sec
      1162 ± 67%     -96.4%      42.06        fsmark.time.elapsed_time
      1162 ± 67%     -96.4%      42.06        fsmark.time.elapsed_time.max
      4.88 ±103%    +800.0%      43.88        fsmark.time.percent_of_cpu_this_job_got
   1030449 ±  4%      +6.9%    1101601        fsmark.time.voluntary_context_switches
 2.153e+11 ± 67%     -96.3%  8.056e+09        cpuidle..time
 3.488e+08 ± 78%     -94.9%   17850901        cpuidle..usage
      4640 ± 33%     -77.5%       1044 ±  4%  numa-vmstat.node3.nr_active_anon
      4640 ± 33%     -77.5%       1044 ±  4%  numa-vmstat.node3.nr_zone_active_anon
      1211 ± 65%     -92.4%      92.65        uptime.boot
    225136 ± 65%     -92.7%      16533        uptime.idle
     18589 ± 33%     -77.5%       4183 ±  4%  numa-meminfo.node3.Active
     18577 ± 33%     -77.5%       4183 ±  4%  numa-meminfo.node3.Active(anon)
     84888 ±101%     -79.8%      17178 ± 13%  numa-meminfo.node3.AnonPages.max
      5.06 ± 20%      -1.3        3.74 ± 28%  turbostat.Busy%
 1.001e+08 ± 94%     -98.9%    1059770 ±161%  turbostat.C6
 1.644e+08 ± 73%     -94.7%    8715770 ±  2%  turbostat.IRQ
     30.14 ±101%    +207.0%      92.52 ± 13%  turbostat.PkgWatt
      0.22 ±  9%      -0.2        0.04 ± 12%  mpstat.cpu.all.iowait%
      2.33 ± 18%      -0.8        1.55 ± 18%  mpstat.cpu.all.irq%
      0.15 ± 12%      -0.0        0.12 ± 14%  mpstat.cpu.all.soft%
      0.12 ± 86%      +0.7        0.86        mpstat.cpu.all.sys%
      0.01 ± 59%      +0.0        0.05 ± 17%  mpstat.cpu.all.usr%
     67317 ±103%    +732.4%     560347        vmstat.io.bo
  42363724 ± 10%     -32.4%   28621274 ±  2%  vmstat.memory.cache
 1.335e+08 ±  4%     +14.5%  1.528e+08        vmstat.memory.free
      0.00         +2e+102%       2.00        vmstat.procs.r
     10465 ± 81%    +586.7%      71873        vmstat.system.cs
     33248 ± 44%     -79.8%       6731 ±  4%  meminfo.Active
     32902 ± 44%     -79.8%       6638 ±  4%  meminfo.Active(anon)
    253144 ±  9%     -41.2%     148942        meminfo.AnonHugePages
  42110320 ± 10%     -32.6%   28401885 ±  2%  meminfo.Cached
      1504 ± 10%     -30.7%       1041 ± 16%  meminfo.Dirty
  40026862 ± 10%     -34.1%   26363521 ±  2%  meminfo.Inactive
  39675639 ± 10%     -34.5%   25994766 ±  2%  meminfo.Inactive(file)
    290840 ±  5%     -19.0%     235488        meminfo.KReclaimable
 1.335e+08 ±  4%     +14.6%   1.53e+08        meminfo.MemFree
  64243558 ±  9%     -30.4%   44715505 ±  2%  meminfo.Memused
      1731 ± 20%    -100.0%       0.00        meminfo.Mlocked
      4269 ±  5%     +14.3%       4879        meminfo.PageTables
    290840 ±  5%     -19.0%     235488        meminfo.SReclaimable
     53252 ± 28%     -51.4%      25904        meminfo.Shmem
    633284 ±  2%     -11.1%     563096 ±  2%  meminfo.Slab
  64349514 ±  9%     -29.3%   45503501 ±  2%  meminfo.max_used_kB
      4879 ± 10%     -33.1%       3265 ±  2%  nfsstat.Client.nfs.v4.close
      4878 ± 10%     -33.1%       3264 ±  2%  nfsstat.Client.nfs.v4.commit
    614.75 ± 69%    -100.0%       0.00        nfsstat.Client.nfs.v4.delegreturn
     12.25 ± 53%     -75.5%       3.00        nfsstat.Client.nfs.v4.getattr
      4883 ± 10%     -33.1%       3269 ±  2%  nfsstat.Client.nfs.v4.lookup
      4880 ± 10%     -33.1%       3266 ±  2%  nfsstat.Client.nfs.v4.open
     19517 ± 10%     -33.1%      13060 ±  2%  nfsstat.Client.nfs.v4.write
     39703 ± 10%     -34.1%      26156 ±  2%  nfsstat.Client.rpc.authrefrsh
     39703 ± 10%     -34.1%      26156 ±  2%  nfsstat.Client.rpc.calls
 2.586e+09 ± 19%     -23.5%  1.979e+09 ±  7%  nfsstat.Server.io.write
     39701 ± 10%     -34.1%      26154 ±  2%  nfsstat.Server.nfs.v4.compound
      4884 ± 10%     -33.1%       3269 ±  2%  nfsstat.Server.nfs.v4.operations.access
      4879 ± 10%     -33.1%       3265 ±  2%  nfsstat.Server.nfs.v4.operations.close
      4878 ± 10%     -33.1%       3264 ±  2%  nfsstat.Server.nfs.v4.operations.commit
    614.62 ± 69%    -100.0%       0.00        nfsstat.Server.nfs.v4.operations.delegreturn
     32346 ± 11%     -29.3%      22884 ±  2%  nfsstat.Server.nfs.v4.operations.getattr
      9765 ± 10%     -33.1%       6537 ±  2%  nfsstat.Server.nfs.v4.operations.getfh
      4883 ± 10%     -33.1%       3268 ±  2%  nfsstat.Server.nfs.v4.operations.lookup
      4880 ± 10%     -33.1%       3266 ±  2%  nfsstat.Server.nfs.v4.operations.open
     39686 ± 10%     -34.1%      26149 ±  2%  nfsstat.Server.nfs.v4.operations.putfh
     19516 ± 10%     -33.1%      13059 ±  2%  nfsstat.Server.nfs.v4.operations.write
     39702 ± 10%     -34.1%      26155 ±  2%  nfsstat.Server.packet.packets
     39702 ± 10%     -34.1%      26155 ±  2%  nfsstat.Server.packet.tcp
     19522 ± 10%     -33.1%      13065 ±  2%  nfsstat.Server.reply.cache.misses
     20179 ± 10%     -35.1%      13089 ±  2%  nfsstat.Server.reply.cache.nocache
     39702 ± 10%     -34.1%      26155 ±  2%  nfsstat.Server.rpc.calls
    332431 ±128%    -100.0%       0.00        proc-vmstat.compact_free_scanned
     27468 ± 68%    -100.0%       0.00        proc-vmstat.compact_isolated
    890053 ±187%    -100.0%       0.00        proc-vmstat.compact_migrate_scanned
      8225 ± 44%     -79.8%       1659 ±  4%  proc-vmstat.nr_active_anon
     82818 ±  2%      +5.7%      87528        proc-vmstat.nr_anon_pages
    122.88 ±  9%     -41.1%      72.38        proc-vmstat.nr_anon_transparent_hugepages
    370.75 ± 11%     -29.2%     262.38 ± 13%  proc-vmstat.nr_dirty
   4304114            +3.4%    4450034        proc-vmstat.nr_dirty_background_threshold
   8618754            +3.4%    8910950        proc-vmstat.nr_dirty_threshold
  10527203 ± 10%     -32.5%    7101028 ±  2%  proc-vmstat.nr_file_pages
  33368299 ±  4%     +14.6%   38248993        proc-vmstat.nr_free_pages
     87805            +5.0%      92189        proc-vmstat.nr_inactive_anon
   9918276 ± 10%     -34.5%    6498985 ±  2%  proc-vmstat.nr_inactive_file
      9105 ±  2%      +3.5%       9420        proc-vmstat.nr_mapped
    432.62 ± 20%    -100.0%       0.00        proc-vmstat.nr_mlock
      1064 ±  5%     +14.6%       1219        proc-vmstat.nr_page_table_pages
     13312 ± 28%     -51.4%       6476        proc-vmstat.nr_shmem
     72708 ±  5%     -19.0%      58874        proc-vmstat.nr_slab_reclaimable
      8225 ± 44%     -79.8%       1659 ±  4%  proc-vmstat.nr_zone_active_anon
     87805            +5.0%      92189        proc-vmstat.nr_zone_inactive_anon
   9918276 ± 10%     -34.5%    6498984 ±  2%  proc-vmstat.nr_zone_inactive_file
      7513 ± 18%     -95.7%     325.38 ±247%  proc-vmstat.numa_hint_faults
      5157 ± 34%     -94.0%     309.88 ±259%  proc-vmstat.numa_hint_faults_local
     46603 ± 27%     -87.1%       6026 ±156%  proc-vmstat.numa_pte_updates
      8545 ± 30%     -81.3%       1600 ± 14%  proc-vmstat.pgactivate
   4244178 ± 63%     -90.1%     419545        proc-vmstat.pgfault
     15238 ± 64%     -95.3%     712.50 ±235%  proc-vmstat.pgmigrate_success
    284968 ± 65%     -92.3%      21934 ±  4%  proc-vmstat.pgreuse
    252373 ±208%    -100.0%       0.00        proc-vmstat.pgscan_file
    252373 ±208%    -100.0%       0.00        proc-vmstat.pgsteal_file
    817.62 ± 70%    -100.0%       0.00        proc-vmstat.workingset_nodes
 3.724e+08 ± 34%    +207.3%  1.144e+09 ±  2%  perf-stat.i.branch-instructions
      8.03 ± 60%      -6.7        1.29 ± 70%  perf-stat.i.branch-miss-rate%
      8.31 ± 56%      +8.2       16.55 ± 18%  perf-stat.i.cache-miss-rate%
   6971632 ± 46%    +147.4%   17248148 ± 19%  perf-stat.i.cache-misses
     10525 ± 81%    +625.8%      76394        perf-stat.i.context-switches
      6.80 ± 36%     -69.7%       2.06 ± 14%  perf-stat.i.cpi
    197.68 ±  4%     +18.7%     234.61        perf-stat.i.cpu-migrations
      2542 ± 51%     -71.7%     718.89 ±  6%  perf-stat.i.cycles-between-cache-misses
 5.035e+08 ± 33%    +204.1%  1.531e+09        perf-stat.i.dTLB-loads
      0.20 ± 65%      -0.2        0.02 ±140%  perf-stat.i.dTLB-store-miss-rate%
 2.694e+08 ± 32%    +193.4%  7.904e+08        perf-stat.i.dTLB-stores
   1634756 ± 16%     +69.5%    2771653 ±  6%  perf-stat.i.iTLB-load-misses
   1534112 ± 67%     +92.5%    2953531 ± 13%  perf-stat.i.iTLB-loads
  1.85e+09 ± 35%    +211.3%  5.758e+09 ±  2%  perf-stat.i.instructions
      1052 ± 22%     +97.4%       2077 ±  7%  perf-stat.i.instructions-per-iTLB-miss
      0.19 ± 40%    +163.9%       0.50 ± 12%  perf-stat.i.ipc
      1.18 ± 87%    +346.2%       5.26 ± 10%  perf-stat.i.major-faults
      5.67 ± 41%    +220.3%      18.18 ±  2%  perf-stat.i.metric.M/sec
      3846 ± 13%     +93.4%       7438        perf-stat.i.minor-faults
     86.47 ±  6%     -26.0       60.50 ±  6%  perf-stat.i.node-load-miss-rate%
    727465 ± 85%    +208.6%    2244747 ± 31%  perf-stat.i.node-load-misses
    209076 ± 96%    +510.5%    1276514 ±  6%  perf-stat.i.node-loads
     71.46 ± 15%     -24.1       47.36 ±  5%  perf-stat.i.node-store-miss-rate%
    390113 ± 80%    +512.2%    2388094 ±  5%  perf-stat.i.node-store-misses
    468202 ±101%    +516.7%    2887527 ± 10%  perf-stat.i.node-stores
      3847 ± 14%     +93.5%       7444        perf-stat.i.page-faults
      7.19 ± 64%      -5.8        1.41 ± 62%  perf-stat.overall.branch-miss-rate%
      6.09 ± 40%     -67.1%       2.00 ± 14%  perf-stat.overall.cpi
      1786 ± 52%     -62.0%     678.12 ± 10%  perf-stat.overall.cycles-between-cache-misses
      0.18 ± 71%      -0.2        0.02 ±134%  perf-stat.overall.dTLB-store-miss-rate%
      1110 ± 25%     +87.8%       2086 ±  7%  perf-stat.overall.instructions-per-iTLB-miss
      0.20 ± 43%    +157.4%       0.51 ± 12%  perf-stat.overall.ipc
     79.97 ±  3%     -17.4       62.56 ±  8%  perf-stat.overall.node-load-miss-rate%
 3.709e+08 ± 34%    +201.2%  1.117e+09 ±  2%  perf-stat.ps.branch-instructions
   6940806 ± 46%    +142.7%   16844018 ± 19%  perf-stat.ps.cache-misses
     10461 ± 81%    +613.1%      74600        perf-stat.ps.context-switches
    191484            -2.1%     187525        perf-stat.ps.cpu-clock
    197.14 ±  3%     +16.3%     229.20        perf-stat.ps.cpu-migrations
 5.015e+08 ± 33%    +198.1%  1.495e+09        perf-stat.ps.dTLB-loads
 2.683e+08 ± 32%    +187.6%  7.717e+08        perf-stat.ps.dTLB-stores
   1629701 ± 16%     +66.0%    2706010 ±  6%  perf-stat.ps.iTLB-load-misses
   1528612 ± 67%     +88.6%    2883595 ± 13%  perf-stat.ps.iTLB-loads
 1.842e+09 ± 35%    +205.2%  5.622e+09 ±  2%  perf-stat.ps.instructions
      1.17 ± 86%    +338.9%       5.15 ± 10%  perf-stat.ps.major-faults
      3829 ± 13%     +88.9%       7234        perf-stat.ps.minor-faults
    722755 ± 84%    +203.3%    2191856 ± 31%  perf-stat.ps.node-load-misses
    207723 ± 96%    +500.3%    1246943 ±  6%  perf-stat.ps.node-loads
    387928 ± 80%    +500.9%    2331078 ±  5%  perf-stat.ps.node-store-misses
    464924 ±101%    +506.7%    2820604 ± 10%  perf-stat.ps.node-stores
      3830 ± 13%     +89.0%       7239        perf-stat.ps.page-faults
    191484            -2.1%     187525        perf-stat.ps.task-clock
 1.687e+12 ± 64%     -85.7%   2.41e+11 ±  2%  perf-stat.total.instructions
      3196 ± 24%     -45.3%       1748 ± 12%  slabinfo.Acpi-Parse.active_objs
      3196 ± 24%     -45.3%       1748 ± 12%  slabinfo.Acpi-Parse.num_objs
     10527 ±  7%     -13.9%       9067 ±  9%  slabinfo.Acpi-State.active_objs
     10527 ±  7%     -13.9%       9068 ±  9%  slabinfo.Acpi-State.num_objs
    678.75 ± 12%     -29.4%     478.88 ± 17%  slabinfo.biovec-128.active_objs
    678.75 ± 12%     -29.4%     478.88 ± 17%  slabinfo.biovec-128.num_objs
    331.25 ± 14%     -36.6%     209.88 ± 21%  slabinfo.biovec-max.active_objs
    331.25 ± 14%     -36.6%     209.88 ± 21%  slabinfo.biovec-max.num_objs
      1865 ± 18%     -40.2%       1116 ± 10%  slabinfo.file_lock_cache.active_objs
      1865 ± 18%     -40.2%       1116 ± 10%  slabinfo.file_lock_cache.num_objs
      9498 ±  9%     -22.6%       7352 ± 10%  slabinfo.fsnotify_mark_connector.active_objs
      9498 ±  9%     -22.6%       7352 ± 10%  slabinfo.fsnotify_mark_connector.num_objs
      2094 ±  5%     -20.3%       1669 ± 12%  slabinfo.ip6-frags.active_objs
      2094 ±  5%     -20.3%       1669 ± 12%  slabinfo.ip6-frags.num_objs
     36144 ±  9%     -14.7%      30830        slabinfo.kmalloc-128.num_objs
     17293 ±  6%     -20.4%      13759        slabinfo.kmalloc-1k.active_objs
    544.00 ±  6%     -20.5%     432.25        slabinfo.kmalloc-1k.active_slabs
     17423 ±  6%     -20.5%      13847        slabinfo.kmalloc-1k.num_objs
    544.00 ±  6%     -20.5%     432.25        slabinfo.kmalloc-1k.num_slabs
     41102 ±  7%     -10.7%      36714 ±  4%  slabinfo.kmalloc-512.num_objs
     17783 ±  7%     -18.9%      14430 ±  4%  slabinfo.kmalloc-rcl-64.active_objs
     17788 ±  7%     -18.6%      14483 ±  4%  slabinfo.kmalloc-rcl-64.num_objs
      5365 ± 10%     -34.0%       3542 ±  2%  slabinfo.nfs_inode_cache.active_objs
      5366 ± 10%     -33.8%       3554 ±  3%  slabinfo.nfs_inode_cache.num_objs
      1502 ± 55%    -100.0%       0.00        slabinfo.nfsd4_delegations.active_objs
      1502 ± 55%    -100.0%       0.00        slabinfo.nfsd4_delegations.num_objs
      1852 ± 16%     -43.8%       1040 ± 28%  slabinfo.nfsd4_files.active_objs
      1852 ± 16%     -43.8%       1040 ± 28%  slabinfo.nfsd4_files.num_objs
      2555 ± 13%     -41.7%       1488 ± 23%  slabinfo.numa_policy.active_objs
      2555 ± 13%     -41.7%       1488 ± 23%  slabinfo.numa_policy.num_objs
    283184 ±  9%     -30.3%     197358        slabinfo.radix_tree_node.active_objs
      5056 ±  9%     -30.3%       3525        slabinfo.radix_tree_node.active_slabs
    283193 ±  9%     -30.3%     197454        slabinfo.radix_tree_node.num_objs
      5056 ±  9%     -30.3%       3525        slabinfo.radix_tree_node.num_slabs
      9664 ± 34%     -63.9%       3492 ± 21%  slabinfo.skbuff_fclone_cache.active_objs
    152.12 ± 35%     -64.5%      54.00 ± 21%  slabinfo.skbuff_fclone_cache.active_slabs
      9766 ± 35%     -64.2%       3492 ± 21%  slabinfo.skbuff_fclone_cache.num_objs
    152.12 ± 35%     -64.5%      54.00 ± 21%  slabinfo.skbuff_fclone_cache.num_slabs
     30879 ±  6%     -21.6%      24219        slabinfo.vmap_area.active_objs
    497.50 ±  8%     -23.5%     380.62        slabinfo.vmap_area.active_slabs
     31876 ±  8%     -23.5%      24384        slabinfo.vmap_area.num_objs
    497.50 ±  8%     -23.5%     380.62        slabinfo.vmap_area.num_slabs
      1446 ± 12%     -38.1%     894.75 ± 37%  slabinfo.xfs_btree_cur.active_objs
      1446 ± 12%     -38.1%     894.75 ± 37%  slabinfo.xfs_btree_cur.num_objs
      2137 ± 24%     -58.7%     882.75 ± 29%  slabinfo.xfs_da_state.active_objs
      2137 ± 24%     -58.7%     882.75 ± 29%  slabinfo.xfs_da_state.num_objs
    923.25 ± 19%     -36.8%     583.75 ± 13%  slabinfo.xfs_icr.active_objs
    923.25 ± 19%     -36.8%     583.75 ± 13%  slabinfo.xfs_icr.num_objs
      5767 ± 10%     -34.4%       3785 ±  4%  slabinfo.xfs_ili.active_objs
      5767 ± 10%     -34.4%       3785 ±  4%  slabinfo.xfs_ili.num_objs
      5676 ± 10%     -33.6%       3768 ±  2%  slabinfo.xfs_inode.active_objs
      5676 ± 10%     -33.6%       3768 ±  2%  slabinfo.xfs_inode.num_objs
      0.02 ± 23%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.02 ± 26%     -97.0%       0.00 ±264%  perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      0.00 ± 50%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.io_schedule.wait_on_page_bit.wait_on_page_writeback.__filemap_fdatawait_range
      0.02 ± 46%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.kthreadd.ret_from_fork
      0.02 ± 42%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.__synchronize_srcu.part
      0.01 ± 25%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.rpc_wait_bit_killable.__wait_on_bit.out_of_line_wait_on_bit.__rpc_execute
      0.02 ± 86%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.rpc_wait_bit_killable.__wait_on_bit.out_of_line_wait_on_bit.nfs4_do_close
      0.01 ± 26%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.rpc_wait_bit_killable.__wait_on_bit.out_of_line_wait_on_bit.nfs4_run_open_task
      0.01 ± 25%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
      0.01 ± 43%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.kthread.ret_from_fork
      0.02 ± 33%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.__break_lease.do_dentry_open.dentry_open
      0.02 ± 31%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.__skb_wait_for_more_packets.unix_dgram_recvmsg.__sys_recvfrom
      0.02 ± 27%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.01 ± 23%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.svc_recv.nfs4_callback_svc.kthread
      0.02 ± 24%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.svc_recv.nfsd.kthread
      0.08 ±  3%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.wait_for_completion.__flush_work.xlog_cil_force_seq
      0.02 ± 30%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.wait_for_completion_killable.__kthread_create_on_node.kthread_create_on_node
      0.00 ± 20%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open.isra
      0.01 ± 32%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.xlog_wait_on_iclog.xlog_force_lsn.xfs_log_force_seq.nfsd_create_setattr
      0.03 ± 37%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.03 ± 46%     -98.0%       0.00 ±264%  perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      0.05 ± 85%    -100.0%       0.00        perf-sched.sch_delay.max.ms.io_schedule.wait_on_page_bit.wait_on_page_writeback.__filemap_fdatawait_range
      0.02 ± 46%    -100.0%       0.00        perf-sched.sch_delay.max.ms.kthreadd.ret_from_fork
      0.03 ± 61%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.__synchronize_srcu.part
      0.02 ± 18%    -100.0%       0.00        perf-sched.sch_delay.max.ms.rpc_wait_bit_killable.__wait_on_bit.out_of_line_wait_on_bit.__rpc_execute
      0.05 ± 90%    -100.0%       0.00        perf-sched.sch_delay.max.ms.rpc_wait_bit_killable.__wait_on_bit.out_of_line_wait_on_bit.nfs4_do_close
      0.02 ± 39%    -100.0%       0.00        perf-sched.sch_delay.max.ms.rpc_wait_bit_killable.__wait_on_bit.out_of_line_wait_on_bit.nfs4_run_open_task
      0.04 ± 60%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
      0.04 ± 96%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_preempt_disabled.kthread.ret_from_fork
      0.04 ± 28%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_timeout.__break_lease.do_dentry_open.dentry_open
      0.02 ± 31%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_timeout.__skb_wait_for_more_packets.unix_dgram_recvmsg.__sys_recvfrom
      0.03 ± 38%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.03 ± 44%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_timeout.svc_recv.nfs4_callback_svc.kthread
      0.05 ± 42%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_timeout.svc_recv.nfsd.kthread
      0.17 ±  6%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_timeout.wait_for_completion.__flush_work.xlog_cil_force_seq
      0.03 ± 39%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_timeout.wait_for_completion_killable.__kthread_create_on_node.kthread_create_on_node
      0.03 ± 82%    -100.0%       0.00        perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open.isra
      0.02 ± 60%    -100.0%       0.00        perf-sched.sch_delay.max.ms.xlog_wait_on_iclog.xlog_force_lsn.xfs_log_force_seq.nfsd_create_setattr
    203.56 ±  8%     -99.6%       0.79 ± 25%  perf-sched.total_wait_and_delay.average.ms
     13213 ±  7%     -94.6%     712.00 ±  3%  perf-sched.total_wait_and_delay.count.ms
      9976           -99.9%      12.88 ± 20%  perf-sched.total_wait_and_delay.max.ms
    203.50 ±  8%     -99.6%       0.77 ± 26%  perf-sched.total_wait_time.average.ms
      9976           -99.9%      12.25 ± 12%  perf-sched.total_wait_time.max.ms
    899.38          -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    809.73 ±  2%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
    835.17 ± 13%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.__module_put_and_exit.nfs4_run_state_manager.kthread
    214.72           -99.7%       0.62 ± 17%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.77 ±  8%     -35.9%       0.49 ± 16%  perf-sched.wait_and_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      9.34 ± 48%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.io_schedule.wait_on_page_bit.wait_on_page_writeback.__filemap_fdatawait_range
    939.99 ± 18%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.kthreadd.ret_from_fork
     59.32           -99.2%       0.50 ± 47%  perf-sched.wait_and_delay.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      9.15 ±  2%     -99.7%       0.03 ± 86%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
    412.07 ±  2%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
    478.65          -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      9.36 ± 67%     -64.2%       3.35 ±  8%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
    244.38 ±  3%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_timeout.svc_recv.nfs4_callback_svc.kthread
    352.16 ±  9%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_timeout.svc_recv.nfsd.kthread
    528.43 ± 45%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_timeout.wait_for_completion_killable.__kthread_create_on_node.kthread_create_on_node
    737.06 ±  2%     -99.8%       1.52 ± 35%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.00 ± 20%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open.isra
    326.78 ±  7%     -99.6%       1.26 ± 12%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork
     20.00          -100.0%       0.00        perf-sched.wait_and_delay.count.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     11.12 ±  2%    -100.0%       0.00        perf-sched.wait_and_delay.count.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      9.75 ± 23%    -100.0%       0.00        perf-sched.wait_and_delay.count.do_task_dead.do_exit.__module_put_and_exit.nfs4_run_state_manager.kthread
    337.00           -88.5%      38.62 ± 20%  perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
    323.50 ±  3%     -90.1%      31.88 ± 25%  perf-sched.wait_and_delay.count.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
    646.00 ± 39%    -100.0%       0.00        perf-sched.wait_and_delay.count.io_schedule.wait_on_page_bit.wait_on_page_writeback.__filemap_fdatawait_range
      9.75 ± 23%    -100.0%       0.00        perf-sched.wait_and_delay.count.kthreadd.ret_from_fork
      3037           -98.6%      43.25 ± 36%  perf-sched.wait_and_delay.count.pipe_read.new_sync_read.vfs_read.ksys_read
      2040 ±  4%     -86.8%     269.75 ±  6%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
     21.88 ±  2%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
     79.50          -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_timeout.kcompactd.kthread.ret_from_fork
      1574 ± 51%     -99.7%       4.75 ± 20%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
     19.50 ± 22%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_timeout.svc_recv.nfs4_callback_svc.kthread
    191.88 ±  9%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_timeout.svc_recv.nfsd.kthread
      9.75 ± 23%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_timeout.wait_for_completion_killable.__kthread_create_on_node.kthread_create_on_node
      2427 ±  3%     -88.9%     269.25 ±  6%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork
     82.00          -100.0%       0.00        perf-sched.wait_and_delay.count.wait_for_partner.fifo_open.do_dentry_open.do_open.isra
      1255 ±  8%     -97.0%      37.62 ± 20%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork
    999.57          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      1000          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      1385 ± 23%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.__module_put_and_exit.nfs4_run_state_manager.kthread
      1041 ± 10%     -99.5%       5.69 ± 29%  perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     21.10           -85.1%       3.13 ± 53%  perf-sched.wait_and_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
    476.99 ±  7%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.io_schedule.wait_on_page_bit.wait_on_page_writeback.__filemap_fdatawait_range
      1495 ± 32%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.kthreadd.ret_from_fork
      1018           -99.7%       3.04 ± 54%  perf-sched.wait_and_delay.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      9976           -99.9%       5.08 ±113%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      1000          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
    505.52          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
    506.01          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_timeout.svc_recv.nfs4_callback_svc.kthread
    508.11          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_timeout.svc_recv.nfsd.kthread
    992.93 ± 49%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_timeout.wait_for_completion_killable.__kthread_create_on_node.kthread_create_on_node
      1270 ± 52%     -99.2%      10.61 ± 22%  perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.03 ± 82%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open.isra
      7297 ±  6%     -99.9%       7.05 ± 26%  perf-sched.wait_and_delay.max.ms.worker_thread.kthread.ret_from_fork
    899.36          -100.0%       0.00        perf-sched.wait_time.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    809.71 ±  2%    -100.0%       0.00        perf-sched.wait_time.avg.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
    835.17 ± 13%    -100.0%       0.00        perf-sched.wait_time.avg.ms.do_task_dead.do_exit.__module_put_and_exit.nfs4_run_state_manager.kthread
    214.71           -99.7%       0.62 ± 17%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.75 ±  7%     -45.8%       0.41 ±  9%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      9.34 ± 48%    -100.0%       0.00        perf-sched.wait_time.avg.ms.io_schedule.wait_on_page_bit.wait_on_page_writeback.__filemap_fdatawait_range
    939.97 ± 18%    -100.0%       0.00        perf-sched.wait_time.avg.ms.kthreadd.ret_from_fork
     59.31           -99.2%       0.48 ± 47%  perf-sched.wait_time.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
    115.36 ± 36%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.__synchronize_srcu.part
      9.15 ±  2%     -99.7%       0.03 ± 86%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
    109.80 ±103%    -100.0%       0.00        perf-sched.wait_time.avg.ms.rpc_wait_bit_killable.__wait_on_bit.out_of_line_wait_on_bit.__rpc_execute
    246.49 ± 54%    -100.0%       0.00        perf-sched.wait_time.avg.ms.rpc_wait_bit_killable.__wait_on_bit.out_of_line_wait_on_bit.nfs4_do_close
     88.39 ± 64%    -100.0%       0.00        perf-sched.wait_time.avg.ms.rpc_wait_bit_killable.__wait_on_bit.out_of_line_wait_on_bit.nfs4_run_open_task
    124.79 ± 77%     -98.8%       1.49 ± 38%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
    412.06 ±  2%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
     27.69 ±194%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_timeout.__break_lease.do_dentry_open.dentry_open
      0.29 ± 45%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_timeout.__skb_wait_for_more_packets.unix_dgram_recvmsg.__sys_recvfrom
    478.63          -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.05 ±194%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_timeout.khugepaged.kthread.ret_from_fork
      9.34 ± 67%     -65.3%       3.24 ±  7%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
    244.37 ±  3%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_timeout.svc_recv.nfs4_callback_svc.kthread
    352.14 ±  9%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_timeout.svc_recv.nfsd.kthread
    165.99 ± 42%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_timeout.wait_for_completion.__flush_work.xlog_cil_force_seq
    528.41 ± 45%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_timeout.wait_for_completion_killable.__kthread_create_on_node.kthread_create_on_node
    737.05 ±  2%     -99.8%       1.51 ± 35%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.00 ± 66%    -100.0%       0.00        perf-sched.wait_time.avg.ms.wait_on_commit.__nfs_commit_inode.nfs_file_fsync.do_fsync
    326.28 ±  6%     -99.6%       1.16 ± 12%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork
      0.02 ± 35%    -100.0%       0.00        perf-sched.wait_time.avg.ms.xlog_wait_on_iclog.xlog_force_lsn.xfs_log_force_seq.nfsd_create_setattr
      0.01 ± 60%    -100.0%       0.00        perf-sched.wait_time.avg.ms.xlog_wait_on_iclog.xlog_force_lsn.xfs_log_force_seq.xfs_file_fsync
    999.55          -100.0%       0.00        perf-sched.wait_time.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      1000          -100.0%       0.00        perf-sched.wait_time.max.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      1385 ± 23%    -100.0%       0.00        perf-sched.wait_time.max.ms.do_task_dead.do_exit.__module_put_and_exit.nfs4_run_state_manager.kthread
      1041 ± 10%     -99.5%       5.69 ± 29%  perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     21.10           -94.9%       1.08 ± 26%  perf-sched.wait_time.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
    476.98 ±  7%    -100.0%       0.00        perf-sched.wait_time.max.ms.io_schedule.wait_on_page_bit.wait_on_page_writeback.__filemap_fdatawait_range
      1495 ± 32%    -100.0%       0.00        perf-sched.wait_time.max.ms.kthreadd.ret_from_fork
      1018           -99.7%       3.03 ± 54%  perf-sched.wait_time.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
    321.60 ± 37%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.__synchronize_srcu.part
      9976           -99.9%       5.08 ±113%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
    360.75 ± 51%    -100.0%       0.00        perf-sched.wait_time.max.ms.rpc_wait_bit_killable.__wait_on_bit.out_of_line_wait_on_bit.__rpc_execute
    432.34 ± 32%    -100.0%       0.00        perf-sched.wait_time.max.ms.rpc_wait_bit_killable.__wait_on_bit.out_of_line_wait_on_bit.nfs4_do_close
    350.38 ± 53%    -100.0%       0.00        perf-sched.wait_time.max.ms.rpc_wait_bit_killable.__wait_on_bit.out_of_line_wait_on_bit.nfs4_run_open_task
    551.24 ± 50%     -98.9%       6.12 ± 41%  perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      1000          -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
    441.56 ± 37%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_timeout.__break_lease.do_dentry_open.dentry_open
      0.29 ± 45%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_timeout.__skb_wait_for_more_packets.unix_dgram_recvmsg.__sys_recvfrom
    505.50          -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.05 ±194%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_timeout.khugepaged.kthread.ret_from_fork
    505.99          -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_timeout.svc_recv.nfs4_callback_svc.kthread
    508.09          -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_timeout.svc_recv.nfsd.kthread
    441.87 ± 37%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_timeout.wait_for_completion.__flush_work.xlog_cil_force_seq
    992.91 ± 49%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_timeout.wait_for_completion_killable.__kthread_create_on_node.kthread_create_on_node
      1270 ± 52%     -99.2%      10.60 ± 22%  perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.00 ± 90%    -100.0%       0.00        perf-sched.wait_time.max.ms.wait_on_commit.__nfs_commit_inode.nfs_file_fsync.do_fsync
      7297 ±  6%     -99.9%       7.05 ± 26%  perf-sched.wait_time.max.ms.worker_thread.kthread.ret_from_fork
      0.04 ± 46%    -100.0%       0.00        perf-sched.wait_time.max.ms.xlog_wait_on_iclog.xlog_force_lsn.xfs_log_force_seq.nfsd_create_setattr
      0.04 ± 72%    -100.0%       0.00        perf-sched.wait_time.max.ms.xlog_wait_on_iclog.xlog_force_lsn.xfs_log_force_seq.xfs_file_fsync
    321599 ±260%    -100.0%     102.38 ± 63%  interrupts.31:PCI-MSI.524289-edge.eth0-TxRx-0
      4301 ±177%     -94.5%     235.75 ±135%  interrupts.32:PCI-MSI.524290-edge.eth0-TxRx-1
   1553423 ±133%     -99.0%      15750 ±260%  interrupts.33:PCI-MSI.524291-edge.eth0-TxRx-2
     16171 ± 75%     -96.8%     520.50 ±192%  interrupts.34:PCI-MSI.524292-edge.eth0-TxRx-3
      2327 ± 67%     -96.3%      87.25        interrupts.9:IO-APIC.9-fasteoi.acpi
   1876677 ± 69%     -95.4%      86746        interrupts.CPU0.LOC:Local_timer_interrupts
    117.38 ± 70%     -86.5%      15.88 ± 97%  interrupts.CPU0.RES:Rescheduling_interrupts
      2327 ± 67%     -96.3%      87.25        interrupts.CPU1.9:IO-APIC.9-fasteoi.acpi
   1883548 ± 69%     -95.4%      86710        interrupts.CPU1.LOC:Local_timer_interrupts
    321599 ±260%    -100.0%     102.38 ± 63%  interrupts.CPU10.31:PCI-MSI.524289-edge.eth0-TxRx-0
   1855977 ± 69%     -95.3%      86685        interrupts.CPU10.LOC:Local_timer_interrupts
   1826047 ± 69%     -95.3%      86572        interrupts.CPU100.LOC:Local_timer_interrupts
   1828771 ± 69%     -95.3%      86537        interrupts.CPU101.LOC:Local_timer_interrupts
      6745 ±133%     -79.6%       1376 ± 61%  interrupts.CPU102.CAL:Function_call_interrupts
   1841329 ± 69%     -95.3%      86662        interrupts.CPU102.LOC:Local_timer_interrupts
   1861860 ± 69%     -95.3%      86647        interrupts.CPU103.LOC:Local_timer_interrupts
   1854697 ± 69%     -95.3%      86622        interrupts.CPU104.LOC:Local_timer_interrupts
      5110 ±134%     -80.1%       1017 ± 29%  interrupts.CPU105.CAL:Function_call_interrupts
   1825302 ± 69%     -95.3%      86565        interrupts.CPU105.LOC:Local_timer_interrupts
   1859451 ± 69%     -95.3%      86574        interrupts.CPU106.LOC:Local_timer_interrupts
   1836074 ± 69%     -95.3%      86462        interrupts.CPU107.LOC:Local_timer_interrupts
   2012016 ± 68%     -95.7%      86643        interrupts.CPU108.LOC:Local_timer_interrupts
   1883845 ± 69%     -95.4%      86667        interrupts.CPU109.LOC:Local_timer_interrupts
      4301 ±177%     -94.5%     235.75 ±135%  interrupts.CPU11.32:PCI-MSI.524290-edge.eth0-TxRx-1
   1836530 ± 69%     -95.3%      86629        interrupts.CPU11.LOC:Local_timer_interrupts
   1858707 ± 69%     -95.3%      86641        interrupts.CPU110.LOC:Local_timer_interrupts
   1838624 ± 69%     -95.3%      86588        interrupts.CPU111.LOC:Local_timer_interrupts
   1874933 ± 69%     -95.4%      86635        interrupts.CPU112.LOC:Local_timer_interrupts
   1833535 ± 69%     -95.3%      86637        interrupts.CPU113.LOC:Local_timer_interrupts
    166.50 ±107%     -95.6%       7.38 ±146%  interrupts.CPU113.RES:Rescheduling_interrupts
   1828491 ± 69%     -95.3%      86687        interrupts.CPU114.LOC:Local_timer_interrupts
    450.25 ± 82%     -68.7%     140.75 ± 71%  interrupts.CPU114.NMI:Non-maskable_interrupts
    450.25 ± 82%     -68.7%     140.75 ± 71%  interrupts.CPU114.PMI:Performance_monitoring_interrupts
    167.12 ±149%     -97.5%       4.12 ±125%  interrupts.CPU114.RES:Rescheduling_interrupts
   1849853 ± 69%     -95.3%      86635        interrupts.CPU115.LOC:Local_timer_interrupts
   1832995 ± 69%     -95.3%      86630        interrupts.CPU116.LOC:Local_timer_interrupts
   1851393 ± 69%     -95.3%      86667        interrupts.CPU117.LOC:Local_timer_interrupts
   1825730 ± 69%     -95.3%      86670        interrupts.CPU118.LOC:Local_timer_interrupts
   1846109 ± 69%     -95.3%      86660        interrupts.CPU119.LOC:Local_timer_interrupts
   1553423 ±133%     -99.0%      15750 ±260%  interrupts.CPU12.33:PCI-MSI.524291-edge.eth0-TxRx-2
      5258 ±128%     -81.7%     959.75 ± 15%  interrupts.CPU12.CAL:Function_call_interrupts
   2010486 ± 68%     -95.7%      86713        interrupts.CPU12.LOC:Local_timer_interrupts
   1748954 ± 71%     -95.0%      86603        interrupts.CPU120.LOC:Local_timer_interrupts
   1728120 ± 72%     -95.0%      86631        interrupts.CPU121.LOC:Local_timer_interrupts
     97.62 ±153%     -92.3%       7.50 ±176%  interrupts.CPU121.RES:Rescheduling_interrupts
      1690 ± 96%     -47.2%     893.00 ±  3%  interrupts.CPU122.CAL:Function_call_interrupts
   1697055 ± 72%     -94.9%      86639        interrupts.CPU122.LOC:Local_timer_interrupts
   1681756 ± 73%     -94.8%      86632        interrupts.CPU123.LOC:Local_timer_interrupts
     56.50 ±100%     -89.8%       5.75 ±239%  interrupts.CPU123.RES:Rescheduling_interrupts
      1005 ±  3%     -11.2%     893.12 ±  3%  interrupts.CPU124.CAL:Function_call_interrupts
   1681177 ± 73%     -94.8%      86619        interrupts.CPU124.LOC:Local_timer_interrupts
      1004 ±  3%     -11.0%     893.50 ±  2%  interrupts.CPU125.CAL:Function_call_interrupts
   1680892 ± 73%     -94.8%      86636        interrupts.CPU125.LOC:Local_timer_interrupts
   1684227 ± 73%     -94.9%      86607        interrupts.CPU126.LOC:Local_timer_interrupts
    999.12 ±  2%     -10.6%     893.25 ±  2%  interrupts.CPU127.CAL:Function_call_interrupts
   1684202 ± 73%     -94.9%      86615        interrupts.CPU127.LOC:Local_timer_interrupts
      1008 ±  2%     -12.2%     885.50        interrupts.CPU128.CAL:Function_call_interrupts
   1682244 ± 73%     -94.9%      86628        interrupts.CPU128.LOC:Local_timer_interrupts
   1679430 ± 73%     -94.8%      86619        interrupts.CPU129.LOC:Local_timer_interrupts
     16171 ± 75%     -96.8%     520.50 ±192%  interrupts.CPU13.34:PCI-MSI.524292-edge.eth0-TxRx-3
   1883757 ± 69%     -95.4%      86659        interrupts.CPU13.LOC:Local_timer_interrupts
   1680341 ± 73%     -94.8%      86616        interrupts.CPU130.LOC:Local_timer_interrupts
   1679677 ± 73%     -94.8%      86619        interrupts.CPU131.LOC:Local_timer_interrupts
   1679934 ± 73%     -94.8%      86621        interrupts.CPU132.LOC:Local_timer_interrupts
   1680744 ± 73%     -94.8%      86611        interrupts.CPU133.LOC:Local_timer_interrupts
   1681069 ± 73%     -94.8%      86644        interrupts.CPU134.LOC:Local_timer_interrupts
   1680034 ± 73%     -94.8%      86617        interrupts.CPU135.LOC:Local_timer_interrupts
    997.38 ±  2%     -10.1%     897.00 ±  4%  interrupts.CPU136.CAL:Function_call_interrupts
   1680265 ± 73%     -94.8%      86638        interrupts.CPU136.LOC:Local_timer_interrupts
   1679516 ± 73%     -94.8%      86623        interrupts.CPU137.LOC:Local_timer_interrupts
   1679261 ± 73%     -94.8%      86615        interrupts.CPU138.LOC:Local_timer_interrupts
    999.75 ±  2%     -10.5%     894.62 ±  4%  interrupts.CPU139.CAL:Function_call_interrupts
   1680292 ± 73%     -94.8%      86603        interrupts.CPU139.LOC:Local_timer_interrupts
   1858790 ± 69%     -95.3%      86710        interrupts.CPU14.LOC:Local_timer_interrupts
      1028 ±  4%     -13.5%     889.00        interrupts.CPU140.CAL:Function_call_interrupts
   1679354 ± 73%     -94.8%      86630        interrupts.CPU140.LOC:Local_timer_interrupts
   1679563 ± 73%     -94.8%      86599        interrupts.CPU141.LOC:Local_timer_interrupts
      1126 ± 27%     -21.5%     884.75        interrupts.CPU142.CAL:Function_call_interrupts
   1677433 ± 73%     -94.8%      86602        interrupts.CPU142.LOC:Local_timer_interrupts
      1001 ±  2%     -12.0%     881.25        interrupts.CPU143.CAL:Function_call_interrupts
   1680245 ± 73%     -94.8%      86642        interrupts.CPU143.LOC:Local_timer_interrupts
   1661529 ± 73%     -94.8%      86601        interrupts.CPU144.LOC:Local_timer_interrupts
   1662129 ± 73%     -94.8%      86612        interrupts.CPU145.LOC:Local_timer_interrupts
   1661692 ± 73%     -94.8%      86617        interrupts.CPU146.LOC:Local_timer_interrupts
   1661058 ± 73%     -94.8%      86608        interrupts.CPU147.LOC:Local_timer_interrupts
   1661348 ± 73%     -94.8%      86593        interrupts.CPU148.LOC:Local_timer_interrupts
   1661251 ± 73%     -94.8%      86611        interrupts.CPU149.LOC:Local_timer_interrupts
   1838540 ± 69%     -95.3%      86606        interrupts.CPU15.LOC:Local_timer_interrupts
   1661343 ± 73%     -94.8%      86584        interrupts.CPU150.LOC:Local_timer_interrupts
   1661977 ± 73%     -94.8%      86616        interrupts.CPU151.LOC:Local_timer_interrupts
   1661388 ± 73%     -94.8%      86593        interrupts.CPU152.LOC:Local_timer_interrupts
   1661633 ± 73%     -94.8%      86620        interrupts.CPU153.LOC:Local_timer_interrupts
   1660665 ± 73%     -94.8%      86623        interrupts.CPU154.LOC:Local_timer_interrupts
   1660729 ± 73%     -94.8%      86612        interrupts.CPU155.LOC:Local_timer_interrupts
   1661672 ± 73%     -94.8%      86612        interrupts.CPU156.LOC:Local_timer_interrupts
   1661162 ± 73%     -94.8%      86618        interrupts.CPU157.LOC:Local_timer_interrupts
   1661479 ± 73%     -94.8%      86602        interrupts.CPU158.LOC:Local_timer_interrupts
   1662439 ± 73%     -94.8%      86599        interrupts.CPU159.LOC:Local_timer_interrupts
   1874629 ± 69%     -95.4%      86580        interrupts.CPU16.LOC:Local_timer_interrupts
   1661069 ± 73%     -94.8%      86582        interrupts.CPU160.LOC:Local_timer_interrupts
   1660777 ± 73%     -94.8%      86554        interrupts.CPU161.LOC:Local_timer_interrupts
   1662336 ± 73%     -94.8%      86607        interrupts.CPU162.LOC:Local_timer_interrupts
   1661511 ± 73%     -94.8%      86584        interrupts.CPU163.LOC:Local_timer_interrupts
   1659664 ± 73%     -94.8%      86615        interrupts.CPU164.LOC:Local_timer_interrupts
   1659710 ± 73%     -94.8%      86633        interrupts.CPU165.LOC:Local_timer_interrupts
   1660610 ± 73%     -94.8%      86589        interrupts.CPU166.LOC:Local_timer_interrupts
   1661014 ± 73%     -94.8%      86626        interrupts.CPU167.LOC:Local_timer_interrupts
   1666884 ± 73%     -94.8%      86597        interrupts.CPU168.LOC:Local_timer_interrupts
   1668196 ± 73%     -94.8%      86586        interrupts.CPU169.LOC:Local_timer_interrupts
   1830797 ± 69%     -95.3%      86644        interrupts.CPU17.LOC:Local_timer_interrupts
   1667612 ± 73%     -94.8%      86577        interrupts.CPU170.LOC:Local_timer_interrupts
   1666200 ± 73%     -94.8%      86576        interrupts.CPU171.LOC:Local_timer_interrupts
   1665751 ± 73%     -94.8%      86575        interrupts.CPU172.LOC:Local_timer_interrupts
   1665725 ± 73%     -94.8%      86587        interrupts.CPU173.LOC:Local_timer_interrupts
   1665772 ± 73%     -94.8%      86608        interrupts.CPU174.LOC:Local_timer_interrupts
   1666540 ± 73%     -94.8%      86585        interrupts.CPU175.LOC:Local_timer_interrupts
   1666021 ± 73%     -94.8%      86578        interrupts.CPU176.LOC:Local_timer_interrupts
   1665461 ± 73%     -94.8%      86605        interrupts.CPU177.LOC:Local_timer_interrupts
      1631 ± 98%     -45.5%     889.88 ±  2%  interrupts.CPU178.CAL:Function_call_interrupts
   1666069 ± 73%     -94.8%      86586        interrupts.CPU178.LOC:Local_timer_interrupts
   1665520 ± 73%     -94.8%      86584        interrupts.CPU179.LOC:Local_timer_interrupts
   1828145 ± 69%     -95.3%      86682        interrupts.CPU18.LOC:Local_timer_interrupts
      1207 ± 43%     -25.8%     895.88 ±  2%  interrupts.CPU180.CAL:Function_call_interrupts
   1665821 ± 73%     -94.8%      86583        interrupts.CPU180.LOC:Local_timer_interrupts
   1667349 ± 73%     -94.8%      86584        interrupts.CPU181.LOC:Local_timer_interrupts
   1666340 ± 73%     -94.8%      86585        interrupts.CPU182.LOC:Local_timer_interrupts
   1665737 ± 73%     -94.8%      86585        interrupts.CPU183.LOC:Local_timer_interrupts
   1665852 ± 73%     -94.8%      86581        interrupts.CPU184.LOC:Local_timer_interrupts
   1665236 ± 73%     -94.8%      86578        interrupts.CPU185.LOC:Local_timer_interrupts
   1665433 ± 73%     -94.8%      86585        interrupts.CPU186.LOC:Local_timer_interrupts
   1665932 ± 73%     -94.8%      86578        interrupts.CPU187.LOC:Local_timer_interrupts
   1664883 ± 73%     -94.8%      86579        interrupts.CPU188.LOC:Local_timer_interrupts
      6671 ±223%     -86.6%     891.25        interrupts.CPU189.CAL:Function_call_interrupts
   1666119 ± 73%     -94.8%      86576        interrupts.CPU189.LOC:Local_timer_interrupts
   1848231 ± 69%     -95.3%      86601        interrupts.CPU19.LOC:Local_timer_interrupts
     91.50 ±101%     -91.1%       8.12 ±175%  interrupts.CPU19.RES:Rescheduling_interrupts
      5826 ±210%     -84.6%     898.25 ±  3%  interrupts.CPU190.CAL:Function_call_interrupts
   1664722 ± 73%     -94.8%      86577        interrupts.CPU190.LOC:Local_timer_interrupts
   1665508 ± 73%     -94.8%      86611        interrupts.CPU191.LOC:Local_timer_interrupts
   1859395 ± 69%     -95.3%      86676        interrupts.CPU2.LOC:Local_timer_interrupts
   1830192 ± 69%     -95.3%      86625        interrupts.CPU20.LOC:Local_timer_interrupts
   1853998 ± 69%     -95.3%      86626        interrupts.CPU21.LOC:Local_timer_interrupts
   1825560 ± 69%     -95.3%      86672        interrupts.CPU22.LOC:Local_timer_interrupts
   1846146 ± 69%     -95.3%      86527        interrupts.CPU23.LOC:Local_timer_interrupts
     87.25 ± 82%     -95.0%       4.38 ±104%  interrupts.CPU23.RES:Rescheduling_interrupts
   1748284 ± 71%     -95.0%      86656        interrupts.CPU24.LOC:Local_timer_interrupts
    114.38 ±154%     -91.9%       9.25 ±169%  interrupts.CPU24.RES:Rescheduling_interrupts
   1727950 ± 72%     -95.0%      86634        interrupts.CPU25.LOC:Local_timer_interrupts
   1697110 ± 72%     -94.9%      86627        interrupts.CPU26.LOC:Local_timer_interrupts
   1680290 ± 73%     -94.8%      86620        interrupts.CPU27.LOC:Local_timer_interrupts
   1679799 ± 73%     -94.8%      86640        interrupts.CPU28.LOC:Local_timer_interrupts
   1679602 ± 73%     -94.8%      86618        interrupts.CPU29.LOC:Local_timer_interrupts
   1827152 ± 69%     -95.3%      86686        interrupts.CPU3.LOC:Local_timer_interrupts
   1682852 ± 73%     -94.9%      86622        interrupts.CPU30.LOC:Local_timer_interrupts
   1684198 ± 73%     -94.9%      86620        interrupts.CPU31.LOC:Local_timer_interrupts
      1202 ± 33%     -25.5%     896.12 ±  4%  interrupts.CPU32.CAL:Function_call_interrupts
   1681078 ± 73%     -94.8%      86623        interrupts.CPU32.LOC:Local_timer_interrupts
   1679404 ± 73%     -94.8%      86635        interrupts.CPU33.LOC:Local_timer_interrupts
   1679060 ± 73%     -94.8%      86630        interrupts.CPU34.LOC:Local_timer_interrupts
   1678302 ± 73%     -94.8%      86618        interrupts.CPU35.LOC:Local_timer_interrupts
   1678569 ± 73%     -94.8%      86606        interrupts.CPU36.LOC:Local_timer_interrupts
   1680702 ± 73%     -94.8%      86646        interrupts.CPU37.LOC:Local_timer_interrupts
   1680876 ± 73%     -94.8%      86601        interrupts.CPU38.LOC:Local_timer_interrupts
   1679449 ± 73%     -94.8%      86595        interrupts.CPU39.LOC:Local_timer_interrupts
   1825094 ± 69%     -95.3%      86611        interrupts.CPU4.LOC:Local_timer_interrupts
   1678985 ± 73%     -94.8%      86588        interrupts.CPU40.LOC:Local_timer_interrupts
   1678999 ± 73%     -94.8%      86653        interrupts.CPU41.LOC:Local_timer_interrupts
   1679106 ± 73%     -94.8%      86665        interrupts.CPU42.LOC:Local_timer_interrupts
      1015 ±  5%     -12.1%     892.88 ±  3%  interrupts.CPU43.CAL:Function_call_interrupts
   1678803 ± 73%     -94.8%      86633        interrupts.CPU43.LOC:Local_timer_interrupts
   1679363 ± 73%     -94.8%      86673        interrupts.CPU44.LOC:Local_timer_interrupts
   1678964 ± 73%     -94.8%      86573        interrupts.CPU45.LOC:Local_timer_interrupts
   1677460 ± 73%     -94.8%      86635        interrupts.CPU46.LOC:Local_timer_interrupts
   1679607 ± 73%     -94.8%      86615        interrupts.CPU47.LOC:Local_timer_interrupts
   1661066 ± 73%     -94.8%      86619        interrupts.CPU48.LOC:Local_timer_interrupts
   1661650 ± 73%     -94.8%      86604        interrupts.CPU49.LOC:Local_timer_interrupts
   1828607 ± 69%     -95.3%      86734        interrupts.CPU5.LOC:Local_timer_interrupts
   1661857 ± 73%     -94.8%      86615        interrupts.CPU50.LOC:Local_timer_interrupts
   1660518 ± 73%     -94.8%      86597        interrupts.CPU51.LOC:Local_timer_interrupts
   1661349 ± 73%     -94.8%      86580        interrupts.CPU52.LOC:Local_timer_interrupts
   1661170 ± 73%     -94.8%      86611        interrupts.CPU53.LOC:Local_timer_interrupts
   1661102 ± 73%     -94.8%      86593        interrupts.CPU54.LOC:Local_timer_interrupts
   1662011 ± 73%     -94.8%      86625        interrupts.CPU55.LOC:Local_timer_interrupts
   1660712 ± 73%     -94.8%      86614        interrupts.CPU56.LOC:Local_timer_interrupts
   1661581 ± 73%     -94.8%      86646        interrupts.CPU57.LOC:Local_timer_interrupts
   1661000 ± 73%     -94.8%      86533        interrupts.CPU58.LOC:Local_timer_interrupts
   1660932 ± 73%     -94.8%      86597        interrupts.CPU59.LOC:Local_timer_interrupts
      3679 ±107%     -74.8%     926.50 ± 26%  interrupts.CPU6.CAL:Function_call_interrupts
   1841528 ± 69%     -95.3%      86616        interrupts.CPU6.LOC:Local_timer_interrupts
   1661627 ± 73%     -94.8%      86632        interrupts.CPU60.LOC:Local_timer_interrupts
   1661351 ± 73%     -94.8%      86610        interrupts.CPU61.LOC:Local_timer_interrupts
   1661342 ± 73%     -94.8%      86633        interrupts.CPU62.LOC:Local_timer_interrupts
   1662194 ± 73%     -94.8%      86610        interrupts.CPU63.LOC:Local_timer_interrupts
   1660245 ± 73%     -94.8%      86617        interrupts.CPU64.LOC:Local_timer_interrupts
   1660374 ± 73%     -94.8%      86588        interrupts.CPU65.LOC:Local_timer_interrupts
   1661943 ± 73%     -94.8%      86622        interrupts.CPU66.LOC:Local_timer_interrupts
   1661106 ± 73%     -94.8%      86632        interrupts.CPU67.LOC:Local_timer_interrupts
   1659557 ± 73%     -94.8%      86610        interrupts.CPU68.LOC:Local_timer_interrupts
   1659725 ± 73%     -94.8%      86605        interrupts.CPU69.LOC:Local_timer_interrupts
   1860522 ± 69%     -95.3%      86631        interrupts.CPU7.LOC:Local_timer_interrupts
   1660906 ± 73%     -94.8%      86617        interrupts.CPU70.LOC:Local_timer_interrupts
   1660645 ± 73%     -94.8%      86615        interrupts.CPU71.LOC:Local_timer_interrupts
   1667336 ± 73%     -94.8%      86621        interrupts.CPU72.LOC:Local_timer_interrupts
   1667945 ± 73%     -94.8%      86627        interrupts.CPU73.LOC:Local_timer_interrupts
     50.25 ± 53%     -86.1%       7.00 ±214%  interrupts.CPU73.RES:Rescheduling_interrupts
   1667309 ± 73%     -94.8%      86608        interrupts.CPU74.LOC:Local_timer_interrupts
   1666462 ± 73%     -94.8%      86601        interrupts.CPU75.LOC:Local_timer_interrupts
   1665846 ± 73%     -94.8%      86594        interrupts.CPU76.LOC:Local_timer_interrupts
   1665527 ± 73%     -94.8%      86597        interrupts.CPU77.LOC:Local_timer_interrupts
   1665756 ± 73%     -94.8%      86598        interrupts.CPU78.LOC:Local_timer_interrupts
   1666239 ± 73%     -94.8%      86607        interrupts.CPU79.LOC:Local_timer_interrupts
   1853724 ± 69%     -95.3%      86652        interrupts.CPU8.LOC:Local_timer_interrupts
   1665711 ± 73%     -94.8%      86599        interrupts.CPU80.LOC:Local_timer_interrupts
   1665083 ± 73%     -94.8%      86597        interrupts.CPU81.LOC:Local_timer_interrupts
   1666249 ± 73%     -94.8%      86602        interrupts.CPU82.LOC:Local_timer_interrupts
   1665656 ± 73%     -94.8%      86611        interrupts.CPU83.LOC:Local_timer_interrupts
   1665782 ± 73%     -94.8%      86610        interrupts.CPU84.LOC:Local_timer_interrupts
   1667302 ± 73%     -94.8%      86598        interrupts.CPU85.LOC:Local_timer_interrupts
   1666381 ± 73%     -94.8%      86602        interrupts.CPU86.LOC:Local_timer_interrupts
   1665835 ± 73%     -94.8%      86606        interrupts.CPU87.LOC:Local_timer_interrupts
      1520 ± 60%     -41.1%     894.88 ±  4%  interrupts.CPU88.CAL:Function_call_interrupts
   1666571 ± 73%     -94.8%      86641        interrupts.CPU88.LOC:Local_timer_interrupts
      2131 ± 91%     -58.4%     886.50 ±  2%  interrupts.CPU89.CAL:Function_call_interrupts
   1665856 ± 73%     -94.8%      86617        interrupts.CPU89.LOC:Local_timer_interrupts
   1822472 ± 69%     -95.2%      86611        interrupts.CPU9.LOC:Local_timer_interrupts
    114.50 ± 86%     -96.3%       4.25 ±107%  interrupts.CPU9.RES:Rescheduling_interrupts
      1410 ± 74%     -37.6%     879.88        interrupts.CPU90.CAL:Function_call_interrupts
   1665454 ± 73%     -94.8%      86608        interrupts.CPU90.LOC:Local_timer_interrupts
      1161 ± 35%     -24.2%     880.38        interrupts.CPU91.CAL:Function_call_interrupts
   1665322 ± 73%     -94.8%      86608        interrupts.CPU91.LOC:Local_timer_interrupts
   1665552 ± 73%     -94.8%      86611        interrupts.CPU92.LOC:Local_timer_interrupts
   1664993 ± 73%     -94.8%      86603        interrupts.CPU93.LOC:Local_timer_interrupts
   1665370 ± 73%     -94.8%      86605        interrupts.CPU94.LOC:Local_timer_interrupts
      4184 ±188%     -78.6%     894.50        interrupts.CPU95.CAL:Function_call_interrupts
   1666405 ± 73%     -94.8%      86650        interrupts.CPU95.LOC:Local_timer_interrupts
   1876332 ± 69%     -95.4%      86657        interrupts.CPU96.LOC:Local_timer_interrupts
    151.00 ± 27%     -34.6%      98.75 ± 34%  interrupts.CPU96.NMI:Non-maskable_interrupts
    151.00 ± 27%     -34.6%      98.75 ± 34%  interrupts.CPU96.PMI:Performance_monitoring_interrupts
   1884687 ± 69%     -95.4%      86653        interrupts.CPU97.LOC:Local_timer_interrupts
   1860073 ± 69%     -95.3%      86713        interrupts.CPU98.LOC:Local_timer_interrupts
   1825707 ± 69%     -95.3%      86647        interrupts.CPU99.LOC:Local_timer_interrupts
 3.296e+08 ± 72%     -95.0%   16630534        interrupts.LOC:Local_timer_interrupts
     10194 ± 65%     -76.0%       2450 ± 23%  interrupts.RES:Rescheduling_interrupts
    113923 ± 69%     -92.0%       9121 ± 10%  softirqs.CPU0.RCU
    149371 ± 65%     -91.8%      12322 ±  8%  softirqs.CPU0.SCHED
    110294 ± 70%     -93.4%       7264 ± 18%  softirqs.CPU1.RCU
    147167 ± 66%     -91.9%      11876 ± 42%  softirqs.CPU1.SCHED
    114821 ± 75%     -93.6%       7392 ± 17%  softirqs.CPU10.RCU
    149722 ± 66%     -94.9%       7641 ± 12%  softirqs.CPU10.SCHED
    121668 ± 72%     -94.5%       6734 ± 16%  softirqs.CPU100.RCU
    146880 ± 67%     -94.6%       7955 ±  6%  softirqs.CPU100.SCHED
    121181 ± 72%     -94.2%       7009 ± 19%  softirqs.CPU101.RCU
    146039 ± 67%     -94.4%       8137 ±  7%  softirqs.CPU101.SCHED
    116509 ± 71%     -94.2%       6811 ± 33%  softirqs.CPU102.RCU
    145174 ± 67%     -94.6%       7870 ±  4%  softirqs.CPU102.SCHED
    120345 ± 72%     -94.2%       7001 ± 14%  softirqs.CPU103.RCU
    145592 ± 67%     -94.5%       7956 ±  7%  softirqs.CPU103.SCHED
    118188 ± 72%     -94.2%       6811 ± 15%  softirqs.CPU104.RCU
    145999 ± 67%     -94.6%       7858 ± 11%  softirqs.CPU104.SCHED
    115775 ± 72%     -94.0%       6908 ± 17%  softirqs.CPU105.RCU
    145753 ± 67%     -95.1%       7124 ± 15%  softirqs.CPU105.SCHED
    117202 ± 73%     -93.9%       7096 ± 16%  softirqs.CPU106.RCU
    132797 ± 77%     -94.4%       7480 ± 11%  softirqs.CPU106.SCHED
    118184 ± 71%     -94.1%       6920 ± 15%  softirqs.CPU107.RCU
    146526 ± 67%     -94.6%       7930 ±  3%  softirqs.CPU107.SCHED
    106017 ± 73%     -93.7%       6691 ± 21%  softirqs.CPU108.RCU
    144867 ± 68%     -94.3%       8216 ±  9%  softirqs.CPU108.SCHED
    114199 ± 71%     -94.2%       6591 ± 14%  softirqs.CPU109.RCU
    130541 ± 77%     -93.9%       7935 ±  7%  softirqs.CPU109.SCHED
      3285 ±113%     -85.0%     493.38 ±148%  softirqs.CPU11.NET_RX
    119418 ± 71%     -93.8%       7409 ± 16%  softirqs.CPU11.RCU
    139384 ± 68%     -94.4%       7761 ± 13%  softirqs.CPU11.SCHED
    113630 ± 70%     -94.1%       6750 ± 16%  softirqs.CPU110.RCU
    145812 ± 67%     -94.8%       7601 ±  9%  softirqs.CPU110.SCHED
    116984 ± 72%     -94.1%       6906 ± 14%  softirqs.CPU111.RCU
    146693 ± 67%     -95.2%       7087 ± 19%  softirqs.CPU111.SCHED
     99851 ± 71%     -93.5%       6533 ± 13%  softirqs.CPU112.RCU
    145116 ± 67%     -94.4%       8187 ± 11%  softirqs.CPU112.SCHED
    107809 ± 71%     -94.2%       6282 ±  8%  softirqs.CPU113.RCU
    146438 ± 67%     -94.7%       7830 ±  4%  softirqs.CPU113.SCHED
      2827 ±122%     -97.8%      61.00 ±122%  softirqs.CPU113.TIMER
    109276 ± 71%     -94.2%       6350 ± 10%  softirqs.CPU114.RCU
    138706 ± 71%     -94.3%       7926 ±  2%  softirqs.CPU114.SCHED
    106809 ± 71%     -93.9%       6501 ± 11%  softirqs.CPU115.RCU
    132420 ± 69%     -94.1%       7769 ±  5%  softirqs.CPU115.SCHED
    105917 ± 71%     -94.1%       6294 ±  9%  softirqs.CPU116.RCU
    146185 ± 67%     -94.6%       7841 ±  5%  softirqs.CPU116.SCHED
    102120 ± 70%     -94.0%       6118 ±  8%  softirqs.CPU117.RCU
    145834 ± 68%     -95.1%       7092 ± 23%  softirqs.CPU117.SCHED
    107536 ± 71%     -94.2%       6222 ± 15%  softirqs.CPU118.RCU
    146264 ± 67%     -94.6%       7861 ±  4%  softirqs.CPU118.SCHED
    104195 ± 71%     -94.2%       6078 ±  7%  softirqs.CPU119.RCU
    145715 ± 67%     -94.7%       7771 ±  4%  softirqs.CPU119.SCHED
    108337 ± 71%     -92.6%       7997 ± 22%  softirqs.CPU12.RCU
    149912 ± 65%     -94.2%       8714 ± 14%  softirqs.CPU12.SCHED
    106114 ± 70%     -94.2%       6128 ±  7%  softirqs.CPU120.RCU
    131891 ± 69%     -94.2%       7677 ± 13%  softirqs.CPU120.SCHED
     96193 ± 70%     -94.0%       5786 ± 11%  softirqs.CPU121.RCU
    143380 ± 67%     -94.5%       7900 ±  4%  softirqs.CPU121.SCHED
    100749 ± 69%     -93.8%       6197 ± 17%  softirqs.CPU122.RCU
    143968 ± 67%     -94.6%       7804 ± 12%  softirqs.CPU122.SCHED
    103588 ± 70%     -94.1%       6081 ± 10%  softirqs.CPU123.RCU
    144796 ± 67%     -94.3%       8183 ±  6%  softirqs.CPU123.SCHED
    105205 ± 70%     -94.1%       6172 ± 16%  softirqs.CPU124.RCU
    144534 ± 67%     -94.5%       7920 ±  5%  softirqs.CPU124.SCHED
    106408 ± 70%     -94.3%       6071 ± 12%  softirqs.CPU125.RCU
    144480 ± 67%     -94.4%       8034 ±  3%  softirqs.CPU125.SCHED
    103778 ± 69%     -94.0%       6200 ± 10%  softirqs.CPU126.RCU
    144304 ± 67%     -94.5%       7906 ±  4%  softirqs.CPU126.SCHED
    101532 ± 70%     -93.9%       6159 ± 11%  softirqs.CPU127.RCU
    143643 ± 67%     -94.6%       7785 ±  7%  softirqs.CPU127.SCHED
    117329 ± 70%     -94.3%       6694 ± 14%  softirqs.CPU128.RCU
    143975 ± 67%     -94.5%       7854 ±  6%  softirqs.CPU128.SCHED
    121692 ± 70%     -94.4%       6816 ± 15%  softirqs.CPU129.RCU
    144473 ± 67%     -94.5%       7901 ±  3%  softirqs.CPU129.SCHED
    114689 ± 71%     -93.6%       7321 ± 26%  softirqs.CPU13.RCU
    145256 ± 66%     -94.1%       8596 ± 17%  softirqs.CPU13.SCHED
    115446 ± 70%     -94.1%       6759 ± 17%  softirqs.CPU130.RCU
    143482 ± 67%     -94.6%       7773 ±  6%  softirqs.CPU130.SCHED
    121853 ± 70%     -94.1%       7143 ± 26%  softirqs.CPU131.RCU
    144402 ± 67%     -94.5%       7955 ±  4%  softirqs.CPU131.SCHED
    122639 ± 70%     -94.3%       6935 ± 11%  softirqs.CPU132.RCU
    144140 ± 67%     -94.5%       7876 ±  8%  softirqs.CPU132.SCHED
    109497 ± 71%     -94.3%       6272 ± 11%  softirqs.CPU133.RCU
    142698 ± 67%     -94.5%       7865 ±  3%  softirqs.CPU133.SCHED
    113809 ± 70%     -94.1%       6720 ± 15%  softirqs.CPU134.RCU
    143437 ± 67%     -94.3%       8118 ± 11%  softirqs.CPU134.SCHED
    121112 ± 70%     -94.2%       7001 ± 16%  softirqs.CPU135.RCU
    144156 ± 67%     -94.4%       8065 ±  4%  softirqs.CPU135.SCHED
    118112 ± 71%     -94.2%       6827 ± 18%  softirqs.CPU136.RCU
    143835 ± 67%     -94.5%       7876 ±  5%  softirqs.CPU136.SCHED
    126020 ± 71%     -94.5%       6931 ± 17%  softirqs.CPU137.RCU
    144943 ± 67%     -94.6%       7834 ±  4%  softirqs.CPU137.SCHED
    123696 ± 70%     -94.7%       6523 ± 24%  softirqs.CPU138.RCU
    144653 ± 67%     -94.5%       7949 ±  3%  softirqs.CPU138.SCHED
    119760 ± 70%     -94.3%       6852 ± 13%  softirqs.CPU139.RCU
    130436 ± 69%     -94.0%       7823 ±  5%  softirqs.CPU139.SCHED
    113876 ± 71%     -93.5%       7443 ± 16%  softirqs.CPU14.RCU
    146578 ± 67%     -94.6%       7939 ±  5%  softirqs.CPU14.SCHED
    123490 ± 70%     -94.7%       6605 ± 16%  softirqs.CPU140.RCU
    144305 ± 67%     -94.4%       8098 ±  8%  softirqs.CPU140.SCHED
    120753 ± 71%     -94.1%       7071 ± 25%  softirqs.CPU141.RCU
    144031 ± 67%     -94.5%       7897 ±  5%  softirqs.CPU141.SCHED
    117977 ± 69%     -94.1%       6946 ± 16%  softirqs.CPU142.RCU
    144370 ± 67%     -94.5%       7993 ±  4%  softirqs.CPU142.SCHED
    121838 ± 71%     -94.4%       6837 ± 14%  softirqs.CPU143.RCU
    144187 ± 67%     -94.5%       7984 ±  4%  softirqs.CPU143.SCHED
    110453 ± 69%     -93.6%       7104 ± 23%  softirqs.CPU144.RCU
    132283 ± 69%     -94.0%       7927 ±  5%  softirqs.CPU144.SCHED
    111256 ± 70%     -94.0%       6639 ± 22%  softirqs.CPU145.RCU
    144248 ± 67%     -94.6%       7791 ±  3%  softirqs.CPU145.SCHED
    110246 ± 69%     -93.7%       6956 ± 10%  softirqs.CPU146.RCU
    144465 ± 67%     -94.4%       8092 ±  3%  softirqs.CPU146.SCHED
    117843 ± 70%     -93.7%       7400 ± 19%  softirqs.CPU147.RCU
    145510 ± 67%     -94.6%       7829 ±  3%  softirqs.CPU147.SCHED
    118474 ± 70%     -93.6%       7639 ± 20%  softirqs.CPU148.RCU
    145424 ± 67%     -94.6%       7816 ±  9%  softirqs.CPU148.SCHED
    118628 ± 70%     -93.8%       7334 ± 19%  softirqs.CPU149.RCU
    145442 ± 67%     -94.7%       7757 ±  3%  softirqs.CPU149.SCHED
    116547 ± 71%     -93.2%       7966 ± 21%  softirqs.CPU15.RCU
    145815 ± 68%     -94.5%       8051 ±  6%  softirqs.CPU15.SCHED
    119781 ± 69%     -93.9%       7298 ± 20%  softirqs.CPU150.RCU
    131919 ± 70%     -94.1%       7816 ±  3%  softirqs.CPU150.SCHED
    116781 ± 70%     -94.0%       7011 ± 17%  softirqs.CPU151.RCU
    144011 ± 67%     -94.6%       7764 ±  5%  softirqs.CPU151.SCHED
    117324 ± 70%     -93.8%       7245 ± 17%  softirqs.CPU152.RCU
    145039 ± 67%     -94.6%       7796 ±  4%  softirqs.CPU152.SCHED
    116751 ± 70%     -93.7%       7372 ± 20%  softirqs.CPU153.RCU
    144211 ± 67%     -94.3%       8242 ±  7%  softirqs.CPU153.SCHED
    119311 ± 70%     -94.0%       7195 ± 20%  softirqs.CPU154.RCU
    144709 ± 67%     -94.7%       7729 ±  5%  softirqs.CPU154.SCHED
    120356 ± 70%     -94.0%       7232 ± 20%  softirqs.CPU155.RCU
    143547 ± 68%     -94.5%       7909 ±  2%  softirqs.CPU155.SCHED
    115589 ± 70%     -93.9%       7021 ± 17%  softirqs.CPU156.RCU
    143900 ± 67%     -94.5%       7959 ±  5%  softirqs.CPU156.SCHED
    116416 ± 69%     -93.7%       7346 ± 25%  softirqs.CPU157.RCU
    144513 ± 67%     -94.6%       7872 ±  4%  softirqs.CPU157.SCHED
    116468 ± 70%     -93.9%       7079 ± 20%  softirqs.CPU158.RCU
    144878 ± 67%     -94.7%       7692 ±  6%  softirqs.CPU158.SCHED
    113447 ± 69%     -93.6%       7247 ± 16%  softirqs.CPU159.RCU
    144623 ± 67%     -94.6%       7839 ±  5%  softirqs.CPU159.SCHED
     98446 ± 69%     -93.5%       6435 ±  8%  softirqs.CPU16.RCU
    146242 ± 67%     -94.6%       7871 ±  3%  softirqs.CPU16.SCHED
    109999 ± 70%     -94.3%       6273 ± 22%  softirqs.CPU160.RCU
    145412 ± 67%     -94.6%       7873 ±  3%  softirqs.CPU160.SCHED
    111445 ± 69%     -94.1%       6564 ± 25%  softirqs.CPU161.RCU
    145684 ± 67%     -94.6%       7879 ±  3%  softirqs.CPU161.SCHED
    100119 ± 71%     -94.1%       5916 ± 19%  softirqs.CPU162.RCU
    143106 ± 67%     -94.6%       7738 ±  5%  softirqs.CPU162.SCHED
    110767 ± 69%     -94.5%       6101 ± 22%  softirqs.CPU163.RCU
    144624 ± 67%     -94.7%       7667 ±  7%  softirqs.CPU163.SCHED
    109708 ± 69%     -94.3%       6304 ± 23%  softirqs.CPU164.RCU
    145488 ± 67%     -94.6%       7791 ±  4%  softirqs.CPU164.SCHED
    110053 ± 68%     -94.3%       6305 ± 22%  softirqs.CPU165.RCU
    145752 ± 67%     -94.6%       7848 ±  2%  softirqs.CPU165.SCHED
    110626 ± 68%     -94.3%       6332 ± 21%  softirqs.CPU166.RCU
    145450 ± 67%     -94.7%       7737 ±  3%  softirqs.CPU166.SCHED
    111326 ± 70%     -94.3%       6368 ± 22%  softirqs.CPU167.RCU
    144610 ± 67%     -94.4%       8137 ±  7%  softirqs.CPU167.SCHED
    105307 ± 70%     -94.3%       6004 ± 20%  softirqs.CPU168.RCU
    125345 ± 71%     -93.9%       7655 ± 12%  softirqs.CPU168.SCHED
     97580 ± 70%     -94.5%       5413 ± 19%  softirqs.CPU169.RCU
    129248 ± 70%     -93.9%       7853 ±  3%  softirqs.CPU169.SCHED
    107905 ± 71%     -93.7%       6846 ± 11%  softirqs.CPU17.RCU
    147398 ± 67%     -94.6%       7958 ±  6%  softirqs.CPU17.SCHED
    103311 ± 70%     -94.7%       5511 ± 17%  softirqs.CPU170.RCU
    140549 ± 66%     -94.3%       7951 ±  3%  softirqs.CPU170.SCHED
    108033 ± 70%     -94.3%       6169 ± 23%  softirqs.CPU171.RCU
    142857 ± 67%     -94.5%       7925 ±  4%  softirqs.CPU171.SCHED
    108057 ± 70%     -94.7%       5772 ± 21%  softirqs.CPU172.RCU
    141731 ± 68%     -94.5%       7804 ±  4%  softirqs.CPU172.SCHED
    106746 ± 71%     -94.6%       5744 ± 19%  softirqs.CPU173.RCU
    141905 ± 67%     -94.3%       8038 ±  2%  softirqs.CPU173.SCHED
    108377 ± 70%     -94.7%       5763 ± 22%  softirqs.CPU174.RCU
    141517 ± 66%     -94.5%       7761 ±  4%  softirqs.CPU174.SCHED
    103957 ± 69%     -94.7%       5491 ± 21%  softirqs.CPU175.RCU
    140206 ± 66%     -94.4%       7786 ±  2%  softirqs.CPU175.SCHED
    111994 ± 69%     -94.4%       6294 ± 16%  softirqs.CPU176.RCU
    140529 ± 67%     -94.5%       7760 ±  4%  softirqs.CPU176.SCHED
    115568 ± 70%     -94.2%       6754 ± 20%  softirqs.CPU177.RCU
    142779 ± 67%     -94.5%       7847 ±  2%  softirqs.CPU177.SCHED
    112387 ± 70%     -94.1%       6590 ± 20%  softirqs.CPU178.RCU
    140968 ± 66%     -94.4%       7830 ±  2%  softirqs.CPU178.SCHED
    119527 ± 70%     -94.3%       6838 ± 21%  softirqs.CPU179.RCU
    141951 ± 67%     -94.6%       7689 ±  5%  softirqs.CPU179.SCHED
    107949 ± 70%     -93.9%       6591 ± 11%  softirqs.CPU18.RCU
    147002 ± 67%     -94.6%       8003 ±  3%  softirqs.CPU18.SCHED
    118331 ± 68%     -94.3%       6686 ± 21%  softirqs.CPU180.RCU
    132024 ± 72%     -94.1%       7723 ±  4%  softirqs.CPU180.SCHED
    107791 ± 70%     -94.3%       6178 ± 15%  softirqs.CPU181.RCU
    138330 ± 68%     -94.6%       7446 ±  9%  softirqs.CPU181.SCHED
    110242 ± 70%     -94.1%       6471 ± 18%  softirqs.CPU182.RCU
    139884 ± 66%     -94.5%       7716 ±  4%  softirqs.CPU182.SCHED
    115290 ± 70%     -93.9%       7015 ± 22%  softirqs.CPU183.RCU
    142197 ± 66%     -94.4%       7945 ±  2%  softirqs.CPU183.SCHED
    112210 ± 70%     -94.1%       6654 ± 14%  softirqs.CPU184.RCU
    139074 ± 68%     -94.4%       7845 ±  2%  softirqs.CPU184.SCHED
    118204 ± 70%     -94.1%       7011 ± 22%  softirqs.CPU185.RCU
    141725 ± 66%     -94.5%       7836 ±  4%  softirqs.CPU185.SCHED
    119087 ± 70%     -94.0%       7184 ± 20%  softirqs.CPU186.RCU
    142514 ± 66%     -94.4%       7945 ±  4%  softirqs.CPU186.SCHED
    114547 ± 70%     -93.8%       7104 ± 23%  softirqs.CPU187.RCU
    141280 ± 66%     -94.6%       7590 ±  5%  softirqs.CPU187.SCHED
    116349 ± 71%     -94.2%       6739 ± 22%  softirqs.CPU188.RCU
    142662 ± 66%     -94.6%       7662 ±  5%  softirqs.CPU188.SCHED
    114968 ± 70%     -94.2%       6712 ± 18%  softirqs.CPU189.RCU
    142100 ± 66%     -94.5%       7866 ±  2%  softirqs.CPU189.SCHED
    107016 ± 71%     -93.5%       6944 ± 13%  softirqs.CPU19.RCU
    144877 ± 69%     -94.7%       7703 ± 12%  softirqs.CPU19.SCHED
    118282 ± 70%     -94.1%       7001 ± 20%  softirqs.CPU190.RCU
    133528 ± 72%     -94.0%       8062 ±  3%  softirqs.CPU190.SCHED
    115275 ± 69%     -94.0%       6894 ± 12%  softirqs.CPU191.RCU
    106238 ± 80%     -94.4%       5998 ± 14%  softirqs.CPU191.SCHED
    116697 ± 72%     -93.6%       7513 ± 22%  softirqs.CPU2.RCU
    146258 ± 67%     -94.2%       8462 ±  5%  softirqs.CPU2.SCHED
    106533 ± 69%     -93.8%       6578 ± 10%  softirqs.CPU20.RCU
    146849 ± 67%     -94.7%       7820 ±  5%  softirqs.CPU20.SCHED
    102773 ± 70%     -93.8%       6364 ±  9%  softirqs.CPU21.RCU
    147016 ± 67%     -94.7%       7835 ±  5%  softirqs.CPU21.SCHED
    108048 ± 70%     -93.9%       6615 ± 12%  softirqs.CPU22.RCU
    147171 ± 67%     -94.6%       8008 ±  4%  softirqs.CPU22.SCHED
    105989 ± 71%     -94.1%       6257 ±  8%  softirqs.CPU23.RCU
    146547 ± 66%     -94.6%       7843 ±  2%  softirqs.CPU23.SCHED
    107508 ± 70%     -93.5%       6999 ± 17%  softirqs.CPU24.RCU
    145391 ± 67%     -94.4%       8153 ±  4%  softirqs.CPU24.SCHED
     96844 ± 73%     -93.8%       6023 ± 14%  softirqs.CPU25.RCU
    143700 ± 67%     -93.5%       9355 ± 31%  softirqs.CPU25.SCHED
    102217 ± 69%     -93.6%       6562 ± 15%  softirqs.CPU26.RCU
    131039 ± 68%     -93.9%       7956 ±  4%  softirqs.CPU26.SCHED
    104826 ± 70%     -93.7%       6608 ± 13%  softirqs.CPU27.RCU
    131768 ± 69%     -94.0%       7950 ±  3%  softirqs.CPU27.SCHED
    106523 ± 70%     -94.1%       6266 ± 16%  softirqs.CPU28.RCU
    144755 ± 67%     -94.5%       8027 ±  2%  softirqs.CPU28.SCHED
    106664 ± 70%     -94.4%       6016 ±  6%  softirqs.CPU29.RCU
    145956 ± 65%     -93.8%       8978 ± 29%  softirqs.CPU29.SCHED
    119154 ± 71%     -93.6%       7648 ± 19%  softirqs.CPU3.RCU
    147355 ± 66%     -94.2%       8496 ±  7%  softirqs.CPU3.SCHED
    104583 ± 69%     -93.8%       6488 ± 10%  softirqs.CPU30.RCU
    144527 ± 66%     -94.5%       7934 ±  5%  softirqs.CPU30.SCHED
    102430 ± 70%     -93.8%       6367 ± 15%  softirqs.CPU31.RCU
    143426 ± 66%     -93.7%       9090 ± 24%  softirqs.CPU31.SCHED
    116417 ± 70%     -93.6%       7419 ± 21%  softirqs.CPU32.RCU
    130941 ± 69%     -93.9%       7944 ±  5%  softirqs.CPU32.SCHED
    119871 ± 70%     -93.7%       7506 ± 16%  softirqs.CPU33.RCU
    145167 ± 66%     -94.4%       8088 ±  5%  softirqs.CPU33.SCHED
    116131 ± 70%     -93.6%       7488 ± 20%  softirqs.CPU34.RCU
    131242 ± 69%     -93.8%       8159 ±  8%  softirqs.CPU34.SCHED
    124050 ± 70%     -93.6%       7926 ± 23%  softirqs.CPU35.RCU
    144571 ± 66%     -94.4%       8136 ±  7%  softirqs.CPU35.SCHED
    123348 ± 71%     -94.0%       7438 ± 17%  softirqs.CPU36.RCU
    144556 ± 66%     -94.5%       7937 ±  4%  softirqs.CPU36.SCHED
    108709 ± 71%     -93.6%       6972 ± 17%  softirqs.CPU37.RCU
    143216 ± 67%     -94.4%       7958 ±  5%  softirqs.CPU37.SCHED
    114216 ± 70%     -93.8%       7117 ± 15%  softirqs.CPU38.RCU
    144169 ± 66%     -94.6%       7848 ±  6%  softirqs.CPU38.SCHED
    121431 ± 70%     -93.8%       7584 ± 18%  softirqs.CPU39.RCU
    144649 ± 66%     -94.2%       8373 ± 10%  softirqs.CPU39.SCHED
    119868 ± 72%     -93.5%       7772 ± 19%  softirqs.CPU4.RCU
    147559 ± 67%     -94.5%       8052 ±  4%  softirqs.CPU4.SCHED
    118917 ± 70%     -93.8%       7319 ± 18%  softirqs.CPU40.RCU
    144028 ± 66%     -94.5%       7936 ±  5%  softirqs.CPU40.SCHED
    126590 ± 70%     -93.9%       7701 ± 18%  softirqs.CPU41.RCU
    145001 ± 66%     -94.3%       8323 ± 15%  softirqs.CPU41.SCHED
    125675 ± 70%     -94.1%       7427 ± 18%  softirqs.CPU42.RCU
    145049 ± 66%     -94.5%       7934 ±  5%  softirqs.CPU42.SCHED
    118730 ± 70%     -93.9%       7279 ± 17%  softirqs.CPU43.RCU
    143879 ± 67%     -94.5%       7867 ±  3%  softirqs.CPU43.SCHED
    121343 ± 70%     -94.1%       7211 ± 22%  softirqs.CPU44.RCU
    145203 ± 67%     -94.5%       7968 ±  4%  softirqs.CPU44.SCHED
    122203 ± 71%     -93.8%       7521 ± 20%  softirqs.CPU45.RCU
    144753 ± 66%     -94.6%       7852 ±  4%  softirqs.CPU45.SCHED
    120357 ± 69%     -93.8%       7513 ± 19%  softirqs.CPU46.RCU
    145049 ± 67%     -94.5%       8043 ±  7%  softirqs.CPU46.SCHED
    123296 ± 70%     -94.5%       6809 ± 22%  softirqs.CPU47.RCU
    144745 ± 66%     -94.5%       8003 ±  3%  softirqs.CPU47.SCHED
    112526 ± 68%     -92.9%       8011 ± 17%  softirqs.CPU48.RCU
    146398 ± 68%     -94.6%       7861 ± 11%  softirqs.CPU48.SCHED
    112785 ± 69%     -93.6%       7240 ± 17%  softirqs.CPU49.RCU
    144478 ± 67%     -94.6%       7749 ±  4%  softirqs.CPU49.SCHED
    122086 ± 72%     -94.1%       7186 ± 23%  softirqs.CPU5.RCU
    146481 ± 67%     -93.8%       9070 ± 39%  softirqs.CPU5.SCHED
    112064 ± 69%     -93.5%       7283 ±  9%  softirqs.CPU50.RCU
    144812 ± 67%     -94.7%       7665 ±  4%  softirqs.CPU50.SCHED
    118074 ± 69%     -93.2%       8042 ± 17%  softirqs.CPU51.RCU
    145452 ± 67%     -94.6%       7903 ±  4%  softirqs.CPU51.SCHED
    118979 ± 70%     -93.5%       7729 ± 17%  softirqs.CPU52.RCU
    146007 ± 67%     -94.9%       7463 ± 11%  softirqs.CPU52.SCHED
    117706 ± 69%     -93.0%       8254 ± 21%  softirqs.CPU53.RCU
    146100 ± 67%     -94.5%       8012 ±  6%  softirqs.CPU53.SCHED
    118415 ± 69%     -93.4%       7789 ± 16%  softirqs.CPU54.RCU
    145382 ± 67%     -94.8%       7511 ± 10%  softirqs.CPU54.SCHED
    117554 ± 70%     -93.7%       7376 ± 15%  softirqs.CPU55.RCU
    144766 ± 67%     -94.7%       7707 ±  5%  softirqs.CPU55.SCHED
    117849 ± 69%     -93.3%       7950 ± 15%  softirqs.CPU56.RCU
    145620 ± 67%     -94.6%       7858 ± 11%  softirqs.CPU56.SCHED
    117646 ± 69%     -93.7%       7458 ± 17%  softirqs.CPU57.RCU
    144674 ± 67%     -94.5%       7920 ±  2%  softirqs.CPU57.SCHED
    119366 ± 69%     -93.4%       7912 ± 16%  softirqs.CPU58.RCU
    144755 ± 67%     -94.6%       7805 ±  2%  softirqs.CPU58.SCHED
    120064 ± 69%     -93.6%       7737 ± 16%  softirqs.CPU59.RCU
    144977 ± 67%     -94.6%       7834 ±  2%  softirqs.CPU59.SCHED
    114962 ± 71%     -92.9%       8116 ± 30%  softirqs.CPU6.RCU
    145714 ± 67%     -95.1%       7127 ± 19%  softirqs.CPU6.SCHED
    115738 ± 70%     -93.7%       7286 ± 12%  softirqs.CPU60.RCU
    144209 ± 67%     -95.0%       7220 ± 17%  softirqs.CPU60.SCHED
    117045 ± 69%     -93.5%       7606 ± 16%  softirqs.CPU61.RCU
    144543 ± 67%     -94.6%       7826 ±  2%  softirqs.CPU61.SCHED
    117458 ± 69%     -93.7%       7402 ± 20%  softirqs.CPU62.RCU
    145402 ± 67%     -94.9%       7466 ± 10%  softirqs.CPU62.SCHED
    113644 ± 68%     -93.3%       7627 ± 14%  softirqs.CPU63.RCU
    144814 ± 67%     -94.6%       7852 ±  2%  softirqs.CPU63.SCHED
    108897 ± 70%     -93.7%       6861 ± 19%  softirqs.CPU64.RCU
    145692 ± 67%     -94.6%       7924 ±  4%  softirqs.CPU64.SCHED
    111017 ± 68%     -94.0%       6631 ± 19%  softirqs.CPU65.RCU
    145937 ± 67%     -94.6%       7904 ±  6%  softirqs.CPU65.SCHED
     99005 ± 71%     -93.6%       6334 ± 18%  softirqs.CPU66.RCU
    143561 ± 67%     -94.8%       7513 ± 10%  softirqs.CPU66.SCHED
    109453 ± 70%     -94.0%       6536 ± 20%  softirqs.CPU67.RCU
    144424 ± 67%     -94.6%       7766 ±  5%  softirqs.CPU67.SCHED
    109104 ± 69%     -94.0%       6573 ± 19%  softirqs.CPU68.RCU
    145930 ± 67%     -94.6%       7834 ±  2%  softirqs.CPU68.SCHED
    108586 ± 69%     -94.1%       6427 ± 19%  softirqs.CPU69.RCU
    120596 ± 72%     -94.2%       7012 ± 12%  softirqs.CPU7.RCU
    146174 ± 67%     -95.3%       6919 ± 19%  softirqs.CPU7.SCHED
    110257 ± 68%     -94.0%       6646 ± 19%  softirqs.CPU70.RCU
    145811 ± 67%     -94.6%       7886        softirqs.CPU70.SCHED
    110866 ± 70%     -94.2%       6471 ± 21%  softirqs.CPU71.RCU
    145003 ± 67%     -94.6%       7848 ±  3%  softirqs.CPU71.SCHED
    104279 ± 70%     -93.6%       6689 ± 20%  softirqs.CPU72.RCU
    140943 ± 66%     -94.4%       7923 ±  2%  softirqs.CPU72.SCHED
     97344 ± 70%     -93.7%       6172 ± 17%  softirqs.CPU73.RCU
    139269 ± 66%     -94.4%       7843 ±  2%  softirqs.CPU73.SCHED
    102376 ± 69%     -94.2%       5939 ± 17%  softirqs.CPU74.RCU
    140370 ± 66%     -94.3%       7936 ±  4%  softirqs.CPU74.SCHED
    107767 ± 69%     -94.3%       6145 ± 19%  softirqs.CPU75.RCU
    141152 ± 68%     -94.4%       7875        softirqs.CPU75.SCHED
    106964 ± 70%     -94.3%       6059 ± 20%  softirqs.CPU76.RCU
    142452 ± 66%     -94.5%       7790 ±  3%  softirqs.CPU76.SCHED
    105833 ± 71%     -93.8%       6605 ± 18%  softirqs.CPU77.RCU
    141721 ± 66%     -94.5%       7819 ±  2%  softirqs.CPU77.SCHED
    107708 ± 70%     -94.4%       6040 ± 20%  softirqs.CPU78.RCU
    141337 ± 66%     -94.5%       7732 ±  3%  softirqs.CPU78.SCHED
    103310 ± 70%     -94.2%       5987 ± 18%  softirqs.CPU79.RCU
    139711 ± 66%     -94.4%       7867 ±  3%  softirqs.CPU79.SCHED
    118389 ± 72%     -94.3%       6805 ± 15%  softirqs.CPU8.RCU
    146035 ± 67%     -94.9%       7383 ±  9%  softirqs.CPU8.SCHED
    111806 ± 69%     -94.1%       6647 ± 16%  softirqs.CPU80.RCU
    140233 ± 66%     -94.4%       7826 ±  2%  softirqs.CPU80.SCHED
    113432 ± 71%     -93.7%       7143 ± 19%  softirqs.CPU81.RCU
    142118 ± 66%     -94.5%       7790 ±  4%  softirqs.CPU81.SCHED
    111372 ± 70%     -93.7%       6975 ± 19%  softirqs.CPU82.RCU
    140581 ± 67%     -94.5%       7750 ±  2%  softirqs.CPU82.SCHED
    119608 ± 70%     -94.0%       7215 ± 20%  softirqs.CPU83.RCU
    141548 ± 66%     -94.6%       7704 ±  3%  softirqs.CPU83.SCHED
    116022 ± 70%     -93.8%       7238 ± 19%  softirqs.CPU84.RCU
    129723 ± 70%     -94.1%       7689 ±  4%  softirqs.CPU84.SCHED
    106977 ± 70%     -93.9%       6557 ± 14%  softirqs.CPU85.RCU
    139995 ± 66%     -94.3%       7910 ±  7%  softirqs.CPU85.SCHED
    111065 ± 69%     -93.6%       7058 ± 22%  softirqs.CPU86.RCU
    139604 ± 66%     -94.4%       7783 ±  3%  softirqs.CPU86.SCHED
    115523 ± 70%     -94.0%       6988 ± 21%  softirqs.CPU87.RCU
    142009 ± 66%     -94.5%       7773 ±  4%  softirqs.CPU87.SCHED
    111992 ± 70%     -93.9%       6871 ± 15%  softirqs.CPU88.RCU
    140144 ± 66%     -94.4%       7831 ±  3%  softirqs.CPU88.SCHED
    117927 ± 70%     -93.8%       7262 ± 21%  softirqs.CPU89.RCU
    140962 ± 67%     -94.4%       7843 ±  5%  softirqs.CPU89.SCHED
    117244 ± 72%     -93.8%       7272 ± 17%  softirqs.CPU9.RCU
    145167 ± 68%     -94.6%       7910 ±  4%  softirqs.CPU9.SCHED
    118638 ± 70%     -93.9%       7252 ± 19%  softirqs.CPU90.RCU
    141589 ± 66%     -94.5%       7730 ±  4%  softirqs.CPU90.SCHED
    114392 ± 70%     -93.5%       7422 ± 18%  softirqs.CPU91.RCU
    140880 ± 66%     -94.5%       7795 ±  3%  softirqs.CPU91.SCHED
    117293 ± 70%     -94.0%       7081 ± 21%  softirqs.CPU92.RCU
    141464 ± 66%     -94.5%       7759 ±  5%  softirqs.CPU92.SCHED
    114549 ± 69%     -94.0%       6928 ± 19%  softirqs.CPU93.RCU
    139039 ± 69%     -94.4%       7847 ±  3%  softirqs.CPU93.SCHED
    117200 ± 70%     -93.9%       7199 ± 20%  softirqs.CPU94.RCU
    141766 ± 66%     -94.5%       7827 ±  3%  softirqs.CPU94.SCHED
    114081 ± 70%     -93.6%       7310 ± 14%  softirqs.CPU95.RCU
     58928 ±111%     -90.7%       5489 ± 26%  softirqs.CPU95.SCHED
    109232 ± 70%     -93.5%       7106 ± 30%  softirqs.CPU96.RCU
    139522 ± 68%     -95.1%       6796 ± 23%  softirqs.CPU96.SCHED
    109860 ± 72%     -94.3%       6285 ±  5%  softirqs.CPU97.RCU
    131667 ± 70%     -94.0%       7935 ±  3%  softirqs.CPU97.SCHED
    119514 ± 72%     -94.8%       6202 ± 22%  softirqs.CPU98.RCU
    144538 ± 69%     -94.6%       7817 ±  2%  softirqs.CPU98.SCHED
    117760 ± 71%     -94.1%       6992 ± 23%  softirqs.CPU99.RCU
    136441 ± 74%     -94.3%       7727 ±  7%  softirqs.CPU99.SCHED
  21713054 ± 70%     -93.9%    1317706 ± 14%  softirqs.RCU
  27318493 ± 67%     -94.4%    1516316 ±  2%  softirqs.SCHED
    214663 ± 64%     -86.7%      28451 ±  4%  softirqs.TIMER





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


---
0DAY/LKP+ Test Infrastructure                   Open Source Technology Center
https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporation

Thanks,
Oliver Sang


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.14.0-rc6-00032-ge38b3f200594-dirty"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.14.0-rc6 Kernel Configuration
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
# CONFIG_XEN is not set
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
# CONFIG_HYPERV_STORAGE is not set
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
# CONFIG_NET_VENDOR_3COM is not set
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
# CONFIG_WLAN_VENDOR_MEDIATEK is not set
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
# CONFIG_DRM_I915_GVT is not set
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
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
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
# CONFIG_FAIL_SUNRPC is not set
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

--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='fsmark'
	export testcase='fsmark'
	export category='benchmark'
	export iterations=1
	export nr_threads=1
	export need_memory='50G'
	export job_origin='fsmark-generic-1brd.yaml'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue='validate'
	export testbox='lkp-csl-2ap2'
	export tbox_group='lkp-csl-2ap2'
	export kconfig='x86_64-rhel-8.3'
	export submit_id='613fed26bb5fc800f1b6b67f'
	export job_file='/lkp/jobs/scheduled/lkp-csl-2ap2/fsmark-performance-1BRD_48G-4M-f2fs-nfsv4-1x-1t-NoSync-24G-ucode=0x5003006-debian-10.4-x86_64-20200603.cgz-e38b3f20059426a0adbde-20210914-65777-xaabu0-3.yaml'
	export id='6e73499efbbd4f3cf46ce843bd0010024881d558'
	export queuer_version='/lkp-src'
	export model='Cascade Lake'
	export nr_node=4
	export nr_cpu=192
	export memory='192G'
	export nr_ssd_partitions=1
	export hdd_partitions=
	export ssd_partitions='/dev/disk/by-id/nvme-INTEL_SSDPE2KX010T8_BTLJ910200B21P0FGN-part4'
	export rootfs_partition='LABEL=LKP-ROOTFS'
	export kernel_cmdline_hw='acpi_rsdp=0x67f44014'
	export brand='Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz'
	export need_kconfig='{"BLK_DEV_RAM"=>"m"}
{"BLK_DEV"=>"y"}
{"BLOCK"=>"y"}
NFSD
F2FS_FS
NFS_V4'
	export commit='e38b3f20059426a0adbde014ff71071739ab5226'
	export need_kconfig_hw='{"IGB"=>"y"}
BLK_DEV_NVME'
	export ucode='0x5003006'
	export enqueue_time='2021-09-14 08:30:31 +0800'
	export _id='613fed26bb5fc800f1b6b67f'
	export _rt='/result/fsmark/performance-1BRD_48G-4M-f2fs-nfsv4-1x-1t-NoSync-24G-ucode=0x5003006/lkp-csl-2ap2/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/e38b3f20059426a0adbde014ff71071739ab5226'
	export user='lkp'
	export compiler='gcc-9'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='f5f61427c009cd034da192397d7510405d318882'
	export base_commit='7d2a07b769330c34b4deabeed939325c77a7ec2f'
	export branch='linus/master'
	export rootfs='debian-10.4-x86_64-20200603.cgz'
	export result_root='/result/fsmark/performance-1BRD_48G-4M-f2fs-nfsv4-1x-1t-NoSync-24G-ucode=0x5003006/lkp-csl-2ap2/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/e38b3f20059426a0adbde014ff71071739ab5226/3'
	export scheduler_version='/lkp/lkp/.src-20210910-192256'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-csl-2ap2/fsmark-performance-1BRD_48G-4M-f2fs-nfsv4-1x-1t-NoSync-24G-ucode=0x5003006-debian-10.4-x86_64-20200603.cgz-e38b3f20059426a0adbde-20210914-65777-xaabu0-3.yaml
ARCH=x86_64
kconfig=x86_64-rhel-8.3
branch=linus/master
commit=e38b3f20059426a0adbde014ff71071739ab5226
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/e38b3f20059426a0adbde014ff71071739ab5226/vmlinuz-5.14.0-rc6-00032-ge38b3f200594-dirty
acpi_rsdp=0x67f44014
max_uptime=2100
RESULT_ROOT=/result/fsmark/performance-1BRD_48G-4M-f2fs-nfsv4-1x-1t-NoSync-24G-ucode=0x5003006/lkp-csl-2ap2/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/e38b3f20059426a0adbde014ff71071739ab5226/3
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
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3/gcc-9/e38b3f20059426a0adbde014ff71071739ab5226/modules.cgz'
	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20210707.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20210906.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-ac08b1c68d1b-1_20210908.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/fs_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/fs2_20200714.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/fsmark-x86_64-698ee57-1_20210907.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/turbostat_20200721.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/turbostat-x86_64-3.7-4_20200721.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20210222.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.14.0'
	export repeat_to=6
	export queue_at_least_once=1
	export kernel='/pkg/linux/x86_64-rhel-8.3/gcc-9/e38b3f20059426a0adbde014ff71071739ab5226/vmlinuz-5.14.0-rc6-00032-ge38b3f200594-dirty'
	export dequeue_time='2021-09-14 08:36:38 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-csl-2ap2/fsmark-performance-1BRD_48G-4M-f2fs-nfsv4-1x-1t-NoSync-24G-ucode=0x5003006-debian-10.4-x86_64-20200603.cgz-e38b3f20059426a0adbde-20210914-65777-xaabu0-3.cgz'

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

	run_setup nr_brd=1 ramdisk_size=51539607552 $LKP_SRC/setup/disk

	run_setup fs='f2fs' $LKP_SRC/setup/fs

	run_setup fs='nfsv4' $LKP_SRC/setup/fs2

	run_setup $LKP_SRC/setup/cpufreq_governor 'performance'

	run_monitor delay=1 $LKP_SRC/monitors/no-stdout/wrapper perf-profile
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
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test filesize='4M' test_size='24G' sync_method='NoSync' $LKP_SRC/tests/wrapper fsmark
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env delay=1 $LKP_SRC/stats/wrapper perf-profile
	env filesize='4M' test_size='24G' sync_method='NoSync' $LKP_SRC/stats/wrapper fsmark
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

	$LKP_SRC/stats/wrapper time fsmark.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---
:#! jobs/fsmark-generic-1brd.yaml:
suite: fsmark
testcase: fsmark
category: benchmark
perf-profile:
  delay: 1
iterations: 1x
nr_threads: 1t
disk: 1BRD_48G
need_memory: 50G
fs: f2fs
fs2: nfsv4
fsmark:
  filesize: 4M
  test_size: 24G
  sync_method: NoSync
job_origin: fsmark-generic-1brd.yaml
:#! queue options:
queue_cmdline_keys:
- branch
- commit
- queue_at_least_once
queue: bisect
testbox: lkp-csl-2ap2
tbox_group: lkp-csl-2ap2
kconfig: x86_64-rhel-8.3
submit_id: 613fe320bb5fc8fbfa8c7442
job_file: "/lkp/jobs/scheduled/lkp-csl-2ap2/fsmark-performance-1BRD_48G-4M-f2fs-nfsv4-1x-1t-NoSync-24G-ucode=0x5003006-debian-10.4-x86_64-20200603.cgz-e38b3f20059426a0adbde-20210914-64506-1wudof4-1.yaml"
id: dbd32f221365b85b7fd9a40fba51bb7732b3f39b
queuer_version: "/lkp-src"
:#! hosts/lkp-csl-2ap2:
model: Cascade Lake
nr_node: 4
nr_cpu: 192
memory: 192G
nr_ssd_partitions: 1
hdd_partitions:
ssd_partitions: "/dev/disk/by-id/nvme-INTEL_SSDPE2KX010T8_BTLJ910200B21P0FGN-part4"
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
:#! include/category/ALL:
cpufreq_governor: performance
:#! include/disk/nr_brd:
need_kconfig:
- BLK_DEV_RAM: m
- BLK_DEV: y
- BLOCK: y
- NFSD
- F2FS_FS
- NFS_V4
:#! include/fsmark:
:#! include/queue/cyclic:
commit: e38b3f20059426a0adbde014ff71071739ab5226
:#! include/testbox/lkp-csl-2ap2:
need_kconfig_hw:
- IGB: y
- BLK_DEV_NVME
ucode: '0x5003006'
:#! include/fs/OTHERS:
:#! include/fs/nfsv4:
enqueue_time: 2021-09-14 07:47:45.076973165 +08:00
_id: 613fe9ccbb5fc8fbfa8c7443
_rt: "/result/fsmark/performance-1BRD_48G-4M-f2fs-nfsv4-1x-1t-NoSync-24G-ucode=0x5003006/lkp-csl-2ap2/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/e38b3f20059426a0adbde014ff71071739ab5226"
:#! schedule options:
user: lkp
compiler: gcc-9
LKP_SERVER: internal-lkp-server
head_commit: f5f61427c009cd034da192397d7510405d318882
base_commit: 7d2a07b769330c34b4deabeed939325c77a7ec2f
branch: linux-devel/devel-hourly-20210912-050321
rootfs: debian-10.4-x86_64-20200603.cgz
result_root: "/result/fsmark/performance-1BRD_48G-4M-f2fs-nfsv4-1x-1t-NoSync-24G-ucode=0x5003006/lkp-csl-2ap2/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/e38b3f20059426a0adbde014ff71071739ab5226/0"
scheduler_version: "/lkp/lkp/.src-20210910-192256"
arch: x86_64
max_uptime: 2100
initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-csl-2ap2/fsmark-performance-1BRD_48G-4M-f2fs-nfsv4-1x-1t-NoSync-24G-ucode=0x5003006-debian-10.4-x86_64-20200603.cgz-e38b3f20059426a0adbde-20210914-64506-1wudof4-1.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3
- branch=linux-devel/devel-hourly-20210912-050321
- commit=e38b3f20059426a0adbde014ff71071739ab5226
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/e38b3f20059426a0adbde014ff71071739ab5226/vmlinuz-5.14.0-rc6-00032-ge38b3f200594-dirty
- acpi_rsdp=0x67f44014
- max_uptime=2100
- RESULT_ROOT=/result/fsmark/performance-1BRD_48G-4M-f2fs-nfsv4-1x-1t-NoSync-24G-ucode=0x5003006/lkp-csl-2ap2/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/e38b3f20059426a0adbde014ff71071739ab5226/0
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
modules_initrd: "/pkg/linux/x86_64-rhel-8.3/gcc-9/e38b3f20059426a0adbde014ff71071739ab5226/modules.cgz"
bm_initrd: "/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20210707.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20210906.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-ac08b1c68d1b-1_20210908.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/fs_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/fs2_20200714.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/fsmark-x86_64-698ee57-1_20210907.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/turbostat_20200721.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/turbostat-x86_64-3.7-4_20200721.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20210222.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn
:#! /lkp/lkp/.src-20210910-192256/include/site/inn:
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer:
watchdog:
:#! runtime status:
last_kernel: 5.14.0-08358-g83ec91697412
repeat_to: 3
:#! user overrides:
queue_at_least_once: 0
kernel: "/pkg/linux/x86_64-rhel-8.3/gcc-9/e38b3f20059426a0adbde014ff71071739ab5226/vmlinuz-5.14.0-rc6-00032-ge38b3f200594-dirty"
dequeue_time: 2021-09-14 08:18:47.006105279 +08:00
job_state: finished
loadavg: 1.45 0.54 0.20 1/1599 11654
start_time: '1631578806'
end_time: '1631578850'
version: "/lkp/lkp/.src-20210910-192329:1703be68:7a67a768b"

--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce

 "modprobe" "-r" "brd"
 "modprobe" "brd" "rd_nr=1" "rd_size=50331648"
dmsetup remove_all
wipefs -a --force /dev/ram0
mkfs -t f2fs /dev/ram0
mkdir -p /fs/ram0
mount -t f2fs /dev/ram0 /fs/ram0
mkdir /export
mount -t tmpfs nfsv4_root_export /export
mkdir -p /export//fs/ram0
mount --bind /fs/ram0 /export//fs/ram0
echo '/export//fs/ram0 *(rw,no_subtree_check,no_root_squash)' >> /etc/exports
systemctl restart rpcbind
systemctl restart rpc-statd
systemctl restart nfs-idmapd
systemctl restart nfs-server
mkdir -p /nfs/ram0
timeout 5m mount -t nfs -o vers=4 localhost:/fs/ram0 /nfs/ram0
touch /nfs/ram0/wait_for_nfs_grace_period

for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*
do
	online_file="$cpu_dir"/online
	[ -f "$online_file" ] && [ "$(cat "$online_file")" -eq 0 ] && continue

	file="$cpu_dir"/cpufreq/scaling_governor
	[ -f "$file" ] && echo "performance" > "$file"
done

fs_mark -d /nfs/ram0/1 -n 6144 -L 1 -S 0 -s 4194304

--tThc/1wpZn/ma/RB--
