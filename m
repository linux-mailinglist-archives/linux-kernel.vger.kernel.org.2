Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECE8E30A068
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 03:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbhBACzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 21:55:23 -0500
Received: from mga04.intel.com ([192.55.52.120]:53312 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229755AbhBACzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 21:55:13 -0500
IronPort-SDR: KRmcg/6iB3F1pUW4KAXaBp5eNy4xhvRzT5KkjoMiqrAsMAyWa8zm9b4ZkDNVPQ1MckjOKGmM2S
 9/+Jmfmvl6zA==
X-IronPort-AV: E=McAfee;i="6000,8403,9881"; a="178060581"
X-IronPort-AV: E=Sophos;i="5.79,391,1602572400"; 
   d="yaml'?scan'208";a="178060581"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2021 18:54:18 -0800
IronPort-SDR: Cg4djZKgMmh2xRt9Nvar0rq6wKvrypIE18I2F2x12eCE4dnX4EbNIVs4PaR8UaBuWUVFGrSdkw
 5EJHsRwED+zQ==
X-IronPort-AV: E=Sophos;i="5.79,391,1602572400"; 
   d="yaml'?scan'208";a="390586752"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2021 18:54:14 -0800
Date:   Mon, 1 Feb 2021 11:10:04 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com
Subject: [xfs]  aa0a2ec202:  fxmark.hdd_xfs_MWUL_9_directio.works/sec -53.2%
 regression
Message-ID: <20210201031004.GA12524@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit


Greeting,

FYI, we noticed a -53.2% regression of fxmark.hdd_xfs_MWUL_9_directio.works/sec due to commit:


commit: aa0a2ec202a8b319516cec852c8c206557749b4c ("xfs: deferred inode inactivation")
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git reserve-rt-metadata-space


in testcase: fxmark
on test machine: 288 threads Intel(R) Xeon Phi(TM) CPU 7295 @ 1.50GHz with 80G memory
with following parameters:

	disk: 1HDD
	media: hdd
	test: MWUL
	fstype: xfs
	directio: directio
	cpufreq_governor: performance
	ucode: 0x11


In addition to that, the commit also has significant impact on the following tests:

+------------------+-----------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.symlink.ops_per_sec -35.1% regression            |
| test machine     | 48 threads Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz with 112G memory |
| test parameters  | class=filesystem                                                      |
|                  | cpufreq_governor=performance                                          |
|                  | disk=1HDD                                                             |
|                  | fs=xfs                                                                |
|                  | nr_threads=10%                                                        |
|                  | testtime=30s                                                          |
|                  | ucode=0x42e                                                           |
+------------------+-----------------------------------------------------------------------+


If you fix the issue, kindly add following tag
Reported-by: kernel test robot <oliver.sang@intel.com>


Details are as below:
-------------------------------------------------------------------------------------------------->


To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp install job.yaml  # job file is attached in this email
        bin/lkp run     job.yaml

=========================================================================================
compiler/cpufreq_governor/directio/disk/fstype/kconfig/media/rootfs/tbox_group/test/testcase/ucode:
  gcc-9/performance/directio/1HDD/xfs/x86_64-rhel-8.3/hdd/debian-10.4-x86_64-20200603.cgz/lkp-knm01/MWUL/fxmark/0x11

commit: 
  bd70706acf ("xfs: decide if inode needs inactivation")
  aa0a2ec202 ("xfs: deferred inode inactivation")

bd70706acfc93277 aa0a2ec202a8b319516cec852c8 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
          0:4            6%           0:4     perf-profile.children.cycles-pp.error_return
          1:4           10%           1:4     perf-profile.children.cycles-pp.error_entry
          0:4            6%           0:4     perf-profile.self.cycles-pp.error_return
          1:4           10%           1:4     perf-profile.self.cycles-pp.error_entry
         %stddev     %change         %stddev
             \          |                \  
    116.21 ± 12%    +151.0%     291.72 ±  4%  fxmark.hdd_xfs_MWUL_18_directio.idle_sec
      0.49 ± 10%    +134.5%       1.16 ± 14%  fxmark.hdd_xfs_MWUL_18_directio.iowait_sec
      2.53 ±  9%     +91.5%       4.85 ±  3%  fxmark.hdd_xfs_MWUL_18_directio.irq_sec
      1.89 ±  2%     -16.9%       1.57        fxmark.hdd_xfs_MWUL_18_directio.irq_util
      7.54 ± 11%    +128.4%      17.22 ±  4%  fxmark.hdd_xfs_MWUL_18_directio.real_sec
      7.22 ± 10%    +135.6%      17.02 ±  4%  fxmark.hdd_xfs_MWUL_18_directio.secs
      0.44 ± 16%     +71.2%       0.76 ±  8%  fxmark.hdd_xfs_MWUL_18_directio.softirq_sec
      0.33 ±  9%     -25.3%       0.25 ± 10%  fxmark.hdd_xfs_MWUL_18_directio.softirq_util
     13.36 ±  3%     -35.8%       8.57 ±  3%  fxmark.hdd_xfs_MWUL_18_directio.sys_sec
     10.05 ±  8%     -72.3%       2.78 ±  3%  fxmark.hdd_xfs_MWUL_18_directio.sys_util
      1.22 ±  4%     +31.2%       1.60        fxmark.hdd_xfs_MWUL_18_directio.user_sec
      0.92 ±  9%     -43.4%       0.52 ±  3%  fxmark.hdd_xfs_MWUL_18_directio.user_util
      7279 ± 11%     -58.0%       3055 ±  4%  fxmark.hdd_xfs_MWUL_18_directio.works/sec
      0.03 ± 40%   +4816.7%       1.48 ± 18%  fxmark.hdd_xfs_MWUL_1_directio.idle_sec
      0.30 ± 41%   +3521.2%      10.96 ± 17%  fxmark.hdd_xfs_MWUL_1_directio.idle_util
      0.45 ±  4%     +36.1%       0.61 ±  5%  fxmark.hdd_xfs_MWUL_1_directio.irq_sec
      9.97 ±  2%     +35.1%      13.46        fxmark.hdd_xfs_MWUL_1_directio.real_sec
      9.63 ±  2%     +34.5%      12.95        fxmark.hdd_xfs_MWUL_1_directio.secs
      8.49           +18.3%      10.04        fxmark.hdd_xfs_MWUL_1_directio.sys_sec
     85.19           -12.3%      74.71        fxmark.hdd_xfs_MWUL_1_directio.sys_util
      0.78 ±  7%     +20.8%       0.94 ±  3%  fxmark.hdd_xfs_MWUL_1_directio.user_sec
      5317 ±  2%     -25.6%       3955        fxmark.hdd_xfs_MWUL_1_directio.works/sec
    199.30 ± 11%    +174.9%     547.89 ±  7%  fxmark.hdd_xfs_MWUL_27_directio.idle_sec
      0.56 ± 11%    +115.6%       1.21 ±  3%  fxmark.hdd_xfs_MWUL_27_directio.iowait_sec
      0.26 ± 13%     -17.2%       0.21 ±  5%  fxmark.hdd_xfs_MWUL_27_directio.iowait_util
      3.78 ±  8%    +124.1%       8.48 ±  7%  fxmark.hdd_xfs_MWUL_27_directio.irq_sec
      1.73           -13.8%       1.49        fxmark.hdd_xfs_MWUL_27_directio.irq_util
      8.19 ± 10%    +158.2%      21.16 ±  7%  fxmark.hdd_xfs_MWUL_27_directio.real_sec
      8.00 ± 10%    +163.8%      21.10 ±  8%  fxmark.hdd_xfs_MWUL_27_directio.secs
      0.56 ±  8%    +106.3%       1.15 ± 14%  fxmark.hdd_xfs_MWUL_27_directio.softirq_sec
      0.26 ± 12%     -21.5%       0.20 ±  9%  fxmark.hdd_xfs_MWUL_27_directio.softirq_util
     13.76           -35.1%       8.94 ±  2%  fxmark.hdd_xfs_MWUL_27_directio.sys_sec
      6.33 ±  9%     -75.1%       1.58 ±  5%  fxmark.hdd_xfs_MWUL_27_directio.sys_util
      1.59           +28.4%       2.04        fxmark.hdd_xfs_MWUL_27_directio.user_sec
      0.73 ±  9%     -50.8%       0.36 ±  6%  fxmark.hdd_xfs_MWUL_27_directio.user_util
      6603 ± 11%     -62.2%       2498 ±  9%  fxmark.hdd_xfs_MWUL_27_directio.works/sec
      1.25 ± 23%    +742.9%      10.56 ± 21%  fxmark.hdd_xfs_MWUL_2_directio.idle_sec
     10.34 ± 20%    +375.6%      49.16 ±  4%  fxmark.hdd_xfs_MWUL_2_directio.idle_util
      0.54 ±  2%     +40.3%       0.76 ± 25%  fxmark.hdd_xfs_MWUL_2_directio.irq_sec
      4.49           -22.2%       3.49 ±  2%  fxmark.hdd_xfs_MWUL_2_directio.irq_util
      6.05 ±  3%     +81.6%      10.99 ± 25%  fxmark.hdd_xfs_MWUL_2_directio.real_sec
      5.85 ±  2%     +85.6%      10.85 ±  2%  fxmark.hdd_xfs_MWUL_2_directio.secs
      0.17 ± 16%     +65.2%       0.29 ± 29%  fxmark.hdd_xfs_MWUL_2_directio.softirq_sec
     77.75 ±  2%     -47.6%      40.76 ±  5%  fxmark.hdd_xfs_MWUL_2_directio.sys_util
      0.62 ±  4%     +33.7%       0.83 ± 17%  fxmark.hdd_xfs_MWUL_2_directio.user_sec
      5.18 ±  7%     -24.3%       3.92 ±  9%  fxmark.hdd_xfs_MWUL_2_directio.user_util
      8773 ±  2%     -46.1%       4729 ±  2%  fxmark.hdd_xfs_MWUL_2_directio.works/sec
    370.11 ±  6%    +153.4%     938.01 ±  6%  fxmark.hdd_xfs_MWUL_36_directio.idle_sec
      0.66 ± 11%    +106.5%       1.36 ± 13%  fxmark.hdd_xfs_MWUL_36_directio.iowait_sec
      6.29 ±  6%    +126.2%      14.21 ±  4%  fxmark.hdd_xfs_MWUL_36_directio.irq_sec
     11.01 ±  6%    +144.6%      26.94 ±  5%  fxmark.hdd_xfs_MWUL_36_directio.real_sec
     10.87 ±  5%    +146.6%      26.81 ±  5%  fxmark.hdd_xfs_MWUL_36_directio.secs
      0.85 ± 13%    +108.5%       1.77 ±  5%  fxmark.hdd_xfs_MWUL_36_directio.softirq_sec
     14.78           -33.1%       9.88 ±  2%  fxmark.hdd_xfs_MWUL_36_directio.sys_sec
      3.76 ±  6%     -72.8%       1.02 ±  3%  fxmark.hdd_xfs_MWUL_36_directio.sys_util
      1.93 ±  2%     +29.1%       2.49 ±  3%  fxmark.hdd_xfs_MWUL_36_directio.user_sec
      0.49 ±  4%     -47.4%       0.26 ±  3%  fxmark.hdd_xfs_MWUL_36_directio.user_util
      4876 ±  6%     -59.5%       1974 ±  6%  fxmark.hdd_xfs_MWUL_36_directio.works/sec
    589.74 ±  7%    +122.6%       1312 ±  2%  fxmark.hdd_xfs_MWUL_45_directio.idle_sec
      0.93 ± 13%     +93.3%       1.80 ±  4%  fxmark.hdd_xfs_MWUL_45_directio.iowait_sec
      9.69 ±  6%    +106.1%      19.96        fxmark.hdd_xfs_MWUL_45_directio.irq_sec
     13.81 ±  7%    +117.4%      30.03 ±  2%  fxmark.hdd_xfs_MWUL_45_directio.real_sec
     13.66 ±  7%    +119.0%      29.92        fxmark.hdd_xfs_MWUL_45_directio.secs
      1.23 ±  6%     +91.0%       2.35 ±  7%  fxmark.hdd_xfs_MWUL_45_directio.softirq_sec
     15.52           -38.4%       9.57 ±  9%  fxmark.hdd_xfs_MWUL_45_directio.sys_sec
      2.52 ±  6%     -71.8%       0.71 ± 11%  fxmark.hdd_xfs_MWUL_45_directio.sys_util
      2.37 ±  2%     +21.5%       2.88        fxmark.hdd_xfs_MWUL_45_directio.user_sec
      0.38 ±  5%     -44.4%       0.21 ±  3%  fxmark.hdd_xfs_MWUL_45_directio.user_util
      3885 ±  7%     -61.3%       1505 ± 19%  fxmark.hdd_xfs_MWUL_45_directio.works/sec
      9.12 ±  4%    +189.4%      26.39 ±  7%  fxmark.hdd_xfs_MWUL_4_directio.idle_sec
     41.10 ±  2%     +79.1%      73.59        fxmark.hdd_xfs_MWUL_4_directio.idle_util
      0.18 ± 22%    +139.4%       0.43 ± 23%  fxmark.hdd_xfs_MWUL_4_directio.iowait_sec
      0.75 ±  3%     +23.0%       0.92 ±  6%  fxmark.hdd_xfs_MWUL_4_directio.irq_sec
      3.38 ±  2%     -23.9%       2.58        fxmark.hdd_xfs_MWUL_4_directio.irq_util
      5.65 ±  2%     +60.6%       9.07 ±  7%  fxmark.hdd_xfs_MWUL_4_directio.real_sec
      5.37           +70.5%       9.15        fxmark.hdd_xfs_MWUL_4_directio.secs
     11.22           -37.2%       7.05 ±  7%  fxmark.hdd_xfs_MWUL_4_directio.sys_sec
     50.63 ±  2%     -61.2%      19.67 ±  2%  fxmark.hdd_xfs_MWUL_4_directio.sys_util
      0.72 ±  4%     +17.1%       0.84 ±  6%  fxmark.hdd_xfs_MWUL_4_directio.user_sec
      3.24 ±  3%     -27.5%       2.35 ±  4%  fxmark.hdd_xfs_MWUL_4_directio.user_util
      9547           -41.2%       5611        fxmark.hdd_xfs_MWUL_4_directio.works/sec
    986.54 ±  5%     +62.4%       1602        fxmark.hdd_xfs_MWUL_54_directio.idle_sec
      1.30 ± 17%     +50.1%       1.95 ±  4%  fxmark.hdd_xfs_MWUL_54_directio.iowait_sec
     15.98 ±  4%     +52.4%      24.36        fxmark.hdd_xfs_MWUL_54_directio.irq_sec
     19.08 ±  4%     +59.8%      30.48        fxmark.hdd_xfs_MWUL_54_directio.real_sec
     19.00 ±  4%     +59.4%      30.27        fxmark.hdd_xfs_MWUL_54_directio.secs
      1.92 ±  6%     +39.6%       2.67 ±  6%  fxmark.hdd_xfs_MWUL_54_directio.softirq_sec
     16.92 ±  2%     -47.9%       8.82 ±  5%  fxmark.hdd_xfs_MWUL_54_directio.sys_sec
      1.65 ±  6%     -67.5%       0.54 ±  6%  fxmark.hdd_xfs_MWUL_54_directio.sys_util
      0.46 ± 58%     -58.9%       0.19 ±  3%  fxmark.hdd_xfs_MWUL_54_directio.user_util
     53161           -31.6%      36377 ± 13%  fxmark.hdd_xfs_MWUL_54_directio.works
      2803 ±  4%     -57.1%       1201 ± 13%  fxmark.hdd_xfs_MWUL_54_directio.works/sec
      1095 ± 16%     +68.9%       1851        fxmark.hdd_xfs_MWUL_63_directio.idle_sec
      1.22 ± 18%     +73.2%       2.11 ±  5%  fxmark.hdd_xfs_MWUL_63_directio.iowait_sec
     18.14 ± 17%     +66.9%      30.26        fxmark.hdd_xfs_MWUL_63_directio.irq_sec
     18.11 ± 16%     +67.5%      30.33        fxmark.hdd_xfs_MWUL_63_directio.real_sec
     18.35 ± 14%     +64.0%      30.10        fxmark.hdd_xfs_MWUL_63_directio.secs
      1.97 ± 10%     +73.2%       3.41 ±  5%  fxmark.hdd_xfs_MWUL_63_directio.softirq_sec
     17.52 ±  7%     -30.9%      12.11 ±  3%  fxmark.hdd_xfs_MWUL_63_directio.sys_sec
      1.57 ± 11%     -59.6%       0.63 ±  3%  fxmark.hdd_xfs_MWUL_63_directio.sys_util
      3.12 ±  6%    +158.3%       8.05        fxmark.hdd_xfs_MWUL_63_directio.user_sec
      0.28 ± 14%     +50.5%       0.42        fxmark.hdd_xfs_MWUL_63_directio.user_util
     53295           -24.1%      40431 ±  4%  fxmark.hdd_xfs_MWUL_63_directio.works
      2981 ± 17%     -54.9%       1343 ±  4%  fxmark.hdd_xfs_MWUL_63_directio.works/sec
      1620 ±  4%     +32.5%       2147        fxmark.hdd_xfs_MWUL_72_directio.idle_sec
      1.65 ±  9%     +27.2%       2.10 ±  6%  fxmark.hdd_xfs_MWUL_72_directio.iowait_sec
     26.52 ±  4%     +26.0%      33.41        fxmark.hdd_xfs_MWUL_72_directio.irq_sec
     23.30 ±  4%     +31.3%      30.60        fxmark.hdd_xfs_MWUL_72_directio.real_sec
     23.68 ±  3%     +28.3%      30.38        fxmark.hdd_xfs_MWUL_72_directio.secs
      2.87 ±  7%     +23.7%       3.55 ±  6%  fxmark.hdd_xfs_MWUL_72_directio.softirq_sec
     18.45           -48.5%       9.49 ±  2%  fxmark.hdd_xfs_MWUL_72_directio.sys_sec
      1.10 ±  2%     -60.9%       0.43 ±  2%  fxmark.hdd_xfs_MWUL_72_directio.sys_util
      0.22 ±  5%     -20.8%       0.17 ±  2%  fxmark.hdd_xfs_MWUL_72_directio.user_util
     54061           -32.8%      36335 ±  4%  fxmark.hdd_xfs_MWUL_72_directio.works
      2285 ±  3%     -47.7%       1196 ±  5%  fxmark.hdd_xfs_MWUL_72_directio.works/sec
     41.05 ±  8%    +160.5%     106.96 ±  5%  fxmark.hdd_xfs_MWUL_9_directio.idle_sec
     72.69 ±  2%     +23.1%      89.45        fxmark.hdd_xfs_MWUL_9_directio.idle_util
      0.40 ± 15%     +90.6%       0.76 ± 22%  fxmark.hdd_xfs_MWUL_9_directio.iowait_sec
      1.37 ±  5%     +62.1%       2.22 ±  5%  fxmark.hdd_xfs_MWUL_9_directio.irq_sec
      2.44           -23.6%       1.86        fxmark.hdd_xfs_MWUL_9_directio.irq_util
      6.39 ±  6%    +109.3%      13.38 ±  5%  fxmark.hdd_xfs_MWUL_9_directio.real_sec
      6.15 ±  7%    +113.1%      13.11 ±  5%  fxmark.hdd_xfs_MWUL_9_directio.secs
      0.29 ± 10%     +61.7%       0.46 ± 15%  fxmark.hdd_xfs_MWUL_9_directio.softirq_sec
      0.51 ±  5%     -23.8%       0.39 ± 11%  fxmark.hdd_xfs_MWUL_9_directio.softirq_util
     12.36           -35.6%       7.95 ±  2%  fxmark.hdd_xfs_MWUL_9_directio.sys_sec
     22.00 ±  6%     -69.7%       6.67 ±  5%  fxmark.hdd_xfs_MWUL_9_directio.sys_util
      0.93 ±  3%     +26.3%       1.18        fxmark.hdd_xfs_MWUL_9_directio.user_sec
      1.66 ±  7%     -40.6%       0.99 ±  3%  fxmark.hdd_xfs_MWUL_9_directio.user_util
      8441 ±  7%     -53.2%       3953 ±  6%  fxmark.hdd_xfs_MWUL_9_directio.works/sec
    320.17           +60.3%     513.37        fxmark.time.elapsed_time
    320.17           +60.3%     513.37        fxmark.time.elapsed_time.max
     18.75 ±  2%     -44.0%      10.50 ±  4%  fxmark.time.percent_of_cpu_this_job_got
     51.67           -15.0%      43.92        fxmark.time.system_time
      9.92           +29.6%      12.86 ± 12%  fxmark.time.user_time
     90949           -18.0%      74622 ±  2%  fxmark.time.voluntary_context_switches
   1800960           +24.1%    2235798        numa-numastat.node0.local_node
   1800905           +24.1%    2235754        numa-numastat.node0.numa_hit
    403.29           +47.5%     594.80        uptime.boot
     40880 ±  2%     +13.9%      46559        uptime.idle
 1.931e+10           +31.8%  2.545e+10        cpuidle.C1.time
  34582175           +34.3%   46448784        cpuidle.C1.usage
     10434 ±  2%     +99.5%      20820 ± 47%  cpuidle.POLL.usage
     73.07            +9.9%      80.28        iostat.cpu.idle
     16.14 ±  2%     -24.5%      12.19        iostat.cpu.system
      2.87 ±  3%     -20.3%       2.29 ±  8%  iostat.cpu.user
      0.27 ±  4%      +0.1        0.35 ±  3%  mpstat.cpu.all.iowait%
      2.21            -0.2        1.98        mpstat.cpu.all.irq%
     15.33            -4.2       11.09        mpstat.cpu.all.sys%
      2.98 ±  2%      -0.6        2.35 ±  8%  mpstat.cpu.all.usr%
     73.75            +9.5%      80.75        vmstat.cpu.id
    104.75 ±  3%    +730.8%     870.25        vmstat.io.bi
     10026           -10.7%       8950        vmstat.io.bo
      2.50 ± 20%     -60.0%       1.00        vmstat.procs.r
     14156           -46.2%       7616 ±  2%  vmstat.system.cs
    110196           -15.8%      92836        vmstat.system.in
      7013 ± 22%     -72.1%       1954 ±  2%  meminfo.Active
      6994 ± 22%     -72.3%       1939 ±  2%  meminfo.Active(anon)
    417797           -10.7%     373172        meminfo.Committed_AS
    360001           -10.0%     324157        meminfo.Inactive
    330962           -10.5%     296339        meminfo.Inactive(anon)
   2896120            -9.9%    2610848        meminfo.Memused
    628.00 ±123%    +146.9%       1550 ± 35%  meminfo.Mlocked
     73641 ±  9%     -39.2%      44810 ±  3%  meminfo.Shmem
     14088           -37.6%       8796        meminfo.max_used_kB
      6985 ± 20%     -71.9%       1963 ±  2%  numa-meminfo.node0.Active
      6966 ± 20%     -72.0%       1948 ±  2%  numa-meminfo.node0.Active(anon)
    359858           -10.0%     323999        numa-meminfo.node0.Inactive
    330991           -10.5%     296278        numa-meminfo.node0.Inactive(anon)
     85528           +13.5%      97113        numa-meminfo.node0.KReclaimable
   2286876           -12.5%    2001442        numa-meminfo.node0.MemUsed
    358.75 ±122%    +147.0%     886.00 ± 35%  numa-meminfo.node0.Mlocked
     85528           +13.5%      97113        numa-meminfo.node0.SReclaimable
     73548 ±  9%     -39.1%      44798 ±  3%  numa-meminfo.node0.Shmem
      1777 ± 22%     -72.6%     486.50 ±  2%  numa-vmstat.node0.nr_active_anon
    206547           +40.0%     289132        numa-vmstat.node0.nr_dirtied
    114.25 ±  3%     -32.6%      77.00 ±  3%  numa-vmstat.node0.nr_dirty
     82741           -10.5%      74088        numa-vmstat.node0.nr_inactive_anon
     89.00 ±124%    +148.0%     220.75 ± 35%  numa-vmstat.node0.nr_mlock
     18389 ±  9%     -39.1%      11191 ±  3%  numa-vmstat.node0.nr_shmem
     21358           +13.7%      24289        numa-vmstat.node0.nr_slab_reclaimable
    206423           +40.0%     289069        numa-vmstat.node0.nr_written
      1777 ± 22%     -72.6%     486.50 ±  2%  numa-vmstat.node0.nr_zone_active_anon
     82741           -10.5%      74088        numa-vmstat.node0.nr_zone_inactive_anon
    133.00 ± 17%     -44.4%      74.00        numa-vmstat.node0.nr_zone_write_pending
     66.50 ±124%    +148.5%     165.25 ± 36%  numa-vmstat.node1.nr_mlock
      1793 ± 21%     -72.8%     488.00 ±  2%  proc-vmstat.nr_active_anon
     66106            -4.0%      63456        proc-vmstat.nr_anon_pages
    372844           +46.1%     544658        proc-vmstat.nr_dirtied
    123.75 ±  4%     -36.6%      78.50 ±  2%  proc-vmstat.nr_dirty
    291692            -2.5%     284309        proc-vmstat.nr_file_pages
     82727           -10.5%      74074        proc-vmstat.nr_inactive_anon
      7077            -3.2%       6849        proc-vmstat.nr_inactive_file
     40483            -2.0%      39683        proc-vmstat.nr_kernel_stack
      9615            -4.5%       9182        proc-vmstat.nr_mapped
    157.50 ±123%    +146.8%     388.75 ± 35%  proc-vmstat.nr_mlock
      1289            -6.1%       1210        proc-vmstat.nr_page_table_pages
     18508 ±  9%     -39.3%      11227 ±  3%  proc-vmstat.nr_shmem
     25906           +10.3%      28565        proc-vmstat.nr_slab_reclaimable
     50633            -4.6%      48309        proc-vmstat.nr_slab_unreclaimable
    372844           +46.1%     544658        proc-vmstat.nr_written
      1793 ± 21%     -72.8%     488.00 ±  2%  proc-vmstat.nr_zone_active_anon
     82727           -10.5%      74074        proc-vmstat.nr_zone_inactive_anon
      7077            -3.2%       6849        proc-vmstat.nr_zone_inactive_file
    149.50           -35.1%      97.00        proc-vmstat.nr_zone_write_pending
   1826076           +23.8%    2260899        proc-vmstat.numa_hit
   1826074           +23.8%    2260897        proc-vmstat.numa_local
     51102 ± 50%     +60.6%      82068 ± 21%  proc-vmstat.numa_pte_updates
     22291 ± 10%     -54.4%      10166 ±  5%  proc-vmstat.pgactivate
   2106909           +23.9%    2610405        proc-vmstat.pgalloc_normal
     22910 ± 11%     -54.2%      10504 ±  4%  proc-vmstat.pgdeactivate
   1251675           +41.6%    1772890        proc-vmstat.pgfault
   2087918           +24.7%    2603980        proc-vmstat.pgfree
     33061 ±  3%   +1233.1%     440746        proc-vmstat.pgpgin
   3148495           +43.8%    4528933        proc-vmstat.pgpgout
    122451           +27.1%     155697        proc-vmstat.pgreuse
     31321            +0.8%      31582        proc-vmstat.pgrotated
   1488940           +13.0%    1682530 ±  3%  proc-vmstat.slabs_scanned
   3749376           +37.8%    5168256        proc-vmstat.unevictable_pgs_scanned
     26326 ±145%    +382.3%     126980 ± 49%  sched_debug.cfs_rq:/.load.min
    288.16 ± 38%    +217.8%     915.64 ± 21%  sched_debug.cfs_rq:/.load_avg.avg
     39.00 ±129%   +1643.2%     679.83 ± 28%  sched_debug.cfs_rq:/.load_avg.min
    119.17 ± 82%    +218.5%     379.58 ±  4%  sched_debug.cfs_rq:/.runnable_avg.min
     84.17 ± 59%    +116.2%     181.94 ± 18%  sched_debug.cfs_rq:/.util_avg.min
     19.08 ± 64%    +461.0%     107.06 ± 34%  sched_debug.cfs_rq:/.util_est_enqueued.avg
      0.12 ±110%  +63100.0%      79.00 ± 23%  sched_debug.cfs_rq:/.util_est_enqueued.min
   1245397 ±  3%     -10.5%    1114348 ±  4%  sched_debug.cpu.avg_idle.avg
   3045705 ±  9%     -16.5%    2544394 ± 14%  sched_debug.cpu.avg_idle.max
    310637 ±  7%     -19.0%     251467 ± 13%  sched_debug.cpu.avg_idle.stddev
    232743           +38.0%     321220        sched_debug.cpu.clock.avg
    232806           +38.0%     321262        sched_debug.cpu.clock.max
    232677           +38.0%     321174        sched_debug.cpu.clock.min
     36.34 ±  9%     -30.7%      25.17        sched_debug.cpu.clock.stddev
    229323           +37.4%     315044        sched_debug.cpu.clock_task.avg
    230157           +37.1%     315627        sched_debug.cpu.clock_task.max
    222335           +39.1%     309293        sched_debug.cpu.clock_task.min
      1333 ±  8%     -13.7%       1150        sched_debug.cpu.clock_task.stddev
      1684 ± 60%     +91.0%       3217 ± 14%  sched_debug.cpu.curr->pid.avg
      8597 ±  6%     +25.7%      10802 ±  3%  sched_debug.cpu.curr->pid.max
    674102 ±  3%      -8.5%     616685 ±  2%  sched_debug.cpu.max_idle_balance_cost.avg
   1757935 ±  9%     -23.6%    1343290 ±  8%  sched_debug.cpu.max_idle_balance_cost.max
    135930 ±  8%     -31.5%      93095 ± 18%  sched_debug.cpu.max_idle_balance_cost.stddev
      0.00 ± 14%     -38.1%       0.00 ±  2%  sched_debug.cpu.next_balance.stddev
      0.27 ± 20%     -16.5%       0.23 ± 14%  sched_debug.cpu.nr_running.stddev
     53415 ± 28%     +48.1%      79096 ±  2%  sched_debug.cpu.nr_switches.avg
     41869 ± 35%     +69.6%      70996 ±  2%  sched_debug.cpu.nr_switches.min
     12912 ±  5%     -44.5%       7162 ± 11%  sched_debug.cpu.nr_switches.stddev
     -0.59         +1633.7%     -10.17        sched_debug.cpu.nr_uninterruptible.avg
     60.92 ±  7%     -32.5%      41.11 ± 13%  sched_debug.cpu.nr_uninterruptible.max
    232666           +38.0%     321157        sched_debug.cpu_clk
    232008           +38.1%     320480        sched_debug.ktime
    233058           +38.0%     321580        sched_debug.sched_clk
      0.94 ±  8%     -42.7%       0.54 ±  5%  perf-stat.i.MPKI
  24556955 ±  4%     -40.4%   14638193 ±  3%  perf-stat.i.branch-instructions
      0.22 ±  5%      -0.1        0.13 ±  5%  perf-stat.i.branch-miss-rate%
   1840133 ±  5%     -39.9%    1106329 ±  4%  perf-stat.i.branch-misses
      0.43 ±  5%      -0.2        0.25 ±  4%  perf-stat.i.cache-miss-rate%
    531501 ±  6%     -42.0%     308063 ±  4%  perf-stat.i.cache-misses
   3678689 ±  6%     -42.1%    2130446 ±  4%  perf-stat.i.cache-references
     13574           -46.4%       7282 ±  2%  perf-stat.i.context-switches
      0.35 ±  8%     -42.7%       0.20 ±  6%  perf-stat.i.cpi
     51423           -14.3%      44085        perf-stat.i.cpu-clock
 1.365e+09 ±  6%     -42.1%  7.896e+08 ±  4%  perf-stat.i.cpu-cycles
    138.23            -9.4%     125.29        perf-stat.i.cpu-migrations
     76.63 ±  5%     -41.3%      44.98 ±  5%  perf-stat.i.cycles-between-cache-misses
      0.04 ±  7%      -0.0        0.03 ±  5%  perf-stat.i.iTLB-load-miss-rate%
   1748496 ±  6%     -42.0%    1014233 ±  4%  perf-stat.i.iTLB-load-misses
 1.175e+08 ±  4%     -40.6%   69775785 ±  3%  perf-stat.i.iTLB-loads
 1.177e+08 ±  4%     -40.7%   69825913 ±  3%  perf-stat.i.instructions
      1.99 ±  4%     -39.9%       1.19 ±  4%  perf-stat.i.instructions-per-iTLB-miss
      0.00 ±  4%     -39.7%       0.00 ±  3%  perf-stat.i.ipc
      3.04 ±  4%     -32.7%       2.05 ±  2%  perf-stat.i.major-faults
      0.00 ±  6%     -42.1%       0.00 ±  4%  perf-stat.i.metric.GHz
      0.43            -5.2%       0.41        perf-stat.i.metric.K/sec
      0.51 ±  4%     -40.5%       0.30 ±  3%  perf-stat.i.metric.M/sec
      3573            -9.7%       3227        perf-stat.i.minor-faults
      3576            -9.7%       3229        perf-stat.i.page-faults
     51423           -14.3%      44085        perf-stat.i.task-clock
  25744212 ±  4%     -39.8%   15500031 ±  4%  perf-stat.ps.branch-instructions
   1925452 ±  5%     -39.3%    1169553 ±  5%  perf-stat.ps.branch-misses
    557154 ±  6%     -41.5%     325974 ±  5%  perf-stat.ps.cache-misses
   3858190 ±  6%     -41.5%    2255512 ±  4%  perf-stat.ps.cache-references
     13464           -46.1%       7250 ±  2%  perf-stat.ps.context-switches
     51872           -14.4%      44389        perf-stat.ps.cpu-clock
 1.431e+09 ±  6%     -41.6%  8.361e+08 ±  5%  perf-stat.ps.cpu-cycles
    138.23            -9.3%     125.33        perf-stat.ps.cpu-migrations
   1832019 ±  5%     -41.4%    1072847 ±  5%  perf-stat.ps.iTLB-load-misses
 1.232e+08 ±  4%     -40.0%   73886028 ±  4%  perf-stat.ps.iTLB-loads
 1.234e+08 ±  4%     -40.1%   73943984 ±  4%  perf-stat.ps.instructions
      3.04 ±  5%     -32.7%       2.04 ±  2%  perf-stat.ps.major-faults
      3560            -9.6%       3220        perf-stat.ps.minor-faults
      3563            -9.6%       3222        perf-stat.ps.page-faults
     51872           -14.4%      44389        perf-stat.ps.task-clock
      3110            -9.7%       2810        slabinfo.Acpi-Parse.active_objs
      3416           -19.2%       2759        slabinfo.Acpi-State.active_objs
      3746           -15.0%       3183        slabinfo.Acpi-State.num_objs
    925.00 ±  4%     -12.4%     810.00 ±  2%  slabinfo.PING.active_objs
     11210           -10.6%      10018 ±  4%  slabinfo.anon_vma.active_objs
     12358           -10.8%      11026 ±  3%  slabinfo.anon_vma.num_objs
     23170 ±  2%     -12.0%      20396 ±  4%  slabinfo.anon_vma_chain.active_objs
     26327           -11.0%      23441 ±  3%  slabinfo.anon_vma_chain.num_objs
     11953 ±  4%     -14.3%      10247 ±  2%  slabinfo.ep_head.active_objs
     14940 ±  4%     -11.1%      13276 ±  3%  slabinfo.ep_head.num_objs
     13557           -13.1%      11779        slabinfo.filp.active_objs
    968.00           -11.9%     852.50        slabinfo.filp.active_slabs
     15496           -11.9%      13645        slabinfo.filp.num_objs
    968.00           -11.9%     852.50        slabinfo.filp.num_slabs
     38642           +27.7%      49345 ±  4%  slabinfo.kmalloc-16.active_objs
     20449           -24.6%      15415        slabinfo.kmalloc-512.active_objs
      2715           -23.7%       2072        slabinfo.kmalloc-512.active_slabs
     21722           -23.7%      16583        slabinfo.kmalloc-512.num_objs
      2715           -23.7%       2072        slabinfo.kmalloc-512.num_slabs
     50680 ±  2%     -13.0%      44084        slabinfo.kmalloc-8.active_objs
     16931 ±  5%     -24.8%      12739 ±  5%  slabinfo.kmalloc-96.active_objs
     22541 ±  3%     -17.4%      18608        slabinfo.kmalloc-96.num_objs
     17837           -10.1%      16027        slabinfo.lsm_file_cache.active_objs
      1100           -11.8%     971.00        slabinfo.mm_struct.active_objs
      1774 ±  2%     +10.6%       1961 ±  2%  slabinfo.numa_policy.active_objs
      1805 ±  2%     +10.2%       1990 ±  2%  slabinfo.numa_policy.num_objs
      4879 ±  2%     -12.3%       4278        slabinfo.pde_opener.active_objs
      5328 ±  2%      -9.9%       4802        slabinfo.pde_opener.num_objs
      4362 ±  2%     -12.5%       3818        slabinfo.pid.active_objs
      2941 ±  5%     -26.9%       2151 ±  3%  slabinfo.proc_inode_cache.active_objs
      2990 ±  4%     -26.2%       2205 ±  3%  slabinfo.proc_inode_cache.num_objs
      2011           -16.8%       1673        slabinfo.seq_file.active_objs
      2238           -13.7%       1931        slabinfo.seq_file.num_objs
      4692 ±  3%     -15.5%       3965 ±  7%  slabinfo.skbuff_head_cache.active_objs
      5106 ±  4%     -12.6%       4461 ±  6%  slabinfo.skbuff_head_cache.num_objs
      2184 ±  2%      -7.9%       2011        slabinfo.sock_inode_cache.active_objs
     19406           -18.9%      15740        slabinfo.vm_area_struct.active_objs
    981.25           -18.8%     797.00        slabinfo.vm_area_struct.active_slabs
     19639           -18.8%      15944        slabinfo.vm_area_struct.num_objs
    981.25           -18.8%     797.00        slabinfo.vm_area_struct.num_slabs
      2688 ±  3%     +22.5%       3293 ±  4%  slabinfo.xfs_buf.active_objs
      2812 ±  2%     +20.6%       3392 ±  4%  slabinfo.xfs_buf.num_objs
     28507           +35.9%      38734        slabinfo.xfs_ili.active_objs
    696.75           +32.9%     925.75        slabinfo.xfs_ili.active_slabs
     29282           +32.9%      38901        slabinfo.xfs_ili.num_objs
    696.75           +32.9%     925.75        slabinfo.xfs_ili.num_slabs
     28127           +35.5%      38119        slabinfo.xfs_inode.active_objs
    898.25           +33.4%       1198        slabinfo.xfs_inode.active_slabs
     28759           +33.4%      38356        slabinfo.xfs_inode.num_objs
    898.25           +33.4%       1198        slabinfo.xfs_inode.num_slabs
     57760 ±  2%     +70.5%      98499        softirqs.BLOCK
     58500 ± 16%     +42.2%      83207 ± 20%  softirqs.CPU0.RCU
     35699 ±  2%     +61.0%      57478 ±  6%  softirqs.CPU0.SCHED
     44274 ± 25%     +59.6%      70673 ± 23%  softirqs.CPU1.RCU
     33946 ±  3%     +66.8%      56609 ±  5%  softirqs.CPU1.SCHED
     31426 ± 20%     +73.3%      54474 ± 27%  softirqs.CPU10.RCU
     28279 ±  4%     +52.4%      43095 ±  3%  softirqs.CPU10.SCHED
     33260 ± 22%     +60.5%      53398 ± 25%  softirqs.CPU11.RCU
     28809           +58.4%      45624        softirqs.CPU11.SCHED
     31722 ± 19%     +70.2%      53985 ± 28%  softirqs.CPU12.RCU
     27759 ±  3%     +57.1%      43599 ±  3%  softirqs.CPU12.SCHED
     32702 ± 17%     +57.5%      51508 ± 24%  softirqs.CPU13.RCU
     27984 ±  6%     +61.0%      45043 ±  3%  softirqs.CPU13.SCHED
     33145 ± 26%     +66.3%      55125 ± 27%  softirqs.CPU14.RCU
     28978 ±  3%     +56.7%      45417 ±  8%  softirqs.CPU14.SCHED
     31291 ± 16%     +65.1%      51673 ± 25%  softirqs.CPU15.RCU
     27951 ±  2%     +60.3%      44814 ±  3%  softirqs.CPU15.SCHED
     28386 ±  9%     +73.9%      49377 ± 27%  softirqs.CPU16.RCU
     26701 ±  4%     +58.5%      42328 ±  4%  softirqs.CPU16.SCHED
     29052 ± 11%     +72.1%      50007 ± 26%  softirqs.CPU17.RCU
     26059 ±  3%     +67.9%      43753 ±  4%  softirqs.CPU17.SCHED
     27787 ± 17%     +63.1%      45321 ± 25%  softirqs.CPU18.RCU
     25183 ±  3%     +59.2%      40084        softirqs.CPU18.SCHED
     27646 ± 19%     +65.1%      45633 ± 27%  softirqs.CPU19.RCU
     25831 ±  2%     +52.8%      39471        softirqs.CPU19.SCHED
     39148 ± 22%     +69.3%      66263 ± 26%  softirqs.CPU2.RCU
     32676 ±  6%     +72.6%      56394        softirqs.CPU2.SCHED
     28023 ± 19%     +61.9%      45378 ± 25%  softirqs.CPU20.RCU
     25733 ±  4%     +54.8%      39826 ±  3%  softirqs.CPU20.SCHED
     28035 ± 19%     +63.1%      45727 ± 25%  softirqs.CPU21.RCU
     25614 ±  3%     +58.5%      40611        softirqs.CPU21.SCHED
     27522 ± 18%     +66.3%      45780 ± 24%  softirqs.CPU22.RCU
     24049 ±  4%     +58.5%      38112 ±  4%  softirqs.CPU22.SCHED
     27996 ± 22%     +61.4%      45191 ± 26%  softirqs.CPU23.RCU
     25179 ±  5%     +52.8%      38474 ±  5%  softirqs.CPU23.SCHED
     27601 ± 18%     +64.9%      45512 ± 27%  softirqs.CPU24.RCU
     24667 ±  6%     +61.1%      39750 ±  2%  softirqs.CPU24.SCHED
     27919 ± 20%     +62.1%      45263 ± 26%  softirqs.CPU25.RCU
     25040           +61.2%      40369 ±  3%  softirqs.CPU25.SCHED
     27946 ± 19%     +60.8%      44937 ± 26%  softirqs.CPU26.RCU
     23068 ±  5%     +57.6%      36345 ±  2%  softirqs.CPU26.SCHED
     24703 ± 21%     +57.2%      38836 ± 25%  softirqs.CPU27.RCU
     22919           +50.5%      34483 ±  5%  softirqs.CPU27.SCHED
     24695 ± 20%     +58.8%      39218 ± 26%  softirqs.CPU28.RCU
     22944 ±  3%     +47.2%      33781 ±  2%  softirqs.CPU28.SCHED
     24751 ± 21%     +58.3%      39172 ± 26%  softirqs.CPU29.RCU
     21666 ±  4%     +62.2%      35150 ±  2%  softirqs.CPU29.SCHED
     38389 ± 19%     +70.4%      65401 ± 26%  softirqs.CPU3.RCU
     32635 ±  3%     +71.6%      56011        softirqs.CPU3.SCHED
     24371 ± 18%     +56.5%      38130 ± 25%  softirqs.CPU30.RCU
     22916 ±  6%     +55.0%      35517 ±  2%  softirqs.CPU30.SCHED
     24331 ± 21%     +60.1%      38953 ± 25%  softirqs.CPU31.RCU
     22808           +48.8%      33946 ±  7%  softirqs.CPU31.SCHED
     23516 ± 20%     +54.3%      36290 ± 24%  softirqs.CPU32.RCU
     23198 ±  3%     +51.3%      35091        softirqs.CPU32.SCHED
     22882 ± 23%     +60.2%      36650 ± 24%  softirqs.CPU33.RCU
     22721 ±  3%     +56.2%      35484        softirqs.CPU33.SCHED
     23690 ± 19%     +54.1%      36512 ± 24%  softirqs.CPU34.RCU
     21475 ±  3%     +58.1%      33949        softirqs.CPU34.SCHED
     23621 ± 20%     +50.6%      35584 ± 23%  softirqs.CPU35.RCU
     22680 ±  4%     +47.3%      33399 ±  2%  softirqs.CPU35.SCHED
     19209 ±  6%     +42.1%      27303 ±  9%  softirqs.CPU36.SCHED
     20836 ± 16%     +52.0%      31676 ± 24%  softirqs.CPU37.RCU
     19075 ±  9%     +49.9%      28599 ±  2%  softirqs.CPU37.SCHED
     20739 ± 16%     +53.5%      31837 ± 24%  softirqs.CPU38.RCU
     20169 ±  2%     +31.7%      26562 ± 11%  softirqs.CPU38.SCHED
     20598 ± 15%     +52.4%      31394 ± 22%  softirqs.CPU39.RCU
     19729 ±  7%     +46.2%      28846 ±  4%  softirqs.CPU39.SCHED
     34472 ± 17%     +73.9%      59952 ± 26%  softirqs.CPU4.RCU
     30931 ±  3%     +61.7%      50001 ±  4%  softirqs.CPU4.SCHED
     20511 ± 20%     +53.8%      31541 ± 24%  softirqs.CPU40.RCU
     19047 ±  4%     +58.1%      30106        softirqs.CPU40.SCHED
     20810 ± 19%     +55.2%      32307 ± 21%  softirqs.CPU41.RCU
     19179 ±  2%     +48.5%      28474 ±  3%  softirqs.CPU41.SCHED
     20575 ± 18%     +53.4%      31562 ± 24%  softirqs.CPU42.RCU
     17641 ±  7%     +59.8%      28196 ±  7%  softirqs.CPU42.SCHED
     20716 ± 18%     +52.3%      31542 ± 23%  softirqs.CPU43.RCU
     18565 ±  3%     +56.9%      29136 ±  2%  softirqs.CPU43.SCHED
     20725 ± 18%     +53.7%      31844 ± 23%  softirqs.CPU44.RCU
     15683 ±  6%     +29.2%      20263 ±  6%  softirqs.CPU44.SCHED
     17744 ± 15%     +39.4%      24734 ± 24%  softirqs.CPU45.RCU
     16409 ±  5%     +38.3%      22694        softirqs.CPU45.SCHED
     16863 ± 17%     +44.4%      24348 ± 23%  softirqs.CPU46.RCU
     16649 ±  6%     +31.5%      21894 ±  7%  softirqs.CPU46.SCHED
     16971 ± 18%     +44.2%      24479 ± 23%  softirqs.CPU47.RCU
     15797 ±  8%     +44.8%      22872 ±  2%  softirqs.CPU47.SCHED
     15535 ± 19%     +42.0%      22056 ± 23%  softirqs.CPU48.RCU
     16167 ± 11%     +39.9%      22620 ±  3%  softirqs.CPU48.SCHED
     15737 ± 18%     +42.9%      22481 ± 23%  softirqs.CPU49.RCU
     16747 ±  3%     +37.7%      23056 ±  2%  softirqs.CPU49.SCHED
     35127 ± 19%     +68.7%      59260 ± 25%  softirqs.CPU5.RCU
     31146 ±  3%     +62.0%      50448 ±  3%  softirqs.CPU5.SCHED
     15574 ± 16%     +39.7%      21752 ± 20%  softirqs.CPU50.RCU
     15909 ±  5%     +41.1%      22450 ±  2%  softirqs.CPU50.SCHED
     15633 ± 17%     +41.3%      22084 ± 23%  softirqs.CPU51.RCU
     16153 ±  2%     +40.4%      22674 ±  2%  softirqs.CPU51.SCHED
     15643 ± 16%     +50.0%      23464 ± 23%  softirqs.CPU52.RCU
     14664 ±  5%     +42.8%      20938 ±  6%  softirqs.CPU52.SCHED
     16338 ± 16%     +39.3%      22752 ± 23%  softirqs.CPU53.RCU
     16607 ±  6%     +35.3%      22463 ±  5%  softirqs.CPU53.SCHED
     11486 ± 19%     +43.1%      16437 ± 21%  softirqs.CPU55.RCU
     11945 ±  8%     +31.3%      15687 ±  4%  softirqs.CPU55.SCHED
     11628 ± 18%     +42.2%      16531 ± 22%  softirqs.CPU56.RCU
     12402 ±  8%     +24.7%      15470 ±  8%  softirqs.CPU56.SCHED
     11683 ± 18%     +43.9%      16814 ± 20%  softirqs.CPU57.RCU
     12627 ±  5%     +22.7%      15491 ±  7%  softirqs.CPU57.SCHED
     11665 ± 20%     +47.9%      17251 ± 24%  softirqs.CPU58.RCU
     11874 ±  5%     +31.8%      15646 ±  5%  softirqs.CPU58.SCHED
     11793 ± 19%     +43.6%      16936 ± 21%  softirqs.CPU59.RCU
     12687 ±  3%     +22.2%      15506 ±  6%  softirqs.CPU59.SCHED
     35383 ± 18%     +68.3%      59549 ± 26%  softirqs.CPU6.RCU
     29867 ± 11%     +67.9%      50145 ±  2%  softirqs.CPU6.SCHED
     11438 ± 19%     +47.2%      16833 ± 24%  softirqs.CPU60.RCU
     12325 ±  5%     +25.1%      15416 ±  3%  softirqs.CPU60.SCHED
     12177 ± 26%     +35.4%      16488 ± 22%  softirqs.CPU61.RCU
     12721           +23.3%      15687        softirqs.CPU61.SCHED
     11705 ± 18%     +47.9%      17317 ± 17%  softirqs.CPU62.RCU
      6842 ± 15%     +24.8%       8538 ± 16%  softirqs.CPU68.RCU
     35380 ± 20%     +68.3%      59531 ± 27%  softirqs.CPU7.RCU
     30170 ±  5%     +61.6%      48751 ±  4%  softirqs.CPU7.SCHED
     35353 ± 18%     +72.3%      60916 ± 27%  softirqs.CPU8.RCU
     28662 ±  7%     +62.9%      46684 ±  3%  softirqs.CPU8.SCHED
     31810 ± 20%     +68.7%      53657 ± 27%  softirqs.CPU9.RCU
     27920 ±  3%     +56.1%      43588 ±  8%  softirqs.CPU9.SCHED
     28125 ± 78%     +99.8%      56207 ± 34%  softirqs.NET_RX
   2095626 ± 15%     +43.7%    3011041 ± 21%  softirqs.RCU
   2041634           +36.5%    2787508        softirqs.SCHED
     58556 ±  4%     +39.0%      81377 ± 10%  softirqs.TIMER
      0.02 ± 16%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.d_alloc_parallel.path_openat.do_filp_open.do_sys_openat2
      0.04 ± 11%     -20.5%       0.03 ±  7%  perf-sched.sch_delay.avg.ms.do_syslog.part.0.kmsg_read.vfs_read
      0.03 ±  2%     -16.1%       0.02 ±  3%  perf-sched.sch_delay.avg.ms.kthread_worker_fn.kthread.ret_from_fork
      0.01 ±173%    +335.0%       0.02 ± 18%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.__kmalloc.kmem_alloc.xfs_dir_removename
      0.44 ± 70%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.down_write.xfs_ilock.xfs_create
      0.08 ±124%     -95.1%       0.00 ±173%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.dput.path_openat.do_filp_open
      0.02 ± 40%     -77.4%       0.00 ±173%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.security_file_alloc.__alloc_file
      0.10 ± 72%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.xfs_inobt_init_common.xfs_inobt_init_cursor
      0.22 ± 48%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.xfs_inode_alloc.xfs_iget
      0.01 ± 29%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.xfs_trans_alloc.xfs_create
      0.12 ± 63%     -96.5%       0.00 ±173%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.xfs_trans_alloc.xfs_iomap_write_unwritten
      0.13 ±160%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.mnt_want_write.path_openat.do_filp_open
      0.02 ± 11%     -30.8%       0.01 ±  3%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.smpboot_thread_fn.kthread.ret_from_fork
      0.01 ±  9%     -14.0%       0.01 ±  8%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.stop_one_cpu.sched_exec.bprm_execve
      0.05 ±131%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      0.02 ± 22%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.rwsem_down_read_slowpath.xfs_log_commit_cil.__xfs_trans_commit.xfs_create
      0.18 ±117%     -83.1%       0.03 ±  6%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.04 ± 57%     -64.8%       0.01 ±  3%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
      0.03 ± 29%     -36.8%       0.02 ±  6%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      0.03 ± 35%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.xfs_log_commit_cil.__xfs_trans_commit.xfs_create.xfs_generic_create
      0.02 ±  8%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.xfs_log_commit_cil.__xfs_trans_commit.xfs_trans_roll.xfs_dialloc_select_ag
      0.05 ± 34%     -55.3%       0.02 ±  5%  perf-sched.sch_delay.avg.ms.xlog_state_get_iclog_space.xlog_write.xlog_cil_push_work.process_one_work
      0.08 ± 51%    -100.0%       0.00        perf-sched.sch_delay.max.ms.d_alloc_parallel.path_openat.do_filp_open.do_sys_openat2
      0.21 ± 83%     -75.1%       0.05 ±  5%  perf-sched.sch_delay.max.ms.do_syslog.part.0.kmsg_read.vfs_read
      6.37 ±167%     -99.1%       0.05 ± 38%  perf-sched.sch_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      3.20 ± 92%     -99.5%       0.01 ±  8%  perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
      0.12 ± 94%     -68.3%       0.04 ± 40%  perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
      0.26 ± 93%     -86.6%       0.04 ± 22%  perf-sched.sch_delay.max.ms.futex_wait_queue_me.futex_wait.do_futex.__x64_sys_futex
      0.42 ± 42%     -68.3%       0.13 ± 19%  perf-sched.sch_delay.max.ms.io_schedule.wait_on_page_bit.wait_on_page_writeback.__filemap_fdatawait_range
      0.66 ± 47%     -83.0%       0.11 ± 34%  perf-sched.sch_delay.max.ms.kthread_worker_fn.kthread.ret_from_fork
      0.05 ± 41%     -58.2%       0.02 ± 74%  perf-sched.sch_delay.max.ms.kthreadd.ret_from_fork
      0.01 ±173%    +675.0%       0.04 ± 59%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.__kmalloc.kmem_alloc.xfs_dir_removename
      3.93 ± 76%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.down_write.xfs_ilock.xfs_create
      1.37 ±157%     -99.7%       0.00 ±173%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.dput.path_openat.do_filp_open
      0.02 ± 39%     -67.9%       0.01 ±100%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.dput.terminate_walk.path_openat
      0.02 ± 23%     -84.9%       0.00 ±173%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.__alloc_file.alloc_empty_file
      0.02 ± 27%     -83.1%       0.00 ±173%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.security_file_alloc.__alloc_file
      1.70 ±108%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.xfs_inobt_init_common.xfs_inobt_init_cursor
      4.29 ± 68%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.xfs_inode_alloc.xfs_iget
      0.05 ± 84%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.xfs_trans_alloc.xfs_create
      1.15 ± 68%     -99.3%       0.01 ±173%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.xfs_trans_alloc.xfs_iomap_write_unwritten
      0.56 ±166%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.mnt_want_write.path_openat.do_filp_open
      3.85 ± 37%     -88.9%       0.43 ±  9%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.smpboot_thread_fn.kthread.ret_from_fork
      0.14 ± 16%    +392.7%       0.67 ± 55%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.submit_bio_checks.submit_bio_noacct.submit_bio
      0.16 ±144%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      0.03 ± 10%     -48.1%       0.01 ± 57%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.wait_for_completion_io.submit_bio_wait.blkdev_issue_flush
      0.14 ±131%    -100.0%       0.00        perf-sched.sch_delay.max.ms.rwsem_down_read_slowpath.xfs_log_commit_cil.__xfs_trans_commit.xfs_create
      0.01 ±100%    +498.2%       0.08 ± 34%  perf-sched.sch_delay.max.ms.rwsem_down_read_slowpath.xfs_log_commit_cil.__xfs_trans_commit.xfs_remove
     25.65 ±154%     -99.6%       0.11 ± 50%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      1.22 ±127%     -97.3%       0.03 ± 12%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
      0.19 ± 96%     -71.0%       0.06 ± 35%  perf-sched.sch_delay.max.ms.schedule_timeout.io_schedule_timeout.wait_for_completion_io.submit_bio_wait
     12.70 ± 80%     -99.4%       0.08 ± 40%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      0.18 ± 24%     +87.9%       0.33 ± 22%  perf-sched.sch_delay.max.ms.schedule_timeout.wait_for_completion.__flush_work.xlog_cil_force_lsn
      2.34 ±133%    -100.0%       0.00        perf-sched.sch_delay.max.ms.xfs_log_commit_cil.__xfs_trans_commit.xfs_create.xfs_generic_create
      0.02 ±  5%    -100.0%       0.00        perf-sched.sch_delay.max.ms.xfs_log_commit_cil.__xfs_trans_commit.xfs_trans_roll.xfs_dialloc_select_ag
      3.92 ± 94%     -93.5%       0.26 ±  8%  perf-sched.sch_delay.max.ms.xlog_state_get_iclog_space.xlog_write.xlog_cil_push_work.process_one_work
      0.27 ± 48%     -65.0%       0.09 ± 37%  perf-sched.sch_delay.max.ms.xlog_wait_on_iclog.__xfs_log_force_lsn.xfs_log_force_lsn.xfs_file_fsync
      0.04 ± 15%     +62.4%       0.06 ± 24%  perf-sched.sch_delay.max.ms.xlog_wait_on_iclog.xfsaild_push.xfsaild.kthread
     29.07 ± 14%    +146.2%      71.57 ±  5%  perf-sched.total_wait_and_delay.average.ms
     76774 ± 13%     -58.4%      31919 ±  6%  perf-sched.total_wait_and_delay.count.ms
      8090 ± 14%     +23.3%       9974        perf-sched.total_wait_and_delay.max.ms
     29.04 ± 14%    +146.3%      71.53 ±  5%  perf-sched.total_wait_time.average.ms
      8090 ± 14%     +23.3%       9974        perf-sched.total_wait_time.max.ms
    198.54 ± 23%     +35.7%     269.49 ±  3%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     12.50 ± 12%     +20.7%      15.08        perf-sched.wait_and_delay.avg.ms.kthread_worker_fn.kthread.ret_from_fork
    709.11 ±114%     -91.9%      57.38 ±173%  perf-sched.wait_and_delay.avg.ms.kthreadd.ret_from_fork
      2802 ±124%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common._cond_resched.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
     13.85 ±  7%     +81.4%      25.12        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common._cond_resched.stop_one_cpu.affine_move_task.__set_cpus_allowed_ptr
    338.39 ± 36%     +61.2%     545.64        perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
      9.45 ± 36%   +1401.1%     141.90 ±  4%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.__down.down.xfs_buf_lock
    151.18 ±  5%     +20.3%     181.94        perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork
      8.31 ± 28%    +323.2%      35.16 ±  9%  perf-sched.wait_and_delay.avg.ms.xlog_grant_head_wait.xlog_grant_head_check.xfs_log_reserve.xfs_trans_reserve
     41.75 ± 50%     -89.2%       4.50 ± 19%  perf-sched.wait_and_delay.count.futex_wait_queue_me.futex_wait.do_futex.__x64_sys_futex
      8.50 ± 41%     -91.2%       0.75 ±173%  perf-sched.wait_and_delay.count.kthreadd.ret_from_fork
      8.00 ± 67%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common._cond_resched.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
     80.00 ±173%    +432.5%     426.00 ± 53%  perf-sched.wait_and_delay.count.rcu_gp_kthread.kthread.ret_from_fork
    157.75 ± 44%     -82.4%      27.75 ± 34%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
     70.25 ± 31%     -53.0%      33.00        perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
      9376 ± 32%     -89.5%     984.50 ±  8%  perf-sched.wait_and_delay.count.schedule_timeout.__down.down.xfs_buf_lock
      4155 ±  3%     -20.5%       3302 ±  2%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork
      5.75 ± 25%     -78.3%       1.25 ± 87%  perf-sched.wait_and_delay.count.xlog_cil_force_lsn.xfs_log_force.xfsaild_push.xfsaild
     46938 ± 13%     -71.3%      13491 ±  9%  perf-sched.wait_and_delay.count.xlog_grant_head_wait.xlog_grant_head_check.xfs_log_reserve.xfs_trans_reserve
     17.75 ±  6%     +52.1%      27.00 ±  8%  perf-sched.wait_and_delay.count.xlog_wait_on_iclog.xfsaild_push.xfsaild.kthread
      2458 ± 59%     -66.9%     814.19 ± 77%  perf-sched.wait_and_delay.max.ms.futex_wait_queue_me.futex_wait.do_futex.__x64_sys_futex
      2761 ± 79%     -93.8%     171.23 ±173%  perf-sched.wait_and_delay.max.ms.kthreadd.ret_from_fork
      6201 ± 48%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common._cond_resched.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
      1087 ± 13%    +817.6%       9974        perf-sched.wait_and_delay.max.ms.preempt_schedule_common._cond_resched.stop_one_cpu.affine_move_task.__set_cpus_allowed_ptr
    417.86 ±  6%     +14.5%     478.51 ±  2%  perf-sched.wait_and_delay.max.ms.schedule_timeout.__down.down.xfs_buf_lock
    217.43 ± 18%     -40.3%     129.80 ± 64%  perf-sched.wait_and_delay.max.ms.xlog_cil_force_lsn.xfs_log_force.xfsaild_push.xfsaild
    417.40 ±  6%    +103.9%     850.87 ± 76%  perf-sched.wait_and_delay.max.ms.xlog_grant_head_wait.xlog_grant_head_check.xfs_log_reserve.xfs_trans_reserve
    198.51 ± 23%     +35.8%     269.48 ±  3%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     14.75 ±116%     -99.6%       0.05 ± 63%  perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
     17.07 ± 42%     -68.8%       5.32 ± 15%  perf-sched.wait_time.avg.ms.io_schedule.rq_qos_wait.wbt_wait.__rq_qos_throttle
     12.47 ± 12%     +20.8%      15.06        perf-sched.wait_time.avg.ms.kthread_worker_fn.kthread.ret_from_fork
    709.08 ±114%     -91.9%      57.37 ±173%  perf-sched.wait_time.avg.ms.kthreadd.ret_from_fork
      1.40 ± 92%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.__kmalloc.kmem_alloc.xfs_dir_createname
      1.16 ±173%   +1621.7%      19.90 ± 55%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.__kmalloc.kmem_alloc.xfs_dir_removename
    195.02 ±173%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     18.12 ±100%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down_write.xfs_ilock.xfs_create
      0.30 ± 75%     -89.7%       0.03 ±100%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.dput.__fput.task_work_run
     10.04 ± 41%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.dput.path_openat.do_filp_open
      5.12 ±156%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.dput.terminate_walk.path_openat
      2802 ±124%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
      1.41 ± 77%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.__alloc_file.alloc_empty_file
     21.64 ±172%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.getname_flags.do_sys_openat2
     19.45 ± 59%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.xfs_inobt_init_common.xfs_inobt_init_cursor
      6.87 ± 45%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.xfs_inode_alloc.xfs_iget
     21.41 ±164%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.xfs_inode_item_init.xfs_trans_ijoin
      8.42 ± 75%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.xfs_trans_alloc.xfs_create
     39.19 ± 75%     -99.0%       0.40 ±173%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.xfs_trans_alloc.xfs_iomap_write_unwritten
      1.97 ± 43%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.mnt_want_write.path_openat.do_filp_open
     13.85 ±  7%     +81.4%      25.12        perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.stop_one_cpu.affine_move_task.__set_cpus_allowed_ptr
     15.84 ±103%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode
     33.91 ± 10%    -100.0%       0.00        perf-sched.wait_time.avg.ms.rwsem_down_read_slowpath.xfs_log_commit_cil.__xfs_trans_commit.xfs_create
     12.45 ±109%    +355.3%      56.70 ±  9%  perf-sched.wait_time.avg.ms.rwsem_down_read_slowpath.xfs_log_commit_cil.__xfs_trans_commit.xfs_remove
    338.35 ± 36%     +61.3%     545.63        perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
      9.42 ± 37%   +1405.4%     141.85 ±  4%  perf-sched.wait_time.avg.ms.schedule_timeout.__down.down.xfs_buf_lock
      0.02 ± 69%    +104.9%       0.04 ± 45%  perf-sched.wait_time.avg.ms.schedule_timeout.khugepaged.kthread.ret_from_fork
      9.40 ±  4%     -48.7%       4.83 ±  9%  perf-sched.wait_time.avg.ms.schedule_timeout.wait_for_completion.__flush_work.xlog_cil_force_lsn
      0.02 ± 63%     -69.8%       0.00 ± 68%  perf-sched.wait_time.avg.ms.wait_for_partner.fifo_open.do_dentry_open.path_openat
    151.11 ±  5%     +20.4%     181.88        perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork
      4.22 ± 31%    -100.0%       0.00        perf-sched.wait_time.avg.ms.xfs_log_commit_cil.__xfs_trans_commit.xfs_create.xfs_generic_create
      4.42 ± 40%    -100.0%       0.00        perf-sched.wait_time.avg.ms.xfs_log_commit_cil.__xfs_trans_commit.xfs_trans_roll.xfs_dialloc_select_ag
      8.28 ± 28%    +324.1%      35.13 ±  9%  perf-sched.wait_time.avg.ms.xlog_grant_head_wait.xlog_grant_head_check.xfs_log_reserve.xfs_trans_reserve
     23.53 ±  3%     +17.5%      27.65 ±  2%  perf-sched.wait_time.avg.ms.xlog_state_get_iclog_space.xlog_write.xlog_cil_push_work.process_one_work
    254.85 ± 60%     -50.9%     125.21        perf-sched.wait_time.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
     11.03 ±167%     -99.2%       0.09 ±119%  perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
    395.08 ± 92%    -100.0%       0.20 ± 50%  perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
      2458 ± 59%     -66.9%     814.16 ± 77%  perf-sched.wait_time.max.ms.futex_wait_queue_me.futex_wait.do_futex.__x64_sys_futex
      2761 ± 79%     -93.8%     171.22 ±173%  perf-sched.wait_time.max.ms.kthreadd.ret_from_fork
      5.93 ±100%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.__kmalloc.kmem_alloc.xfs_dir_createname
      1.78 ±173%   +9342.2%     168.40 ± 90%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.__kmalloc.kmem_alloc.xfs_dir_removename
      1948 ±173%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
    180.08 ± 97%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down_write.xfs_ilock.xfs_create
      1.36 ±100%     -97.8%       0.03 ±100%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.dput.__fput.task_work_run
    134.40 ± 81%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.dput.path_openat.do_filp_open
     15.21 ±157%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.dput.terminate_walk.path_openat
      6201 ± 48%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
      5.31 ± 79%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.__alloc_file.alloc_empty_file
     21.65 ±172%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.getname_flags.do_sys_openat2
    275.44 ± 57%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.xfs_inobt_init_common.xfs_inobt_init_cursor
    130.08 ± 80%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.xfs_inode_alloc.xfs_iget
     43.26 ±160%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.xfs_inode_item_init.xfs_trans_ijoin
     38.03 ± 87%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.xfs_trans_alloc.xfs_create
    446.13 ± 59%     -99.8%       0.80 ±173%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.xfs_trans_alloc.xfs_iomap_write_unwritten
      6.15 ± 45%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.mnt_want_write.path_openat.do_filp_open
    355.42 ± 43%     -86.9%      46.56 ± 70%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.process_one_work.worker_thread.kthread
      1087 ± 13%    +817.6%       9974        perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.stop_one_cpu.affine_move_task.__set_cpus_allowed_ptr
     56.87 ±114%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode
    198.79 ± 16%    -100.0%       0.00        perf-sched.wait_time.max.ms.rwsem_down_read_slowpath.xfs_log_commit_cil.__xfs_trans_commit.xfs_create
     95.71 ±100%    +303.1%     385.76 ± 12%  perf-sched.wait_time.max.ms.rwsem_down_read_slowpath.xfs_log_commit_cil.__xfs_trans_commit.xfs_remove
    414.09 ±  6%     +15.5%     478.10 ±  2%  perf-sched.wait_time.max.ms.schedule_timeout.__down.down.xfs_buf_lock
    468.62 ± 77%     -93.8%      29.28 ± 22%  perf-sched.wait_time.max.ms.schedule_timeout.io_schedule_timeout.wait_for_completion_io.submit_bio_wait
      0.02 ± 69%    +104.9%       0.04 ± 45%  perf-sched.wait_time.max.ms.schedule_timeout.khugepaged.kthread.ret_from_fork
    294.77 ±  3%     -60.0%     117.80 ± 36%  perf-sched.wait_time.max.ms.schedule_timeout.wait_for_completion.__flush_work.xlog_cil_force_lsn
     31.05 ±115%    -100.0%       0.00        perf-sched.wait_time.max.ms.xfs_log_commit_cil.__xfs_trans_commit.xfs_create.xfs_generic_create
      8.22 ± 49%    -100.0%       0.00        perf-sched.wait_time.max.ms.xfs_log_commit_cil.__xfs_trans_commit.xfs_trans_roll.xfs_dialloc_select_ag
    217.41 ± 18%     -40.3%     129.78 ± 64%  perf-sched.wait_time.max.ms.xlog_cil_force_lsn.xfs_log_force.xfsaild_push.xfsaild
    415.85 ±  6%    +104.4%     849.85 ± 77%  perf-sched.wait_time.max.ms.xlog_grant_head_wait.xlog_grant_head_check.xfs_log_reserve.xfs_trans_reserve
      0.55 ± 11%     -64.3%       0.20 ± 50%  perf-sched.wait_time.max.ms.xlog_wait_on_iclog.__xfs_log_force_lsn.xfs_log_force_lsn.xfs_file_fsync
     36285 ± 57%    +149.6%      90556        interrupts.180:IR-PCI-MSI.512000-edge.ahci[0000:00:1f.2]
      2668 ±104%    +955.7%      28172 ±102%  interrupts.38:IR-PCI-MSI.4194306-edge.eth0-TxRx-1
    506550            +6.4%     538938        interrupts.CAL:Function_call_interrupts
      1796 ± 57%     +93.6%       3477 ±  2%  interrupts.CPU0.180:IR-PCI-MSI.512000-edge.ahci[0000:00:1f.2]
      9098 ±  9%     +22.8%      11168 ±  4%  interrupts.CPU0.CAL:Function_call_interrupts
    640984           +60.1%    1026465        interrupts.CPU0.LOC:Local_timer_interrupts
    600.50 ± 30%     -69.9%     180.75 ± 37%  interrupts.CPU0.NMI:Non-maskable_interrupts
    600.50 ± 30%     -69.9%     180.75 ± 37%  interrupts.CPU0.PMI:Performance_monitoring_interrupts
      3636 ± 29%    +152.0%       9165 ± 53%  interrupts.CPU0.RES:Rescheduling_interrupts
     90.75 ± 24%    +122.0%     201.50 ± 23%  interrupts.CPU0.TLB:TLB_shootdowns
      5890 ± 57%    +178.9%      16429        interrupts.CPU1.180:IR-PCI-MSI.512000-edge.ahci[0000:00:1f.2]
      8753 ± 10%     +34.3%      11760 ±  8%  interrupts.CPU1.CAL:Function_call_interrupts
    557692           +67.6%     934794        interrupts.CPU1.LOC:Local_timer_interrupts
      2559 ± 18%     +93.5%       4952 ± 10%  interrupts.CPU1.RES:Rescheduling_interrupts
     80.50 ± 37%    +169.9%     217.25 ± 13%  interrupts.CPU1.TLB:TLB_shootdowns
    458081 ±  2%     +62.4%     743914        interrupts.CPU10.LOC:Local_timer_interrupts
     57.75 ±  9%     +65.4%      95.50 ±  6%  interrupts.CPU10.TLB:TLB_shootdowns
    457813 ±  2%     +62.6%     744205        interrupts.CPU11.LOC:Local_timer_interrupts
    139.00 ± 22%     +65.6%     230.25 ± 14%  interrupts.CPU11.RES:Rescheduling_interrupts
      1830 ± 94%    +948.8%      19201 ±108%  interrupts.CPU12.38:IR-PCI-MSI.4194306-edge.eth0-TxRx-1
    457869 ±  2%     +62.6%     744326        interrupts.CPU12.LOC:Local_timer_interrupts
    424.50 ± 50%     -58.0%     178.25 ± 31%  interrupts.CPU12.NMI:Non-maskable_interrupts
    424.50 ± 50%     -58.0%     178.25 ± 31%  interrupts.CPU12.PMI:Performance_monitoring_interrupts
    142.25 ± 19%     +40.6%     200.00 ±  8%  interrupts.CPU12.RES:Rescheduling_interrupts
    457704 ±  2%     +62.6%     744120        interrupts.CPU13.LOC:Local_timer_interrupts
    122.50 ± 16%    +140.6%     294.75 ± 56%  interrupts.CPU13.RES:Rescheduling_interrupts
    458395 ±  2%     +62.5%     744793        interrupts.CPU14.LOC:Local_timer_interrupts
    499.25 ± 38%     -73.1%     134.50 ± 13%  interrupts.CPU14.NMI:Non-maskable_interrupts
    499.25 ± 38%     -73.1%     134.50 ± 13%  interrupts.CPU14.PMI:Performance_monitoring_interrupts
    101.75 ± 19%    +129.7%     233.75 ± 24%  interrupts.CPU14.RES:Rescheduling_interrupts
    458051 ±  2%     +62.5%     744313        interrupts.CPU15.LOC:Local_timer_interrupts
    374.25 ± 60%     -66.9%     123.75 ±  5%  interrupts.CPU15.NMI:Non-maskable_interrupts
    374.25 ± 60%     -66.9%     123.75 ±  5%  interrupts.CPU15.PMI:Performance_monitoring_interrupts
      3577 ± 11%     +31.5%       4702 ±  5%  interrupts.CPU16.CAL:Function_call_interrupts
    458299 ±  2%     +62.4%     744369        interrupts.CPU16.LOC:Local_timer_interrupts
    319.00 ± 25%     -53.0%     150.00 ±  8%  interrupts.CPU16.NMI:Non-maskable_interrupts
    319.00 ± 25%     -53.0%     150.00 ±  8%  interrupts.CPU16.PMI:Performance_monitoring_interrupts
    121.75 ± 22%     +94.0%     236.25 ± 25%  interrupts.CPU16.RES:Rescheduling_interrupts
      9138 ±173%    +473.7%      52422 ± 57%  interrupts.CPU17.180:IR-PCI-MSI.512000-edge.ahci[0000:00:1f.2]
    458322 ±  2%     +62.3%     743806        interrupts.CPU17.LOC:Local_timer_interrupts
    271.50 ± 29%     +81.9%     493.75 ± 48%  interrupts.CPU17.NMI:Non-maskable_interrupts
    271.50 ± 29%     +81.9%     493.75 ± 48%  interrupts.CPU17.PMI:Performance_monitoring_interrupts
    112.25 ± 25%     +98.0%     222.25 ± 16%  interrupts.CPU17.RES:Rescheduling_interrupts
    419237 ±  2%     +58.9%     666177        interrupts.CPU18.LOC:Local_timer_interrupts
    102.50 ±  8%     +31.5%     134.75 ± 15%  interrupts.CPU18.RES:Rescheduling_interrupts
      2923 ±  8%     +29.2%       3778 ± 15%  interrupts.CPU19.CAL:Function_call_interrupts
    419863 ±  2%     +58.8%     666693        interrupts.CPU19.LOC:Local_timer_interrupts
    468.50 ± 42%     -71.3%     134.25 ± 13%  interrupts.CPU19.NMI:Non-maskable_interrupts
    468.50 ± 42%     -71.3%     134.25 ± 13%  interrupts.CPU19.PMI:Performance_monitoring_interrupts
      8781 ±  6%     +42.3%      12499 ± 16%  interrupts.CPU2.CAL:Function_call_interrupts
    527217           +66.0%     875081        interrupts.CPU2.LOC:Local_timer_interrupts
    606.50 ± 40%     -76.4%     143.25 ± 10%  interrupts.CPU2.NMI:Non-maskable_interrupts
    606.50 ± 40%     -76.4%     143.25 ± 10%  interrupts.CPU2.PMI:Performance_monitoring_interrupts
    109.00 ± 41%    +177.8%     302.75 ± 30%  interrupts.CPU2.TLB:TLB_shootdowns
    420071 ±  2%     +58.5%     665924        interrupts.CPU20.LOC:Local_timer_interrupts
     76.00 ± 35%    +104.6%     155.50 ± 14%  interrupts.CPU20.RES:Rescheduling_interrupts
    419827 ±  2%     +59.0%     667725        interrupts.CPU21.LOC:Local_timer_interrupts
    475.00 ± 41%     -71.4%     135.75 ±  9%  interrupts.CPU21.NMI:Non-maskable_interrupts
    475.00 ± 41%     -71.4%     135.75 ±  9%  interrupts.CPU21.PMI:Performance_monitoring_interrupts
     92.00 ± 33%     +66.6%     153.25 ± 25%  interrupts.CPU21.RES:Rescheduling_interrupts
      3057 ±  7%     +54.6%       4727 ±  7%  interrupts.CPU22.CAL:Function_call_interrupts
    419911 ±  2%     +58.6%     666150        interrupts.CPU22.LOC:Local_timer_interrupts
    285.25 ± 24%     -52.9%     134.25 ±  6%  interrupts.CPU22.NMI:Non-maskable_interrupts
    285.25 ± 24%     -52.9%     134.25 ±  6%  interrupts.CPU22.PMI:Performance_monitoring_interrupts
      3413 ±  5%     +22.0%       4164 ±  6%  interrupts.CPU23.CAL:Function_call_interrupts
    419713 ±  2%     +58.6%     665517        interrupts.CPU23.LOC:Local_timer_interrupts
    354.75 ± 29%     -56.6%     154.00 ± 37%  interrupts.CPU23.NMI:Non-maskable_interrupts
    354.75 ± 29%     -56.6%     154.00 ± 37%  interrupts.CPU23.PMI:Performance_monitoring_interrupts
    419900 ±  2%     +58.5%     665698        interrupts.CPU24.LOC:Local_timer_interrupts
    421914           +57.9%     666018        interrupts.CPU25.LOC:Local_timer_interrupts
    407.25 ± 17%     -50.2%     202.75 ± 43%  interrupts.CPU25.NMI:Non-maskable_interrupts
    407.25 ± 17%     -50.2%     202.75 ± 43%  interrupts.CPU25.PMI:Performance_monitoring_interrupts
     32.50 ± 24%    +102.3%      65.75 ± 50%  interrupts.CPU25.TLB:TLB_shootdowns
    420409 ±  2%     +58.4%     666105        interrupts.CPU26.LOC:Local_timer_interrupts
    381863           +51.9%     580175        interrupts.CPU27.LOC:Local_timer_interrupts
    426.50 ± 51%     -71.0%     123.75 ±  9%  interrupts.CPU27.NMI:Non-maskable_interrupts
    426.50 ± 51%     -71.0%     123.75 ±  9%  interrupts.CPU27.PMI:Performance_monitoring_interrupts
    380677 ±  2%     +52.4%     580025        interrupts.CPU28.LOC:Local_timer_interrupts
    474.25 ± 45%     -69.0%     147.00 ± 39%  interrupts.CPU28.NMI:Non-maskable_interrupts
    474.25 ± 45%     -69.0%     147.00 ± 39%  interrupts.CPU28.PMI:Performance_monitoring_interrupts
    380642 ±  2%     +52.5%     580519        interrupts.CPU29.LOC:Local_timer_interrupts
    433.75 ± 58%     -63.3%     159.25 ± 32%  interrupts.CPU29.NMI:Non-maskable_interrupts
    433.75 ± 58%     -63.3%     159.25 ± 32%  interrupts.CPU29.PMI:Performance_monitoring_interrupts
     10.75 ± 41%  +25930.2%       2798 ±102%  interrupts.CPU3.38:IR-PCI-MSI.4194306-edge.eth0-TxRx-1
    523996           +66.9%     874356        interrupts.CPU3.LOC:Local_timer_interrupts
    377.25 ± 23%     -59.0%     154.50 ± 13%  interrupts.CPU3.NMI:Non-maskable_interrupts
    377.25 ± 23%     -59.0%     154.50 ± 13%  interrupts.CPU3.PMI:Performance_monitoring_interrupts
    943.00 ±  6%     +26.1%       1189 ± 16%  interrupts.CPU3.RES:Rescheduling_interrupts
     97.25 ± 51%    +179.4%     271.75 ± 15%  interrupts.CPU3.TLB:TLB_shootdowns
    380419 ±  2%     +52.6%     580547        interrupts.CPU30.LOC:Local_timer_interrupts
     60.75 ± 31%    +138.7%     145.00 ± 39%  interrupts.CPU30.RES:Rescheduling_interrupts
    380846 ±  2%     +52.3%     580053        interrupts.CPU31.LOC:Local_timer_interrupts
    380984 ±  2%     +52.4%     580499        interrupts.CPU32.LOC:Local_timer_interrupts
    358.00 ± 42%     -57.3%     153.00 ± 35%  interrupts.CPU32.NMI:Non-maskable_interrupts
    358.00 ± 42%     -57.3%     153.00 ± 35%  interrupts.CPU32.PMI:Performance_monitoring_interrupts
      2459 ± 11%     +18.6%       2916 ±  7%  interrupts.CPU33.CAL:Function_call_interrupts
    381196 ±  2%     +52.3%     580727        interrupts.CPU33.LOC:Local_timer_interrupts
    604.00 ± 72%     -75.2%     149.50 ± 37%  interrupts.CPU33.NMI:Non-maskable_interrupts
    604.00 ± 72%     -75.2%     149.50 ± 37%  interrupts.CPU33.PMI:Performance_monitoring_interrupts
      2451 ±  9%     +38.2%       3387 ± 14%  interrupts.CPU34.CAL:Function_call_interrupts
    380544 ±  2%     +52.5%     580350        interrupts.CPU34.LOC:Local_timer_interrupts
    353.25 ± 31%     -62.8%     131.50 ± 17%  interrupts.CPU34.NMI:Non-maskable_interrupts
    353.25 ± 31%     -62.8%     131.50 ± 17%  interrupts.CPU34.PMI:Performance_monitoring_interrupts
     54.75 ±  8%     +95.0%     106.75 ± 26%  interrupts.CPU34.RES:Rescheduling_interrupts
      2366 ±  8%     +27.0%       3005 ± 17%  interrupts.CPU35.CAL:Function_call_interrupts
    380754 ±  2%     +52.4%     580385        interrupts.CPU35.LOC:Local_timer_interrupts
    416.75 ± 50%     -64.5%     147.75 ± 31%  interrupts.CPU35.NMI:Non-maskable_interrupts
    416.75 ± 50%     -64.5%     147.75 ± 31%  interrupts.CPU35.PMI:Performance_monitoring_interrupts
     58.50 ± 31%     +91.0%     111.75 ± 11%  interrupts.CPU35.RES:Rescheduling_interrupts
    333550 ±  2%     +44.6%     482213        interrupts.CPU36.LOC:Local_timer_interrupts
    333497 ±  2%     +44.7%     482650        interrupts.CPU37.LOC:Local_timer_interrupts
    333466 ±  2%     +44.6%     482105        interrupts.CPU38.LOC:Local_timer_interrupts
    398.75 ± 43%     -59.4%     162.00 ± 32%  interrupts.CPU38.NMI:Non-maskable_interrupts
    398.75 ± 43%     -59.4%     162.00 ± 32%  interrupts.CPU38.PMI:Performance_monitoring_interrupts
    333861 ±  2%     +44.4%     482098        interrupts.CPU39.LOC:Local_timer_interrupts
    494408 ±  2%     +64.7%     814507        interrupts.CPU4.LOC:Local_timer_interrupts
    429.25 ± 60%     -57.0%     184.50 ± 27%  interrupts.CPU4.NMI:Non-maskable_interrupts
    429.25 ± 60%     -57.0%     184.50 ± 27%  interrupts.CPU4.PMI:Performance_monitoring_interrupts
    333775 ±  2%     +44.4%     482085        interrupts.CPU40.LOC:Local_timer_interrupts
    333880 ±  2%     +44.4%     482073        interrupts.CPU41.LOC:Local_timer_interrupts
    316.25 ± 29%     -44.8%     174.50 ± 39%  interrupts.CPU41.NMI:Non-maskable_interrupts
    316.25 ± 29%     -44.8%     174.50 ± 39%  interrupts.CPU41.PMI:Performance_monitoring_interrupts
    333802 ±  2%     +44.5%     482331        interrupts.CPU42.LOC:Local_timer_interrupts
    334200 ±  2%     +44.3%     482415        interrupts.CPU43.LOC:Local_timer_interrupts
    313.75 ± 32%     -60.2%     124.75 ±  6%  interrupts.CPU43.NMI:Non-maskable_interrupts
    313.75 ± 32%     -60.2%     124.75 ±  6%  interrupts.CPU43.PMI:Performance_monitoring_interrupts
     36.50 ± 26%     +93.2%      70.50 ± 27%  interrupts.CPU43.RES:Rescheduling_interrupts
    334102 ±  2%     +44.4%     482397        interrupts.CPU44.LOC:Local_timer_interrupts
      2070 ±  6%     +34.1%       2776 ± 24%  interrupts.CPU45.CAL:Function_call_interrupts
    279054 ±  3%     +34.8%     376092        interrupts.CPU45.LOC:Local_timer_interrupts
    312.25 ± 30%     -61.4%     120.50 ±  4%  interrupts.CPU45.NMI:Non-maskable_interrupts
    312.25 ± 30%     -61.4%     120.50 ±  4%  interrupts.CPU45.PMI:Performance_monitoring_interrupts
    279009 ±  3%     +34.7%     375846        interrupts.CPU46.LOC:Local_timer_interrupts
    279126 ±  2%     +34.8%     376278        interrupts.CPU47.LOC:Local_timer_interrupts
     28.00 ± 59%    +153.6%      71.00 ± 59%  interrupts.CPU47.RES:Rescheduling_interrupts
    279112 ±  2%     +34.9%     376619        interrupts.CPU48.LOC:Local_timer_interrupts
    258.00 ± 31%     -53.7%     119.50 ±  6%  interrupts.CPU48.NMI:Non-maskable_interrupts
    258.00 ± 31%     -53.7%     119.50 ±  6%  interrupts.CPU48.PMI:Performance_monitoring_interrupts
    279374 ±  2%     +34.8%     376480        interrupts.CPU49.LOC:Local_timer_interrupts
     11.75 ± 17%  +17527.7%       2071 ± 95%  interrupts.CPU5.38:IR-PCI-MSI.4194306-edge.eth0-TxRx-1
    492980           +65.1%     813694        interrupts.CPU5.LOC:Local_timer_interrupts
      2046 ±  9%     +27.1%       2601 ±  8%  interrupts.CPU50.CAL:Function_call_interrupts
    279385 ±  3%     +34.7%     376401        interrupts.CPU50.LOC:Local_timer_interrupts
    329.00 ± 31%     -50.9%     161.50 ± 28%  interrupts.CPU50.NMI:Non-maskable_interrupts
    329.00 ± 31%     -50.9%     161.50 ± 28%  interrupts.CPU50.PMI:Performance_monitoring_interrupts
    279308 ±  3%     +34.8%     376383        interrupts.CPU51.LOC:Local_timer_interrupts
    279401 ±  3%     +34.8%     376721        interrupts.CPU52.LOC:Local_timer_interrupts
    439.50 ±  4%     -66.2%     148.75 ± 31%  interrupts.CPU52.NMI:Non-maskable_interrupts
    439.50 ±  4%     -66.2%     148.75 ± 31%  interrupts.CPU52.PMI:Performance_monitoring_interrupts
    279320 ±  3%     +34.9%     376673        interrupts.CPU53.LOC:Local_timer_interrupts
    584.25 ± 36%     -63.6%     212.50 ± 23%  interrupts.CPU53.NMI:Non-maskable_interrupts
    584.25 ± 36%     -63.6%     212.50 ± 23%  interrupts.CPU53.PMI:Performance_monitoring_interrupts
    209503 ±  3%     +25.7%     263328        interrupts.CPU54.LOC:Local_timer_interrupts
     16.00 ±122%    +828.1%     148.50 ± 29%  interrupts.CPU54.NMI:Non-maskable_interrupts
     16.00 ±122%    +828.1%     148.50 ± 29%  interrupts.CPU54.PMI:Performance_monitoring_interrupts
    209692 ±  3%     +25.7%     263619        interrupts.CPU55.LOC:Local_timer_interrupts
     13.75 ±127%    +778.2%     120.75 ± 10%  interrupts.CPU55.NMI:Non-maskable_interrupts
     13.75 ±127%    +778.2%     120.75 ± 10%  interrupts.CPU55.PMI:Performance_monitoring_interrupts
    209679 ±  3%     +26.0%     264210        interrupts.CPU56.LOC:Local_timer_interrupts
     16.25 ±115%   +1666.2%     287.00 ± 65%  interrupts.CPU56.NMI:Non-maskable_interrupts
     16.25 ±115%   +1666.2%     287.00 ± 65%  interrupts.CPU56.PMI:Performance_monitoring_interrupts
    210162 ±  3%     +25.9%     264671        interrupts.CPU57.LOC:Local_timer_interrupts
     16.25 ±120%   +1158.5%     204.50 ± 31%  interrupts.CPU57.NMI:Non-maskable_interrupts
     16.25 ±120%   +1158.5%     204.50 ± 31%  interrupts.CPU57.PMI:Performance_monitoring_interrupts
    210144 ±  3%     +25.8%     264429        interrupts.CPU58.LOC:Local_timer_interrupts
     25.00 ±107%    +608.0%     177.00 ± 32%  interrupts.CPU58.NMI:Non-maskable_interrupts
     25.00 ±107%    +608.0%     177.00 ± 32%  interrupts.CPU58.PMI:Performance_monitoring_interrupts
    210140 ±  3%     +26.0%     264721        interrupts.CPU59.LOC:Local_timer_interrupts
     24.25 ±121%    +569.1%     162.25 ± 29%  interrupts.CPU59.NMI:Non-maskable_interrupts
     24.25 ±121%    +569.1%     162.25 ± 29%  interrupts.CPU59.PMI:Performance_monitoring_interrupts
     40.25 ± 98%   +8284.5%       3374 ± 98%  interrupts.CPU6.39:IR-PCI-MSI.4194307-edge.eth0-TxRx-2
      4974 ± 10%     +46.2%       7271 ± 13%  interrupts.CPU6.CAL:Function_call_interrupts
    493028           +64.8%     812425        interrupts.CPU6.LOC:Local_timer_interrupts
    330.00 ± 27%     -36.1%     210.75 ± 37%  interrupts.CPU6.NMI:Non-maskable_interrupts
    330.00 ± 27%     -36.1%     210.75 ± 37%  interrupts.CPU6.PMI:Performance_monitoring_interrupts
    210128 ±  3%     +25.7%     264225        interrupts.CPU60.LOC:Local_timer_interrupts
    210662 ±  3%     +25.5%     264417        interrupts.CPU61.LOC:Local_timer_interrupts
     45.25 ±149%    +286.7%     175.00 ± 29%  interrupts.CPU61.NMI:Non-maskable_interrupts
     45.25 ±149%    +286.7%     175.00 ± 29%  interrupts.CPU61.PMI:Performance_monitoring_interrupts
      1602 ± 12%     +30.9%       2096 ± 15%  interrupts.CPU62.CAL:Function_call_interrupts
    210530 ±  3%     +25.8%     264752        interrupts.CPU62.LOC:Local_timer_interrupts
     27.00 ±100%    +886.1%     266.25 ±  3%  interrupts.CPU62.NMI:Non-maskable_interrupts
     27.00 ±100%    +886.1%     266.25 ±  3%  interrupts.CPU62.PMI:Performance_monitoring_interrupts
    141169            +9.1%     153981        interrupts.CPU63.LOC:Local_timer_interrupts
    141087            +9.3%     154188        interrupts.CPU64.LOC:Local_timer_interrupts
      1676 ± 13%     -16.3%       1402 ±  2%  interrupts.CPU65.CAL:Function_call_interrupts
    140977            +9.6%     154443        interrupts.CPU65.LOC:Local_timer_interrupts
    141180            +9.1%     154085        interrupts.CPU66.LOC:Local_timer_interrupts
    141292            +9.0%     153947        interrupts.CPU67.LOC:Local_timer_interrupts
    141300            +9.7%     154947        interrupts.CPU68.LOC:Local_timer_interrupts
    141181            +9.5%     154618        interrupts.CPU69.LOC:Local_timer_interrupts
      5135 ±  6%     +18.4%       6080 ±  7%  interrupts.CPU7.CAL:Function_call_interrupts
    493616           +64.6%     812685        interrupts.CPU7.LOC:Local_timer_interrupts
     62.50 ± 32%    +120.8%     138.00 ± 17%  interrupts.CPU7.TLB:TLB_shootdowns
    140761            +9.9%     154659        interrupts.CPU70.LOC:Local_timer_interrupts
    140489           +10.2%     154865        interrupts.CPU71.LOC:Local_timer_interrupts
    495084 ±  2%     +64.1%     812250        interrupts.CPU8.LOC:Local_timer_interrupts
    377.50 ± 19%     -64.1%     135.50 ±  2%  interrupts.CPU8.NMI:Non-maskable_interrupts
    377.50 ± 19%     -64.1%     135.50 ±  2%  interrupts.CPU8.PMI:Performance_monitoring_interrupts
     60.00 ± 24%    +100.4%     120.25 ± 21%  interrupts.CPU8.TLB:TLB_shootdowns
    458426 ±  2%     +62.3%     743856        interrupts.CPU9.LOC:Local_timer_interrupts
  34015055           +36.1%   46309125        interrupts.LOC:Local_timer_interrupts
    290.00           +11.4%     323.00        interrupts.MCP:Machine_check_polls
     21618 ± 24%     -43.0%      12313 ±  2%  interrupts.NMI:Non-maskable_interrupts
     21618 ± 24%     -43.0%      12313 ±  2%  interrupts.PMI:Performance_monitoring_interrupts
     13988 ±  7%     +78.0%      24895 ± 21%  interrupts.RES:Rescheduling_interrupts
      3586 ±  6%     +44.0%       5166 ±  4%  interrupts.TLB:TLB_shootdowns
     32.41 ± 16%     -32.4        0.00        perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
     32.38 ± 16%     -32.4        0.00        perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64
     28.80 ± 16%     -28.8        0.00        perf-profile.calltrace.cycles-pp.xfs_generic_create.path_openat.do_filp_open.do_sys_openat2.do_sys_open
     28.55 ± 16%     -28.5        0.00        perf-profile.calltrace.cycles-pp.xfs_create.xfs_generic_create.path_openat.do_filp_open.do_sys_openat2
     18.27 ±101%     -18.3        0.00        perf-profile.calltrace.cycles-pp.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
     18.26 ±101%     -18.3        0.00        perf-profile.calltrace.cycles-pp.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
     14.79 ±101%     -14.8        0.00        perf-profile.calltrace.cycles-pp.open64
     14.65 ±101%     -14.7        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.open64
     14.61 ±101%     -14.6        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
     14.60 ±101%     -14.6        0.00        perf-profile.calltrace.cycles-pp.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
     14.59 ±101%     -14.6        0.00        perf-profile.calltrace.cycles-pp.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
     14.00 ± 22%     -14.0        0.00        perf-profile.calltrace.cycles-pp.xfs_dir_ialloc.xfs_create.xfs_generic_create.path_openat.do_filp_open
     11.13 ± 27%     -11.1        0.00        perf-profile.calltrace.cycles-pp.xfs_dialloc_ag.xfs_dir_ialloc.xfs_create.xfs_generic_create.path_openat
     10.11 ± 29%     -10.1        0.00        perf-profile.calltrace.cycles-pp.xfs_check_agi_freecount.xfs_dialloc_ag.xfs_dir_ialloc.xfs_create.xfs_generic_create
      6.17 ± 17%      -6.2        0.00        perf-profile.calltrace.cycles-pp.xfs_trans_alloc.xfs_create.xfs_generic_create.path_openat.do_filp_open
      6.11 ± 17%      -6.1        0.00        perf-profile.calltrace.cycles-pp.xfs_trans_reserve.xfs_trans_alloc.xfs_create.xfs_generic_create.path_openat
      5.94 ± 31%      -5.9        0.00        perf-profile.calltrace.cycles-pp.xfs_inobt_get_rec.xfs_check_agi_freecount.xfs_dialloc_ag.xfs_dir_ialloc.xfs_create
      5.61 ± 17%      -5.6        0.00        perf-profile.calltrace.cycles-pp.__xfs_trans_commit.xfs_create.xfs_generic_create.path_openat.do_filp_open
      5.44 ± 18%      -5.4        0.00        perf-profile.calltrace.cycles-pp.xfs_log_commit_cil.__xfs_trans_commit.xfs_create.xfs_generic_create.path_openat
      3.31 ± 19%      -2.8        0.55 ± 72%  perf-profile.calltrace.cycles-pp.perf_prepare_sample.perf_event_output_forward.__perf_event_overflow.perf_swevent_overflow.perf_tp_event
      2.88 ± 26%      -2.6        0.26 ±100%  perf-profile.calltrace.cycles-pp.perf_callchain.perf_prepare_sample.perf_event_output_forward.__perf_event_overflow.perf_swevent_overflow
      2.85 ± 26%      -2.6        0.26 ±100%  perf-profile.calltrace.cycles-pp.get_perf_callchain.perf_callchain.perf_prepare_sample.perf_event_output_forward.__perf_event_overflow
      4.04 ± 13%      -2.2        1.83 ± 15%  perf-profile.calltrace.cycles-pp.xlog_grant_head_wait.xlog_grant_head_check.xfs_log_reserve.xfs_trans_reserve.xfs_trans_alloc
      3.67 ± 12%      -2.0        1.68 ± 12%  perf-profile.calltrace.cycles-pp.schedule.xlog_grant_head_wait.xlog_grant_head_check.xfs_log_reserve.xfs_trans_reserve
      3.66 ± 12%      -2.0        1.67 ± 12%  perf-profile.calltrace.cycles-pp.__schedule.schedule.xlog_grant_head_wait.xlog_grant_head_check.xfs_log_reserve
      3.08 ± 14%      -1.4        1.72 ± 10%  perf-profile.calltrace.cycles-pp.process_simple.perf_session__process_events.record__finish_output.cmd_record.cmd_sched
      1.80 ± 14%      -1.3        0.46 ± 57%  perf-profile.calltrace.cycles-pp.__perf_event_overflow.perf_swevent_overflow.perf_tp_event.perf_trace_sched_switch.__schedule
      1.78 ± 14%      -1.3        0.46 ± 57%  perf-profile.calltrace.cycles-pp.perf_event_output_forward.__perf_event_overflow.perf_swevent_overflow.perf_tp_event.perf_trace_sched_switch
      3.27 ± 14%      -1.0        2.24 ±  8%  perf-profile.calltrace.cycles-pp.record__finish_output.cmd_record.cmd_sched.run_builtin.main
      3.97 ± 18%      -1.0        2.95 ±  6%  perf-profile.calltrace.cycles-pp.cmd_record.cmd_sched.run_builtin.main.__libc_start_main
      3.97 ± 18%      -1.0        2.95 ±  6%  perf-profile.calltrace.cycles-pp.cmd_sched.run_builtin.main.__libc_start_main
      3.26 ± 13%      -1.0        2.24 ±  8%  perf-profile.calltrace.cycles-pp.perf_session__process_events.record__finish_output.cmd_record.cmd_sched.run_builtin
      4.36 ± 18%      -0.9        3.46 ±  5%  perf-profile.calltrace.cycles-pp.__libc_start_main
      4.36 ± 17%      -0.9        3.46 ±  5%  perf-profile.calltrace.cycles-pp.main.__libc_start_main
      4.36 ± 17%      -0.9        3.46 ±  5%  perf-profile.calltrace.cycles-pp.run_builtin.main.__libc_start_main
      1.57 ± 21%      -0.9        0.69 ± 12%  perf-profile.calltrace.cycles-pp.__ordered_events__flush.perf_session__process_user_event.process_simple.perf_session__process_events.record__finish_output
      1.57 ± 21%      -0.9        0.69 ± 12%  perf-profile.calltrace.cycles-pp.perf_session__process_user_event.process_simple.perf_session__process_events.record__finish_output.cmd_record
      1.19 ± 19%      -0.9        0.31 ±102%  perf-profile.calltrace.cycles-pp.perf_trace_sched_wakeup_template.try_to_wake_up.xlog_grant_head_wake.xfs_log_space_wake.xfs_log_ticket_ungrant
      1.14 ± 20%      -0.8        0.30 ±101%  perf-profile.calltrace.cycles-pp.perf_tp_event.perf_trace_sched_wakeup_template.try_to_wake_up.xlog_grant_head_wake.xfs_log_space_wake
      1.50 ± 21%      -0.8        0.69 ± 12%  perf-profile.calltrace.cycles-pp.perf_session__deliver_event.__ordered_events__flush.perf_session__process_user_event.process_simple.perf_session__process_events
      1.88 ±  8%      -0.8        1.10 ±  2%  perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      1.85 ±  8%      -0.8        1.08 ±  2%  perf-profile.calltrace.cycles-pp.__schedule.schedule_idle.do_idle.cpu_startup_entry.start_secondary
      1.47 ± 19%      -0.8        0.71 ± 70%  perf-profile.calltrace.cycles-pp.try_to_wake_up.xlog_grant_head_wake.xfs_log_space_wake.xfs_log_ticket_ungrant.xfs_log_commit_cil
      1.58 ± 25%      -0.8        0.83 ± 11%  perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.xlog_grant_head_wait.xlog_grant_head_check
      1.54 ± 26%      -0.7        0.81 ± 12%  perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_task_fair.__schedule.schedule.xlog_grant_head_wait
      1.53 ± 19%      -0.7        0.85 ± 41%  perf-profile.calltrace.cycles-pp.xlog_grant_head_wake.xfs_log_space_wake.xfs_log_ticket_ungrant.xfs_log_commit_cil.__xfs_trans_commit
      1.11 ± 29%      -0.7        0.45 ± 57%  perf-profile.calltrace.cycles-pp.__perf_event_overflow.perf_swevent_overflow.perf_tp_event.perf_trace_sched_stat_runtime.update_curr
      1.11 ± 29%      -0.7        0.45 ± 57%  perf-profile.calltrace.cycles-pp.perf_swevent_overflow.perf_tp_event.perf_trace_sched_stat_runtime.update_curr.dequeue_entity
      1.10 ± 29%      -0.7        0.44 ± 57%  perf-profile.calltrace.cycles-pp.perf_event_output_forward.__perf_event_overflow.perf_swevent_overflow.perf_tp_event.perf_trace_sched_stat_runtime
      1.31 ± 28%      -0.6        0.71 ±  9%  perf-profile.calltrace.cycles-pp.update_curr.dequeue_entity.dequeue_task_fair.__schedule.schedule
      1.21 ± 29%      -0.6        0.64 ±  9%  perf-profile.calltrace.cycles-pp.perf_trace_sched_stat_runtime.update_curr.dequeue_entity.dequeue_task_fair.__schedule
      1.15 ± 30%      -0.6        0.59 ±  9%  perf-profile.calltrace.cycles-pp.perf_tp_event.perf_trace_sched_stat_runtime.update_curr.dequeue_entity.dequeue_task_fair
      1.05 ± 12%      -0.6        0.49 ± 57%  perf-profile.calltrace.cycles-pp.perf_tp_event.perf_trace_sched_switch.__schedule.schedule_idle.do_idle
      0.99 ± 11%      -0.5        0.47 ± 57%  perf-profile.calltrace.cycles-pp.perf_swevent_overflow.perf_tp_event.perf_trace_sched_switch.__schedule.schedule_idle
      1.14 ± 11%      -0.5        0.66 ±  7%  perf-profile.calltrace.cycles-pp.perf_trace_sched_switch.__schedule.schedule_idle.do_idle.cpu_startup_entry
      1.03 ± 21%      -0.3        0.68 ± 12%  perf-profile.calltrace.cycles-pp.machines__deliver_event.perf_session__deliver_event.__ordered_events__flush.perf_session__process_user_event.process_simple
      0.44 ± 58%      +0.2        0.68 ± 12%  perf-profile.calltrace.cycles-pp.dso__load.map__load.thread__find_map.build_id__mark_dso_hit.machines__deliver_event
      0.43 ± 58%      +0.2        0.66 ± 12%  perf-profile.calltrace.cycles-pp.__dso__load_kallsyms.dso__load.map__load.thread__find_map.build_id__mark_dso_hit
      0.76 ±  3%      +0.3        1.08 ±  5%  perf-profile.calltrace.cycles-pp.rcu_sched_clock_irq.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues
      0.66 ±  7%      +0.4        1.02 ±  2%  perf-profile.calltrace.cycles-pp.update_sd_lb_stats.find_busiest_group.load_balance.rebalance_domains.__softirqentry_text_start
      0.93 ± 18%      +0.4        1.30 ±  7%  perf-profile.calltrace.cycles-pp.read
      0.71 ±  9%      +0.4        1.09 ±  3%  perf-profile.calltrace.cycles-pp.find_busiest_group.load_balance.rebalance_domains.__softirqentry_text_start.asm_call_sysvec_on_stack
      0.88 ± 19%      +0.4        1.27 ±  8%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
      0.86 ± 19%      +0.4        1.25 ±  9%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.84 ± 19%      +0.4        1.24 ±  9%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.86 ± 19%      +0.4        1.26 ±  9%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.81 ±  8%      +0.4        1.23 ±  4%  perf-profile.calltrace.cycles-pp.update_rq_clock.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer
      0.94 ± 10%      +0.4        1.37 ± 11%  perf-profile.calltrace.cycles-pp.update_blocked_averages.run_rebalance_domains.__softirqentry_text_start.asm_call_sysvec_on_stack.do_softirq_own_stack
      0.98 ± 11%      +0.5        1.44 ± 10%  perf-profile.calltrace.cycles-pp.run_rebalance_domains.__softirqentry_text_start.asm_call_sysvec_on_stack.do_softirq_own_stack.irq_exit_rcu
      1.11 ± 10%      +0.5        1.66 ±  5%  perf-profile.calltrace.cycles-pp.load_balance.rebalance_domains.__softirqentry_text_start.asm_call_sysvec_on_stack.do_softirq_own_stack
      0.92 ±  8%      +0.6        1.47 ±  8%  perf-profile.calltrace.cycles-pp.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.asm_call_sysvec_on_stack
      0.00            +0.6        0.55 ± 10%  perf-profile.calltrace.cycles-pp.hrtimer_get_next_event.get_next_timer_interrupt.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select
      0.45 ± 59%      +0.6        1.00 ± 11%  perf-profile.calltrace.cycles-pp.__remove_hrtimer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.asm_call_sysvec_on_stack
      0.00            +0.6        0.59 ±  9%  perf-profile.calltrace.cycles-pp.arch_cpu_idle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      0.13 ±173%      +0.6        0.73 ±  5%  perf-profile.calltrace.cycles-pp.cpuidle_governor_latency_req.menu_select.do_idle.cpu_startup_entry.start_secondary
      0.00            +0.6        0.62 ±  6%  perf-profile.calltrace.cycles-pp.timerqueue_add.enqueue_hrtimer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      1.33 ±  9%      +0.6        1.96 ±  3%  perf-profile.calltrace.cycles-pp.rebalance_domains.__softirqentry_text_start.asm_call_sysvec_on_stack.do_softirq_own_stack.irq_exit_rcu
      0.00            +0.7        0.66 ±  9%  perf-profile.calltrace.cycles-pp.update_irq_load_avg.update_rq_clock.scheduler_tick.update_process_times.tick_sched_handle
      0.13 ±173%      +0.7        0.79 ± 12%  perf-profile.calltrace.cycles-pp.timerqueue_del.__remove_hrtimer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      0.13 ±173%      +0.7        0.79 ±  6%  perf-profile.calltrace.cycles-pp.lapic_next_deadline.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.asm_call_sysvec_on_stack
      0.00            +0.7        0.69 ± 21%  perf-profile.calltrace.cycles-pp.xlog_cil_insert_items.xfs_log_commit_cil.__xfs_trans_commit.xfs_remove.xfs_vn_unlink
      0.00            +0.7        0.71 ± 10%  perf-profile.calltrace.cycles-pp.xfs_iunlink.xfs_remove.xfs_vn_unlink.vfs_unlink.do_unlinkat
      0.00            +0.7        0.73 ±  5%  perf-profile.calltrace.cycles-pp.enqueue_hrtimer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.asm_call_sysvec_on_stack
      1.22 ± 12%      +0.8        1.97 ± 13%  perf-profile.calltrace.cycles-pp.ktime_get.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.asm_call_sysvec_on_stack
      0.00            +0.8        0.80 ± 11%  perf-profile.calltrace.cycles-pp.rcu_idle_exit.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      0.00            +0.8        0.82 ± 11%  perf-profile.calltrace.cycles-pp.xfs_dir2_leafn_lookup_for_entry.xfs_da3_node_lookup_int.xfs_dir2_node_removename.xfs_dir_removename.xfs_remove
      0.00            +0.8        0.83 ± 12%  perf-profile.calltrace.cycles-pp.xfs_dir2_leafn_remove.xfs_dir2_node_removename.xfs_dir_removename.xfs_remove.xfs_vn_unlink
      0.74 ± 31%      +0.8        1.59 ± 11%  perf-profile.calltrace.cycles-pp.ktime_get.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      1.76 ±  7%      +0.9        2.65 ±  6%  perf-profile.calltrace.cycles-pp.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues
      0.00            +0.9        0.95 ± 38%  perf-profile.calltrace.cycles-pp.xfs_log_space_wake.xfs_log_ticket_ungrant.xfs_log_commit_cil.__xfs_trans_commit.xfs_remove
      0.13 ±173%      +1.0        1.09 ±  5%  perf-profile.calltrace.cycles-pp.get_next_timer_interrupt.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select.do_idle
      0.00            +1.0        0.99 ± 38%  perf-profile.calltrace.cycles-pp.xfs_log_ticket_ungrant.xfs_log_commit_cil.__xfs_trans_commit.xfs_remove.xfs_vn_unlink
      1.15 ±  8%      +1.0        2.17 ±  6%  perf-profile.calltrace.cycles-pp.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select.do_idle.cpu_startup_entry
      0.12 ±173%      +1.0        1.16 ±  4%  perf-profile.calltrace.cycles-pp.hrtimer_next_event_without.tick_nohz_get_sleep_length.menu_select.do_idle.cpu_startup_entry
      1.36 ± 19%      +1.2        2.51 ± 12%  perf-profile.calltrace.cycles-pp.ktime_get_update_offsets_now.hrtimer_interrupt.__sysvec_apic_timer_interrupt.asm_call_sysvec_on_stack.sysvec_apic_timer_interrupt
      1.83 ±  8%      +1.2        3.07 ±  9%  perf-profile.calltrace.cycles-pp.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.asm_call_sysvec_on_stack.sysvec_apic_timer_interrupt
      0.00            +1.3        1.26 ± 13%  perf-profile.calltrace.cycles-pp.xfs_da3_node_lookup_int.xfs_dir2_node_removename.xfs_dir_removename.xfs_remove.xfs_vn_unlink
      3.54 ±  7%      +1.3        4.89 ±  8%  perf-profile.calltrace.cycles-pp.__softirqentry_text_start.asm_call_sysvec_on_stack.do_softirq_own_stack.irq_exit_rcu.sysvec_apic_timer_interrupt
      3.55 ±  7%      +1.4        4.92 ±  8%  perf-profile.calltrace.cycles-pp.asm_call_sysvec_on_stack.do_softirq_own_stack.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      3.60 ±  7%      +1.4        4.99 ±  8%  perf-profile.calltrace.cycles-pp.do_softirq_own_stack.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      3.82 ± 13%      +1.5        5.29 ±  6%  perf-profile.calltrace.cycles-pp.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt
      4.11 ± 13%      +1.6        5.75 ±  5%  perf-profile.calltrace.cycles-pp.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      0.22 ±173%      +1.7        1.92 ± 14%  perf-profile.calltrace.cycles-pp.xlog_grant_head_check.xfs_log_reserve.xfs_trans_reserve.xfs_trans_alloc.xfs_remove
      4.21 ±  8%      +1.8        6.00 ±  8%  perf-profile.calltrace.cycles-pp.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.23 ±173%      +1.8        2.05 ± 12%  perf-profile.calltrace.cycles-pp.xfs_log_reserve.xfs_trans_reserve.xfs_trans_alloc.xfs_remove.xfs_vn_unlink
      1.92 ±  8%      +2.0        3.95 ±  3%  perf-profile.calltrace.cycles-pp.tick_nohz_get_sleep_length.menu_select.do_idle.cpu_startup_entry.start_secondary
      0.00            +2.2        2.22 ± 11%  perf-profile.calltrace.cycles-pp.xfs_dir2_node_removename.xfs_dir_removename.xfs_remove.xfs_vn_unlink.vfs_unlink
      0.14 ±173%      +2.2        2.37 ± 10%  perf-profile.calltrace.cycles-pp.xfs_dir_removename.xfs_remove.xfs_vn_unlink.vfs_unlink.do_unlinkat
      0.28 ±173%      +2.3        2.57 ± 12%  perf-profile.calltrace.cycles-pp.xfs_trans_reserve.xfs_trans_alloc.xfs_remove.xfs_vn_unlink.vfs_unlink
      0.28 ±173%      +2.3        2.62 ± 12%  perf-profile.calltrace.cycles-pp.xfs_trans_alloc.xfs_remove.xfs_vn_unlink.vfs_unlink.do_unlinkat
      0.64 ± 65%      +2.4        3.00 ± 29%  perf-profile.calltrace.cycles-pp.ktime_get.tick_irq_enter.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.20 ±173%      +2.4        2.57 ± 24%  perf-profile.calltrace.cycles-pp.xfs_log_commit_cil.__xfs_trans_commit.xfs_remove.xfs_vn_unlink.vfs_unlink
      0.21 ±173%      +2.5        2.75 ± 24%  perf-profile.calltrace.cycles-pp.__xfs_trans_commit.xfs_remove.xfs_vn_unlink.vfs_unlink.do_unlinkat
      1.32 ± 18%      +2.6        3.88 ± 23%  perf-profile.calltrace.cycles-pp.tick_irq_enter.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      1.46 ± 17%      +2.7        4.15 ± 21%  perf-profile.calltrace.cycles-pp.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      5.00 ±  4%      +2.8        7.76 ±  4%  perf-profile.calltrace.cycles-pp.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.asm_call_sysvec_on_stack
      4.64 ±  5%      +4.3        8.99 ±  4%  perf-profile.calltrace.cycles-pp.menu_select.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      7.55 ±  5%      +4.5       12.04 ±  2%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.asm_call_sysvec_on_stack.sysvec_apic_timer_interrupt
      3.46 ± 71%      +6.6       10.09 ± 12%  perf-profile.calltrace.cycles-pp.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
     12.01 ±  5%      +7.7       19.68 ±  3%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.asm_call_sysvec_on_stack.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      1.32 ± 78%      +7.8        9.12 ± 11%  perf-profile.calltrace.cycles-pp.xfs_remove.xfs_vn_unlink.vfs_unlink.do_unlinkat.do_syscall_64
      1.32 ± 79%      +7.8        9.14 ± 11%  perf-profile.calltrace.cycles-pp.xfs_vn_unlink.vfs_unlink.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.35 ± 79%      +7.9        9.23 ± 11%  perf-profile.calltrace.cycles-pp.vfs_unlink.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
     12.59 ±  5%      +8.1       20.70 ±  3%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.asm_call_sysvec_on_stack.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
     12.70 ±  5%      +8.2       20.87 ±  3%  perf-profile.calltrace.cycles-pp.asm_call_sysvec_on_stack.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      9.16 ±  4%      +8.9       18.02 ±  2%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
     19.68 ±  5%     +13.7       33.36 ±  3%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle
     21.31 ±  5%     +14.9       36.19 ±  3%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
     31.81 ±  3%     +25.1       56.88        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
     32.62 ±  3%     +25.1       57.71        perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     41.86 ±  2%     +29.5       71.40        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     41.93 ±  2%     +29.6       71.50        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     41.93 ±  2%     +29.6       71.50        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     42.58 ±  3%     +29.7       72.25        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     33.46 ± 15%     -32.7        0.80 ±  7%  perf-profile.children.cycles-pp.do_sys_open
     33.43 ± 15%     -32.6        0.79 ±  7%  perf-profile.children.cycles-pp.do_sys_openat2
     32.90 ± 15%     -32.2        0.69 ±  3%  perf-profile.children.cycles-pp.path_openat
     32.93 ± 15%     -32.2        0.74 ±  7%  perf-profile.children.cycles-pp.do_filp_open
     28.84 ± 16%     -28.8        0.00        perf-profile.children.cycles-pp.xfs_generic_create
     28.58 ± 16%     -28.6        0.00        perf-profile.children.cycles-pp.xfs_create
     44.72 ±  2%     -27.2       17.55 ±  7%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     43.63 ±  3%     -26.6       17.02 ±  7%  perf-profile.children.cycles-pp.do_syscall_64
     14.01 ± 21%     -14.0        0.00        perf-profile.children.cycles-pp.xfs_dir_ialloc
     11.13 ± 27%     -11.1        0.00        perf-profile.children.cycles-pp.xfs_dialloc_ag
     11.07 ± 27%     -10.9        0.22 ± 33%  perf-profile.children.cycles-pp.xfs_check_agi_freecount
      6.64 ± 29%      -6.5        0.15 ± 22%  perf-profile.children.cycles-pp.xfs_inobt_get_rec
      7.06 ± 10%      -4.4        2.67 ± 12%  perf-profile.children.cycles-pp.xfs_trans_alloc
      6.97 ± 10%      -4.4        2.61 ± 12%  perf-profile.children.cycles-pp.xfs_trans_reserve
      4.38 ± 27%      -4.3        0.08 ± 64%  perf-profile.children.cycles-pp.xfs_btree_check_sblock
      6.47 ±  8%      -3.7        2.82 ± 23%  perf-profile.children.cycles-pp.__xfs_trans_commit
      6.24 ±  9%      -3.6        2.66 ± 24%  perf-profile.children.cycles-pp.xfs_log_commit_cil
      3.55 ± 31%      -3.5        0.04 ±115%  perf-profile.children.cycles-pp.xfs_btree_increment
      3.50 ± 28%      -3.4        0.08 ± 62%  perf-profile.children.cycles-pp.xfs_btree_get_rec
      7.24 ±  8%      -3.4        3.83 ± 11%  perf-profile.children.cycles-pp.perf_tp_event
      6.95 ±  7%      -3.3        3.65 ± 11%  perf-profile.children.cycles-pp.perf_swevent_overflow
      6.91 ±  7%      -3.3        3.63 ± 11%  perf-profile.children.cycles-pp.__perf_event_overflow
      7.96 ±  8%      -3.3        4.69 ±  7%  perf-profile.children.cycles-pp.__schedule
      6.83 ±  7%      -3.2        3.60 ± 11%  perf-profile.children.cycles-pp.perf_event_output_forward
      2.90 ± 27%      -2.8        0.06 ± 58%  perf-profile.children.cycles-pp.__xfs_btree_check_sblock
      4.92 ± 11%      -2.8        2.09 ± 12%  perf-profile.children.cycles-pp.xfs_log_reserve
      5.83 ±  7%      -2.7        3.10 ± 12%  perf-profile.children.cycles-pp.perf_prepare_sample
      4.61 ± 11%      -2.7        1.95 ± 14%  perf-profile.children.cycles-pp.xlog_grant_head_check
      5.32 ±  7%      -2.6        2.76 ± 11%  perf-profile.children.cycles-pp.perf_callchain
      5.26 ±  7%      -2.5        2.74 ± 11%  perf-profile.children.cycles-pp.get_perf_callchain
      5.99 ±  9%      -2.5        3.50 ±  8%  perf-profile.children.cycles-pp.schedule
      4.28 ± 10%      -2.4        1.86 ± 15%  perf-profile.children.cycles-pp.xlog_grant_head_wait
      4.87 ±  8%      -2.4        2.50 ± 12%  perf-profile.children.cycles-pp.perf_callchain_kernel
      2.59 ± 16%      -2.1        0.47 ± 33%  perf-profile.children.cycles-pp.__percpu_counter_compare
      2.57 ± 16%      -2.1        0.46 ± 32%  perf-profile.children.cycles-pp.__percpu_counter_sum
      3.53 ±  9%      -1.7        1.85 ± 13%  perf-profile.children.cycles-pp.unwind_next_frame
      2.04 ± 15%      -1.5        0.50 ± 28%  perf-profile.children.cycles-pp.xfs_mod_fdblocks
      2.33 ± 12%      -1.4        0.89 ±  4%  perf-profile.children.cycles-pp.xfs_trans_read_buf_map
      3.11 ± 10%      -1.4        1.70 ±  8%  perf-profile.children.cycles-pp.update_curr
      3.09 ± 14%      -1.4        1.72 ± 10%  perf-profile.children.cycles-pp.process_simple
      2.82 ± 11%      -1.3        1.50 ±  8%  perf-profile.children.cycles-pp.perf_trace_sched_stat_runtime
      2.71 ±  7%      -1.3        1.44 ± 12%  perf-profile.children.cycles-pp.perf_trace_sched_switch
      1.58 ± 18%      -1.2        0.37 ± 52%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      2.65 ± 11%      -1.2        1.48 ±  7%  perf-profile.children.cycles-pp.dequeue_task_fair
      2.58 ± 11%      -1.1        1.45 ±  7%  perf-profile.children.cycles-pp.dequeue_entity
      2.12 ±  8%      -1.1        1.00 ± 37%  perf-profile.children.cycles-pp.xfs_log_ticket_ungrant
      1.75 ± 16%      -1.1        0.64 ±  5%  perf-profile.children.cycles-pp.xfs_buf_read_map
      1.65 ± 16%      -1.1        0.57 ±  6%  perf-profile.children.cycles-pp.xfs_buf_get_map
      2.03 ±  8%      -1.1        0.96 ± 38%  perf-profile.children.cycles-pp.xfs_log_space_wake
      3.27 ± 14%      -1.0        2.24 ±  8%  perf-profile.children.cycles-pp.record__finish_output
      3.97 ± 18%      -1.0        2.95 ±  6%  perf-profile.children.cycles-pp.cmd_sched
      3.26 ± 13%      -1.0        2.24 ±  8%  perf-profile.children.cycles-pp.perf_session__process_events
      3.98 ± 18%      -1.0        2.96 ±  6%  perf-profile.children.cycles-pp.cmd_record
      2.73 ±  5%      -1.0        1.74 ± 24%  perf-profile.children.cycles-pp.try_to_wake_up
      1.88 ±  6%      -1.0        0.89 ± 40%  perf-profile.children.cycles-pp.xlog_grant_head_wake
      2.03 ±  7%      -1.0        1.05 ± 17%  perf-profile.children.cycles-pp.perf_trace_sched_wakeup_template
      1.47 ± 18%      -1.0        0.51 ±  6%  perf-profile.children.cycles-pp.xfs_buf_find
      4.36 ± 18%      -0.9        3.46 ±  5%  perf-profile.children.cycles-pp.__libc_start_main
      4.36 ± 17%      -0.9        3.46 ±  5%  perf-profile.children.cycles-pp.main
      4.36 ± 17%      -0.9        3.46 ±  5%  perf-profile.children.cycles-pp.run_builtin
      1.57 ± 21%      -0.9        0.69 ± 12%  perf-profile.children.cycles-pp.perf_session__process_user_event
      1.58 ±  9%      -0.9        0.71 ± 22%  perf-profile.children.cycles-pp.xlog_cil_insert_items
      1.15 ± 32%      -0.9        0.30 ± 13%  perf-profile.children.cycles-pp.xfs_read_agi
      0.96 ± 18%      -0.8        0.14 ± 23%  perf-profile.children.cycles-pp.xfs_errortag_test
      1.33 ±  8%      -0.8        0.52 ± 20%  perf-profile.children.cycles-pp.kmem_cache_alloc
      1.92 ±  8%      -0.8        1.11 ±  3%  perf-profile.children.cycles-pp.schedule_idle
      0.93 ± 22%      -0.8        0.15 ± 15%  perf-profile.children.cycles-pp.xfs_next_bit
      1.46 ±  5%      -0.8        0.70 ± 10%  perf-profile.children.cycles-pp.__orc_find
      1.34 ± 41%      -0.7        0.68 ± 20%  perf-profile.children.cycles-pp.ksys_write
      1.18 ±  9%      -0.7        0.53 ±  8%  perf-profile.children.cycles-pp.orc_find
      1.32 ± 42%      -0.7        0.67 ± 20%  perf-profile.children.cycles-pp.vfs_write
      1.60 ±  7%      -0.6        0.99 ± 11%  perf-profile.children.cycles-pp.__unwind_start
      0.77 ± 40%      -0.6        0.17 ± 16%  perf-profile.children.cycles-pp.xfs_buf_lock
      0.76 ± 40%      -0.6        0.17 ± 16%  perf-profile.children.cycles-pp.down
      0.75 ± 41%      -0.6        0.17 ± 16%  perf-profile.children.cycles-pp.__down
      0.83 ± 24%      -0.6        0.24 ± 10%  perf-profile.children.cycles-pp.xfs_agino_range
      0.92 ± 31%      -0.6        0.35 ± 29%  perf-profile.children.cycles-pp.schedule_timeout
      1.08 ± 14%      -0.6        0.53 ±  6%  perf-profile.children.cycles-pp.xfs_da_read_buf
      1.03 ± 15%      -0.5        0.50 ± 11%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      1.15 ± 35%      -0.5        0.64 ± 18%  perf-profile.children.cycles-pp.new_sync_write
      0.98 ± 16%      -0.5        0.48 ±  8%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.91 ± 13%      -0.5        0.43 ± 18%  perf-profile.children.cycles-pp.task_tick_fair
      0.83 ±  7%      -0.5        0.35 ± 12%  perf-profile.children.cycles-pp.unwind_get_return_address
      1.63 ± 21%      -0.5        1.15 ±  7%  perf-profile.children.cycles-pp.__ordered_events__flush
      0.77 ± 33%      -0.5        0.30 ±  2%  perf-profile.children.cycles-pp.queue_event
      1.61 ± 14%      -0.5        1.15 ± 11%  perf-profile.children.cycles-pp._raw_spin_lock
      0.83 ± 33%      -0.5        0.37 ±  8%  perf-profile.children.cycles-pp.ordered_events__queue
      0.82 ± 15%      -0.5        0.36 ±  9%  perf-profile.children.cycles-pp.task_work_run
      0.75 ±  5%      -0.5        0.30 ± 11%  perf-profile.children.cycles-pp.__kernel_text_address
      1.62 ±  9%      -0.4        1.18 ±  8%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.67 ±  5%      -0.4        0.25 ± 17%  perf-profile.children.cycles-pp.kernel_text_address
      0.70 ± 14%      -0.4        0.31 ± 11%  perf-profile.children.cycles-pp.sched_ttwu_pending
      1.38 ±  8%      -0.4        1.00 ±  2%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.70 ± 15%      -0.4        0.33 ± 23%  perf-profile.children.cycles-pp.xfs_buf_item_format
      0.61 ± 15%      -0.4        0.26 ±  5%  perf-profile.children.cycles-pp.__libc_write
      0.67 ± 13%      -0.4        0.31 ± 14%  perf-profile.children.cycles-pp.__fput
      0.74 ± 10%      -0.3        0.39 ± 14%  perf-profile.children.cycles-pp.perf_output_sample
      0.79 ± 13%      -0.3        0.45 ±  8%  perf-profile.children.cycles-pp.flush_smp_call_function_from_idle
      0.49 ±  9%      -0.3        0.18 ± 23%  perf-profile.children.cycles-pp.xfs_buf_item_release
      0.56 ±  9%      -0.3        0.26 ±  5%  perf-profile.children.cycles-pp.generic_file_write_iter
      0.56 ±  9%      -0.3        0.26 ±  5%  perf-profile.children.cycles-pp.__generic_file_write_iter
      0.55 ±  7%      -0.3        0.24 ±  6%  perf-profile.children.cycles-pp.generic_perform_write
      0.74 ± 24%      -0.3        0.45 ± 20%  perf-profile.children.cycles-pp.memcpy_erms
      0.39 ± 20%      -0.3        0.10 ± 46%  perf-profile.children.cycles-pp.xfs_buf_unlock
      1.21 ± 14%      -0.3        0.92 ±  3%  perf-profile.children.cycles-pp.newidle_balance
      0.39 ± 11%      -0.3        0.11 ± 28%  perf-profile.children.cycles-pp.alloc_empty_file
      0.56 ± 25%      -0.3        0.28 ± 19%  perf-profile.children.cycles-pp.kmem_cache_free
      0.36 ± 10%      -0.3        0.10 ± 33%  perf-profile.children.cycles-pp.__alloc_file
      0.45 ± 13%      -0.3        0.19 ± 18%  perf-profile.children.cycles-pp.xfs_inode_item_format
      0.34 ± 22%      -0.3        0.08 ± 37%  perf-profile.children.cycles-pp.do_dentry_open
      0.44 ±  9%      -0.3        0.18 ± 30%  perf-profile.children.cycles-pp.dput
      0.32 ± 18%      -0.3        0.06 ± 71%  perf-profile.children.cycles-pp.up
      0.35 ± 19%      -0.3        0.10 ± 23%  perf-profile.children.cycles-pp.xfs_ag_block_count
      0.53 ± 12%      -0.2        0.29 ±  3%  perf-profile.children.cycles-pp.xfs_dir3_leaf_check_int
      0.46 ± 37%      -0.2        0.23 ± 15%  perf-profile.children.cycles-pp.finish_task_switch
      0.64 ± 11%      -0.2        0.41 ± 24%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.62 ± 11%      -0.2        0.39 ± 22%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.33 ± 10%      -0.2        0.11 ± 57%  perf-profile.children.cycles-pp.d_alloc_parallel
      0.34 ± 16%      -0.2        0.13 ± 18%  perf-profile.children.cycles-pp.shmem_getpage_gfp
      0.37 ± 17%      -0.2        0.16 ± 13%  perf-profile.children.cycles-pp._xfs_trans_bjoin
      0.27 ± 11%      -0.2        0.07 ±104%  perf-profile.children.cycles-pp.d_alloc
      0.37 ± 15%      -0.2        0.18 ± 10%  perf-profile.children.cycles-pp.xfs_dabuf_map
      0.30 ± 10%      -0.2        0.11 ± 31%  perf-profile.children.cycles-pp.is_module_text_address
      0.76 ± 12%      -0.2        0.57 ± 23%  perf-profile.children.cycles-pp.update_load_avg
      0.29 ±  7%      -0.2        0.11 ± 13%  perf-profile.children.cycles-pp.shmem_write_begin
      0.29 ± 17%      -0.2        0.11 ± 30%  perf-profile.children.cycles-pp.xfs_inode_item_format_data_fork
      0.32 ± 17%      -0.2        0.14 ± 41%  perf-profile.children.cycles-pp.__module_address
      0.27 ± 13%      -0.2        0.09 ± 79%  perf-profile.children.cycles-pp.__d_alloc
      0.53 ±  9%      -0.2        0.36 ± 26%  perf-profile.children.cycles-pp.enqueue_entity
      0.32 ± 15%      -0.2        0.15 ± 29%  perf-profile.children.cycles-pp.xfs_buf_item_size
      0.29 ± 14%      -0.2        0.13 ± 34%  perf-profile.children.cycles-pp.xfs_buf_item_size_segment
      0.29 ± 16%      -0.2        0.12 ± 23%  perf-profile.children.cycles-pp.cpumask_next
      0.21 ± 10%      -0.2        0.05 ±100%  perf-profile.children.cycles-pp.xfs_perag_get
      0.26 ±  7%      -0.2        0.10 ± 36%  perf-profile.children.cycles-pp.___slab_alloc
      0.24 ± 29%      -0.2        0.09 ± 21%  perf-profile.children.cycles-pp.evsel__parse_sample
      0.37 ± 14%      -0.2        0.21 ± 10%  perf-profile.children.cycles-pp.getname_flags
      0.38 ± 14%      -0.2        0.22 ± 19%  perf-profile.children.cycles-pp.perf_output_copy
      0.27 ±  6%      -0.2        0.11 ± 35%  perf-profile.children.cycles-pp.__slab_alloc
      0.22 ± 16%      -0.2        0.07 ± 71%  perf-profile.children.cycles-pp.evlist__parse_sample
      0.33 ± 11%      -0.1        0.18 ± 23%  perf-profile.children.cycles-pp.___might_sleep
      0.39 ± 12%      -0.1        0.24 ± 22%  perf-profile.children.cycles-pp.__alloc_pages_nodemask
      0.23 ± 19%      -0.1        0.09 ± 38%  perf-profile.children.cycles-pp.xfs_iextents_copy
      0.25 ± 13%      -0.1        0.11 ± 30%  perf-profile.children.cycles-pp.__module_text_address
      0.27 ± 16%      -0.1        0.13 ± 14%  perf-profile.children.cycles-pp.strncpy_from_user
      0.91 ± 11%      -0.1        0.78 ± 10%  perf-profile.children.cycles-pp.link_path_walk
      0.27 ± 22%      -0.1        0.14 ± 16%  perf-profile.children.cycles-pp.xfs_bmapi_read
      0.30 ± 13%      -0.1        0.17 ± 34%  perf-profile.children.cycles-pp.stack_access_ok
      0.15 ± 18%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.__x64_sys_close
      0.15 ± 30%      -0.1        0.04 ±107%  perf-profile.children.cycles-pp.get_obj_cgroup_from_current
      0.14 ± 19%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.xfs_trans_ijoin
      0.30 ± 16%      -0.1        0.19 ± 24%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.14 ±  9%      -0.1        0.03 ±102%  perf-profile.children.cycles-pp.xfs_trans_log_buf
      0.15 ±  7%      -0.1        0.04 ±102%  perf-profile.children.cycles-pp.__radix_tree_lookup
      0.14 ± 23%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.shmem_alloc_and_acct_page
      0.33 ±  3%      -0.1        0.22 ± 28%  perf-profile.children.cycles-pp.kmem_alloc
      0.48 ±  9%      -0.1        0.38 ± 12%  perf-profile.children.cycles-pp.xfs_trans_log_inode
      0.19 ±  5%      -0.1        0.08 ± 15%  perf-profile.children.cycles-pp.xfs_bmap_last_offset
      0.23 ± 14%      -0.1        0.12 ±  4%  perf-profile.children.cycles-pp.perf_callchain_user
      0.20 ± 15%      -0.1        0.10 ± 34%  perf-profile.children.cycles-pp.xfs_buf_rele
      0.17 ± 16%      -0.1        0.06 ± 59%  perf-profile.children.cycles-pp.__list_add_valid
      0.13 ± 17%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.memset_erms
      0.17 ± 12%      -0.1        0.07 ± 20%  perf-profile.children.cycles-pp.xfs_dir2_isblock
      0.27 ± 16%      -0.1        0.18 ± 32%  perf-profile.children.cycles-pp.__perf_event_header__init_id
      0.13 ± 19%      -0.1        0.04 ± 58%  perf-profile.children.cycles-pp.perf_output_begin_forward
      0.11 ± 13%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.pagecache_get_page
      0.27 ± 21%      -0.1        0.18 ±  8%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.15 ± 22%      -0.1        0.06 ± 67%  perf-profile.children.cycles-pp.perf_event_pid_type
      0.14 ± 12%      -0.1        0.05 ±103%  perf-profile.children.cycles-pp.xfs_buf_ioend
      0.17 ± 17%      -0.1        0.09 ± 58%  perf-profile.children.cycles-pp.xfs_iflush_cluster
      0.14 ± 35%      -0.1        0.05 ± 63%  perf-profile.children.cycles-pp.machine__findnew_thread
      0.12 ± 25%      -0.1        0.04 ±107%  perf-profile.children.cycles-pp.perf_trace_buf_alloc
      0.14 ±  5%      -0.1        0.06 ± 13%  perf-profile.children.cycles-pp.xfs_bmap_last_extent
      0.18 ± 18%      -0.1        0.10 ± 22%  perf-profile.children.cycles-pp.obj_cgroup_charge
      0.11 ± 17%      -0.1        0.03 ±105%  perf-profile.children.cycles-pp.xfs_buf_inode_iodone
      0.18 ± 31%      -0.1        0.11 ± 43%  perf-profile.children.cycles-pp.__check_object_size
      0.11 ±  8%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.update_cfs_group
      0.20 ±  9%      -0.1        0.13 ± 21%  perf-profile.children.cycles-pp.__might_sleep
      0.11 ± 17%      -0.1        0.04 ±102%  perf-profile.children.cycles-pp.down_trylock
      0.10 ± 32%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.evlist__parse_sample_timestamp
      0.16 ±  9%      -0.1        0.09 ± 17%  perf-profile.children.cycles-pp.__get_user_nocheck_1
      0.12 ± 29%      -0.1        0.06 ± 59%  perf-profile.children.cycles-pp.__x64_sys_poll
      0.12 ± 29%      -0.1        0.06 ± 59%  perf-profile.children.cycles-pp.do_sys_poll
      0.11 ± 22%      -0.1        0.04 ±100%  perf-profile.children.cycles-pp.xfs_ilock
      0.12 ± 19%      -0.1        0.05 ± 63%  perf-profile.children.cycles-pp.xfs_buf_trylock
      0.16 ±  9%      -0.1        0.09 ± 14%  perf-profile.children.cycles-pp.iov_iter_fault_in_readable
      0.13 ± 24%      -0.1        0.07 ± 21%  perf-profile.children.cycles-pp.xfs_trans_add_item
      0.18 ± 20%      -0.1        0.11 ± 20%  perf-profile.children.cycles-pp.__d_lookup_rcu
      0.15 ± 16%      -0.1        0.09 ± 21%  perf-profile.children.cycles-pp.xfs_buf_item_init
      0.13 ± 25%      -0.1        0.07 ± 12%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.14 ±  8%      -0.1        0.07 ± 65%  perf-profile.children.cycles-pp.rmqueue
      0.11 ± 18%      -0.1        0.05 ± 58%  perf-profile.children.cycles-pp.get_stack_info
      0.11 ± 20%      -0.1        0.05 ± 60%  perf-profile.children.cycles-pp.unlazy_walk
      0.11 ± 15%      -0.1        0.05 ± 59%  perf-profile.children.cycles-pp.xfs_buf_item_log
      0.13 ± 29%      -0.1        0.07 ± 20%  perf-profile.children.cycles-pp.__poll
      0.14 ±  8%      -0.1        0.08 ± 15%  perf-profile.children.cycles-pp.path_init
      0.11 ± 28%      -0.1        0.06 ± 60%  perf-profile.children.cycles-pp.call_rcu
      0.16 ± 11%      -0.1        0.11 ±  7%  perf-profile.children.cycles-pp.xfs_dir3_data_read
      0.15 ±  7%      -0.1        0.10 ± 30%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.26 ±  4%      -0.0        0.21 ± 12%  perf-profile.children.cycles-pp._cond_resched
      0.11 ± 11%      -0.0        0.08 ± 16%  perf-profile.children.cycles-pp.tlb_finish_mmu
      0.06 ± 28%      +0.0        0.08 ± 21%  perf-profile.children.cycles-pp.machine__exit
      0.06 ± 28%      +0.0        0.08 ± 21%  perf-profile.children.cycles-pp.dso__delete
      0.08 ± 10%      +0.0        0.11 ± 17%  perf-profile.children.cycles-pp.arch_scale_freq_tick
      0.06 ± 11%      +0.0        0.09 ± 20%  perf-profile.children.cycles-pp.rcu_needs_cpu
      0.10 ± 14%      +0.0        0.13 ± 14%  perf-profile.children.cycles-pp.local_touch_nmi
      0.09 ± 16%      +0.0        0.13 ± 12%  perf-profile.children.cycles-pp.cpuidle_get_cpu_driver
      0.03 ±100%      +0.0        0.07 ± 12%  perf-profile.children.cycles-pp.symbols__delete
      0.13 ± 17%      +0.0        0.17 ± 11%  perf-profile.children.cycles-pp.__open64
      0.07 ± 17%      +0.0        0.11 ± 20%  perf-profile.children.cycles-pp.update_group_capacity
      0.07 ± 26%      +0.0        0.12 ± 22%  perf-profile.children.cycles-pp.flush_end_io
      0.01 ±173%      +0.0        0.06 ±  7%  perf-profile.children.cycles-pp.rcu_dynticks_task_enter
      0.12 ± 26%      +0.0        0.17 ±  6%  perf-profile.children.cycles-pp.profile_tick
      0.13 ± 22%      +0.0        0.18 ± 16%  perf-profile.children.cycles-pp.write_cache
      0.11 ± 14%      +0.0        0.15 ± 10%  perf-profile.children.cycles-pp.cpu_cache_level__read
      0.07 ± 61%      +0.0        0.12 ± 11%  perf-profile.children.cycles-pp.cpuidle_not_available
      0.06 ± 20%      +0.1        0.11 ± 17%  perf-profile.children.cycles-pp.rcu_irq_exit
      0.03 ±102%      +0.1        0.09 ± 24%  perf-profile.children.cycles-pp.evsel__read_counter
      0.07 ± 62%      +0.1        0.13 ± 12%  perf-profile.children.cycles-pp.balance_fair
      0.07 ± 62%      +0.1        0.12 ± 23%  perf-profile.children.cycles-pp.rcu_idle_enter
      0.08 ± 10%      +0.1        0.14 ± 30%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.12 ± 26%      +0.1        0.19 ± 11%  perf-profile.children.cycles-pp.tick_nohz_tick_stopped
      0.06 ± 63%      +0.1        0.12 ± 22%  perf-profile.children.cycles-pp.blk_mq_trigger_softirq
      0.10 ±  4%      +0.1        0.16 ± 13%  perf-profile.children.cycles-pp.raise_softirq
      0.06 ± 17%      +0.1        0.12 ± 22%  perf-profile.children.cycles-pp.iomap_finish_ioend
      0.03 ±102%      +0.1        0.09 ± 26%  perf-profile.children.cycles-pp.slab_show
      0.10 ± 30%      +0.1        0.16 ± 20%  perf-profile.children.cycles-pp.tick_program_event
      0.07 ± 21%      +0.1        0.13 ± 28%  perf-profile.children.cycles-pp.rcu_is_cpu_rrupt_from_idle
      0.04 ± 58%      +0.1        0.11 ± 24%  perf-profile.children.cycles-pp.end_page_writeback
      0.06 ± 59%      +0.1        0.12 ± 25%  perf-profile.children.cycles-pp.rcu_segcblist_ready_cbs
      0.00            +0.1        0.07 ± 16%  perf-profile.children.cycles-pp.xfs_iunlink_update_dinode
      0.05 ± 67%      +0.1        0.13 ± 19%  perf-profile.children.cycles-pp.sched_idle_set_state
      0.24 ± 14%      +0.1        0.32 ± 13%  perf-profile.children.cycles-pp.rb_insert_color
      0.12 ± 28%      +0.1        0.20 ± 19%  perf-profile.children.cycles-pp.blk_update_request
      0.21 ± 20%      +0.1        0.28 ± 13%  perf-profile.children.cycles-pp.trigger_load_balance
      0.11 ± 16%      +0.1        0.19 ± 16%  perf-profile.children.cycles-pp.call_cpuidle
      0.02 ±173%      +0.1        0.10 ± 10%  perf-profile.children.cycles-pp.evict
      0.01 ±173%      +0.1        0.09 ± 20%  perf-profile.children.cycles-pp.__x86_retpoline_rbx
      0.11 ±  7%      +0.1        0.20 ± 19%  perf-profile.children.cycles-pp.sched_clock_idle_wakeup_event
      0.03 ±102%      +0.1        0.11 ± 11%  perf-profile.children.cycles-pp.iomap_submit_ioend
      0.00            +0.1        0.08 ± 24%  perf-profile.children.cycles-pp.cpuidle_select
      0.13 ± 15%      +0.1        0.21 ± 11%  perf-profile.children.cycles-pp.cpu_latency_qos_limit
      0.00            +0.1        0.09 ± 44%  perf-profile.children.cycles-pp.xfs_inode_set_inactive_tag
      0.00            +0.1        0.09 ± 24%  perf-profile.children.cycles-pp.find_idlest_group
      0.07 ± 26%      +0.1        0.16 ± 17%  perf-profile.children.cycles-pp.irq_work_tick
      0.11 ± 17%      +0.1        0.20 ± 20%  perf-profile.children.cycles-pp.rcu_nmi_exit
      0.13 ± 17%      +0.1        0.22 ± 16%  perf-profile.children.cycles-pp.update_rt_rq_load_avg
      0.09 ± 17%      +0.1        0.18 ± 14%  perf-profile.children.cycles-pp.tick_check_broadcast_expired
      0.00            +0.1        0.10 ± 41%  perf-profile.children.cycles-pp.xfs_lock_two_inodes
      0.09 ± 19%      +0.1        0.19 ± 14%  perf-profile.children.cycles-pp.rcu_dynticks_eqs_enter
      0.14 ± 25%      +0.1        0.24 ± 22%  perf-profile.children.cycles-pp.timekeeping_max_deferment
      0.10 ± 25%      +0.1        0.20 ± 11%  perf-profile.children.cycles-pp.tick_nohz_idle_got_tick
      0.07 ± 11%      +0.1        0.17 ± 23%  perf-profile.children.cycles-pp.restore_regs_and_return_to_kernel
      0.23 ± 22%      +0.1        0.33 ± 21%  perf-profile.children.cycles-pp.update_ts_time_stats
      0.22 ± 14%      +0.1        0.32 ±  2%  perf-profile.children.cycles-pp.run_posix_cpu_timers
      0.17 ± 21%      +0.1        0.28 ± 13%  perf-profile.children.cycles-pp.can_stop_idle_tick
      0.11 ± 22%      +0.1        0.22 ± 11%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
      0.26 ± 13%      +0.1        0.37 ±  5%  perf-profile.children.cycles-pp.cpumask_next_and
      0.10 ± 18%      +0.1        0.21 ± 25%  perf-profile.children.cycles-pp.__xfs_buf_submit
      0.09 ± 18%      +0.1        0.20 ± 11%  perf-profile.children.cycles-pp.irq_work_needs_cpu
      0.39 ±  8%      +0.1        0.50 ±  4%  perf-profile.children.cycles-pp.cmd_stat
      0.39 ±  8%      +0.1        0.50 ±  4%  perf-profile.children.cycles-pp.__run_perf_stat
      0.39 ±  8%      +0.1        0.50 ±  4%  perf-profile.children.cycles-pp.dispatch_events
      0.38 ±  7%      +0.1        0.50 ±  4%  perf-profile.children.cycles-pp.process_interval
      0.10 ± 25%      +0.1        0.22 ±  8%  perf-profile.children.cycles-pp.x86_pmu_disable
      0.38 ±  7%      +0.1        0.50 ±  4%  perf-profile.children.cycles-pp.read_counters
      0.15 ± 20%      +0.1        0.28 ± 21%  perf-profile.children.cycles-pp.scsi_io_completion
      0.08 ± 10%      +0.1        0.21 ± 26%  perf-profile.children.cycles-pp._xfs_buf_ioapply
      0.03 ±100%      +0.1        0.15 ± 48%  perf-profile.children.cycles-pp.handle_edge_irq
      0.00            +0.1        0.12 ± 17%  perf-profile.children.cycles-pp.__x64_sys_unlink
      0.15 ± 21%      +0.1        0.28 ± 21%  perf-profile.children.cycles-pp.scsi_end_request
      0.38 ± 10%      +0.1        0.51 ± 17%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.10 ± 19%      +0.1        0.23 ± 22%  perf-profile.children.cycles-pp.xfs_buf_delwri_submit_buffers
      0.29 ± 26%      +0.1        0.43 ±  9%  perf-profile.children.cycles-pp.blk_done_softirq
      0.54 ± 17%      +0.1        0.68 ± 12%  perf-profile.children.cycles-pp.dso__load
      0.46 ±  4%      +0.1        0.59 ± 10%  perf-profile.children.cycles-pp.idle_cpu
      0.18 ±  9%      +0.1        0.31 ± 18%  perf-profile.children.cycles-pp.nr_iowait_cpu
      0.53 ± 16%      +0.1        0.67 ± 13%  perf-profile.children.cycles-pp.__dso__load_kallsyms
      0.16 ± 17%      +0.1        0.30 ± 11%  perf-profile.children.cycles-pp.rcu_nmi_enter
      0.17 ± 13%      +0.1        0.32 ±  9%  perf-profile.children.cycles-pp.irqentry_exit
      0.22 ± 33%      +0.1        0.36 ± 18%  perf-profile.children.cycles-pp.xfs_verify_ino
      0.47 ±  2%      +0.2        0.64 ± 11%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.32 ± 17%      +0.2        0.49 ±  8%  perf-profile.children.cycles-pp.__hrtimer_get_next_event
      0.03 ±173%      +0.2        0.22 ±  8%  perf-profile.children.cycles-pp.xfs_iunlink_update_inode
      0.32 ±  9%      +0.2        0.52 ±  8%  perf-profile.children.cycles-pp.tsc_verify_tsc_adjust
      0.36 ± 17%      +0.2        0.56 ± 14%  perf-profile.children.cycles-pp.tick_nohz_irq_exit
      0.27 ±  9%      +0.2        0.48 ± 11%  perf-profile.children.cycles-pp.menu_reflect
      0.55 ± 14%      +0.2        0.76 ±  9%  perf-profile.children.cycles-pp.update_irq_load_avg
      1.61 ±  9%      +0.2        1.82        perf-profile.children.cycles-pp.update_sd_lb_stats
      1.68 ±  7%      +0.2        1.89        perf-profile.children.cycles-pp.find_busiest_group
      0.38 ±  5%      +0.2        0.61 ±  8%  perf-profile.children.cycles-pp.arch_cpu_idle_enter
      0.29 ± 10%      +0.2        0.52 ± 14%  perf-profile.children.cycles-pp.rb_erase
      0.34 ± 41%      +0.2        0.57 ± 15%  perf-profile.children.cycles-pp.xfs_dir_ino_validate
      0.12 ± 71%      +0.2        0.36 ± 22%  perf-profile.children.cycles-pp.asm_common_interrupt
      0.12 ± 71%      +0.2        0.36 ± 22%  perf-profile.children.cycles-pp.common_interrupt
      0.28 ±  3%      +0.2        0.52 ±  8%  perf-profile.children.cycles-pp.rcu_eqs_enter
      0.23            +0.2        0.48 ± 16%  perf-profile.children.cycles-pp.rcu_eqs_exit
      0.51            +0.3        0.77 ±  5%  perf-profile.children.cycles-pp.cpuidle_governor_latency_req
      0.06 ±100%      +0.3        0.32 ± 20%  perf-profile.children.cycles-pp.path_parentat
      0.40 ± 11%      +0.3        0.66 ±  9%  perf-profile.children.cycles-pp.timerqueue_add
      0.29 ± 11%      +0.3        0.57 ±  4%  perf-profile.children.cycles-pp.irqentry_enter
      0.30 ±  7%      +0.3        0.59 ±  7%  perf-profile.children.cycles-pp.native_apic_msr_eoi_write
      0.06 ±100%      +0.3        0.34 ± 22%  perf-profile.children.cycles-pp.filename_parentat
      0.47 ±  7%      +0.3        0.76 ±  7%  perf-profile.children.cycles-pp.enqueue_hrtimer
      0.85 ±  3%      +0.3        1.15 ±  5%  perf-profile.children.cycles-pp.rcu_sched_clock_irq
      0.13 ± 28%      +0.3        0.44 ± 55%  perf-profile.children.cycles-pp.blk_mq_submit_bio
      2.19 ±  4%      +0.3        2.51 ±  2%  perf-profile.children.cycles-pp.load_balance
      0.00            +0.3        0.32 ± 39%  perf-profile.children.cycles-pp.xfs_inactive_inode
      0.00            +0.3        0.33 ± 39%  perf-profile.children.cycles-pp.xfs_inactive_worker
      0.00            +0.3        0.33 ± 39%  perf-profile.children.cycles-pp.xfs_inode_walk
      0.00            +0.3        0.33 ± 39%  perf-profile.children.cycles-pp.xfs_inode_walk_ag
      0.49 ± 13%      +0.3        0.82 ±  5%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.15 ± 32%      +0.3        0.48 ± 52%  perf-profile.children.cycles-pp.submit_bio_noacct
      0.15 ± 30%      +0.3        0.49 ± 52%  perf-profile.children.cycles-pp.submit_bio
      0.94 ± 22%      +0.3        1.28 ± 10%  perf-profile.children.cycles-pp.seq_read
      0.03 ±173%      +0.3        0.37 ± 14%  perf-profile.children.cycles-pp.xfs_droplink
      0.68 ± 15%      +0.4        1.04 ± 12%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.20 ± 19%      +0.4        0.57 ± 11%  perf-profile.children.cycles-pp.hrtimer_get_next_event
      0.93 ± 19%      +0.4        1.30 ±  7%  perf-profile.children.cycles-pp.read
      0.77 ± 15%      +0.4        1.14 ± 12%  perf-profile.children.cycles-pp.asm_sysvec_irq_work
      0.77 ± 15%      +0.4        1.14 ± 12%  perf-profile.children.cycles-pp.sysvec_irq_work
      0.77 ± 15%      +0.4        1.14 ± 12%  perf-profile.children.cycles-pp.__sysvec_irq_work
      0.77 ± 15%      +0.4        1.14 ± 12%  perf-profile.children.cycles-pp.irq_work_run
      0.77 ± 15%      +0.4        1.14 ± 12%  perf-profile.children.cycles-pp.irq_work_single
      0.50 ± 17%      +0.4        0.88 ±  9%  perf-profile.children.cycles-pp.timerqueue_del
      1.11 ± 10%      +0.4        1.49 ±  3%  perf-profile.children.cycles-pp.update_rq_clock
      0.43 ±  7%      +0.4        0.82 ± 11%  perf-profile.children.cycles-pp.rcu_idle_exit
      1.01 ± 22%      +0.4        1.41 ±  6%  perf-profile.children.cycles-pp.seq_read_iter
      1.04 ± 10%      +0.4        1.44 ±  9%  perf-profile.children.cycles-pp.update_blocked_averages
      0.94 ± 13%      +0.4        1.34 ±  4%  perf-profile.children.cycles-pp.native_sched_clock
      0.97 ± 13%      +0.4        1.38 ±  3%  perf-profile.children.cycles-pp.sched_clock
      0.59 ±  9%      +0.4        1.00 ± 14%  perf-profile.children.cycles-pp.read_tsc
      0.62 ± 16%      +0.4        1.04 ± 10%  perf-profile.children.cycles-pp.__remove_hrtimer
      0.79 ± 10%      +0.4        1.22 ± 18%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.85 ± 15%      +0.4        1.27 ±  8%  perf-profile.children.cycles-pp.irq_work_run_list
      1.04 ± 11%      +0.4        1.48 ± 10%  perf-profile.children.cycles-pp.run_rebalance_domains
      1.19 ± 11%      +0.5        1.70 ±  5%  perf-profile.children.cycles-pp.sched_clock_cpu
      1.66 ± 16%      +0.5        2.18 ±  5%  perf-profile.children.cycles-pp.ksys_read
      1.62 ± 16%      +0.5        2.15 ±  5%  perf-profile.children.cycles-pp.vfs_read
      1.00 ± 11%      +0.5        1.55 ±  8%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      0.21 ± 65%      +0.6        0.82 ± 11%  perf-profile.children.cycles-pp.xfs_dir2_leafn_lookup_for_entry
      1.41 ± 10%      +0.6        2.02 ±  3%  perf-profile.children.cycles-pp.rebalance_domains
      0.09 ± 78%      +0.6        0.72 ± 10%  perf-profile.children.cycles-pp.xfs_iunlink
      0.61 ± 26%      +0.6        1.25 ±  7%  perf-profile.children.cycles-pp.__hrtimer_next_event_base
      0.42 ± 19%      +0.7        1.12 ±  5%  perf-profile.children.cycles-pp.get_next_timer_interrupt
      0.42 ± 15%      +0.8        1.20 ±  5%  perf-profile.children.cycles-pp.hrtimer_next_event_without
      0.04 ±173%      +0.8        0.83 ± 12%  perf-profile.children.cycles-pp.xfs_dir2_leafn_remove
      4.97 ±  9%      +1.1        6.02 ±  6%  perf-profile.children.cycles-pp.update_process_times
      1.20 ±  8%      +1.1        2.27 ±  5%  perf-profile.children.cycles-pp.tick_nohz_next_event
      1.45 ± 15%      +1.1        2.55 ± 12%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      5.26 ± 10%      +1.2        6.44 ±  5%  perf-profile.children.cycles-pp.tick_sched_handle
      1.96 ±  9%      +1.2        3.14 ±  9%  perf-profile.children.cycles-pp.clockevents_program_event
      4.18 ±  8%      +1.3        5.47 ±  8%  perf-profile.children.cycles-pp.do_softirq_own_stack
      4.62 ±  5%      +1.3        5.96 ±  7%  perf-profile.children.cycles-pp.__softirqentry_text_start
      4.88 ±  8%      +1.7        6.56 ±  7%  perf-profile.children.cycles-pp.irq_exit_rcu
      1.96 ±  8%      +2.0        3.99 ±  4%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.30 ± 73%      +2.1        2.38 ± 10%  perf-profile.children.cycles-pp.xfs_dir_removename
      0.10 ±173%      +2.1        2.22 ± 11%  perf-profile.children.cycles-pp.xfs_dir2_node_removename
      6.44 ±  6%      +2.1        8.58 ±  4%  perf-profile.children.cycles-pp.tick_sched_timer
      1.36 ± 17%      +2.6        3.96 ± 23%  perf-profile.children.cycles-pp.tick_irq_enter
      1.53 ± 16%      +2.7        4.26 ± 21%  perf-profile.children.cycles-pp.irq_enter_rcu
      9.28 ±  7%      +3.8       13.08 ±  2%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      3.32 ±  9%      +4.0        7.34 ± 14%  perf-profile.children.cycles-pp.ktime_get
      4.75 ±  5%      +4.4        9.13 ±  4%  perf-profile.children.cycles-pp.menu_select
      3.46 ± 71%      +6.6       10.09 ± 12%  perf-profile.children.cycles-pp.do_unlinkat
     14.06 ±  7%      +6.8       20.90 ±  2%  perf-profile.children.cycles-pp.hrtimer_interrupt
     14.67 ±  6%      +7.2       21.90 ±  2%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      1.32 ± 78%      +7.8        9.12 ± 11%  perf-profile.children.cycles-pp.xfs_remove
      1.32 ± 79%      +7.8        9.14 ± 11%  perf-profile.children.cycles-pp.xfs_vn_unlink
      1.35 ± 78%      +7.9        9.23 ± 11%  perf-profile.children.cycles-pp.vfs_unlink
      9.22 ±  4%      +8.9       18.09 ±  3%  perf-profile.children.cycles-pp.intel_idle
     19.09 ±  6%      +9.2       28.32        perf-profile.children.cycles-pp.asm_call_sysvec_on_stack
     22.23 ±  6%     +12.4       34.64 ±  2%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
     23.96 ±  5%     +12.9       36.82 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
     33.00 ±  3%     +25.2       58.22        perf-profile.children.cycles-pp.cpuidle_enter_state
     33.11 ±  3%     +25.2       58.35        perf-profile.children.cycles-pp.cpuidle_enter
     41.93 ±  2%     +29.6       71.50        perf-profile.children.cycles-pp.start_secondary
     42.58 ±  3%     +29.7       72.25        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     42.58 ±  3%     +29.7       72.25        perf-profile.children.cycles-pp.cpu_startup_entry
     42.57 ±  3%     +29.7       72.25        perf-profile.children.cycles-pp.do_idle
      1.78 ± 26%      -1.7        0.04 ± 58%  perf-profile.self.cycles-pp.__xfs_btree_check_sblock
      1.58 ± 15%      -1.3        0.24 ± 20%  perf-profile.self.cycles-pp.__percpu_counter_sum
      1.55 ± 18%      -1.2        0.36 ± 51%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.92 ± 18%      -0.8        0.12 ± 22%  perf-profile.self.cycles-pp.xfs_errortag_test
      1.46 ±  5%      -0.8        0.70 ± 10%  perf-profile.self.cycles-pp.__orc_find
      0.87 ± 21%      -0.7        0.14 ± 13%  perf-profile.self.cycles-pp.xfs_next_bit
      1.17 ±  9%      -0.5        0.65 ± 26%  perf-profile.self.cycles-pp.unwind_next_frame
      0.74 ± 34%      -0.5        0.26 ± 15%  perf-profile.self.cycles-pp.queue_event
      0.49 ± 19%      -0.3        0.15 ± 23%  perf-profile.self.cycles-pp.xfs_agino_range
      0.47 ± 11%      -0.2        0.23 ± 16%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.51 ± 11%      -0.2        0.28 ±  6%  perf-profile.self.cycles-pp.xfs_dir3_leaf_check_int
      0.65 ± 16%      -0.2        0.42 ± 17%  perf-profile.self.cycles-pp.memcpy_erms
      0.30 ± 21%      -0.2        0.09 ± 24%  perf-profile.self.cycles-pp.xfs_ag_block_count
      0.29 ± 13%      -0.2        0.09 ± 27%  perf-profile.self.cycles-pp.xfs_buf_item_format
      0.32 ± 17%      -0.2        0.14 ± 41%  perf-profile.self.cycles-pp.__module_address
      0.36 ± 10%      -0.2        0.19 ± 31%  perf-profile.self.cycles-pp.kmem_cache_free
      0.23 ± 11%      -0.2        0.07 ± 69%  perf-profile.self.cycles-pp.xlog_cil_insert_items
      0.18 ± 10%      -0.1        0.03 ±102%  perf-profile.self.cycles-pp.kernel_text_address
      0.23 ± 28%      -0.1        0.09 ± 17%  perf-profile.self.cycles-pp.evsel__parse_sample
      0.32 ± 12%      -0.1        0.17 ± 24%  perf-profile.self.cycles-pp.___might_sleep
      0.21 ± 19%      -0.1        0.07 ± 72%  perf-profile.self.cycles-pp.evlist__parse_sample
      0.30 ±  6%      -0.1        0.16 ±  7%  perf-profile.self.cycles-pp.perf_output_sample
      0.36 ±  9%      -0.1        0.22 ±  6%  perf-profile.self.cycles-pp.orc_find
      0.30 ± 16%      -0.1        0.17 ± 20%  perf-profile.self.cycles-pp.xfs_buf_find
      0.20 ± 13%      -0.1        0.08 ± 58%  perf-profile.self.cycles-pp.xfs_log_commit_cil
      0.28 ± 14%      -0.1        0.17 ± 35%  perf-profile.self.cycles-pp.stack_access_ok
      0.26 ± 10%      -0.1        0.14 ± 13%  perf-profile.self.cycles-pp.perf_callchain_kernel
      0.16 ± 18%      -0.1        0.05 ± 58%  perf-profile.self.cycles-pp.__list_add_valid
      0.29 ± 17%      -0.1        0.19 ± 25%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.14 ± 10%      -0.1        0.04 ±102%  perf-profile.self.cycles-pp.__radix_tree_lookup
      0.13 ± 26%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.xfs_buf_item_size_segment
      0.12 ± 15%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.memset_erms
      0.13 ± 19%      -0.1        0.04 ± 58%  perf-profile.self.cycles-pp.perf_output_begin_forward
      0.12 ± 13%      -0.1        0.04 ±102%  perf-profile.self.cycles-pp.link_path_walk
      0.12 ± 13%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.xfs_buf_get_map
      0.15 ± 17%      -0.1        0.07 ± 64%  perf-profile.self.cycles-pp.perf_output_copy
      0.24 ± 24%      -0.1        0.16 ±  9%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.13 ± 14%      -0.1        0.06 ± 60%  perf-profile.self.cycles-pp.xfs_inode_item_format
      0.16 ± 13%      -0.1        0.09 ± 32%  perf-profile.self.cycles-pp.perf_prepare_sample
      0.10 ± 17%      -0.1        0.03 ±102%  perf-profile.self.cycles-pp.finish_task_switch
      0.10 ±  4%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.update_cfs_group
      0.11 ± 17%      -0.1        0.04 ±100%  perf-profile.self.cycles-pp.xfs_buf_item_init
      0.10 ± 15%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.perf_trace_sched_switch
      0.13 ± 25%      -0.1        0.07 ± 12%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.18 ±  8%      -0.1        0.12 ± 32%  perf-profile.self.cycles-pp.__unwind_start
      0.17 ± 19%      -0.1        0.11 ± 17%  perf-profile.self.cycles-pp.__d_lookup_rcu
      0.10 ± 11%      -0.1        0.04 ±103%  perf-profile.self.cycles-pp.enqueue_entity
      0.26 ±  9%      -0.1        0.20 ± 22%  perf-profile.self.cycles-pp.__schedule
      0.11 ± 15%      -0.1        0.05 ± 59%  perf-profile.self.cycles-pp.xfs_buf_item_log
      0.12 ± 27%      -0.1        0.07 ± 59%  perf-profile.self.cycles-pp.___perf_sw_event
      0.17 ±  8%      -0.1        0.11 ± 24%  perf-profile.self.cycles-pp.__might_sleep
      0.10 ± 29%      -0.0        0.05 ± 61%  perf-profile.self.cycles-pp.__task_pid_nr_ns
      0.10 ± 25%      -0.0        0.06 ± 11%  perf-profile.self.cycles-pp.xfs_trans_add_item
      0.08 ± 10%      +0.0        0.11 ± 13%  perf-profile.self.cycles-pp.arch_scale_freq_tick
      0.09 ± 16%      +0.0        0.12 ± 12%  perf-profile.self.cycles-pp.cpuidle_get_cpu_driver
      0.06 ± 15%      +0.0        0.10 ± 28%  perf-profile.self.cycles-pp.rcu_is_cpu_rrupt_from_idle
      0.07 ± 17%      +0.0        0.11 ± 11%  perf-profile.self.cycles-pp.map__process_kallsym_symbol
      0.07 ± 17%      +0.0        0.11 ± 17%  perf-profile.self.cycles-pp.update_group_capacity
      0.01 ±173%      +0.0        0.06 ±  7%  perf-profile.self.cycles-pp.rcu_dynticks_task_enter
      0.10 ± 25%      +0.0        0.14 ± 15%  perf-profile.self.cycles-pp.tick_sched_timer
      0.09 ± 30%      +0.0        0.13 ± 11%  perf-profile.self.cycles-pp.vsnprintf
      0.12 ± 26%      +0.0        0.17 ±  6%  perf-profile.self.cycles-pp.profile_tick
      0.05 ± 67%      +0.1        0.10 ± 19%  perf-profile.self.cycles-pp.rcu_idle_enter
      0.06 ± 20%      +0.1        0.11 ± 15%  perf-profile.self.cycles-pp.irqentry_exit
      0.15 ± 25%      +0.1        0.21 ± 13%  perf-profile.self.cycles-pp.trigger_load_balance
      0.07 ± 24%      +0.1        0.13 ± 31%  perf-profile.self.cycles-pp.irq_work_run_list
      0.10 ±  4%      +0.1        0.16 ± 11%  perf-profile.self.cycles-pp.raise_softirq
      0.05 ± 62%      +0.1        0.11 ± 20%  perf-profile.self.cycles-pp.rcu_segcblist_ready_cbs
      0.07 ± 25%      +0.1        0.13 ±  9%  perf-profile.self.cycles-pp.irq_work_tick
      0.10 ± 33%      +0.1        0.16 ± 19%  perf-profile.self.cycles-pp.tick_program_event
      0.05 ± 62%      +0.1        0.12 ± 29%  perf-profile.self.cycles-pp.sched_idle_set_state
      0.16 ± 20%      +0.1        0.23 ± 19%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.24 ± 14%      +0.1        0.31 ±  8%  perf-profile.self.cycles-pp.rebalance_domains
      0.00            +0.1        0.07 ± 17%  perf-profile.self.cycles-pp.cpuidle_select
      0.28 ± 14%      +0.1        0.35 ±  5%  perf-profile.self.cycles-pp.perf_mux_hrtimer_handler
      0.01 ±173%      +0.1        0.09 ± 19%  perf-profile.self.cycles-pp.__x86_retpoline_rbx
      0.00            +0.1        0.07 ± 24%  perf-profile.self.cycles-pp.find_idlest_group
      0.10 ± 18%      +0.1        0.17 ± 15%  perf-profile.self.cycles-pp.call_cpuidle
      0.08            +0.1        0.15 ± 17%  perf-profile.self.cycles-pp.sched_clock_idle_wakeup_event
      0.07 ±  7%      +0.1        0.14 ± 23%  perf-profile.self.cycles-pp.tick_nohz_irq_exit
      0.06 ± 58%      +0.1        0.13 ± 14%  perf-profile.self.cycles-pp.rcu_nmi_exit
      0.09 ± 21%      +0.1        0.17 ± 16%  perf-profile.self.cycles-pp.tick_check_broadcast_expired
      0.10 ± 27%      +0.1        0.18 ±  8%  perf-profile.self.cycles-pp.tick_nohz_idle_got_tick
      0.09 ± 17%      +0.1        0.17 ±  9%  perf-profile.self.cycles-pp.rcu_dynticks_eqs_enter
      0.11 ± 23%      +0.1        0.20 ± 11%  perf-profile.self.cycles-pp.cpu_latency_qos_limit
      0.13 ± 19%      +0.1        0.22 ± 16%  perf-profile.self.cycles-pp.update_rt_rq_load_avg
      0.12 ± 22%      +0.1        0.22 ± 14%  perf-profile.self.cycles-pp.cpuidle_governor_latency_req
      0.07 ± 17%      +0.1        0.17 ± 24%  perf-profile.self.cycles-pp.restore_regs_and_return_to_kernel
      0.08 ± 17%      +0.1        0.18 ± 13%  perf-profile.self.cycles-pp.hrtimer_next_event_without
      0.06 ± 58%      +0.1        0.16 ± 13%  perf-profile.self.cycles-pp.irq_work_needs_cpu
      0.24 ± 10%      +0.1        0.34 ±  8%  perf-profile.self.cycles-pp.scheduler_tick
      0.22 ±  6%      +0.1        0.32 ± 10%  perf-profile.self.cycles-pp.sched_clock_cpu
      0.21 ± 13%      +0.1        0.32 ±  3%  perf-profile.self.cycles-pp.run_posix_cpu_timers
      0.17 ± 21%      +0.1        0.28 ± 13%  perf-profile.self.cycles-pp.can_stop_idle_tick
      0.28 ± 16%      +0.1        0.38 ± 10%  perf-profile.self.cycles-pp.__sysvec_apic_timer_interrupt
      0.11 ± 22%      +0.1        0.22 ± 11%  perf-profile.self.cycles-pp.__intel_pmu_enable_all
      0.10 ± 28%      +0.1        0.21 ±  6%  perf-profile.self.cycles-pp.x86_pmu_disable
      0.24 ± 21%      +0.1        0.36 ±  9%  perf-profile.self.cycles-pp.irq_exit_rcu
      0.19 ±  4%      +0.1        0.32 ±  2%  perf-profile.self.cycles-pp.irq_enter_rcu
      0.03 ±105%      +0.1        0.15 ±  9%  perf-profile.self.cycles-pp.hrtimer_get_next_event
      0.18 ±  8%      +0.1        0.30 ± 15%  perf-profile.self.cycles-pp.clockevents_program_event
      0.17 ± 10%      +0.1        0.30 ± 19%  perf-profile.self.cycles-pp.nr_iowait_cpu
      0.17 ±  7%      +0.1        0.29 ± 14%  perf-profile.self.cycles-pp.menu_reflect
      0.37 ± 10%      +0.1        0.50 ± 17%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.20 ± 17%      +0.1        0.33 ± 20%  perf-profile.self.cycles-pp.rcu_idle_exit
      0.12 ± 25%      +0.1        0.26 ±  8%  perf-profile.self.cycles-pp.irqentry_enter
      0.13 ± 23%      +0.1        0.26 ± 17%  perf-profile.self.cycles-pp.rcu_nmi_enter
      0.14 ± 26%      +0.1        0.28 ± 20%  perf-profile.self.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.45 ±  2%      +0.1        0.59 ±  9%  perf-profile.self.cycles-pp.idle_cpu
      0.42 ±  6%      +0.1        0.56 ±  4%  perf-profile.self.cycles-pp.update_rq_clock
      0.19 ± 11%      +0.2        0.34 ± 11%  perf-profile.self.cycles-pp.rcu_eqs_enter
      0.47 ±  2%      +0.2        0.63 ± 11%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.20 ± 19%      +0.2        0.36 ±  7%  perf-profile.self.cycles-pp.timerqueue_del
      0.67 ±  5%      +0.2        0.83        perf-profile.self.cycles-pp.rcu_sched_clock_irq
      0.49 ± 21%      +0.2        0.67 ± 16%  perf-profile.self.cycles-pp.update_process_times
      0.19 ± 19%      +0.2        0.37 ± 16%  perf-profile.self.cycles-pp.tick_irq_enter
      0.24 ± 12%      +0.2        0.43 ±  6%  perf-profile.self.cycles-pp.tsc_verify_tsc_adjust
      0.20 ± 12%      +0.2        0.39 ± 14%  perf-profile.self.cycles-pp.sysvec_apic_timer_interrupt
      0.55 ± 14%      +0.2        0.74 ±  9%  perf-profile.self.cycles-pp.update_irq_load_avg
      0.44 ± 16%      +0.2        0.64 ±  6%  perf-profile.self.cycles-pp.__hrtimer_run_queues
      0.21 ± 18%      +0.2        0.41 ±  4%  perf-profile.self.cycles-pp.timerqueue_add
      0.28 ± 11%      +0.2        0.48 ± 12%  perf-profile.self.cycles-pp.rb_erase
      0.11 ± 20%      +0.2        0.32 ± 28%  perf-profile.self.cycles-pp.rcu_eqs_exit
      0.41 ± 13%      +0.2        0.63 ± 11%  perf-profile.self.cycles-pp.hrtimer_interrupt
      0.47 ±  9%      +0.2        0.70 ±  8%  perf-profile.self.cycles-pp.tick_nohz_next_event
      0.17 ± 16%      +0.2        0.40 ±  4%  perf-profile.self.cycles-pp.get_next_timer_interrupt
      0.73 ± 14%      +0.3        0.99 ±  8%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.30 ±  7%      +0.3        0.58 ±  7%  perf-profile.self.cycles-pp.native_apic_msr_eoi_write
      0.49 ± 13%      +0.3        0.82 ±  5%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.57 ±  8%      +0.4        0.94 ±  2%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.88 ± 14%      +0.4        1.26 ±  3%  perf-profile.self.cycles-pp.native_sched_clock
      0.53 ± 13%      +0.4        0.93 ± 10%  perf-profile.self.cycles-pp.do_idle
      0.56 ±  8%      +0.4        0.96 ± 12%  perf-profile.self.cycles-pp.read_tsc
      0.56 ± 23%      +0.6        1.16 ±  5%  perf-profile.self.cycles-pp.__hrtimer_next_event_base
      1.23 ± 12%      +0.7        1.92        perf-profile.self.cycles-pp.cpuidle_enter_state
      1.29 ± 18%      +1.0        2.30 ± 12%  perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      2.11 ± 11%      +2.0        4.07 ± 10%  perf-profile.self.cycles-pp.menu_select
      2.82 ±  9%      +3.6        6.44 ± 16%  perf-profile.self.cycles-pp.ktime_get
      9.22 ±  4%      +8.9       18.09 ±  3%  perf-profile.self.cycles-pp.intel_idle


                                                                                
                     fxmark.hdd_xfs_MWUL_72_directio.sys_sec                    
                                                                                
  25 +----------------------------------------------------------------------+   
     |                                                                      |   
     |                                                                      |   
  20 |-+       +..+.+..           .+..+..+.+..+.+.. .+..                   .|   
     |..+      :       +.+..+.+..+                 +    +.+..+.+..+.+..+.+. |   
     |  :      :                                                            |   
  15 |-+:     :                                                             |   
     |   :    :                                                             |   
  10 |-+ :    :                            O  O O  O           O            |   
     |  O:O  O:O  O O  O O  O O  O O     O           O  O O  O    O         |   
     |   :    :                                                             |   
   5 |-+ :    :                                                             |   
     |    :  :                                                              |   
     |    :  :                                                              |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                     fxmark.hdd_xfs_MWUL_72_directio.sys_util                   
                                                                                
  1.2 +---------------------------------------------------------------------+   
      |                .+.+..+.  .+.  .+.  .+.     +..      .+..+.+..+.+..+.|   
    1 |..       +..+.+.        +.   +.   +.   +.. +   +.+..+                |   
      |         :                                +                          |   
      |  +      :                                                           |   
  0.8 |-+:      :                                                           |   
      |  :     :                                                            |   
  0.6 |-+ :    :                                                            |   
      |   :    :                            O    O                          |   
  0.4 |-+O:O  O:O  O O  O O  O O  O O    O    O    O  O O  O O  O O         |   
      |   :    :                                                            |   
      |   :    :                                                            |   
  0.2 |-+  :  :                                                             |   
      |    :  :                                                             |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                      fxmark.hdd_xfs_MWUL_63_directio.secs                      
                                                                                
  35 +----------------------------------------------------------------------+   
     |                                                                      |   
  30 |-+O O  O O  O O  O O  O O  O O     O O  O O  O O  O O  O O  O         |   
     |                                                                      |   
  25 |-+                                                                    |   
     |                                              .+..  +.. .+..          |   
  20 |..+        .+.  .+.+..+.  .+.+..+..+.+..+.  .+     +   +    +    +.  .|   
     |  :      +.   +.        +.                +.      +          + ..  +. |   
  15 |-+ :     :                                                    +       |   
     |   :    :                                                             |   
  10 |-+ :    :                                                             |   
     |   :    :                                                             |   
   5 |-+  :   :                                                             |   
     |    :  :                                                              |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                        fxmark.hdd_xfs_MWUL_63_directio.works                   
                                                                                
  60000 +-------------------------------------------------------------------+   
        |                 .+..         .+. .+..    .+.           .+..       |   
  50000 |.+       +.+..+.+    +.+..+.+.   +    +.+.   +..+.+.+..+    +.+..+.|   
        | :       :                                                         |   
        |  :      :                         O    O       O O    O O         |   
  40000 |-O: O O :O    O O    O O  O O    O    O    O O      O              |   
        |  :     :  O      O                                                |   
  30000 |-+:     :                                                          |   
        |   :    :                                                          |   
  20000 |-+ :   :                                                           |   
        |   :   :                                                           |   
        |   :   :                                                           |   
  10000 |-+  :  :                                                           |   
        |    : :                                                            |   
      0 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                     fxmark.hdd_xfs_MWUL_63_directio.works_sec                  
                                                                                
  4000 +--------------------------------------------------------------------+   
       |                                                             +      |   
  3500 |-+                                                          + :     |   
  3000 |-+       +             .+                       +..        +  :     |   
       |.+       :+  .+.    .+.  +    .+..+.+.+..+.    +          +    : .+.|   
  2500 |-:      :  +.   +..+      +..+             +..+    +.+.. +     +.   |   
       |  :     :                                               +           |   
  2000 |-+:     :                                                           |   
       |  :     :                                                           |   
  1500 |-+ :O  :        O                 O O    O    O O  O    O O         |   
  1000 |-O :  O: O O  O    O O  O O  O        O    O         O              |   
       |   :   :                                                            |   
   500 |-+ :   :                                                            |   
       |    : :                                                             |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                    fxmark.hdd_xfs_MWUL_63_directio.real_sec                    
                                                                                
  35 +----------------------------------------------------------------------+   
     |                                                                      |   
  30 |-+O O  O O  O O  O O  O O  O O     O O  O O  O O  O O  O O  O         |   
     |                                                                      |   
  25 |-+                                                       +..          |   
     |                                              .+    +.. +             |   
  20 |..+         +.  .+.+..    .+.+..+..+.+..+.  .+  +  :   +    +    +.  .|   
     |  :       ..  +.      +.+.                +.     + :         :  +  +. |   
  15 |-+ :     +                                        +          : +      |   
     |   :     :                                                    +       |   
  10 |-+ :    :                                                             |   
     |   :    :                                                             |   
   5 |-+  :   :                                                             |   
     |    :  :                                                              |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                    fxmark.hdd_xfs_MWUL_63_directio.user_sec                    
                                                                                
  12 +----------------------------------------------------------------------+   
     |                                                                      |   
  10 |-+       O                                                            |   
     |                                                                      |   
     |    O  O      O       O              O  O O  O                        |   
   8 |-+O         O    O O    O  O O     O           O  O O  O O  O         |   
     |                                                                      |   
   6 |-+                                                                    |   
     |                                                                      |   
   4 |-+                                                                    |   
     |..+      +..+.  .+.+..+.+..+.+..+..+.+..+.+..+.+.. .+..+.+..+.  .+.+..|   
     |   :     :    +.                                  +           +.      |   
   2 |-+ :    :                                                             |   
     |    :   :                                                             |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                     fxmark.hdd_xfs_MWUL_63_directio.idle_sec                   
                                                                                
  2000 +--------------------------------------------------------------------+   
  1800 |-O  O O  O O  O O  O O  O O  O    O O O  O O  O O  O O  O O         |   
       |                                                                    |   
  1600 |-+                                                                  |   
  1400 |-+                                                     .+           |   
       |.          +..  +..       +..             .+..+    +.+.  +     +.. .|   
  1200 |-+        +    +   +.+.. +   +.+..+.+.+..+     + ..       +    :  + |   
  1000 |-:       +    +         +                       +          +  :     |   
   800 |-+:      :                                                  + :     |   
       |  :     :                                                    +      |   
   600 |-+ :    :                                                           |   
   400 |-+ :   :                                                            |   
       |   :   :                                                            |   
   200 |-+  : :                                                             |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                     fxmark.hdd_xfs_MWUL_63_directio.sys_util                   
                                                                                
    2 +---------------------------------------------------------------------+   
  1.8 |-+                                                            +      |   
      |  +           +                                              + :     |   
  1.6 |..:      +.. + +   +.. .+..              .+.    .+..        +  :     |   
  1.4 |-+:      :  +   + +   +    +.+..+.+..+.+.   +..+    +.+.. .+    +..+.|   
      |   :     :       +                                       +           |   
  1.2 |-+ :    :                                                            |   
    1 |-+ :    :                                                            |   
  0.8 |-+ :    :                                                            |   
      |   :    :                            O    O              O O         |   
  0.6 |-+O:O  O:O  O O  O O  O O  O O    O    O    O  O O  O O              |   
  0.4 |-+  :   :                                                            |   
      |    :  :                                                             |   
  0.2 |-+  :  :                                                             |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                      fxmark.hdd_xfs_MWUL_54_directio.secs                      
                                                                                
  35 +----------------------------------------------------------------------+   
     |                                                                      |   
  30 |-+O O  O O  O O  O O  O O  O O     O O  O O  O O  O O  O O  O         |   
     |                                                                      |   
  25 |-+                                                                    |   
     |                        +..                                           |   
  20 |..+      +.. .+..+.+.. +    .+..            .+.    .+..+.       .+.+..|   
     |  :      :  +         +    +    +..+.+..+.+.   +..+      +..+.+.      |   
  15 |-+ :     :                                                            |   
     |   :    :                                                             |   
  10 |-+ :    :                                                             |   
     |   :    :                                                             |   
   5 |-+  :   :                                                             |   
     |    :  :                                                              |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                     fxmark.hdd_xfs_MWUL_54_directio.works_sec                  
                                                                                
  3500 +--------------------------------------------------------------------+   
       |           +..            +..                 +.                    |   
  3000 |-+        +         .+    :   .+..+.+.+..+. ..  +..    .+.+..+.     |   
       |         +    +.  .+  +  :   +             +       +.+.        +..+.|   
  2500 |.+       :      +.     + :                                          |   
       | :      :               +                                           |   
  2000 |-+:     :                                                           |   
       |  :     :                                                           |   
  1500 |-+:     :  O       O    O O  O        O    O  O    O                |   
       | O :O  : O    O O    O            O O    O      O       O           |   
  1000 |-+ :  O:                                             O    O         |   
       |   :   :                                                            |   
   500 |-+ :   :                                                            |   
       |    : :                                                             |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                    fxmark.hdd_xfs_MWUL_54_directio.real_sec                    
                                                                                
  35 +----------------------------------------------------------------------+   
     |                                                                      |   
  30 |-+O O  O O  O O  O O  O O  O O     O O  O O  O O  O O  O O  O         |   
     |                                                                      |   
  25 |-+                                                                    |   
     |                .+.     +..                                           |   
  20 |..+      +.. .+.   +.. +    .+..            .+.    .+..+.       .+.+..|   
     |  :      :  +         +    +    +..+.+..+.+.   +..+      +..+.+.      |   
  15 |-+ :     :                                                            |   
     |   :    :                                                             |   
  10 |-+ :    :                                                             |   
     |   :    :                                                             |   
   5 |-+  :   :                                                             |   
     |    :  :                                                              |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                     fxmark.hdd_xfs_MWUL_54_directio.sys_sec                    
                                                                                
  18 +----------------------------------------------------------------------+   
     |..+      +..+.+..+.+..+.+..+.+..+..+.+..+. ..  +..+.+..+.+..+    +.+..|   
  16 |-+:      :                                +                           |   
  14 |-+:      :                                                            |   
     |  :      :                                                            |   
  12 |-+ :    :                                                             |   
  10 |-+ :    :        O O    O  O O     O    O    O O                      |   
     |  O:O   :O  O O       O              O    O       O O  O O            |   
   8 |-+ :   O:                                                   O         |   
   6 |-+ :    :                                                             |   
     |   :    :                                                             |   
   4 |-+  :  :                                                              |   
   2 |-+  :  :                                                              |   
     |    :  :                                                              |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                     fxmark.hdd_xfs_MWUL_54_directio.idle_sec                   
                                                                                
  1800 +--------------------------------------------------------------------+   
       |      O                                                   O         |   
  1600 |-O  O    O O  O O  O O  O O  O    O O O  O O  O O  O O  O           |   
  1400 |-+                                                                  |   
       |                                                                    |   
  1200 |-+             .+..     +                                           |   
  1000 |.+       +.  .+    +. .. +  .+.           .+..    .+.+..      .+..+.|   
       | :       : +.        +    +.   +..+.+.+..+    +.+.      +.+..+      |   
   800 |-+:     :                                                           |   
   600 |-+:     :                                                           |   
       |   :    :                                                           |   
   400 |-+ :   :                                                            |   
   200 |-+ :   :                                                            |   
       |    : :                                                             |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                     fxmark.hdd_xfs_MWUL_54_directio.sys_util                   
                                                                                
    2 +---------------------------------------------------------------------+   
  1.8 |-+          +              +     .+.. .+..    .+.            .+      |   
      |          .. +       .+   : +  .+    +    +.+.   +.. .+..+.+.  +     |   
  1.6 |..+      +    +.. .+.  :  :  +.                     +           +..+.|   
  1.4 |-+:      :       +     : :                                           |   
      |  :      :              +                                            |   
  1.2 |-+ :    :                                                            |   
    1 |-+ :    :                                                            |   
  0.8 |-+ :    :                                                            |   
      |   :    :                                                            |   
  0.6 |-+O:O   :O  O O  O O  O O  O O    O  O O  O O  O O  O O  O           |   
  0.4 |-+ :   O:                                                  O         |   
      |    :  :                                                             |   
  0.2 |-+  :  :                                                             |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                      fxmark.hdd_xfs_MWUL_45_directio.secs                      
                                                                                
  35 +----------------------------------------------------------------------+   
     |                                                                      |   
  30 |-+O O  O O  O O  O O  O O  O O     O O  O O  O O    O  O O  O         |   
     |                                                                      |   
  25 |-+                                                O                   |   
     |                                                                      |   
  20 |-+                                                                    |   
     |         +..                                                          |   
  15 |-.+      :  +.  .+.+..+.+..+.+..+..+.+..+.+..+.+..+.+..+.+..+.  .+.  .|   
     |. :     :     +.                                              +.   +. |   
  10 |-+ :    :                                                             |   
     |   :    :                                                             |   
   5 |-+ :    :                                                             |   
     |    :  :                                                              |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                     fxmark.hdd_xfs_MWUL_45_directio.works_sec                  
                                                                                
  4500 +--------------------------------------------------------------------+   
       |             + +                                             +    + |   
  4000 |.+          +   +..+.     +..             .+.. .+..+.      .. + .. +|   
  3500 |-+        .+         +.. +   +.+.. .+.  .+    +      +..+.+    +    |   
       | :       +              +         +   +.                            |   
  3000 |-+:      :                                                          |   
  2500 |-+:     :                                                           |   
       |  :     :                                                           |   
  2000 |-+:     :  O  O    O                            O       O           |   
  1500 |-O :O O :O      O    O  O O  O    O O O  O O  O      O    O         |   
       |   :   :                                                            |   
  1000 |-+ :   :                                           O                |   
   500 |-+ :   :                                                            |   
       |    : :                                                             |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                    fxmark.hdd_xfs_MWUL_45_directio.real_sec                    
                                                                                
  35 +----------------------------------------------------------------------+   
     |                                                                      |   
  30 |-+O O  O O  O O  O O  O O  O O     O O  O O  O O    O  O O  O         |   
     |                                                                      |   
  25 |-+                                                O                   |   
     |                                                                      |   
  20 |-+                                                                    |   
     |         +..                                                          |   
  15 |-.+      :  +.  .+.+..+.+..+.+..+..+.+..+.+..+.+..+.+..+.+..+.  .+.  .|   
     |. :     :     +.                                              +.   +. |   
  10 |-+ :    :                                                             |   
     |   :    :                                                             |   
   5 |-+ :    :                                                             |   
     |    :  :                                                              |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                     fxmark.hdd_xfs_MWUL_45_directio.sys_sec                    
                                                                                
  16 +----------------------------------------------------------------------+   
     |. :      :  +    +      +..+.+..+.   +.        +..+.+.        +.   +. |   
  14 |-+:      :                                                            |   
  12 |-+:      :                                                            |   
     |   :    :                                                             |   
  10 |-+ :    :O  O O  O O  O    O O     O O  O O  O O  O    O O  O         |   
     |  O:O  O:               O                                             |   
   8 |-+ :    :                                           O                 |   
     |   :    :                                                             |   
   6 |-+ :    :                                                             |   
   4 |-+ :    :                                                             |   
     |    :  :                                                              |   
   2 |-+  :  :                                                              |   
     |    :  :                                                              |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                     fxmark.hdd_xfs_MWUL_45_directio.idle_sec                   
                                                                                
  1400 +--------------------------------------------------------------------+   
       | O  O O  O O  O O  O O  O O  O    O O O  O O  O    O O  O O         |   
  1200 |-+                                                                  |   
       |                                                O                   |   
  1000 |-+                                                                  |   
       |                                                                    |   
   800 |-+                                                                  |   
       |.+       +.         .+..+.       .+. .+..           .+..+.          |   
   600 |-:       : +.. .+..+      +..+.+.   +    +.+..+.+..+      +..+.+.. .|   
       |  :     :     +                                                   + |   
   400 |-+:     :                                                           |   
       |   :   :                                                            |   
   200 |-+ :   :                                                            |   
       |    : :                                                             |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                     fxmark.hdd_xfs_MWUL_45_directio.irq_sec                    
                                                                                
  25 +----------------------------------------------------------------------+   
     |                                                                      |   
     |    O  O O                 O                                          |   
  20 |-+O         O    O O  O O    O     O O  O O  O O    O  O O  O         |   
     |              O                                                       |   
     |                                                  O                   |   
  15 |-+                                                                    |   
     |                                                                      |   
  10 |-.+      +..+.  .+.+..+.+.. .+..+..+.+..+.+..+.+..+.  .+.+..+.  .+.  .|   
     |. :      :    +.           +                        +.        +.   +. |   
     |   :    :                                                             |   
   5 |-+ :    :                                                             |   
     |   :    :                                                             |   
     |    :  :                                                              |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                     fxmark.hdd_xfs_MWUL_45_directio.user_util                  
                                                                                
  0.45 +--------------------------------------------------------------------+   
       |              +.  .+                                              + |   
   0.4 |.+          ..  +.  :    .+..             .+..    .+.     +..+. .. +|   
  0.35 |-+        .+        :  .+    +.+.. .+.  .+    +.+.   +.. +     +    |   
       | :       +           +.           +   +.                +           |   
   0.3 |-+:      :                                                          |   
  0.25 |-+:     :                                                           |   
       | O: O O :O O  O O  O O  O    O    O           O O    O  O O         |   
   0.2 |-+:     :                 O         O O  O O       O                |   
  0.15 |-+ :    :                                                           |   
       |   :   :                                                            |   
   0.1 |-+ :   :                                                            |   
  0.05 |-+ :   :                                                            |   
       |    : :                                                             |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                     fxmark.hdd_xfs_MWUL_45_directio.sys_util                   
                                                                                
    3 +---------------------------------------------------------------------+   
      |             : +                                                   + |   
  2.5 |..           :  + .+..                     .+..              .+. .. +|   
      |  +        .+    +        .+.+..+.  .+.  .+     .+..+.+..+.+.   +    |   
      |  :      +.           +.+.        +.   +.      +                     |   
    2 |-+:      :                                                           |   
      |   :     :                                                           |   
  1.5 |-+ :    :                                                            |   
      |   :    :                                                            |   
    1 |-+ :    :                                                            |   
      |   :    :   O    O O  O      O    O              O       O O         |   
      |  O:O  O:O    O         O  O         O O  O O  O    O O              |   
  0.5 |-+  :  :                                                             |   
      |    :  :                                                             |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                      fxmark.hdd_xfs_MWUL_36_directio.secs                      
                                                                                
  35 +----------------------------------------------------------------------+   
     |                                                                      |   
  30 |-+            O         O  O O          O    O         O              |   
     |  O O       O    O    O                        O    O                 |   
  25 |-+       O         O                 O    O              O  O         |   
     |       O                           O              O                   |   
  20 |-+                                                                    |   
     |                                                                      |   
  15 |-+                                                                    |   
     |           .+.  .+.+.. .+..+.      +    +.  .+.  .+.  .+.+.. .+.. .+..|   
  10 |..+      +.   +.      +      +.. .. + ..  +.   +.   +.      +    +    |   
     |   :     :                      +    +                                |   
   5 |-+ :    :                                                             |   
     |    :   :                                                             |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                     fxmark.hdd_xfs_MWUL_36_directio.works_sec                  
                                                                                
  7000 +--------------------------------------------------------------------+   
       |                                                                    |   
  6000 |-+                             +    +                               |   
       |+             +               + :   ::   +                          |   
  5000 |-+          .. +    .+..    .+   : : :  + +  .+    +.    .+.. .+.. +|   
       | :       +.+    +..+    +.+.     : :  :+   +.  + ..  +..+    +    + |   
  4000 |-+:      :                        +   +         +                   |   
       |  :     :                                                           |   
  3000 |-+:     :                                                           |   
       |   :  O :                         O                                 |   
  2000 |-O :O  : O O  O O  O O    O  O      O    O    O O  O O  O O         |   
       |   :   :                O             O    O                        |   
  1000 |-+ :   :                                                            |   
       |    : :                                                             |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                    fxmark.hdd_xfs_MWUL_36_directio.real_sec                    
                                                                                
  35 +----------------------------------------------------------------------+   
     |                                                                      |   
  30 |-+            O       O O  O O          O    O         O              |   
     |  O O       O    O                             O    O                 |   
  25 |-+       O         O                 O    O       O      O  O         |   
     |       O                           O                                  |   
  20 |-+                                                                    |   
     |                                                                      |   
  15 |-+                                 +    +                             |   
     | .+      +..+.  .+.+.. .+..+.     + :  + +  .+.  .+.+..+.+.. .+.. .+..|   
  10 |.+:      :    +.      +      +.. +  : +   +.   +.           +    +    |   
     |   :    :                       +    +                                |   
   5 |-+ :    :                                                             |   
     |    :  :                                                              |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                     fxmark.hdd_xfs_MWUL_36_directio.sys_sec                    
                                                                                
  16 +----------------------------------------------------------------------+   
     | .+      +..+.+..+.+..+.+..+.+..  .+.  .+.  .+.+..+.+..+.+..+.+..+.+..|   
  14 |.+:      :                      +.   +.   +.                          |   
  12 |-+:      :                                                            |   
     |  :      :                                                            |   
  10 |-+O:    :   O O  O O  O O  O O       O  O O  O O    O  O    O         |   
     |   :O  O:O                         O              O      O            |   
   8 |-+ :    :                                                             |   
     |   :    :                                                             |   
   6 |-+ :    :                                                             |   
   4 |-+ :    :                                                             |   
     |    :  :                                                              |   
   2 |-+  :  :                                                              |   
     |    :  :                                                              |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                     fxmark.hdd_xfs_MWUL_36_directio.idle_sec                   
                                                                                
  1200 +--------------------------------------------------------------------+   
       |                                                                    |   
  1000 |-+            O      O  O O  O        O    O         O              |   
       | O  O      O    O                   O    O    O    O                |   
       |         O         O                            O       O O         |   
   800 |-+    O                           O                                 |   
       |                                                                    |   
   600 |-+                                                                  |   
       |                                                                    |   
   400 |-+        .+.. .+..+.  .+.+..     +   +.. .+.. .+.. .+..+.  .+.  .+.|   
       |.+       +    +      +.      +. .. + +   +    +    +      +.   +.   |   
       |  :     :                      +    +                               |   
   200 |-+ :    :                                                           |   
       |   :   :                                                            |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                     fxmark.hdd_xfs_MWUL_36_directio.irq_sec                    
                                                                                
  18 +----------------------------------------------------------------------+   
     |                        O               O    O                        |   
  16 |-+  O       O         O    O O                         O              |   
  14 |-+O      O    O  O                   O    O    O    O    O  O         |   
     |       O           O               O              O                   |   
  12 |-+                                                                    |   
  10 |-+                                                                    |   
     |                                                                      |   
   8 |-+                                 +    +.       .+.                  |   
   6 |-.+      +..+.+..+.+..+.+..+.+.. .. + ..  +..+.+.   +..+.+..+.+..+.+..|   
     |. :      :                      +    +                                |   
   4 |-+ :    :                                                             |   
   2 |-+ :    :                                                             |   
     |    :  :                                                              |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                     fxmark.hdd_xfs_MWUL_36_directio.user_util                  
                                                                                
  0.6 +---------------------------------------------------------------------+   
      |..                             + :  : :                              |   
  0.5 |-+           .+..    .+.  .+. +  :  : :   +.  .+          .+.. .+.. .|   
      |  +      +..+     .+.   +.   +    ::   :..  +.  +  .+.  .+    +    + |   
      |  :      :       +                +    +         +.   +.             |   
  0.4 |-+:      :                                                           |   
      |   :    :                                                            |   
  0.3 |-+ :   O:                            O    O                          |   
      |  O:O   :O  O O  O O  O    O O    O    O    O  O O  O O  O O         |   
  0.2 |-+ :    :               O                                            |   
      |   :    :                                                            |   
      |   :    :                                                            |   
  0.1 |-+  :  :                                                             |   
      |    :  :                                                             |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                     fxmark.hdd_xfs_MWUL_36_directio.sys_util                   
                                                                                
    5 +---------------------------------------------------------------------+   
  4.5 |-+                              +    +                               |   
      |..                            ..:   ::                               |   
    4 |-+           .+..    .+.    .+   :  : :   +.  .+          .+.. .+.. +|   
  3.5 |-++      +..+     .+.   +..+     : :  :  +  +.  +  .+.  .+    +    + |   
      |  :      :       +                ::   :+        +.   +.             |   
    3 |-+:      :                        +    +                             |   
  2.5 |-+ :    :                                                            |   
    2 |-+ :    :                                                            |   
      |   :    :                                                            |   
  1.5 |-+ :    :                                                            |   
    1 |-+O:O  O:O  O O  O O  O O  O O    O  O O  O O  O O  O O  O O         |   
      |    :  :                                                             |   
  0.5 |-+  :  :                                                             |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                      fxmark.hdd_xfs_MWUL_27_directio.secs                      
                                                                                
  25 +----------------------------------------------------------------------+   
     |                                                         O            |   
     |  O                O    O          O                O       O         |   
  20 |-+          O O       O    O                   O  O                   |   
     |       O O       O           O       O  O O  O         O              |   
     |    O                                                                 |   
  15 |-+                                                                    |   
     |                                                                      |   
  10 |-+                                                                    |   
     |..       +..+.  .+.    .+..+.+..  .+.  .+.  .+.            .+.  .+.  .|   
     |  +      :    +.   +..+         +.   +.   +.   +..+.+..+.+.   +.   +. |   
   5 |-+ :    :                                                             |   
     |   :    :                                                             |   
     |    :  :                                                              |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                     fxmark.hdd_xfs_MWUL_27_directio.works_sec                  
                                                                                
  8000 +--------------------------------------------------------------------+   
       |             : :   +.+..       +..  +         +.            + :     |   
  7000 |.+           : : ..           +    + +  .+. ..  +..+.+..+. +  :   + |   
  6000 |-:       +. :   +       +.+..+    +   +.   +              +    :.. +|   
       |  :      : +                                                   +    |   
  5000 |-+:     :                                                           |   
       |  :     :                                                           |   
  4000 |-+:     :                                                           |   
       |   :O   :                                                           |   
  3000 |-+ :  O: O O  O O    O    O  O      O O  O O  O O    O              |   
  2000 |-O :   :           O    O         O                O    O O         |   
       |   :   :                                                            |   
  1000 |-+  :  :                                                            |   
       |    : :                                                             |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                    fxmark.hdd_xfs_MWUL_27_directio.real_sec                    
                                                                                
  25 +----------------------------------------------------------------------+   
     |                   O                                     O            |   
     |  O                   O O          O                O       O         |   
  20 |-+          O O            O                   O  O                   |   
     |       O O       O           O       O  O O  O         O              |   
     |    O                                                                 |   
  15 |-+                                                                    |   
     |                                                                      |   
  10 |-+                                                                    |   
     |..       +..+.  .+.    .+..+.+..  .+.  .+.  .+.         .+..+.  .+.  .|   
     |  +      :    +.   +..+         +.   +.   +.   +..+.+..+      +.   +. |   
   5 |-+ :    :                                                             |   
     |   :    :                                                             |   
     |    :  :                                                              |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                     fxmark.hdd_xfs_MWUL_27_directio.sys_sec                    
                                                                                
  16 +----------------------------------------------------------------------+   
     |                                                                      |   
  14 |..+      +..+.+..+.+..+.+..+.+..+..+.+..+.+..+.+..+.+..+.+..+.+..+.+..|   
  12 |-+:      :                                                            |   
     |  :      :                                                            |   
  10 |-+ :     :                                                            |   
     |  O:O   :   O    O O  O O  O O     O O  O O  O O  O O  O O  O         |   
   8 |-+ :   O:O    O                                                       |   
     |   :    :                                                             |   
   6 |-+ :    :                                                             |   
   4 |-+ :    :                                                             |   
     |    :   :                                                             |   
   2 |-+  :  :                                                              |   
     |    :  :                                                              |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                     fxmark.hdd_xfs_MWUL_27_directio.idle_sec                   
                                                                                
  600 +---------------------------------------------------------------------+   
      |  O                     O         O                 O      O         |   
  500 |-+          O O       O    O                   O O                   |   
      |         O                   O       O O  O O         O              |   
      |    O  O         O                                                   |   
  400 |-+                                                                   |   
      |                                                                     |   
  300 |-+                                                                   |   
      |                                                                     |   
  200 |..       +..+.  .+.    .+..+.+.. .+.. .+.. .+..         .+.+.. .+.. .|   
      |  +      :    +.   +..+         +    +    +    +.+..+.+.      +    + |   
      |   :    :                                                            |   
  100 |-+ :    :                                                            |   
      |    :  :                                                             |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                     fxmark.hdd_xfs_MWUL_27_directio.irq_sec                    
                                                                                
  10 +----------------------------------------------------------------------+   
   9 |-+                 O                                     O  O         |   
     |  O         O         O O          O                O                 |   
   8 |-+                         O O                 O  O                   |   
   7 |-+     O O    O  O                   O  O O  O         O              |   
     |    O                                                                 |   
   6 |-+                                                                    |   
   5 |-+                                                                    |   
   4 |..       +..+.              .+..  .+.  .+.  .+.                 .+.  .|   
     |  +      :    +..+.+..+.+..+    +.   +.   +.   +..+.+..+.+..+.+.   +. |   
   3 |-+:     :                                                             |   
   2 |-+ :    :                                                             |   
     |   :    :                                                             |   
   1 |-+  :  :                                                              |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                     fxmark.hdd_xfs_MWUL_27_directio.user_util                  
                                                                                
  0.9 +---------------------------------------------------------------------+   
      |              +..                                             +      |   
  0.8 |-+           :   +.+..+.        +.  .+.       .+.  .+.+..   .. :   + |   
  0.7 |..+      +.. :          +..+. ..  +.   +..+.+.   +.      +.+   : .. +|   
      |  :      :  +                +                                  +    |   
  0.6 |-+:      :                                                           |   
  0.5 |-+ :    :                                                            |   
      |   :O   :                                                            |   
  0.4 |-+O:   O:O  O O  O    O    O O    O  O O  O O  O O    O              |   
  0.3 |-+ :    :          O    O                           O    O O         |   
      |   :    :                                                            |   
  0.2 |-+ :    :                                                            |   
  0.1 |-+  :  :                                                             |   
      |    :  :                                                             |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                    fxmark.hdd_xfs_MWUL_27_directio.sys_util                    
                                                                                
  8 +-----------------------------------------------------------------------+   
    |                    +.                                         +       |   
  7 |-+            +..  +  +..       +..   +         +.  .+..+.    : +      |   
  6 |-.+      +.. +    +      +.+.. +    .. +  .+. ..  +.      +.. :  + .+..|   
    |. :      :  +    +            +    +    +.   +               +    +    |   
  5 |-+:      :                                                             |   
    |   :    :                                                              |   
  4 |-+ :    :                                                              |   
    |   :    :                                                              |   
  3 |-+ :    :                                                              |   
  2 |-+ :O   :                                                              |   
    |  O:   O:O  O O  O  O O  O O  O    O  O O  O O  O O  O  O O  O         |   
  1 |-+  :  :                                                               |   
    |    :  :                                                               |   
  0 +-----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                     fxmark.hdd_xfs_MWUL_27_directio.irq_util                   
                                                                                
    2 +---------------------------------------------------------------------+   
  1.8 |-.+               .+..                                               |   
      |. :      +..+.+..+    +.+..+.+..+.+..+.+..+.+..+.+..+.+..+.+..+.+..+.|   
  1.6 |-+: O  O :  O    O    O    O O    O  O O  O O  O                     |   
  1.4 |-+:      :    O    O    O                        O  O O  O O         |   
      |   :     :                                                           |   
  1.2 |-+ :    :                                                            |   
    1 |-+ :    :                                                            |   
  0.8 |-+ :    :                                                            |   
      |   :    :                                                            |   
  0.6 |-+ :    :                                                            |   
  0.4 |-+  :   :                                                            |   
      |    :  :                                                             |   
  0.2 |-+  :  :                                                             |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                      fxmark.hdd_xfs_MWUL_18_directio.secs                      
                                                                                
  25 +----------------------------------------------------------------------+   
     |                        O                                             |   
     |                                                                      |   
  20 |-+                                                                    |   
     |    O    O  O O  O O       O                      O O  O              |   
     |  O                          O     O O    O    O         O  O         |   
  15 |-+     O              O                 O    O                        |   
     |                                                                      |   
  10 |-+                                                                    |   
     |                                                             .+..     |   
     | .+      +.. .+..+.+..+.+..+.  .+..+.+..+.+..+.+..+.+..+.+..+    +.+..|   
   5 |.+ :     :  +                +.                                       |   
     |   :    :                                                             |   
     |    :   :                                                             |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                     fxmark.hdd_xfs_MWUL_18_directio.works_sec                  
                                                                                
  9000 +--------------------------------------------------------------------+   
       |.+       +    +.           .. +         .+                +         |   
  8000 |-:       :      +..+.    .+    +..+.+.+.  :   +.+..      + +   +.. +|   
  7000 |-:       :           +..+                 : ..     +.  .+   + +   + |   
       |  :     :                                  +         +.      +      |   
  6000 |-+:     :                                                           |   
  5000 |-+:     :                                                           |   
       |  :     :                                                           |   
  4000 |-+ :   :                              O    O                        |   
  3000 |-O :O O: O    O O    O    O  O    O O    O    O      O  O O         |   
       |   :   :   O       O                            O  O                |   
  2000 |-+ :   :                O                                           |   
  1000 |-+  : :                                                             |   
       |    : :                                                             |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                    fxmark.hdd_xfs_MWUL_18_directio.real_sec                    
                                                                                
  25 +----------------------------------------------------------------------+   
     |                        O                                             |   
     |                                                                      |   
  20 |-+                 O                              O                   |   
     |    O    O  O O  O         O                        O       O         |   
     |  O    O                     O     O O    O    O       O O            |   
  15 |-+                    O                 O    O                        |   
     |                                                                      |   
  10 |-+                                                                    |   
     |                                                      .+.    .+.. .+..|   
     |..+      +.. .+..+.+..+.+..+.  .+..+.+..+.+..+.+..+.+.   +..+    +    |   
   5 |-+ :     :  +                +.                                       |   
     |   :    :                                                             |   
     |    :   :                                                             |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                     fxmark.hdd_xfs_MWUL_18_directio.sys_sec                    
                                                                                
  14 +----------------------------------------------------------------------+   
     |..+      +..+.+..+.+..+.+..+.  .+..+.+..+.+..+.+..+.+.   +..+    +    |   
  12 |-+:      :                   +.                                       |   
     |  :      :                                                            |   
  10 |-+:      :                                                            |   
     |   :    :   O    O O    O    O                    O O       O         |   
   8 |-+O:O  O:O    O       O    O       O O  O O  O O       O O            |   
     |   :    :                                                             |   
   6 |-+ :    :                                                             |   
     |   :    :                                                             |   
   4 |-+ :    :                                                             |   
     |    :  :                                                              |   
   2 |-+  :  :                                                              |   
     |    :  :                                                              |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                     fxmark.hdd_xfs_MWUL_18_directio.idle_sec                   
                                                                                
  450 +---------------------------------------------------------------------+   
      |                        O                                            |   
  400 |-+                                                                   |   
  350 |-+                                                                   |   
      |            O      O                             O  O                |   
  300 |-+O O    O    O  O         O O                        O  O O         |   
  250 |-+     O              O           O  O O  O O  O                     |   
      |                                                                     |   
  200 |-+                                                                   |   
  150 |-+                                                                   |   
      |                     .+.+..                .+..    .+.+..+.  .+.  .+.|   
  100 |..+      +..+.+..+.+.      +.+..+.+..+.+..+    +.+.        +.   +.   |   
   50 |-+ :    :                                                            |   
      |   :    :                                                            |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                     fxmark.hdd_xfs_MWUL_18_directio.irq_sec                    
                                                                                
  7 +-----------------------------------------------------------------------+   
    |                         O                                             |   
  6 |-+                                                                     |   
    |                    O                             O                    |   
  5 |-+O O    O  O O  O         O                         O       O         |   
    |       O              O       O    O  O    O    O       O O            |   
  4 |-+                                      O    O                         |   
    |                                                                       |   
  3 |-+                                                            .+..     |   
    |..+      +.. .+..+..+.+..+.+.. .+..+..+.+..+.+..+.+..+..+.+..+    +.+..|   
  2 |-+:      :  +                 +                                        |   
    |   :    :                                                              |   
  1 |-+ :    :                                                              |   
    |    :  :                                                               |   
  0 +-----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                     fxmark.hdd_xfs_MWUL_18_directio.user_util                  
                                                                                
  1.2 +---------------------------------------------------------------------+   
      |                            .+..                                     |   
    1 |..+      +..+.+..         .+             .+                         .|   
      |  :      :       +.+..+.+.      +.+..+.+.  +  .+.+..    .+.+..  +..+ |   
      |  :      :                                  +.      +.+.       +     |   
  0.8 |-+ :     :                                                    +      |   
      |   :    :                                                            |   
  0.6 |-+ :   O:                              O    O  O                     |   
      |  O:O   :O  O O  O O  O    O O    O  O    O         O O  O O         |   
  0.4 |-+ :    :               O                        O                   |   
      |   :    :                                                            |   
      |    :   :                                                            |   
  0.2 |-+  :  :                                                             |   
      |    :  :                                                             |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                    fxmark.hdd_xfs_MWUL_18_directio.sys_util                    
                                                                                
  12 +----------------------------------------------------------------------+   
     |..+      +..+.+..           +            .+..              .+         |   
  10 |-+:      :       +.+..    .+    +..+.+..+     .+..+.    .+.  +  .+. ..|   
     |  :      :            +.+.                   +      +..+      +.   +  |   
     |  :      :                                                            |   
   8 |-+ :    :                                                             |   
     |   :    :                                                             |   
   6 |-+ :    :                                                             |   
     |   :    :                                                             |   
   4 |-+ :    :                                                             |   
     |   :    :             O                 O    O                        |   
     |  O :  : O  O O  O O    O  O O     O O    O    O  O O  O O  O         |   
   2 |-+  :  :                                                              |   
     |    :  :                                                              |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                     fxmark.hdd_xfs_MWUL_18_directio.idle_util                  
                                                                                
  100 +---------------------------------------------------------------------+   
   90 |-+O O  O O  O O  O O  O O  O O    O  O O  O O  O O  O O  O O         |   
      |..+      +..+.+..+.+..+.+..+.+..+.+..+.+..+.+..+.+..+.+..+.+..+.+..+.|   
   80 |-+:      :                                                           |   
   70 |-+:      :                                                           |   
      |   :     :                                                           |   
   60 |-+ :    :                                                            |   
   50 |-+ :    :                                                            |   
   40 |-+ :    :                                                            |   
      |   :    :                                                            |   
   30 |-+ :    :                                                            |   
   20 |-+  :   :                                                            |   
      |    :  :                                                             |   
   10 |-+  :  :                                                             |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                     fxmark.hdd_xfs_MWUL_18_directio.irq_util                   
                                                                                
  2.5 +---------------------------------------------------------------------+   
      |                                                                     |   
      |                                                                     |   
    2 |..+      +..+.+..+.+..+.+..+.+.. .+.. .+..+.  .+.       .+.+.. .+.. .|   
      |  :      :                      +    +      +.   +..+.+.      +    + |   
      |  : O  O :  O    O O  O O  O O    O  O O  O O  O O  O O  O O         |   
  1.5 |-+ :    :     O                                                      |   
      |   :    :                                                            |   
    1 |-+ :    :                                                            |   
      |   :    :                                                            |   
      |   :    :                                                            |   
  0.5 |-+ :    :                                                            |   
      |    :  :                                                             |   
      |    :  :                                                             |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                     fxmark.hdd_xfs_MWUL_9_directio.real_sec                    
                                                                                
  18 +----------------------------------------------------------------------+   
     |            O O                                                       |   
  16 |-+  O  O O                                                            |   
  14 |-+O                O    O                         O O    O  O         |   
     |                 O    O              O  O O  O O                      |   
  12 |-+                         O O     O                   O              |   
  10 |-+                                                                    |   
     |                                                                      |   
   8 |-+                             .+.. .+..         .+.                  |   
   6 |..+      +..+.+..+.+..+.+..+.+.    +    +.+.. .+.   +..+.+..+.+..+.+..|   
     |  :      :                                   +                        |   
   4 |-+ :    :                                                             |   
   2 |-+ :    :                                                             |   
     |    :  :                                                              |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                     fxmark.hdd_xfs_MWUL_9_directio.sys_sec                     
                                                                                
  14 +----------------------------------------------------------------------+   
     |                                                 .+.                  |   
  12 |..+      +..+.+..+.+..+.+..+.+..+..+.+..+.+..+.+.   +..+.+..+.+..+.+..|   
     |  :      :                                                            |   
  10 |-+:      :                                                            |   
     |   :O    :  O                                                         |   
   8 |-+O:   O:O    O  O O  O O  O O     O O  O O  O O  O O  O O  O         |   
     |   :    :                                                             |   
   6 |-+ :    :                                                             |   
     |   :    :                                                             |   
   4 |-+ :    :                                                             |   
     |    :   :                                                             |   
   2 |-+  :  :                                                              |   
     |    :  :                                                              |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                      fxmark.hdd_xfs_MWUL_9_directio.idle_sec                   
                                                                                
  140 +---------------------------------------------------------------------+   
      |         O  O O                                                      |   
  120 |-+O O  O                                         O                   |   
      |                   O    O              O    O       O    O O         |   
  100 |-+               O    O    O         O    O    O      O              |   
      |                             O    O                                  |   
   80 |-+                                                                   |   
      |                                                                     |   
   60 |-+                                                                   |   
      |                               .+.  .+.         .+..         .+.     |   
   40 |..+      +..+.+..+.+..+.+..+.+.   +.   +..+.  .+    +.+..+.+.   +..+.|   
      |   :     :                                  +.                       |   
   20 |-+ :    :                                                            |   
      |    :   :                                                            |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                     fxmark.hdd_xfs_MWUL_9_directio.sys_util                    
                                                                                
  25 +----------------------------------------------------------------------+   
     | .+             .+.         .+           .+.   +..  +..+.        +.   |   
     |. :      +..+.+.   +..+.+..+  +    +    +          +     +..+. ..  +..|   
  20 |-+:      :                     + .. + ..          +           +       |   
     |  :      :                      +    +                                |   
     |   :     :                                                            |   
  15 |-+ :    :                                                             |   
     |   :    :                                                             |   
  10 |-+ :    :                                                             |   
     |   :    :                                                             |   
     |  O:    :        O O  O O  O O     O O  O O  O O    O  O O  O         |   
   5 |-+  :  O:O  O O                                   O                   |   
     |    :  :                                                              |   
     |    :  :                                                              |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                     fxmark.hdd_xfs_MWUL_9_directio.idle_util                   
                                                                                
  100 +---------------------------------------------------------------------+   
   90 |-+O O  O O  O O    O    O            O O  O O    O  O    O O         |   
      |                 O    O    O O    O            O      O              |   
   80 |-+                             .+.  .+.                              |   
   70 |..+      +..+.+..+.+..+.+..+.+.   +.   +..+.+..+.+..+.+..+.+..+.+..+.|   
      |  :      :                                                           |   
   60 |-+:      :                                                           |   
   50 |-+ :    :                                                            |   
   40 |-+ :    :                                                            |   
      |   :    :                                                            |   
   30 |-+ :    :                                                            |   
   20 |-+ :    :                                                            |   
      |    :  :                                                             |   
   10 |-+  :  :                                                             |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                      fxmark.hdd_xfs_MWUL_9_directio.irq_util                   
                                                                                
    3 +---------------------------------------------------------------------+   
      |                                                                     |   
  2.5 |-.+             .+.+..      .+..           .+..+.              .+..  |   
      |. :      +..+.+.      +.+..+    +.+..+.+..+      +..+.+..+.+..+    +.|   
      |  :      :                                                           |   
    2 |-+O:O    :  O    O O  O    O O    O  O O  O O  O O  O O  O O         |   
      |   :   O:O    O         O                                            |   
  1.5 |-+ :    :                                                            |   
      |   :    :                                                            |   
    1 |-+ :    :                                                            |   
      |   :    :                                                            |   
      |    :   :                                                            |   
  0.5 |-+  :  :                                                             |   
      |    :  :                                                             |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                       fxmark.hdd_xfs_MWUL_4_directio.secs                      
                                                                                
  12 +----------------------------------------------------------------------+   
     |                                                                      |   
  10 |-+                 O                                                  |   
     |  O O  O O  O         O O  O       O    O    O O  O O    O  O         |   
     |              O  O           O       O    O            O              |   
   8 |-+                                                                    |   
     |                                                                      |   
   6 |-+                     .+..                                .+.        |   
     |..+      +..+.+..+.+..+    +.+..+..+.+..+.+..+.+..+.+..+.+.   +..+.+..|   
   4 |-+:      :                                                            |   
     |   :    :                                                             |   
     |   :    :                                                             |   
   2 |-+ :    :                                                             |   
     |    :  :                                                              |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                      fxmark.hdd_xfs_MWUL_4_directio.works_sec                  
                                                                                
  12000 +-------------------------------------------------------------------+   
        |                                                   .+..            |   
  10000 |-+       +.+..   .+..+.  .+.    .+.  .+.       .+.+                |   
        |.+       :    +.+      +.   +..+   +.   +..+.+.        +.+..+.+..+.|   
        | :       :                                                         |   
   8000 |-+:     :                                                          |   
        |  :     :                                                          |   
   6000 |-+:     :     O O    O    O O      O  O O  O        O              |   
        | O: O O :O O      O    O         O           O  O O    O O         |   
   4000 |-+ :   :                                                           |   
        |   :   :                                                           |   
        |   :   :                                                           |   
   2000 |-+ :   :                                                           |   
        |    : :                                                            |   
      0 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                     fxmark.hdd_xfs_MWUL_4_directio.real_sec                    
                                                                                
  12 +----------------------------------------------------------------------+   
     |                                                                      |   
  10 |-+O O         O    O  O                             O                 |   
     |       O O  O           O  O       O           O  O                   |   
     |                 O           O       O  O O  O         O O  O         |   
   8 |-+                                                                    |   
     |                                                                      |   
   6 |..           .+..+.    .+.. .+..+.. .+..    .+.+..      .+..+.+..+.  .|   
     |  +      +..+      +..+    +       +    +.+.      +.+..+           +. |   
   4 |-+:      :                                                            |   
     |   :    :                                                             |   
     |   :    :                                                             |   
   2 |-+ :    :                                                             |   
     |    :  :                                                              |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                     fxmark.hdd_xfs_MWUL_4_directio.sys_sec                     
                                                                                
  12 +----------------------------------------------------------------------+   
     |..+      +..+.+..+.+..+.+..+.+..+..+.+..+.+..+.+..+.+..+.+..+.+..+.+..|   
  10 |-+:      :                                                            |   
     |  :      :                                                            |   
     |  :      :                                                            |   
   8 |-+O:O   :     O  O O  O      O                 O  O O                 |   
     |   :   O:O  O           O  O       O O  O O  O         O O  O         |   
   6 |-+ :    :                                                             |   
     |   :    :                                                             |   
   4 |-+ :    :                                                             |   
     |   :    :                                                             |   
     |    :  :                                                              |   
   2 |-+  :  :                                                              |   
     |    :  :                                                              |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                     fxmark.hdd_xfs_MWUL_4_directio.idle_sec                    
                                                                                
  35 +----------------------------------------------------------------------+   
     |              O                                                       |   
  30 |-+O O              O                                O                 |   
     |       O O  O         O O  O                   O  O      O            |   
  25 |-+               O           O     O O  O O  O         O    O         |   
     |                                                                      |   
  20 |-+                                                                    |   
     |                                                                      |   
  15 |-+                                                                    |   
     |                                                                      |   
  10 |..           .+..+.    .+.. .+..+.. .+..    .+.+..      .+..+.+..+.  .|   
     |  +      +..+      +..+    +       +    +.+.      +.+..+           +. |   
   5 |-+ :    :                                                             |   
     |   :    :                                                             |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                     fxmark.hdd_xfs_MWUL_4_directio.user_util                   
                                                                                
    4 +---------------------------------------------------------------------+   
      |                   +..                              +                |   
  3.5 |-.+        .+     :    .+.. .+.. .+.. .+..+.  .+. .. +         .+..+.|   
    3 |.+:      +.  +    :   +    +    +    +      +.   +    +..+.+..+      |   
      |  :      :    +..+                                                   |   
  2.5 |-+ :     :                        O  O    O           O    O         |   
      |  O:O  O:O  O    O O  O O  O O         O    O  O O  O    O           |   
    2 |-+ :    :     O                                                      |   
      |   :    :                                                            |   
  1.5 |-+ :    :                                                            |   
    1 |-+ :    :                                                            |   
      |    :   :                                                            |   
  0.5 |-+  :  :                                                             |   
      |    :  :                                                             |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                     fxmark.hdd_xfs_MWUL_4_directio.sys_util                    
                                                                                
  60 +----------------------------------------------------------------------+   
     |                  .+..             +    +.            .+.             |   
  50 |..+      +..+.+..+    +.  .+.+.. .. + ..  +..+.+..+.+.   +.. .+.. .+..|   
     |  :      :              +.      +    +                      +    +    |   
     |  :      :                                                            |   
  40 |-+ :     :                                                            |   
     |   :    :                                                             |   
  30 |-+ :    :                                                             |   
     |   :    :                                                             |   
  20 |-+ :    :   O    O    O O    O     O O  O O  O O  O O  O O            |   
     |  O:O  O:O    O    O       O                                O         |   
     |    :   :                                                             |   
  10 |-+  :  :                                                              |   
     |    :  :                                                              |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                    fxmark.hdd_xfs_MWUL_4_directio.idle_util                    
                                                                                
  80 +----------------------------------------------------------------------+   
     |  O O  O O  O O  O O  O O  O O     O O  O O  O O  O O  O O  O         |   
  70 |-+                                                                    |   
  60 |-+                                                                    |   
     |                                                                      |   
  50 |-+                                                                    |   
     |                       .+..    .+.. .+..                              |   
  40 |..+      +..+.+..+.  .+    +.+.    +    +.+..+.+..+.+.. .+..+.+..+.+..|   
     |  :      :         +.                                  +              |   
  30 |-+ :    :                                                             |   
  20 |-+ :    :                                                             |   
     |   :    :                                                             |   
  10 |-+ :    :                                                             |   
     |    :  :                                                              |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                      fxmark.hdd_xfs_MWUL_4_directio.irq_util                   
                                                                                
    4 +---------------------------------------------------------------------+   
      |         +..                                                         |   
  3.5 |..+      :  +.+..+.+..+.+..+.+.. .+.. .+..+.+..+.+..+.+..+.+..+.+..+.|   
    3 |-+:      :                      +    +                               |   
      |  :      :                                                           |   
  2.5 |-+O:O  O:O  O    O O  O O  O O    O  O O  O O  O O  O O  O O         |   
      |   :    :     O                                                      |   
    2 |-+ :    :                                                            |   
      |   :    :                                                            |   
  1.5 |-+ :    :                                                            |   
    1 |-+ :    :                                                            |   
      |    :  :                                                             |   
  0.5 |-+  :  :                                                             |   
      |    :  :                                                             |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                       fxmark.hdd_xfs_MWUL_2_directio.secs                      
                                                                                
  12 +----------------------------------------------------------------------+   
     |  O                     O    O                    O    O O            |   
  10 |-+       O            O                 O    O O    O       O         |   
     |    O  O    O    O O       O       O                                  |   
     |                                     O    O                           |   
   8 |-+                                                                    |   
     |                                                                      |   
   6 |-.+      +..+.+..+.+..+.+..+.+..+..+.+..+.+..+.+.. .+..+.+..+.+..+.+..|   
     |. :      :                                        +                   |   
   4 |-+ :    :                                                             |   
     |   :    :                                                             |   
     |   :    :                                                             |   
   2 |-+ :    :                                                             |   
     |    :  :                                                              |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                      fxmark.hdd_xfs_MWUL_2_directio.works_sec                  
                                                                                
  10000 +-------------------------------------------------------------------+   
   9000 |.+           .+.+.+.. .+.. .+..+.+.+..+.+..    .+.              .+.|   
        | :       +.+.        +    +                +.+.   +.+..+.+..+.+.   |   
   8000 |-:       :                                                         |   
   7000 |-+:      :                                                         |   
        |  :     :                                                          |   
   6000 |-+:   O :  O              O        O    O                          |   
   5000 |-+: O   :O      O O  O      O    O    O    O O    O O    O         |   
   4000 |-O :    :     O        O                        O      O           |   
        |   :   :                                                           |   
   3000 |-+ :   :                                                           |   
   2000 |-+ :   :                                                           |   
        |    :  :                                                           |   
   1000 |-+  : :                                                            |   
      0 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                     fxmark.hdd_xfs_MWUL_2_directio.idle_sec                    
                                                                                
  14 +----------------------------------------------------------------------+   
     |                                                  O      O            |   
  12 |-+O                                                         O         |   
     |            O      O       O            O    O                        |   
  10 |-+     O      O  O                             O                      |   
     |         O            O O    O       O    O            O              |   
   8 |-+  O                              O                O                 |   
     |                                                                      |   
   6 |-+                                                                    |   
     |                                                                      |   
   4 |-+                                                                    |   
     |                                                                      |   
   2 |-+         .+.       .+.                    .+.    .+..      .+..     |   
     |..+.    .+.   +..+.+.   +..+.+..+..+.+..+.+.   +..+    +.+..+    +.+..|   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                     fxmark.hdd_xfs_MWUL_2_directio.sys_util                    
                                                                                
  90 +----------------------------------------------------------------------+   
     |..           .+..                                .+               .+..|   
  80 |-++      +..+    +.+..+.+..+.+..+..+.+..+.+..+.+.  +  .+.+..+.+..+    |   
  70 |-+:      :                                          +.                |   
     |  :      :                                                            |   
  60 |-+ :     :                                                            |   
  50 |-+ :    :                                                             |   
     |   :   O:        O O       O         O    O    O         O  O         |   
  40 |-+O:O   :O  O O       O O    O     O    O    O    O O  O              |   
  30 |-+ :    :                                                             |   
     |   :    :                                                             |   
  20 |-+  :   :                                                             |   
  10 |-+  :  :                                                              |   
     |    :  :                                                              |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                    fxmark.hdd_xfs_MWUL_2_directio.idle_util                    
                                                                                
  60 +----------------------------------------------------------------------+   
     |                                                                      |   
  50 |-+O      O    O       O O    O     O    O    O      O  O              |   
     |    O  O    O    O O       O         O    O    O  O      O  O         |   
     |                                                                      |   
  40 |-+                                                                    |   
     |                                                                      |   
  30 |-+                                                                    |   
     |                                                                      |   
  20 |-+                                                                    |   
     |                                                    +..               |   
     |         +..+.  .+.+..+.  .+.+..  .+.  .+.+..+.+.. :   +.+.. .+..    .|   
  10 |..+     :     +.        +.      +.   +.            :        +    +.+. |   
     |   +    :                                         +                   |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                      fxmark.hdd_xfs_MWUL_2_directio.irq_util                   
                                                                                
    5 +---------------------------------------------------------------------+   
  4.5 |..+      +.. .+..+.+.. .+..    .+.  .+.  .+.+.. .+..    .+.+.. .+..+.|   
      |  :      :  +         +    +.+.   +.   +.      +    +.+.      +      |   
    4 |-+:      :                                                           |   
  3.5 |-+: O  O :  O    O O  O    O O    O  O    O    O    O O  O O         |   
      |   :    :O    O         O              O    O    O                   |   
    3 |-+ :    :                                                            |   
  2.5 |-+ :    :                                                            |   
    2 |-+ :    :                                                            |   
      |   :    :                                                            |   
  1.5 |-+ :    :                                                            |   
    1 |-+  :  :                                                             |   
      |    :  :                                                             |   
  0.5 |-+  :  :                                                             |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                       fxmark.hdd_xfs_MWUL_1_directio.secs                      
                                                                                
  14 +----------------------------------------------------------------------+   
     |  O O  O O  O O  O O  O O  O O     O O  O O  O O  O O  O O  O         |   
  12 |-+                                                                    |   
     |                                                                      |   
  10 |..+      +..+.+..+.+..    .+.                    .+.+..+.+..+.+..+.+..|   
     |  :      :            +.+.   +..+..+.+..+.+..+.+.                     |   
   8 |-+:      :                                                            |   
     |   :    :                                                             |   
   6 |-+ :    :                                                             |   
     |   :    :                                                             |   
   4 |-+ :    :                                                             |   
     |   :    :                                                             |   
   2 |-+  :  :                                                              |   
     |    :  :                                                              |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                     fxmark.hdd_xfs_MWUL_1_directio.works_sec                   
                                                                                
  6000 +--------------------------------------------------------------------+   
       |          .+..+.    .+..+.+..+.+..+.+.+..+.+..+.                   .|   
  5000 |.+       +      +..+                            +..+.+..+.+..+.+..+ |   
       | :       :                                                          |   
       |  : O    :                                                          |   
  4000 |-O:   O :O O  O O  O O  O O  O    O O O  O O  O O  O O  O O         |   
       |  :     :                                                           |   
  3000 |-+:     :                                                           |   
       |   :    :                                                           |   
  2000 |-+ :   :                                                            |   
       |   :   :                                                            |   
       |   :   :                                                            |   
  1000 |-+  :  :                                                            |   
       |    : :                                                             |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                     fxmark.hdd_xfs_MWUL_1_directio.real_sec                    
                                                                                
  14 +----------------------------------------------------------------------+   
     |  O O  O O  O    O    O O    O       O  O O  O O  O O       O         |   
  12 |-+                                                                    |   
     |                                                                      |   
  10 |..+      +..+.+..+.+..+.+..+.+..+..+.+..+.+..+.+..+.+..+.+..+.+..+.+..|   
     |  :      :                                                            |   
   8 |-+:      :                                                            |   
     |   :    :                                                             |   
   6 |-+ :    :                                                             |   
     |   :    :                                                             |   
   4 |-+ :    :                                                             |   
     |   :    :                                                             |   
   2 |-+  :  :                                                              |   
     |    :  :                                                              |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                     fxmark.hdd_xfs_MWUL_1_directio.sys_sec                     
                                                                                
  12 +----------------------------------------------------------------------+   
     |                                                                      |   
  10 |-+O O  O O  O O  O O  O    O       O O    O    O    O  O O  O         |   
     |                        O    O          O    O    O                   |   
     |..+      +..+.+..+.+..+.+..+.+..+..+.+..+.+..+.+..+.+..+.+..+.+..+.+..|   
   8 |-+:      :                                                            |   
     |  :      :                                                            |   
   6 |-+ :    :                                                             |   
     |   :    :                                                             |   
   4 |-+ :    :                                                             |   
     |   :    :                                                             |   
     |   :    :                                                             |   
   2 |-+  :  :                                                              |   
     |    :  :                                                              |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                      fxmark.hdd_xfs_MWUL_1_directio.idle_sec                   
                                                                                
    2 +---------------------------------------------------------------------+   
  1.8 |-+                                                    O              |   
      |                                  O                                  |   
  1.6 |-+     O      O         O  O           O    O  O         O           |   
  1.4 |-+  O    O         O                             O  O                |   
      |                      O      O       O    O                          |   
  1.2 |-+          O                                                        |   
    1 |-+O                                                        O         |   
  0.8 |-+               O                                                   |   
      |                                                                     |   
  0.6 |-+                                                                   |   
  0.4 |-+                                                                   |   
      |                                                                     |   
  0.2 |-+                     .+..                                          |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                     fxmark.hdd_xfs_MWUL_1_directio.sys_util                    
                                                                                
  90 +----------------------------------------------------------------------+   
     |..+      +..+.+..+.+..+.+..+.+..+..+.+..+.+..+.+..+.+..+.+..+.+..+.+..|   
  80 |-+: O  O :  O O  O O  O O  O O       O  O O  O O  O O    O  O         |   
  70 |-+:      :                         O                   O              |   
     |  :      :                                                            |   
  60 |-+ :    :                                                             |   
  50 |-+ :    :                                                             |   
     |   :    :                                                             |   
  40 |-+ :    :                                                             |   
  30 |-+ :    :                                                             |   
     |   :    :                                                             |   
  20 |-+  :  :                                                              |   
  10 |-+  :  :                                                              |   
     |    :  :                                                              |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                    fxmark.hdd_xfs_MWUL_1_directio.idle_util                    
                                                                                
  14 +----------------------------------------------------------------------+   
     |                                                       O              |   
  12 |-+     O      O         O          O    O    O           O            |   
     |    O                      O                   O  O O                 |   
  10 |-+       O         O         O       O    O                           |   
     |                      O                                               |   
   8 |-+O         O                                               O         |   
     |                                                                      |   
   6 |-+               O                                                    |   
     |                                                                      |   
   4 |-+                                                                    |   
     |                                                                      |   
   2 |-+                                                                    |   
     |..                     .+..+.                                         |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                      perf-sched.total_wait_time.average.ms                     
                                                                                
  80 +----------------------------------------------------------------------+   
     |    O  O O       O    O O  O O     O                O  O              |   
  70 |-+            O    O                 O  O O  O O  O         O         |   
  60 |-+                                                       O            |   
     |                                                                      |   
  50 |-+                                                                    |   
     |                                                                      |   
  40 |-+                                                                    |   
     |                                              .+..      .+.. .+..     |   
  30 |..+.+    +..+.  .+.+..+.+..+.  .+..+.+..+.+..+    +.+..+    +     .+..|   
  20 |-+   :   :    +.             +.                                  +    |   
     |     :  :                                                             |   
  10 |-+    : :                                                             |   
     |      ::                                                              |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                      perf-sched.total_wait_and_delay.count.ms                  
                                                                                
  100000 +------------------------------------------------------------------+   
   90000 |-+                          +                                     |   
         |           +.+..          .. +  .+. .+..                     +.. .|   
   80000 |.+..      +     +.+.. .+.+    +.   +    +.+     .+..    +    :  + |   
   70000 |-+  +    +           +                     +  .+    +. + +  :     |   
         |    :    :                                  +.        +   + :     |   
   60000 |-+  :   :                                                  +      |   
   50000 |-+   :  :                                                         |   
   40000 |-+   :  :                                                         |   
         |     :  :    O    O                O O  O O O  O      O           |   
   30000 |-O  O:O: O O    O    O O O  O    O               O  O   O         |   
   20000 |-+   : :                                                          |   
         |      ::                                                          |   
   10000 |-+    :                                                           |   
       0 +------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                   perf-sched.total_wait_and_delay.average.ms                   
                                                                                
  80 +----------------------------------------------------------------------+   
     |    O  O O       O    O O  O O     O                O  O              |   
  70 |-+            O    O                 O  O O  O O  O         O         |   
  60 |-+                                                       O            |   
     |                                                                      |   
  50 |-+                                                                    |   
     |                                                                      |   
  40 |-+                                                                    |   
     |                                              .+..      .+.. .+..     |   
  30 |..+.+    +..+.  .+.+..+.+..+.  .+..+.+..+.+..+    +.+..+    +     .+..|   
  20 |-+   :   :    +.             +.                                  +    |   
     |     :  :                                                             |   
  10 |-+    : :                                                             |   
     |      ::                                                              |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  50 +----------------------------------------------------------------------+   
  45 |-+                    O      O                                        |   
     |                                                                      |   
  40 |-+                         O       O                   O              |   
  35 |-+O              O O    O                      O  O O       O         |   
     |       O    O                        O  O O  O                        |   
  30 |-+  O    O                                               O            |   
  25 |-+            O                                                       |   
  20 |-+                                                                    |   
     |                                                                      |   
  15 |-+                                                                    |   
  10 |-+ .+                                         .+..           .+..     |   
     |..+  +   +..+.+..+.+..+.+..+.+..+..+.+..+.+..+    +.+..+.+..+    +.+..|   
   5 |-+    + +                                                             |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  60000 +-------------------------------------------------------------------+   
        |           +..+            .+..                                    |   
  50000 |.+..      :    +         .+     .+.  .+.+..                   +.. .|   
        |          :     +.+..+.+.      +   +.      +.    .+.+..  +.. :   + |   
        |    +    +                                   +..+       +    :     |   
  40000 |-+  :    :                                             +    +      |   
        |    :   :                                                          |   
  30000 |-+   :  :                                                          |   
        |     :  :                                                          |   
  20000 |-+   :  :                                                          |   
        |    O:O:      O                       O    O           O           |   
        | O   : : O O    O O  O O  O      O O    O    O  O O O    O         |   
  10000 |-+    ::                    O                                      |   
        |      :                                                            |   
      0 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  50 +----------------------------------------------------------------------+   
  45 |-+                    O      O                                        |   
     |                                                                      |   
  40 |-+                         O       O                   O              |   
  35 |-+O              O O    O                      O  O O       O         |   
     |       O    O                        O  O O  O                        |   
  30 |-+  O    O                                               O            |   
  25 |-+            O                                                       |   
  20 |-+                                                                    |   
     |                                                                      |   
  15 |-+                                                                    |   
  10 |-+ .+                                         .+..           .+..     |   
     |..+  +   +..+.+..+.+..+.+..+.+..+..+.+..+.+..+    +.+..+.+..+    +.+..|   
   5 |-+    + +                                                             |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                             fxmark.time.system_time                            
                                                                                
  60 +----------------------------------------------------------------------+   
     |                                                                      |   
  50 |..+      +..+.+..+.+..+.+..+.+..+..+.+..+.+..+.+..+.+..+.+..+.+..+.+..|   
     |  :      :       O                                                    |   
     |  : O  O :  O O    O  O O  O O     O O  O O  O O  O O  O O  O         |   
  40 |-+ :     :                                                            |   
     |   :    :                                                             |   
  30 |-+ :    :                                                             |   
     |   :    :                                                             |   
  20 |-+ :    :                                                             |   
     |   :    :                                                             |   
     |    :   :                                                             |   
  10 |-+  :  :                                                              |   
     |    :  :                                                              |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                     fxmark.time.percent_of_cpu_this_job_got                    
                                                                                
  20 +----------------------------------------------------------------------+   
  18 |..+      +..+.+..+.+..+.+..+.+..+..+.+..+.+..+.+..+.+..+.+..+.+..+.+..|   
     |  :      :                                                            |   
  16 |-+:      :                                                            |   
  14 |-+:      :                                                            |   
     |   :    :                                                             |   
  12 |-+ :    :                    O     O                O  O              |   
  10 |-+O:O  O:O  O O  O O  O O  O         O  O O  O O  O      O  O         |   
   8 |-+ :    :                                                             |   
     |   :    :                                                             |   
   6 |-+ :    :                                                             |   
   4 |-+  :  :                                                              |   
     |    :  :                                                              |   
   2 |-+  :  :                                                              |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                             fxmark.time.elapsed_time                           
                                                                                
  600 +---------------------------------------------------------------------+   
      |         O    O                                                      |   
  500 |-+O O  O    O    O O  O O  O O    O  O O  O O  O O  O O  O O         |   
      |                                                                     |   
      |                                                                     |   
  400 |-+                                                                   |   
      |..+      +..+.  .+.+.. .+.. .+.. .+.. .+..+.+..+.+..+.+..+.    .+.. .|   
  300 |-+:      :    +.      +    +    +    +                     +..+    + |   
      |   :     :                                                           |   
  200 |-+ :    :                                                            |   
      |   :    :                                                            |   
      |   :    :                                                            |   
  100 |-+  :   :                                                            |   
      |    :  :                                                             |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                           fxmark.time.elapsed_time.max                         
                                                                                
  600 +---------------------------------------------------------------------+   
      |         O    O                                                      |   
  500 |-+O O  O    O    O O  O O  O O    O  O O  O O  O O  O O  O O         |   
      |                                                                     |   
      |                                                                     |   
  400 |-+                                                                   |   
      |..+      +..+.  .+.+.. .+.. .+.. .+.. .+..+.+..+.+..+.+..+.    .+.. .|   
  300 |-+:      :    +.      +    +    +    +                     +..+    + |   
      |   :     :                                                           |   
  200 |-+ :    :                                                            |   
      |   :    :                                                            |   
      |   :    :                                                            |   
  100 |-+  :   :                                                            |   
      |    :  :                                                             |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                
[*] bisect-good sample
[O] bisect-bad  sample

***************************************************************************************************
lkp-ivb-2ep1: 48 threads Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz with 112G memory
=========================================================================================
class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/testcase/testtime/ucode:
  filesystem/gcc-9/performance/1HDD/xfs/x86_64-rhel-8.3/10%/debian-10.4-x86_64-20200603.cgz/lkp-ivb-2ep1/stress-ng/30s/0x42e

commit: 
  bd70706acf ("xfs: decide if inode needs inactivation")
  aa0a2ec202 ("xfs: deferred inode inactivation")

bd70706acfc93277 aa0a2ec202a8b319516cec852c8 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
           :4           75%           3:4     kmsg.XFS(sda1):xlog_verify_grant_tail:space>BBTOB(tail_blocks)
           :4           25%           1:4     kmsg.XFS(sdc1):xlog_verify_grant_tail:space>BBTOB(tail_blocks)
          0:4            2%           0:4     perf-profile.children.cycles-pp.error_entry
          0:4            3%           0:4     perf-profile.self.cycles-pp.error_entry
         %stddev     %change         %stddev
             \          |                \  
    762397           -34.0%     503332 ±  4%  stress-ng.dentry.ops
     25117           -34.3%      16507 ±  3%  stress-ng.dentry.ops_per_sec
    614345 ±  2%     -54.7%     278560 ± 10%  stress-ng.dir.ops
     20186 ±  2%     -55.2%       9044 ± 10%  stress-ng.dir.ops_per_sec
    345342 ±  4%     -68.5%     108645 ± 11%  stress-ng.dnotify.ops
     11511 ±  4%     -69.1%       3560 ± 10%  stress-ng.dnotify.ops_per_sec
     61369 ±  2%     -16.0%      51536 ±  4%  stress-ng.dup.ops
      2045 ±  2%     -16.0%       1717 ±  4%  stress-ng.dup.ops_per_sec
  10174292 ±  3%     -30.5%    7071785 ±  3%  stress-ng.fanotify.ops
    339083 ±  3%     -31.4%     232584 ±  2%  stress-ng.fanotify.ops_per_sec
     22806 ± 10%    +183.1%      64575 ± 13%  stress-ng.file-ioctl.ops
    760.07 ± 10%    +183.1%       2151 ± 13%  stress-ng.file-ioctl.ops_per_sec
    443564 ±  4%     -82.8%      76291 ±  6%  stress-ng.filename.ops
     14335 ±  4%     -82.8%       2461 ±  9%  stress-ng.filename.ops_per_sec
   2097131           +26.2%    2647620        stress-ng.open.ops
     57775 ±  7%     +51.2%      87339        stress-ng.open.ops_per_sec
     74.50 ±  2%     -32.6%      50.25 ±  3%  stress-ng.symlink.ops
      2.44 ±  2%     -35.1%       1.58 ±  2%  stress-ng.symlink.ops_per_sec
  24521968 ±  2%     -48.0%   12747982 ±  3%  stress-ng.time.file_system_outputs
    519151            -9.1%     471755 ±  2%  stress-ng.time.involuntary_context_switches
   6814722            -9.6%    6160333 ±  5%  stress-ng.time.minor_page_faults
    430.00            -5.9%     404.75        stress-ng.time.percent_of_cpu_this_job_got
      4313            -6.7%       4026        stress-ng.time.system_time
    923.92            -2.8%     897.91 ±  2%  stress-ng.time.user_time
  21538659 ±  3%      -5.5%   20348776        stress-ng.time.voluntary_context_switches
      9.95            -2.9%       9.66        iostat.cpu.system
      0.33 ±  3%      +0.0        0.35 ±  4%  mpstat.cpu.all.iowait%
      2746           +86.8%       5130 ±  3%  vmstat.io.bo
    146449 ±  2%     +31.2%     192179        meminfo.SUnreclaim
    342090 ±  2%     +15.3%     394548        meminfo.Slab
     60316 ± 37%     +72.5%     104035 ± 26%  numa-meminfo.node1.SUnreclaim
    125496 ± 60%     +75.4%     220167 ± 31%  numa-meminfo.node1.Slab
  16716070 ± 24%     -35.2%   10838307 ± 26%  numa-numastat.node0.local_node
  16743470 ± 24%     -35.1%   10866340 ± 26%  numa-numastat.node0.numa_hit
   1548486 ± 39%     -69.9%     466159 ± 46%  numa-vmstat.node0.nr_dirtied
     15076 ± 37%     +72.7%      26030 ± 26%  numa-vmstat.node1.nr_slab_unreclaimable
    121455 ± 16%     +43.7%     174520 ± 30%  sched_debug.cpu.nr_switches.min
      0.07 ±  7%     +16.3%       0.09        sched_debug.cpu.nr_uninterruptible.avg
      0.01 ± 62%    +220.0%       0.02 ± 49%  perf-sched.sch_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork
      0.70 ±132%     -93.4%       0.05 ±122%  perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.chmod_common.do_fchmodat.__x64_sys_fchmodat
      0.02 ± 68%     +91.9%       0.03 ± 42%  perf-sched.sch_delay.max.ms.schedule_timeout.wait_for_completion.__flush_work.lru_add_drain_all
      3.71 ± 13%     +15.4%       4.28 ± 18%  perf-sched.total_sch_delay.max.ms
      7236 ± 14%     -30.9%       4998 ± 15%  perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
    151.53 ± 65%     +93.7%     293.50 ± 11%  perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      0.00 ± 13%     +46.2%       0.00 ± 17%  perf-sched.wait_time.avg.ms.rwsem_down_write_slowpath.chmod_common.__x64_sys_fchmod.do_syscall_64
      0.08 ±102%  +3.1e+05%     250.22 ±172%  perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
      7236 ± 14%     -30.9%       4998 ± 15%  perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
    151.51 ± 65%     +93.7%     293.48 ± 11%  perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      1307            -6.4%       1223 ±  6%  proc-vmstat.nr_active_file
   3065246 ±  2%     -48.0%    1593497 ±  3%  proc-vmstat.nr_dirtied
     67017            -1.3%      66137        proc-vmstat.nr_inactive_anon
     11490            +1.4%      11654        proc-vmstat.nr_kernel_stack
     36609 ±  2%     +31.3%      48067        proc-vmstat.nr_slab_unreclaimable
      1307            -6.4%       1223 ±  6%  proc-vmstat.nr_zone_active_file
     67017            -1.3%      66137        proc-vmstat.nr_zone_inactive_anon
  27229902            -8.0%   25055284        proc-vmstat.numa_hit
  27185796            -8.0%   25011208        proc-vmstat.numa_local
    251478            -2.0%     246429        proc-vmstat.pgactivate
  31503578            -5.2%   29875694        proc-vmstat.pgalloc_normal
  10270259            -6.6%    9593490 ±  3%  proc-vmstat.pgfault
  31446645            -5.1%   29833764        proc-vmstat.pgfree
   3352880           +86.3%    6245878 ±  3%  proc-vmstat.pgpgout
    417588            -8.9%     380376 ±  2%  proc-vmstat.pgreuse
      3.80            +0.2        4.04        perf-stat.i.branch-miss-rate%
  27214428            -3.6%   26234148 ±  2%  perf-stat.i.branch-misses
      3.10            +4.3%       3.24        perf-stat.i.cpi
 1.781e+10            -2.8%  1.731e+10 ±  2%  perf-stat.i.cpu-cycles
 2.278e+09            -5.8%  2.145e+09        perf-stat.i.dTLB-loads
 1.443e+09            -5.6%  1.362e+09        perf-stat.i.dTLB-stores
     74.42            +2.6       76.99        perf-stat.i.iTLB-load-miss-rate%
   4074352            -6.7%    3801097 ±  2%  perf-stat.i.iTLB-load-misses
   1385167 ±  6%     -24.2%    1049686 ±  7%  perf-stat.i.iTLB-loads
      0.51            -3.8%       0.49        perf-stat.i.ipc
      0.37            -2.8%       0.36 ±  2%  perf-stat.i.metric.GHz
    121.14            -5.1%     114.97        perf-stat.i.metric.M/sec
      8241            -6.5%       7702 ±  3%  perf-stat.i.minor-faults
      8241            -6.5%       7703 ±  3%  perf-stat.i.page-faults
     74.63            +3.8       78.39        perf-stat.overall.iTLB-load-miss-rate%
     46.13            -0.8       45.31        perf-stat.overall.node-load-miss-rate%
  27193617            -3.6%   26217941 ±  2%  perf-stat.ps.branch-misses
 1.783e+10            -2.8%  1.734e+10 ±  2%  perf-stat.ps.cpu-cycles
 2.279e+09            -5.8%  2.147e+09        perf-stat.ps.dTLB-loads
 1.442e+09            -5.6%  1.362e+09        perf-stat.ps.dTLB-stores
   4070600            -6.7%    3799155 ±  2%  perf-stat.ps.iTLB-load-misses
   1384203 ±  6%     -24.2%    1048928 ±  7%  perf-stat.ps.iTLB-loads
      0.68            +7.8%       0.74 ±  7%  perf-stat.ps.major-faults
      8242            -6.5%       7703 ±  3%  perf-stat.ps.minor-faults
      8243            -6.5%       7704 ±  3%  perf-stat.ps.page-faults
 1.178e+13 ±  2%      -4.3%  1.127e+13 ±  3%  perf-stat.total.instructions
     96391           +34.8%     129901 ±  2%  softirqs.BLOCK
    148604 ±  3%     -10.7%     132694 ±  2%  softirqs.CPU0.SCHED
    148732 ±  6%     -20.3%     118548 ± 12%  softirqs.CPU13.SCHED
    229059 ± 25%     -53.7%     106151 ± 15%  softirqs.CPU2.RCU
    191392 ± 23%     -43.1%     108976 ± 34%  softirqs.CPU24.RCU
    186326 ± 22%     -29.9%     130523 ± 26%  softirqs.CPU25.RCU
    210905 ± 34%     -52.9%      99410 ± 12%  softirqs.CPU26.RCU
      6202 ± 60%     -60.4%       2457 ± 49%  softirqs.CPU27.TIMER
    360.25 ±  5%    +707.0%       2907 ±146%  softirqs.CPU29.NET_RX
    159637 ± 26%     -34.4%     104653 ± 20%  softirqs.CPU29.RCU
    222899 ± 24%     -53.9%     102799 ± 28%  softirqs.CPU30.RCU
    250400 ± 31%     -62.8%      93049 ± 24%  softirqs.CPU31.RCU
    140102 ± 36%     -38.6%      86012 ± 14%  softirqs.CPU32.RCU
    182901 ± 26%     -48.3%      94561 ± 22%  softirqs.CPU35.RCU
    166453 ± 22%     -25.6%     123825 ± 23%  softirqs.CPU36.RCU
    164252 ± 13%     -37.1%     103303 ± 22%  softirqs.CPU40.RCU
    135252 ± 10%     +15.7%     156436 ±  3%  softirqs.CPU45.SCHED
      9848 ± 60%     -72.5%       2708 ± 46%  softirqs.CPU5.TIMER
      7088 ± 30%     -57.8%       2990 ± 20%  softirqs.CPU6.TIMER
    203903 ± 28%     -50.8%     100257 ± 17%  softirqs.CPU7.RCU
    173360 ± 19%     -40.5%     103154 ± 24%  softirqs.CPU8.RCU
    123880           +30.9%     162160 ±  2%  softirqs.CPU8.TASKLET
    225545 ± 32%     -51.0%     110580 ± 35%  softirqs.CPU9.RCU
   8763854 ± 13%     -30.4%    6099526 ± 11%  softirqs.RCU
    124127           +30.8%     162412 ±  2%  softirqs.TASKLET
    177777 ±  4%      -9.8%     160339        softirqs.TIMER
      0.63 ± 16%      +0.2        0.85 ±  9%  perf-profile.calltrace.cycles-pp.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      1.03 ± 19%      +0.3        1.28 ± 15%  perf-profile.calltrace.cycles-pp.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.asm_call_sysvec_on_stack
      0.27 ±100%      +0.4        0.64 ± 11%  perf-profile.calltrace.cycles-pp.do_softirq_own_stack.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.15 ±173%      +0.5        0.63 ± 11%  perf-profile.calltrace.cycles-pp.asm_call_sysvec_on_stack.do_softirq_own_stack.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.14 ±173%      +0.5        0.63 ± 11%  perf-profile.calltrace.cycles-pp.__softirqentry_text_start.asm_call_sysvec_on_stack.do_softirq_own_stack.irq_exit_rcu.sysvec_apic_timer_interrupt
      4.05 ± 18%      +1.0        5.04 ± 11%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      0.55 ± 30%      -0.2        0.30 ± 32%  perf-profile.children.cycles-pp.xlog_grant_push_ail
      0.53 ± 31%      -0.2        0.29 ± 34%  perf-profile.children.cycles-pp.xlog_grant_push_threshold
      0.04 ± 58%      +0.0        0.07 ± 17%  perf-profile.children.cycles-pp.run_posix_cpu_timers
      0.14 ± 17%      +0.0        0.19 ±  9%  perf-profile.children.cycles-pp.update_blocked_averages
      0.12 ±  6%      +0.1        0.18 ± 14%  perf-profile.children.cycles-pp.__hrtimer_next_event_base
      0.15 ± 18%      +0.1        0.20 ±  7%  perf-profile.children.cycles-pp.run_rebalance_domains
      0.01 ±173%      +0.1        0.07 ± 17%  perf-profile.children.cycles-pp.native_apic_mem_write
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.can_stop_idle_tick
      0.28 ± 15%      +0.1        0.35 ± 16%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.25 ± 17%      +0.1        0.32 ± 15%  perf-profile.children.cycles-pp.io_serial_in
      0.44 ± 14%      +0.1        0.56 ± 16%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.50 ± 15%      +0.2        0.68 ±  9%  perf-profile.children.cycles-pp.do_softirq_own_stack
      0.49 ± 15%      +0.2        0.67 ±  9%  perf-profile.children.cycles-pp.__softirqentry_text_start
      0.67 ± 14%      +0.2        0.90 ±  8%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.07 ± 12%      +0.0        0.10 ± 15%  perf-profile.self.cycles-pp.irq_exit_rcu
      0.04 ± 58%      +0.0        0.07 ± 17%  perf-profile.self.cycles-pp.run_posix_cpu_timers
      0.03 ±100%      +0.0        0.07 ±  7%  perf-profile.self.cycles-pp.get_next_timer_interrupt
      0.03 ±100%      +0.0        0.07 ± 12%  perf-profile.self.cycles-pp.__sysvec_apic_timer_interrupt
      0.11 ±  7%      +0.0        0.15 ± 17%  perf-profile.self.cycles-pp.__hrtimer_next_event_base
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.can_stop_idle_tick
      0.01 ±173%      +0.1        0.07 ± 22%  perf-profile.self.cycles-pp.native_apic_mem_write
      0.25 ± 17%      +0.1        0.32 ± 15%  perf-profile.self.cycles-pp.io_serial_in
      1414 ± 60%    +285.3%       5450 ± 53%  interrupts.36:PCI-MSI.2621442-edge.eth0-TxRx-1
    699.25 ±  5%    +727.1%       5783 ±147%  interrupts.38:PCI-MSI.2621444-edge.eth0-TxRx-3
    245008           +31.2%     321564 ±  2%  interrupts.73:PCI-MSI.2097152-edge.isci-msix
      4059 ± 35%  +13879.8%     567546 ±133%  interrupts.CPU1.RES:Rescheduling_interrupts
     17484 ± 22%    +363.4%      81025 ± 27%  interrupts.CPU12.CAL:Function_call_interrupts
     11267 ± 31%     +64.1%      18493 ± 26%  interrupts.CPU12.TLB:TLB_shootdowns
     15771 ± 41%    +315.1%      65472 ± 55%  interrupts.CPU15.CAL:Function_call_interrupts
     22895 ± 21%    +105.8%      47130 ± 27%  interrupts.CPU16.CAL:Function_call_interrupts
     13855 ± 18%    +219.9%      44330 ± 17%  interrupts.CPU17.CAL:Function_call_interrupts
      1991 ± 45%    +781.9%      17560 ±142%  interrupts.CPU17.RES:Rescheduling_interrupts
     14126 ± 30%     +94.1%      27414 ± 36%  interrupts.CPU19.CAL:Function_call_interrupts
     12856 ± 37%    +312.0%      52972 ± 39%  interrupts.CPU20.CAL:Function_call_interrupts
      2135 ± 27%   +5630.6%     122347 ±166%  interrupts.CPU20.RES:Rescheduling_interrupts
     11053 ± 56%    +215.3%      34852 ± 28%  interrupts.CPU20.TLB:TLB_shootdowns
     52976 ± 55%     -70.2%      15791 ± 25%  interrupts.CPU26.CAL:Function_call_interrupts
      1414 ± 60%    +285.3%       5450 ± 53%  interrupts.CPU27.36:PCI-MSI.2621442-edge.eth0-TxRx-1
    699.25 ±  5%    +727.1%       5783 ±147%  interrupts.CPU29.38:PCI-MSI.2621444-edge.eth0-TxRx-3
    155.50 ± 24%    +777.7%       1364 ±147%  interrupts.CPU3.NMI:Non-maskable_interrupts
    155.50 ± 24%    +777.7%       1364 ±147%  interrupts.CPU3.PMI:Performance_monitoring_interrupts
     13711 ± 27%     +89.6%      25998 ± 26%  interrupts.CPU30.TLB:TLB_shootdowns
    133.75 ± 13%    +312.5%     551.75 ± 92%  interrupts.CPU34.NMI:Non-maskable_interrupts
    133.75 ± 13%    +312.5%     551.75 ± 92%  interrupts.CPU34.PMI:Performance_monitoring_interrupts
    178.25 ± 29%     +52.2%     271.25 ±  8%  interrupts.CPU35.NMI:Non-maskable_interrupts
    178.25 ± 29%     +52.2%     271.25 ±  8%  interrupts.CPU35.PMI:Performance_monitoring_interrupts
     19344 ± 53%    +190.0%      56103 ± 23%  interrupts.CPU37.CAL:Function_call_interrupts
     11575 ± 33%    +198.7%      34576 ± 61%  interrupts.CPU38.TLB:TLB_shootdowns
     10009 ± 25%    +112.9%      21306 ± 16%  interrupts.CPU40.TLB:TLB_shootdowns
     19680 ± 28%    +233.2%      65572 ± 31%  interrupts.CPU41.CAL:Function_call_interrupts
      2000 ± 28%    +149.1%       4983 ± 49%  interrupts.CPU41.RES:Rescheduling_interrupts
     20595 ± 51%    +140.9%      49613 ± 51%  interrupts.CPU42.CAL:Function_call_interrupts
      1996 ± 31%     +94.9%       3890 ± 22%  interrupts.CPU42.RES:Rescheduling_interrupts
      2420 ± 48%  +22009.8%     535222 ±162%  interrupts.CPU43.RES:Rescheduling_interrupts
      2536 ± 27%     +78.3%       4522 ± 16%  interrupts.CPU44.RES:Rescheduling_interrupts
     15485 ± 28%    +158.7%      40058 ± 57%  interrupts.CPU46.CAL:Function_call_interrupts
      2308 ± 23%   +6628.5%     155311 ±168%  interrupts.CPU46.RES:Rescheduling_interrupts
     13813 ± 32%    +276.8%      52045 ± 39%  interrupts.CPU47.CAL:Function_call_interrupts
      2184 ± 35%    +104.7%       4471 ± 17%  interrupts.CPU47.RES:Rescheduling_interrupts
    245008           +31.2%     321564 ±  2%  interrupts.CPU8.73:PCI-MSI.2097152-edge.isci-msix
    415032 ±153%     -98.2%       7495 ±123%  interrupts.CPU8.RES:Rescheduling_interrupts
     57924 ± 40%     -69.6%      17593 ± 33%  interrupts.CPU9.CAL:Function_call_interrupts
     19168           -20.6%      15216 ± 13%  slabinfo.Acpi-Parse.active_objs
     19420           -21.6%      15216 ± 13%  slabinfo.Acpi-Parse.num_objs
    289.50 ± 22%     +58.0%     457.50 ± 11%  slabinfo.biovec-128.active_objs
    289.50 ± 22%     +58.0%     457.50 ± 11%  slabinfo.biovec-128.num_objs
    622.50 ± 20%     +59.0%     989.50 ±  8%  slabinfo.biovec-64.active_objs
    622.50 ± 20%     +59.0%     989.50 ±  8%  slabinfo.biovec-64.num_objs
    322.25 ± 14%     +43.7%     463.00 ±  6%  slabinfo.biovec-max.active_objs
    324.50 ± 14%     +51.3%     491.00 ±  5%  slabinfo.biovec-max.num_objs
    176664 ±  3%     -23.0%     136056        slabinfo.dentry.active_objs
      8900 ±  4%     -22.0%       6941        slabinfo.dentry.active_slabs
    186915 ±  4%     -22.0%     145772        slabinfo.dentry.num_objs
      8900 ±  4%     -22.0%       6941        slabinfo.dentry.num_slabs
      2820 ±  4%    +235.5%       9463 ± 29%  slabinfo.dmaengine-unmap-16.active_objs
     67.00 ±  5%    +238.4%     226.75 ± 28%  slabinfo.dmaengine-unmap-16.active_slabs
      2839 ±  5%    +236.4%       9549 ± 28%  slabinfo.dmaengine-unmap-16.num_objs
     67.00 ±  5%    +238.4%     226.75 ± 28%  slabinfo.dmaengine-unmap-16.num_slabs
      1597 ± 44%    +130.4%       3679 ±  2%  slabinfo.dnotify_struct.active_objs
      1597 ± 44%    +130.4%       3679 ±  2%  slabinfo.dnotify_struct.num_objs
     42701 ±  5%     -24.4%      32288        slabinfo.filp.active_objs
      2731 ±  5%     -24.0%       2075        slabinfo.filp.active_slabs
     43714 ±  5%     -24.0%      33218        slabinfo.filp.num_objs
      2731 ±  5%     -24.0%       2075        slabinfo.filp.num_slabs
     67887 ± 11%     +25.0%      84872        slabinfo.kmalloc-16.active_objs
     69225 ± 10%     +29.2%      89464        slabinfo.kmalloc-16.num_objs
     16838 ±  4%     -12.5%      14737        slabinfo.kmalloc-192.active_objs
     20086 ±  4%      -9.7%      18131 ±  2%  slabinfo.kmalloc-192.num_objs
      6339 ±  2%     +22.1%       7741 ±  3%  slabinfo.kmalloc-256.active_objs
    411.00 ±  2%     +27.6%     524.25 ±  2%  slabinfo.kmalloc-256.active_slabs
      6584 ±  2%     +27.5%       8395 ±  2%  slabinfo.kmalloc-256.num_objs
    411.00 ±  2%     +27.6%     524.25 ±  2%  slabinfo.kmalloc-256.num_slabs
     26190 ±  2%    +186.6%      75070 ±  3%  slabinfo.kmalloc-512.active_objs
      4235 ±  3%    +165.5%      11243 ±  3%  slabinfo.kmalloc-512.active_slabs
     33883 ±  3%    +165.5%      89948 ±  3%  slabinfo.kmalloc-512.num_objs
      4235 ±  3%    +165.5%      11243 ±  3%  slabinfo.kmalloc-512.num_slabs
     40900 ±  7%     +16.8%      47790 ±  6%  slabinfo.kmalloc-64.active_objs
    648.25 ±  7%     +16.6%     755.75 ±  6%  slabinfo.kmalloc-64.active_slabs
     41529 ±  7%     +16.5%      48398 ±  6%  slabinfo.kmalloc-64.num_objs
    648.25 ±  7%     +16.6%     755.75 ±  6%  slabinfo.kmalloc-64.num_slabs
    141552 ± 10%     -59.6%      57244 ± 12%  slabinfo.kmalloc-8.active_objs
    276.00 ± 10%     -56.1%     121.25 ± 12%  slabinfo.kmalloc-8.active_slabs
    141556 ± 10%     -55.9%      62376 ± 11%  slabinfo.kmalloc-8.num_objs
    276.00 ± 10%     -56.1%     121.25 ± 12%  slabinfo.kmalloc-8.num_slabs
    799.50 ±  2%    +153.4%       2026 ±  2%  slabinfo.kmalloc-8k.active_objs
    217.75 ±  2%    +160.8%     568.00        slabinfo.kmalloc-8k.active_slabs
    872.50 ±  2%    +160.6%       2273        slabinfo.kmalloc-8k.num_objs
    217.75 ±  2%    +160.8%     568.00        slabinfo.kmalloc-8k.num_slabs
     15268 ±  3%     -13.4%      13219        slabinfo.kmalloc-96.active_objs
     16467 ±  3%     -11.7%      14534        slabinfo.kmalloc-96.num_objs
      9876 ± 11%     -60.8%       3871 ± 14%  slabinfo.kmalloc-rcl-128.active_objs
    810.50           -68.5%     255.50 ±  5%  slabinfo.kmalloc-rcl-128.active_slabs
     25952           -68.4%       8193 ±  5%  slabinfo.kmalloc-rcl-128.num_objs
    810.50           -68.5%     255.50 ±  5%  slabinfo.kmalloc-rcl-128.num_slabs
     16724 ±  4%     -70.3%       4964 ±  4%  slabinfo.kmalloc-rcl-192.active_objs
      8146 ±  3%     -75.9%       1963 ±  6%  slabinfo.kmalloc-rcl-192.active_slabs
    171083 ±  3%     -75.9%      41242 ±  6%  slabinfo.kmalloc-rcl-192.num_objs
      8146 ±  3%     -75.9%       1963 ±  6%  slabinfo.kmalloc-rcl-192.num_slabs
      6677 ±  3%     -69.3%       2052 ±  6%  slabinfo.kmalloc-rcl-256.active_objs
      1048 ±  2%     -70.0%     314.75 ±  3%  slabinfo.kmalloc-rcl-256.active_slabs
     16779 ±  2%     -69.9%       5048 ±  3%  slabinfo.kmalloc-rcl-256.num_objs
      1048 ±  2%     -70.0%     314.75 ±  3%  slabinfo.kmalloc-rcl-256.num_slabs
     15097 ±  3%     -71.5%       4308        slabinfo.kmalloc-rcl-512.active_objs
      2847 ±  5%     -73.7%     749.25 ±  3%  slabinfo.kmalloc-rcl-512.active_slabs
     22782 ±  5%     -73.7%       5995 ±  3%  slabinfo.kmalloc-rcl-512.num_objs
      2847 ±  5%     -73.7%     749.25 ±  3%  slabinfo.kmalloc-rcl-512.num_slabs
     19138 ± 14%     -48.5%       9855 ±  6%  slabinfo.kmalloc-rcl-64.active_objs
      1074 ±  7%     -71.5%     306.25 ±  4%  slabinfo.kmalloc-rcl-64.active_slabs
     68822 ±  7%     -71.5%      19630 ±  4%  slabinfo.kmalloc-rcl-64.num_objs
      1074 ±  7%     -71.5%     306.25 ±  4%  slabinfo.kmalloc-rcl-64.num_slabs
     12739 ±  6%     -35.4%       8226 ± 13%  slabinfo.kmalloc-rcl-96.active_objs
     12993 ±  6%     -34.7%       8487 ± 12%  slabinfo.kmalloc-rcl-96.num_objs
     64154 ±  6%     -14.1%      55123 ±  5%  slabinfo.lsm_file_cache.active_objs
      1816 ± 22%     +68.3%       3056 ±  9%  slabinfo.numa_policy.active_objs
    123.75 ± 22%     +72.1%     213.00 ±  8%  slabinfo.numa_policy.active_slabs
      1864 ± 22%     +71.7%       3202 ±  8%  slabinfo.numa_policy.num_objs
    123.75 ± 22%     +72.1%     213.00 ±  8%  slabinfo.numa_policy.num_slabs
    911.50 ±  4%     +12.4%       1024        slabinfo.pool_workqueue.num_objs
     54939 ±  9%     -20.9%      43483        slabinfo.proc_inode_cache.active_objs
      4587 ±  9%     -20.8%       3633        slabinfo.proc_inode_cache.active_slabs
     55058 ±  9%     -20.8%      43599        slabinfo.proc_inode_cache.num_objs
      4587 ±  9%     -20.8%       3633        slabinfo.proc_inode_cache.num_slabs
      8917 ±  4%     -21.7%       6982 ±  2%  slabinfo.shmem_inode_cache.active_objs
    816.50 ±  5%     -21.7%     639.00 ±  2%  slabinfo.shmem_inode_cache.active_slabs
      8984 ±  5%     -21.7%       7033 ±  2%  slabinfo.shmem_inode_cache.num_objs
    816.50 ±  5%     -21.7%     639.00 ±  2%  slabinfo.shmem_inode_cache.num_slabs
    637.00 ± 18%     +59.3%       1014 ±  9%  slabinfo.skbuff_fclone_cache.active_objs
    637.00 ± 18%     +59.3%       1014 ±  9%  slabinfo.skbuff_fclone_cache.num_objs
      1856 ±  4%     +18.5%       2200 ±  7%  slabinfo.skbuff_head_cache.num_objs
      3052 ± 28%    +101.0%       6134 ± 13%  slabinfo.xfs_buf.active_objs
     76.00 ± 27%    +107.2%     157.50 ± 11%  slabinfo.xfs_buf.active_slabs
      3205 ± 27%    +106.9%       6634 ± 11%  slabinfo.xfs_buf.num_objs
     76.00 ± 27%    +107.2%     157.50 ± 11%  slabinfo.xfs_buf.num_slabs
      2670 ± 33%     +88.4%       5029 ± 24%  slabinfo.xfs_efd_item.active_objs
      2776 ± 32%     +88.3%       5229 ± 24%  slabinfo.xfs_efd_item.num_objs
      2763 ± 33%     +84.9%       5110 ± 23%  slabinfo.xfs_efi_item.active_objs
      2873 ± 32%     +85.0%       5316 ± 23%  slabinfo.xfs_efi_item.num_objs
      4069 ± 52%    +111.7%       8615 ± 21%  slabinfo.xfs_icr.active_objs
     88.25 ± 52%    +115.6%     190.25 ± 21%  slabinfo.xfs_icr.active_slabs
      4085 ± 52%    +115.2%       8789 ± 21%  slabinfo.xfs_icr.num_objs
     88.25 ± 52%    +115.6%     190.25 ± 21%  slabinfo.xfs_icr.num_slabs
     18407 ±  4%    +259.7%      66215 ±  2%  slabinfo.xfs_ili.active_objs
    451.50 ±  3%    +277.2%       1703 ±  2%  slabinfo.xfs_ili.active_slabs
     18980 ±  3%    +277.0%      71552 ±  2%  slabinfo.xfs_ili.num_objs
    451.50 ±  3%    +277.2%       1703 ±  2%  slabinfo.xfs_ili.num_slabs
     16851 ±  4%    +282.4%      64436 ±  2%  slabinfo.xfs_inode.active_objs
    541.75 ±  2%    +298.7%       2160        slabinfo.xfs_inode.active_slabs
     17359 ±  2%    +298.3%      69141        slabinfo.xfs_inode.num_objs
    541.75 ±  2%    +298.7%       2160        slabinfo.xfs_inode.num_slabs





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


Thanks,
Oliver Sang


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.11.0-rc4-00084-gaa0a2ec202a8"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.11.0-rc4 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-9 (Debian 9.3.0-15) 9.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=90300
CONFIG_LD_VERSION=235000000
CONFIG_CLANG_VERSION=0
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
CONFIG_BPF=y
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
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
# CONFIG_BPF_LSM is not set
CONFIG_BPF_SYSCALL=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_BPF_JIT_DEFAULT_ON=y
# CONFIG_BPF_PRELOAD is not set
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
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
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
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
CONFIG_X86_THERMAL_VECTOR=y

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
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y

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
CONFIG_SFI=y

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
CONFIG_OPROFILE=m
CONFIG_OPROFILE_EVENT_MULTIPLEX=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
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
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y

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
# CONFIG_MODULE_COMPRESS is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_TRIM_UNUSED_KSYMS is not set
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
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_BOUNCE=y
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
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ZONE_DEVICE=y
CONFIG_DEV_PAGEMAP_OPS=y
CONFIG_HMM_MIRROR=y
CONFIG_DEVICE_PRIVATE=y
CONFIG_VMAP_PFN=y
CONFIG_FRAME_VECTOR=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_MAPPING_DIRTY_HELPERS=y
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
CONFIG_NF_LOG_COMMON=m
CONFIG_NF_LOG_NETDEV=m
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
CONFIG_NF_LOG_BRIDGE=m
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
CONFIG_HAVE_NET_DSA=y
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
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_JIT=y
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
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
CONFIG_PAGE_POOL=y
CONFIG_FAILOVER=m
CONFIG_ETHTOOL_NETLINK=y
CONFIG_HAVE_EBPF_JIT=y

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
# CONFIG_PCIE_BW is not set
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
CONFIG_KUNIT_DRIVER_PE_TEST=y
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
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_SKD is not set
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
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_MISC_RTSX=m
CONFIG_PVPANIC=y
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
# CONFIG_MISC_ALCOR_PCI is not set
CONFIG_MISC_RTSX_PCI=m
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_HABANA_AI is not set
# CONFIG_UACCE is not set
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
# CONFIG_SCSI_GDTH is not set
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

#
# Distributed Switch Architecture drivers
#
# end of Distributed Switch Architecture drivers

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
# CONFIG_NET_VENDOR_AURORA is not set
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
# CONFIG_IGC is not set
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
# CONFIG_MICREL_PHY is not set
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_NATIONAL_PHY is not set
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
# CONFIG_SERIAL_IFX6X60 is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_ROCKETPORT is not set
CONFIG_CYCLADES=m
# CONFIG_CYZ_INTR is not set
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
CONFIG_SYNCLINK_GT=m
# CONFIG_ISI is not set
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
CONFIG_NOZOMI=m
# CONFIG_NULL_TTY is not set
# CONFIG_TRACE_SINK is not set
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
# CONFIG_DEVKMEM is not set
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
# CONFIG_GPIO_XILINX is not set
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
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ2515X is not set
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_BQ25980 is not set
CONFIG_CHARGER_SMB347=m
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
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
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
# CONFIG_SENSORS_AMD_ENERGY is not set
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
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
# CONFIG_SENSORS_ADM1266 is not set
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_BEL_PFE is not set
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_INSPUR_IPSPS is not set
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_IR38064 is not set
# CONFIG_SENSORS_IRPS5401 is not set
# CONFIG_SENSORS_ISL68137 is not set
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC3815 is not set
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
# CONFIG_ABX500_CORE is not set
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
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# CONFIG_DRM_VGEM is not set
# CONFIG_DRM_VKMS is not set
CONFIG_DRM_VMWGFX=m
CONFIG_DRM_VMWGFX_FBCON=y
CONFIG_DRM_GMA500=m
CONFIG_DRM_GMA600=y
CONFIG_DRM_GMA3600=y
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
# CONFIG_DRM_XEN is not set
# CONFIG_DRM_VBOXVIDEO is not set
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
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
# CONFIG_HID_ROCCAT is not set
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
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
CONFIG_I2C_HID=m
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
# CONFIG_USB_CDNS3 is not set
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
# CONFIG_INFINIBAND_BNXT_RE is not set
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
# CONFIG_EDAC_AMD64_ERROR_INJECTION is not set
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
# CONFIG_XILINX_ZYNQMP_DPDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
# CONFIG_DW_EDMA is not set
# CONFIG_DW_EDMA_PCIE is not set
CONFIG_HSU_DMA=y
# CONFIG_SF_PDMA is not set

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
# CONFIG_STAGING is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
# CONFIG_ALIENWARE_WMI is not set
# CONFIG_HUAWEI_WMI is not set
# CONFIG_UV_SYSFS is not set
# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
CONFIG_INTEL_WMI_THUNDERBOLT=m
CONFIG_MXM_WMI=m
# CONFIG_PEAQ_WMI is not set
# CONFIG_XIAOMI_WMI is not set
CONFIG_ACERHDF=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACER_WMI=m
# CONFIG_AMD_PMC is not set
CONFIG_APPLE_GMUX=m
CONFIG_ASUS_LAPTOP=m
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
CONFIG_EEEPC_LAPTOP=m
CONFIG_EEEPC_WMI=m
CONFIG_DCDBAS=m
CONFIG_DELL_SMBIOS=m
CONFIG_DELL_SMBIOS_WMI=y
# CONFIG_DELL_SMBIOS_SMM is not set
CONFIG_DELL_LAPTOP=m
CONFIG_DELL_RBTN=m
CONFIG_DELL_RBU=m
CONFIG_DELL_SMO8800=m
CONFIG_DELL_WMI=m
# CONFIG_DELL_WMI_SYSMAN is not set
CONFIG_DELL_WMI_DESCRIPTOR=m
CONFIG_DELL_WMI_AIO=m
CONFIG_DELL_WMI_LED=m
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
# CONFIG_INTEL_PMT_CLASS is not set
# CONFIG_INTEL_PMT_TELEMETRY is not set
# CONFIG_INTEL_PMT_CRASHLOG is not set
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
# CONFIG_XILINX_VCU is not set
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
# CONFIG_F2FS_IO_TRACE is not set
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
# CONFIG_IMA_DEFAULT_HASH_SHA512 is not set
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
CONFIG_LSM="lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor,bpf"

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
CONFIG_CRYPTO_GLUE_HELPER_X86=y

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=m
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
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
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=y
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
CONFIG_CRYPTO_RMD128=m
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_RMD256=m
CONFIG_CRYPTO_RMD320=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
# CONFIG_CRYPTO_SM3 is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_TGR192=m
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
CONFIG_CRYPTO_SALSA20=m
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
CONFIG_DEBUG_INFO_DWARF4=y
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
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
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
# CONFIG_MEMTEST is not set
# CONFIG_HYPERV_TESTING is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='fxmark'
	export testcase='fxmark'
	export category='benchmark'
	export media='hdd'
	export job_origin='/lkp-src/allot/cyclic:p2:linux-devel:devel-hourly/lkp-knm01/fxmark-lkp-knm01.yaml'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue='validate'
	export testbox='lkp-knm01'
	export tbox_group='lkp-knm01'
	export kconfig='x86_64-rhel-8.3'
	export submit_id='6014ffc0f3136e5ce973687e'
	export job_file='/lkp/jobs/scheduled/lkp-knm01/fxmark-performance-directio-1HDD-xfs-hdd-MWUL-ucode=0x11-monitor=70d6d718-debian-10.4-x86_64-20200603.cgz-aa0a2ec202a8b319516cec-20210130-23785-1cy9azx-3.yaml'
	export id='3427d950ab770fb7d113fa98c17f945615d340e6'
	export queuer_version='/lkp-src'
	export model='Knights Mill'
	export nr_node=1
	export nr_cpu=288
	export memory='80G'
	export hdd_partitions='/dev/disk/by-id/ata-WDC_WD30EZRX-00SPEB0_WD-WCC4E4EK5J23-part2
/dev/disk/by-id/ata-WDC_WD30EZRX-00SPEB0_WD-WCC4E4EK5J23-part3'
	export nr_hdd_partitions=2
	export nr_ssd_partitions=2
	export ssd_partitions='/dev/disk/by-id/nvme-INTEL_SSDPECME016T4_CVF8709100031P6IGN-1-part1
/dev/disk/by-id/nvme-INTEL_SSDPECME016T4_CVF8709100031P6IGN-2-part1'
	export swap_partitions='LABEL=SWAP'
	export rootfs_partition='/dev/disk/by-id/ata-WDC_WD30EZRX-00SPEB0_WD-WCC4E4EK5J23-part1'
	export brand='Intel(R) Xeon Phi(TM) CPU 7295 @ 1.50GHz'
	export need_kconfig='CONFIG_BLK_DEV_SD
CONFIG_SCSI
CONFIG_BLOCK=y
CONFIG_SATA_AHCI
CONFIG_SATA_AHCI_PLATFORM
CONFIG_ATA
CONFIG_PCI=y
CONFIG_F2FS_FS=m'
	export commit='aa0a2ec202a8b319516cec852c8c206557749b4c'
	export need_kconfig_hw='CONFIG_IGB=y
CONFIG_SATA_AHCI
CONFIG_BLK_DEV_NVME'
	export ucode='0x11'
	export enqueue_time='2021-01-30 14:42:08 +0800'
	export _id='6014ffc3f3136e5ce973687f'
	export _rt='/result/fxmark/performance-directio-1HDD-xfs-hdd-MWUL-ucode=0x11-monitor=70d6d718/lkp-knm01/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/aa0a2ec202a8b319516cec852c8c206557749b4c'
	export user='lkp'
	export compiler='gcc-9'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='cc87ac2d6c99fe52675fca5f4f5a947954d340d7'
	export base_commit='6ee1d745b7c9fd573fba142a2efdad76a9f1cb04'
	export branch='djwong-xfs/reserve-rt-metadata-space'
	export rootfs='debian-10.4-x86_64-20200603.cgz'
	export monitor_sha='70d6d718'
	export result_root='/result/fxmark/performance-directio-1HDD-xfs-hdd-MWUL-ucode=0x11-monitor=70d6d718/lkp-knm01/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/aa0a2ec202a8b319516cec852c8c206557749b4c/3'
	export scheduler_version='/lkp/lkp/.src-20210129-150426'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-knm01/fxmark-performance-directio-1HDD-xfs-hdd-MWUL-ucode=0x11-monitor=70d6d718-debian-10.4-x86_64-20200603.cgz-aa0a2ec202a8b319516cec-20210130-23785-1cy9azx-3.yaml
ARCH=x86_64
kconfig=x86_64-rhel-8.3
branch=djwong-xfs/reserve-rt-metadata-space
commit=aa0a2ec202a8b319516cec852c8c206557749b4c
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/aa0a2ec202a8b319516cec852c8c206557749b4c/vmlinuz-5.11.0-rc4-00084-gaa0a2ec202a8
max_uptime=2100
RESULT_ROOT=/result/fxmark/performance-directio-1HDD-xfs-hdd-MWUL-ucode=0x11-monitor=70d6d718/lkp-knm01/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/aa0a2ec202a8b319516cec852c8c206557749b4c/3
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
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3/gcc-9/aa0a2ec202a8b319516cec852c8c206557749b4c/modules.cgz'
	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20201211.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/fxmark_20210107.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/fxmark-x86_64-0ce9491-1_20210107.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20201126.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-e71ba9452f0b-1_20210106.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20201117.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.9.0-rc1-00045-gc9a6bef24e6d7'
	export repeat_to=4
	export queue_at_least_once=1
	export kernel='/pkg/linux/x86_64-rhel-8.3/gcc-9/aa0a2ec202a8b319516cec852c8c206557749b4c/vmlinuz-5.11.0-rc4-00084-gaa0a2ec202a8'
	export dequeue_time='2021-01-30 15:00:46 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-knm01/fxmark-performance-directio-1HDD-xfs-hdd-MWUL-ucode=0x11-monitor=70d6d718-debian-10.4-x86_64-20200603.cgz-aa0a2ec202a8b319516cec-20210130-23785-1cy9azx-3.cgz'

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

	run_setup nr_hdd=1 $LKP_SRC/setup/disk

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
	run_monitor $LKP_SRC/monitors/wrapper perf-sched
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
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test test='MWUL' fstype='xfs' directio='directio' $LKP_SRC/tests/wrapper fxmark
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper fxmark
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
	$LKP_SRC/stats/wrapper perf-sched
	$LKP_SRC/stats/wrapper softirqs
	$LKP_SRC/stats/wrapper diskstats
	$LKP_SRC/stats/wrapper nfsstat
	$LKP_SRC/stats/wrapper cpuidle
	$LKP_SRC/stats/wrapper sched_debug
	$LKP_SRC/stats/wrapper perf-stat
	$LKP_SRC/stats/wrapper mpstat
	$LKP_SRC/stats/wrapper perf-profile

	$LKP_SRC/stats/wrapper time fxmark.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/fxmark-lkp-knm01.yaml
suite: fxmark
testcase: fxmark
category: benchmark
disk: 1HDD
media: hdd
fxmark:
  test: MWUL
  fstype: xfs
  directio: directio
job_origin: "/lkp-src/allot/cyclic:p2:linux-devel:devel-hourly/lkp-knm01/fxmark-lkp-knm01.yaml"

#! queue options
queue_cmdline_keys:
- branch
- commit
- queue_at_least_once
queue: bisect
testbox: lkp-knm01
tbox_group: lkp-knm01
kconfig: x86_64-rhel-8.3
submit_id: 6014ee18f3136e583842b8c4
job_file: "/lkp/jobs/scheduled/lkp-knm01/fxmark-performance-directio-1HDD-xfs-hdd-MWUL-ucode=0x11-monitor=70d6d718-debian-10.4-x86_64-20200603.cgz-aa0a2ec202a8b319516cec-20210130-22584-htqrvz-1.yaml"
id: c2d945b54a76017916720455dfd3fdb3e67310e4
queuer_version: "/lkp-src"

#! hosts/lkp-knm01
model: Knights Mill
nr_node: 1
nr_cpu: 288
memory: 80G
hdd_partitions:
- "/dev/disk/by-id/ata-WDC_WD30EZRX-00SPEB0_WD-WCC4E4EK5J23-part2"
- "/dev/disk/by-id/ata-WDC_WD30EZRX-00SPEB0_WD-WCC4E4EK5J23-part3"
nr_hdd_partitions: 2
nr_ssd_partitions: 2
ssd_partitions:
- "/dev/disk/by-id/nvme-INTEL_SSDPECME016T4_CVF8709100031P6IGN-1-part1"
- "/dev/disk/by-id/nvme-INTEL_SSDPECME016T4_CVF8709100031P6IGN-2-part1"
swap_partitions: LABEL=SWAP
rootfs_partition: "/dev/disk/by-id/ata-WDC_WD30EZRX-00SPEB0_WD-WCC4E4EK5J23-part1"
brand: Intel(R) Xeon Phi(TM) CPU 7295 @ 1.50GHz

#! include/category/benchmark
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

#! include/category/ALL
cpufreq_governor: performance

#! include/disk/nr_hdd
need_kconfig:
- CONFIG_BLK_DEV_SD
- CONFIG_SCSI
- CONFIG_BLOCK=y
- CONFIG_SATA_AHCI
- CONFIG_SATA_AHCI_PLATFORM
- CONFIG_ATA
- CONFIG_PCI=y
- CONFIG_F2FS_FS=m

#! include/fxmark

#! include/queue/cyclic
commit: aa0a2ec202a8b319516cec852c8c206557749b4c

#! include/testbox/lkp-knm01
need_kconfig_hw:
- CONFIG_IGB=y
- CONFIG_SATA_AHCI
- CONFIG_BLK_DEV_NVME
ucode: '0x11'
enqueue_time: 2021-01-30 13:26:48.929186318 +08:00
_id: 6014f653f3136e583842b8c5
_rt: "/result/fxmark/performance-directio-1HDD-xfs-hdd-MWUL-ucode=0x11-monitor=70d6d718/lkp-knm01/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/aa0a2ec202a8b319516cec852c8c206557749b4c"

#! schedule options
user: lkp
compiler: gcc-9
LKP_SERVER: internal-lkp-server
head_commit: cc87ac2d6c99fe52675fca5f4f5a947954d340d7
base_commit: 6ee1d745b7c9fd573fba142a2efdad76a9f1cb04
branch: linux-devel/devel-hourly-20210129-151358
rootfs: debian-10.4-x86_64-20200603.cgz
monitor_sha: 70d6d718
result_root: "/result/fxmark/performance-directio-1HDD-xfs-hdd-MWUL-ucode=0x11-monitor=70d6d718/lkp-knm01/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/aa0a2ec202a8b319516cec852c8c206557749b4c/0"
scheduler_version: "/lkp/lkp/.src-20210129-150426"
arch: x86_64
max_uptime: 2100
initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-knm01/fxmark-performance-directio-1HDD-xfs-hdd-MWUL-ucode=0x11-monitor=70d6d718-debian-10.4-x86_64-20200603.cgz-aa0a2ec202a8b319516cec-20210130-22584-htqrvz-1.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3
- branch=linux-devel/devel-hourly-20210129-151358
- commit=aa0a2ec202a8b319516cec852c8c206557749b4c
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/aa0a2ec202a8b319516cec852c8c206557749b4c/vmlinuz-5.11.0-rc4-00084-gaa0a2ec202a8
- max_uptime=2100
- RESULT_ROOT=/result/fxmark/performance-directio-1HDD-xfs-hdd-MWUL-ucode=0x11-monitor=70d6d718/lkp-knm01/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/aa0a2ec202a8b319516cec852c8c206557749b4c/0
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
modules_initrd: "/pkg/linux/x86_64-rhel-8.3/gcc-9/aa0a2ec202a8b319516cec852c8c206557749b4c/modules.cgz"
bm_initrd: "/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20201211.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/fxmark_20210107.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/fxmark-x86_64-0ce9491-1_20210107.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20201126.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-e71ba9452f0b-1_20210106.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20201117.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn

#! /lkp/lkp/.src-20210129-150426/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer: 
watchdog: 

#! runtime status
last_kernel: 4.20.0
repeat_to: 2

#! user overrides
queue_at_least_once: 0
kernel: "/pkg/linux/x86_64-rhel-8.3/gcc-9/aa0a2ec202a8b319516cec852c8c206557749b4c/vmlinuz-5.11.0-rc4-00084-gaa0a2ec202a8"
dequeue_time: 2021-01-30 14:08:06.689005448 +08:00
job_state: finished
loadavg: 8.36 17.99 11.85 1/2153 18991
start_time: '1611986993'
end_time: '1611987509'
version: "/lkp/lkp/.src-20210129-150457:0bf10eb4:083a53f24"

--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce


for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*
do
	online_file="$cpu_dir"/online
	[ -f "$online_file" ] && [ "$(cat "$online_file")" -eq 0 ] && continue

	file="$cpu_dir"/cpufreq/scaling_governor
	[ -f "$file" ] && echo "performance" > "$file"
done


--gBBFr7Ir9EOA20Yy--
