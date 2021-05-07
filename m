Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB02C375E86
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 03:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234053AbhEGBsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 21:48:33 -0400
Received: from mga14.intel.com ([192.55.52.115]:1130 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229801AbhEGBsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 21:48:30 -0400
IronPort-SDR: BZATXBAqY3ZxUsdxtqVa7Ot7shifU4T5NywS7xylGhXnu83BvfG0qz7Gmx40hu2JuMrM1OJ8G5
 eFIAQkblYhAg==
X-IronPort-AV: E=McAfee;i="6200,9189,9976"; a="198270855"
X-IronPort-AV: E=Sophos;i="5.82,279,1613462400"; 
   d="scan'208";a="198270855"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2021 18:47:31 -0700
IronPort-SDR: Vbxsh18j6iczcjDk55LYzWilx/D6ai55apQeVRSO39ls1QhW7ZZi4+sSvakWzMgDfWJrl1kWTo
 KcpSmsiLogRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,279,1613462400"; 
   d="scan'208";a="397446126"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 06 May 2021 18:47:30 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lepaT-000Ay8-I0; Fri, 07 May 2021 01:47:29 +0000
Date:   Fri, 07 May 2021 09:46:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/urgent] BUILD SUCCESS
 0258bdfaff5bd13c4d2383150b7097aecd6b6d82
Message-ID: <60949c06.qAI/ktMeDh/Wv40Z%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/urgent
branch HEAD: 0258bdfaff5bd13c4d2383150b7097aecd6b6d82  sched/fair: Fix unfairness caused by missing load decay

elapsed time: 729m

configs tested: 186
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
riscv                            allmodconfig
i386                             allyesconfig
riscv                            allyesconfig
arm                       mainstone_defconfig
powerpc                     pq2fads_defconfig
sparc                       sparc64_defconfig
arm                        keystone_defconfig
um                               alldefconfig
s390                                defconfig
mips                          rb532_defconfig
arm                             ezx_defconfig
riscv             nommu_k210_sdcard_defconfig
mips                      maltasmvp_defconfig
arm                         cm_x300_defconfig
arm                         hackkit_defconfig
arm                     eseries_pxa_defconfig
sparc                               defconfig
powerpc                        fsp2_defconfig
arm                            zeus_defconfig
openrisc                  or1klitex_defconfig
arm                        spear6xx_defconfig
powerpc                     ep8248e_defconfig
arm                         orion5x_defconfig
arm                        multi_v7_defconfig
powerpc                      ep88xc_defconfig
powerpc                    amigaone_defconfig
m68k                            q40_defconfig
powerpc                      acadia_defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                    ge_imp3a_defconfig
sh                          rsk7203_defconfig
sh                          polaris_defconfig
arm                        shmobile_defconfig
mips                        nlm_xlr_defconfig
arm                          lpd270_defconfig
mips                         bigsur_defconfig
arm                           sama5_defconfig
m68k                       m5249evb_defconfig
arm                      integrator_defconfig
s390                          debug_defconfig
mips                      malta_kvm_defconfig
h8300                    h8300h-sim_defconfig
powerpc                        cell_defconfig
powerpc                     tqm8560_defconfig
sh                      rts7751r2d1_defconfig
mips                     loongson1c_defconfig
sparc64                          alldefconfig
mips                        omega2p_defconfig
sh                     sh7710voipgw_defconfig
m68k                          multi_defconfig
sh                          lboxre2_defconfig
mips                           gcw0_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc                      mgcoge_defconfig
mips                           mtx1_defconfig
m68k                            mac_defconfig
sh                           se7751_defconfig
riscv                            alldefconfig
powerpc                      ppc40x_defconfig
mips                          ath25_defconfig
sh                   sh7724_generic_defconfig
mips                           jazz_defconfig
m68k                         amcore_defconfig
powerpc                 mpc834x_mds_defconfig
arm                        oxnas_v6_defconfig
arm                         nhk8815_defconfig
powerpc                 mpc832x_rdb_defconfig
m68k                             allyesconfig
powerpc                     redwood_defconfig
arm                       cns3420vb_defconfig
arm                         mv78xx0_defconfig
sparc                       sparc32_defconfig
sh                                  defconfig
arc                        vdk_hs38_defconfig
arm                          moxart_defconfig
powerpc                      obs600_defconfig
arm                       imx_v6_v7_defconfig
ia64                        generic_defconfig
mips                        bcm47xx_defconfig
arm                          exynos_defconfig
m68k                                defconfig
x86_64                              defconfig
mips                       bmips_be_defconfig
arc                              alldefconfig
m68k                        m5272c3_defconfig
arc                        nsimosci_defconfig
powerpc                     powernv_defconfig
powerpc                     asp8347_defconfig
mips                        jmr3927_defconfig
mips                      loongson3_defconfig
mips                     cu1830-neo_defconfig
arc                            hsdk_defconfig
arm                        realview_defconfig
m68k                       m5275evb_defconfig
arm                       multi_v4t_defconfig
powerpc                     akebono_defconfig
arm                       aspeed_g5_defconfig
arm                        mvebu_v7_defconfig
arm                          simpad_defconfig
arm                      jornada720_defconfig
riscv                    nommu_k210_defconfig
mips                        nlm_xlp_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                    sam440ep_defconfig
sh                 kfr2r09-romimage_defconfig
mips                         cobalt_defconfig
mips                           ip22_defconfig
arm                              alldefconfig
xtensa                generic_kc705_defconfig
powerpc                   currituck_defconfig
powerpc                     stx_gp3_defconfig
um                            kunit_defconfig
powerpc                     rainier_defconfig
mips                         mpc30x_defconfig
powerpc                 mpc837x_mds_defconfig
sh                              ul2_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
sparc                            allyesconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210506
i386                 randconfig-a006-20210506
i386                 randconfig-a001-20210506
i386                 randconfig-a005-20210506
i386                 randconfig-a004-20210506
i386                 randconfig-a002-20210506
x86_64               randconfig-a014-20210506
x86_64               randconfig-a015-20210506
x86_64               randconfig-a012-20210506
x86_64               randconfig-a013-20210506
x86_64               randconfig-a011-20210506
x86_64               randconfig-a016-20210506
i386                 randconfig-a015-20210506
i386                 randconfig-a013-20210506
i386                 randconfig-a016-20210506
i386                 randconfig-a014-20210506
i386                 randconfig-a012-20210506
i386                 randconfig-a011-20210506
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a001-20210506
x86_64               randconfig-a003-20210506
x86_64               randconfig-a005-20210506
x86_64               randconfig-a002-20210506
x86_64               randconfig-a006-20210506
x86_64               randconfig-a004-20210506

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
