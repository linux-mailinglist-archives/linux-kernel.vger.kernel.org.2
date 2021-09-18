Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13B4E4104DC
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 09:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242469AbhIRHnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 03:43:01 -0400
Received: from mga17.intel.com ([192.55.52.151]:34225 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233688AbhIRHm4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 03:42:56 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10110"; a="203087532"
X-IronPort-AV: E=Sophos;i="5.85,303,1624345200"; 
   d="scan'208";a="203087532"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2021 00:41:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,303,1624345200"; 
   d="scan'208";a="546852483"
Received: from lkp-server01.sh.intel.com (HELO 285e7b116627) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Sep 2021 00:41:30 -0700
Received: from kbuild by 285e7b116627 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mRUyX-0004jS-K8; Sat, 18 Sep 2021 07:41:29 +0000
Date:   Sat, 18 Sep 2021 15:41:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:kcsan] BUILD SUCCESS
 ac20e39e8d254da3f82b5ed2afc7bb1e804d32c9
Message-ID: <61459823.KmrbRLtCjIYFP/UU%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git kcsan
branch HEAD: ac20e39e8d254da3f82b5ed2afc7bb1e804d32c9  kcsan: selftest: Cleanup and add missing __init

elapsed time: 2212m

configs tested: 213
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210916
i386                 randconfig-c001-20210918
sh                          rsk7269_defconfig
powerpc                     ep8248e_defconfig
riscv                    nommu_virt_defconfig
m68k                       bvme6000_defconfig
powerpc64                        alldefconfig
um                                  defconfig
openrisc                 simple_smp_defconfig
arm                        oxnas_v6_defconfig
mips                     loongson2k_defconfig
arm                      tct_hammer_defconfig
h8300                            alldefconfig
sh                          landisk_defconfig
um                           x86_64_defconfig
arm                        mvebu_v7_defconfig
arc                        nsimosci_defconfig
arc                 nsimosci_hs_smp_defconfig
arm                          badge4_defconfig
mips                  decstation_64_defconfig
mips                            e55_defconfig
mips                     loongson1b_defconfig
sh                           se7712_defconfig
powerpc                        warp_defconfig
arm                      integrator_defconfig
powerpc                 mpc837x_rdb_defconfig
ia64                                defconfig
powerpc                 mpc8313_rdb_defconfig
mips                      pic32mzda_defconfig
sh                          r7785rp_defconfig
powerpc                      ppc6xx_defconfig
arm                          simpad_defconfig
s390                          debug_defconfig
arm                       mainstone_defconfig
arm                            qcom_defconfig
arm                          pcm027_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                     tqm8541_defconfig
powerpc                    klondike_defconfig
powerpc                     tqm8548_defconfig
powerpc                     kmeter1_defconfig
powerpc                  mpc885_ads_defconfig
arm                         cm_x300_defconfig
sh                               alldefconfig
m68k                         amcore_defconfig
ia64                        generic_defconfig
arm                        vexpress_defconfig
m68k                        m5272c3_defconfig
arm                        clps711x_defconfig
arm                     davinci_all_defconfig
openrisc                  or1klitex_defconfig
arm                           viper_defconfig
arm                            zeus_defconfig
powerpc                      tqm8xx_defconfig
arm                        mvebu_v5_defconfig
powerpc                     sequoia_defconfig
arm                        mini2440_defconfig
mips                        workpad_defconfig
arm                     eseries_pxa_defconfig
sh                           se7343_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                       maple_defconfig
arm                             pxa_defconfig
arm                           tegra_defconfig
sh                           se7780_defconfig
mips                    maltaup_xpa_defconfig
powerpc                      acadia_defconfig
arm                          pxa168_defconfig
sh                        sh7785lcr_defconfig
arm                        multi_v7_defconfig
powerpc                      chrp32_defconfig
sh                          sdk7786_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                        spear3xx_defconfig
powerpc                     powernv_defconfig
mips                          rm200_defconfig
mips                     cu1000-neo_defconfig
arm                          ep93xx_defconfig
xtensa                  audio_kc705_defconfig
xtensa                          iss_defconfig
sh                          kfr2r09_defconfig
x86_64                              defconfig
sh                                  defconfig
x86_64                           allyesconfig
powerpc                  storcenter_defconfig
arm                        keystone_defconfig
arm                             ezx_defconfig
arm                       omap2plus_defconfig
powerpc                    adder875_defconfig
m68k                         apollo_defconfig
arm                       multi_v4t_defconfig
powerpc                   motionpro_defconfig
arm                         s3c6400_defconfig
s390                             alldefconfig
powerpc                     tqm8540_defconfig
powerpc                    socrates_defconfig
powerpc                       eiger_defconfig
powerpc                mpc7448_hpc2_defconfig
mips                         cobalt_defconfig
x86_64               randconfig-c001-20210916
arm                  randconfig-c002-20210916
x86_64               randconfig-c001-20210918
arm                  randconfig-c002-20210918
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
arc                              allyesconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
s390                             allyesconfig
parisc                           allyesconfig
parisc                              defconfig
s390                                defconfig
s390                             allmodconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a013-20210918
x86_64               randconfig-a016-20210918
x86_64               randconfig-a012-20210918
x86_64               randconfig-a011-20210918
x86_64               randconfig-a014-20210918
x86_64               randconfig-a015-20210918
x86_64               randconfig-a016-20210916
x86_64               randconfig-a013-20210916
x86_64               randconfig-a012-20210916
x86_64               randconfig-a011-20210916
x86_64               randconfig-a014-20210916
x86_64               randconfig-a015-20210916
i386                 randconfig-a016-20210916
i386                 randconfig-a015-20210916
i386                 randconfig-a011-20210916
i386                 randconfig-a012-20210916
i386                 randconfig-a013-20210916
i386                 randconfig-a014-20210916
i386                 randconfig-a016-20210918
i386                 randconfig-a012-20210918
i386                 randconfig-a011-20210918
i386                 randconfig-a015-20210918
i386                 randconfig-a013-20210918
i386                 randconfig-a014-20210918
riscv                randconfig-r042-20210916
s390                 randconfig-r044-20210916
arc                  randconfig-r043-20210916
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
riscv                randconfig-c006-20210916
x86_64               randconfig-c007-20210916
mips                 randconfig-c004-20210916
powerpc              randconfig-c003-20210916
arm                  randconfig-c002-20210916
i386                 randconfig-c001-20210916
s390                 randconfig-c005-20210916
riscv                randconfig-c006-20210917
x86_64               randconfig-c007-20210917
mips                 randconfig-c004-20210917
powerpc              randconfig-c003-20210917
arm                  randconfig-c002-20210917
i386                 randconfig-c001-20210917
s390                 randconfig-c005-20210917
riscv                randconfig-c006-20210918
x86_64               randconfig-c007-20210918
powerpc              randconfig-c003-20210918
mips                 randconfig-c004-20210918
i386                 randconfig-c001-20210918
arm                  randconfig-c002-20210918
s390                 randconfig-c005-20210918
x86_64               randconfig-a002-20210916
x86_64               randconfig-a003-20210916
x86_64               randconfig-a006-20210916
x86_64               randconfig-a004-20210916
x86_64               randconfig-a005-20210916
x86_64               randconfig-a001-20210916
i386                 randconfig-a004-20210916
i386                 randconfig-a005-20210916
i386                 randconfig-a006-20210916
i386                 randconfig-a002-20210916
i386                 randconfig-a003-20210916
i386                 randconfig-a001-20210916
i386                 randconfig-a004-20210918
i386                 randconfig-a005-20210918
i386                 randconfig-a002-20210918
i386                 randconfig-a006-20210918
i386                 randconfig-a001-20210918
i386                 randconfig-a003-20210918
hexagon              randconfig-r045-20210916
hexagon              randconfig-r041-20210916

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
