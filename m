Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92443453979
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 19:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239549AbhKPSmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 13:42:16 -0500
Received: from mga03.intel.com ([134.134.136.65]:22670 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233361AbhKPSmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 13:42:12 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10170"; a="233737343"
X-IronPort-AV: E=Sophos;i="5.87,239,1631602800"; 
   d="scan'208";a="233737343"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2021 10:37:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,239,1631602800"; 
   d="scan'208";a="536013828"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 16 Nov 2021 10:37:20 -0800
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mn3KZ-0000hn-Q9; Tue, 16 Nov 2021 18:37:19 +0000
Date:   Wed, 17 Nov 2021 02:36:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/mm] BUILD SUCCESS
 19c88fc96d941dd7102399bbf7f437f2b93d7e4e
Message-ID: <6193fa35.ScBxYLoe/1ItdFN1%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/mm
branch HEAD: 19c88fc96d941dd7102399bbf7f437f2b93d7e4e  x86/mm: Add missing <asm/cpufeatures.h> dependency to <asm/page_64.h>

elapsed time: 725m

configs tested: 209
configs skipped: 71

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211116
powerpc                      ep88xc_defconfig
mips                      pic32mzda_defconfig
powerpc                     rainier_defconfig
powerpc                 mpc834x_itx_defconfig
mips                        bcm47xx_defconfig
ia64                         bigsur_defconfig
mips                         tb0287_defconfig
sh                   sh7724_generic_defconfig
m68k                       m5249evb_defconfig
x86_64                              defconfig
arm                        cerfcube_defconfig
powerpc                       eiger_defconfig
sh                           se7722_defconfig
arm                      footbridge_defconfig
powerpc                     tqm8555_defconfig
arm                         assabet_defconfig
sh                        sh7757lcr_defconfig
arc                          axs101_defconfig
sh                          rsk7269_defconfig
arm                        shmobile_defconfig
openrisc                 simple_smp_defconfig
arm                        spear3xx_defconfig
arm                          imote2_defconfig
m68k                            q40_defconfig
arc                            hsdk_defconfig
arm                         s5pv210_defconfig
xtensa                          iss_defconfig
powerpc                 mpc837x_rdb_defconfig
mips                            ar7_defconfig
mips                             allyesconfig
powerpc                      arches_defconfig
m68k                            mac_defconfig
powerpc                     tqm8560_defconfig
m68k                          multi_defconfig
sh                            hp6xx_defconfig
powerpc                      ppc44x_defconfig
powerpc                 mpc85xx_cds_defconfig
mips                      malta_kvm_defconfig
sparc64                          alldefconfig
mips                          ath25_defconfig
arm                          simpad_defconfig
sh                      rts7751r2d1_defconfig
mips                           gcw0_defconfig
m68k                       m5208evb_defconfig
mips                      bmips_stb_defconfig
arm                        clps711x_defconfig
arm                         socfpga_defconfig
powerpc               mpc834x_itxgp_defconfig
mips                           rs90_defconfig
arm                          exynos_defconfig
powerpc                        cell_defconfig
arm                         axm55xx_defconfig
arm                           sama5_defconfig
mips                          rm200_defconfig
arm                           stm32_defconfig
arm                       spear13xx_defconfig
ia64                             alldefconfig
sh                            titan_defconfig
mips                          malta_defconfig
arm                       versatile_defconfig
powerpc                    socrates_defconfig
arm                             mxs_defconfig
sh                   secureedge5410_defconfig
powerpc                      bamboo_defconfig
h8300                               defconfig
arm                       imx_v4_v5_defconfig
sh                         apsh4a3a_defconfig
arm                            hisi_defconfig
mips                          rb532_defconfig
arm                          badge4_defconfig
sh                           sh2007_defconfig
powerpc                     ksi8560_defconfig
powerpc                     kilauea_defconfig
arm                         hackkit_defconfig
arm                            qcom_defconfig
sh                          r7780mp_defconfig
xtensa                       common_defconfig
sh                            migor_defconfig
arm                         orion5x_defconfig
arm                      tct_hammer_defconfig
sh                          sdk7780_defconfig
powerpc                      cm5200_defconfig
powerpc                   microwatt_defconfig
mips                       bmips_be_defconfig
um                               alldefconfig
ia64                                defconfig
arm                        magician_defconfig
powerpc                mpc7448_hpc2_defconfig
mips                          ath79_defconfig
arm                          collie_defconfig
sh                          rsk7203_defconfig
m68k                        m5407c3_defconfig
mips                           xway_defconfig
riscv                             allnoconfig
arm                  colibri_pxa270_defconfig
arc                           tb10x_defconfig
arm                            dove_defconfig
nios2                         3c120_defconfig
arm                       mainstone_defconfig
powerpc                         wii_defconfig
powerpc                     mpc512x_defconfig
sh                           se7343_defconfig
sh                         ecovec24_defconfig
arm                        vexpress_defconfig
powerpc                    ge_imp3a_defconfig
sh                        sh7763rdp_defconfig
mips                         mpc30x_defconfig
sh                     sh7710voipgw_defconfig
nds32                            alldefconfig
m68k                       bvme6000_defconfig
xtensa                  audio_kc705_defconfig
riscv             nommu_k210_sdcard_defconfig
mips                            e55_defconfig
arm                         bcm2835_defconfig
powerpc                 mpc8313_rdb_defconfig
arm                        mini2440_defconfig
um                                  defconfig
powerpc                         ps3_defconfig
h8300                       h8s-sim_defconfig
powerpc                    mvme5100_defconfig
arm                         lpc32xx_defconfig
sh                           se7780_defconfig
xtensa                         virt_defconfig
ia64                          tiger_defconfig
arm                  randconfig-c002-20211116
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                              debian-10.3
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a015-20211116
x86_64               randconfig-a013-20211116
x86_64               randconfig-a012-20211116
x86_64               randconfig-a011-20211116
x86_64               randconfig-a016-20211116
x86_64               randconfig-a014-20211116
i386                 randconfig-a014-20211116
i386                 randconfig-a016-20211116
i386                 randconfig-a012-20211116
i386                 randconfig-a013-20211116
i386                 randconfig-a011-20211116
i386                 randconfig-a015-20211116
arc                  randconfig-r043-20211116
s390                 randconfig-r044-20211116
riscv                randconfig-r042-20211116
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
x86_64               randconfig-c007-20211116
i386                 randconfig-c001-20211116
arm                  randconfig-c002-20211116
riscv                randconfig-c006-20211116
powerpc              randconfig-c003-20211116
s390                 randconfig-c005-20211116
mips                 randconfig-c004-20211116
x86_64               randconfig-a005-20211116
x86_64               randconfig-a003-20211116
x86_64               randconfig-a001-20211116
x86_64               randconfig-a006-20211116
x86_64               randconfig-a004-20211116
x86_64               randconfig-a002-20211116
i386                 randconfig-a006-20211116
i386                 randconfig-a003-20211116
i386                 randconfig-a005-20211116
i386                 randconfig-a001-20211116
i386                 randconfig-a004-20211116
i386                 randconfig-a002-20211116
hexagon              randconfig-r045-20211116
hexagon              randconfig-r041-20211116

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
