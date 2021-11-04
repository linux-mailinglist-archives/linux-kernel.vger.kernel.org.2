Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A17D0444CBA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 01:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbhKDAyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 20:54:11 -0400
Received: from mga18.intel.com ([134.134.136.126]:16479 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230030AbhKDAyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 20:54:10 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10157"; a="218532774"
X-IronPort-AV: E=Sophos;i="5.87,207,1631602800"; 
   d="scan'208";a="218532774"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2021 17:51:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,207,1631602800"; 
   d="scan'208";a="489768625"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 03 Nov 2021 17:51:31 -0700
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1miQyY-0005x2-QM; Thu, 04 Nov 2021 00:51:30 +0000
Date:   Thu, 04 Nov 2021 08:51:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 ea79c24a30aa27ccc4aac26be33f8b73f3f1f59c
Message-ID: <61832e8a.dhfUUW8Emma3fUmg%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: ea79c24a30aa27ccc4aac26be33f8b73f3f1f59c  Merge branch 'timers/urgent'

elapsed time: 895m

configs tested: 158
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211103
powerpc                   motionpro_defconfig
ia64                        generic_defconfig
powerpc                     tqm8560_defconfig
m68k                        m5307c3_defconfig
arc                      axs103_smp_defconfig
arm                        spear6xx_defconfig
i386                                defconfig
h8300                            allyesconfig
sh                           se7750_defconfig
arm                            xcep_defconfig
m68k                       m5475evb_defconfig
mips                     loongson1b_defconfig
powerpc                        fsp2_defconfig
m68k                         amcore_defconfig
powerpc                      cm5200_defconfig
mips                         mpc30x_defconfig
powerpc                        icon_defconfig
sh                           se7721_defconfig
powerpc                 mpc837x_rdb_defconfig
sh                               j2_defconfig
powerpc                         wii_defconfig
arm                          badge4_defconfig
mips                      maltaaprp_defconfig
sh                   sh7770_generic_defconfig
mips                          rb532_defconfig
arm                           h5000_defconfig
arm                        neponset_defconfig
ia64                             allmodconfig
sh                        edosk7760_defconfig
sh                               allmodconfig
openrisc                            defconfig
powerpc                      arches_defconfig
powerpc                     ppa8548_defconfig
sh                ecovec24-romimage_defconfig
powerpc                     asp8347_defconfig
s390                             alldefconfig
powerpc                     tqm8548_defconfig
nios2                         3c120_defconfig
arm64                            alldefconfig
arm                           stm32_defconfig
sh                           se7780_defconfig
mips                        omega2p_defconfig
m68k                            q40_defconfig
mips                           jazz_defconfig
arm                        mvebu_v7_defconfig
powerpc                      pmac32_defconfig
sh                     sh7710voipgw_defconfig
arc                          axs101_defconfig
mips                      maltasmvp_defconfig
arm                         bcm2835_defconfig
powerpc                      mgcoge_defconfig
sh                             sh03_defconfig
arm                           tegra_defconfig
arm                        multi_v5_defconfig
arm                          simpad_defconfig
sh                         microdev_defconfig
riscv             nommu_k210_sdcard_defconfig
sh                            shmin_defconfig
riscv                    nommu_k210_defconfig
sh                         ap325rxa_defconfig
sh                          kfr2r09_defconfig
arm                        mvebu_v5_defconfig
sh                      rts7751r2d1_defconfig
sh                 kfr2r09-romimage_defconfig
m68k                       m5249evb_defconfig
m68k                       bvme6000_defconfig
sparc                       sparc32_defconfig
arm                         axm55xx_defconfig
powerpc                   lite5200b_defconfig
powerpc                         ps3_defconfig
mips                      bmips_stb_defconfig
arm                            dove_defconfig
arm                       multi_v4t_defconfig
powerpc                     tqm8540_defconfig
arm                  randconfig-c002-20211103
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
arc                              allyesconfig
nios2                            allyesconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
arc                                 defconfig
xtensa                           allyesconfig
parisc                              defconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
s390                             allmodconfig
sparc                            allyesconfig
sparc                               defconfig
i386                              debian-10.3
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a012-20211103
x86_64               randconfig-a015-20211103
x86_64               randconfig-a016-20211103
x86_64               randconfig-a011-20211103
x86_64               randconfig-a013-20211103
x86_64               randconfig-a014-20211103
i386                 randconfig-a014-20211103
i386                 randconfig-a016-20211103
i386                 randconfig-a013-20211103
i386                 randconfig-a015-20211103
i386                 randconfig-a011-20211103
i386                 randconfig-a012-20211103
arc                  randconfig-r043-20211103
riscv                randconfig-r042-20211103
s390                 randconfig-r044-20211103
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
mips                 randconfig-c004-20211103
arm                  randconfig-c002-20211103
i386                 randconfig-c001-20211103
s390                 randconfig-c005-20211103
powerpc              randconfig-c003-20211103
riscv                randconfig-c006-20211103
x86_64               randconfig-c007-20211103
x86_64               randconfig-a006-20211103
x86_64               randconfig-a004-20211103
x86_64               randconfig-a001-20211103
x86_64               randconfig-a002-20211103
x86_64               randconfig-a005-20211103
x86_64               randconfig-a003-20211103
i386                 randconfig-a005-20211103
i386                 randconfig-a003-20211103
i386                 randconfig-a001-20211103
i386                 randconfig-a004-20211103
i386                 randconfig-a006-20211103
i386                 randconfig-a002-20211103
hexagon              randconfig-r041-20211103
hexagon              randconfig-r045-20211103

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
