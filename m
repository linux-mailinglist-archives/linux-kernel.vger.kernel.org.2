Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEC9A338207
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 01:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbhCLAFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 19:05:20 -0500
Received: from mga03.intel.com ([134.134.136.65]:50757 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229470AbhCLAEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 19:04:43 -0500
IronPort-SDR: JfvdQBTf02px1ZvWC2zYlGrx4VpT+HD6/7RqMCoIdg2xNsNKMkiahe44GCBIiW/JN0hTyB45XO
 FxEDxc3dEqYQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9920"; a="188799481"
X-IronPort-AV: E=Sophos;i="5.81,241,1610438400"; 
   d="scan'208";a="188799481"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2021 16:04:39 -0800
IronPort-SDR: EziDPcOF8lh9KxFkfMzCnqAmP4oFNcoND8i21jy8KKqqc116gwL1Gd+X7XLLPKilO7lMVzYCrq
 qupPlCy8BePg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,241,1610438400"; 
   d="scan'208";a="370718697"
Received: from lkp-server02.sh.intel.com (HELO ce64c092ff93) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 11 Mar 2021 16:04:35 -0800
Received: from kbuild by ce64c092ff93 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lKVIA-00012Y-G8; Fri, 12 Mar 2021 00:04:34 +0000
Date:   Fri, 12 Mar 2021 08:03:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 81519f778830d1ab02274eeaaeab6797fdc4ec52
Message-ID: <604aafe2.cGhYikdaPyDDjkwu%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
branch HEAD: 81519f778830d1ab02274eeaaeab6797fdc4ec52  x86/setup: Remove unused RESERVE_BRK_ARRAY()

elapsed time: 724m

configs tested: 137
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
xtensa                generic_kc705_defconfig
powerpc                      walnut_defconfig
powerpc                   lite5200b_defconfig
ia64                        generic_defconfig
powerpc                      ppc6xx_defconfig
arm                       imx_v4_v5_defconfig
arm                        shmobile_defconfig
mips                     loongson1b_defconfig
mips                          rm200_defconfig
sh                          r7785rp_defconfig
powerpc                 mpc836x_rdk_defconfig
mips                        qi_lb60_defconfig
powerpc                     tqm8555_defconfig
openrisc                 simple_smp_defconfig
powerpc                      pcm030_defconfig
um                           x86_64_defconfig
sh                           se7751_defconfig
sh                               allmodconfig
arm                           spitz_defconfig
nds32                            alldefconfig
powerpc                    socrates_defconfig
sh                           se7712_defconfig
riscv                               defconfig
arm                          collie_defconfig
arc                          axs101_defconfig
sh                   sh7724_generic_defconfig
m68k                         apollo_defconfig
arm                         lpc32xx_defconfig
m68k                          multi_defconfig
powerpc                    adder875_defconfig
powerpc                      mgcoge_defconfig
arm                      tct_hammer_defconfig
s390                             allmodconfig
mips                            e55_defconfig
sh                      rts7751r2d1_defconfig
sh                           se7750_defconfig
powerpc                     tqm5200_defconfig
powerpc                     tqm8548_defconfig
mips                         cobalt_defconfig
powerpc                 mpc836x_mds_defconfig
xtensa                         virt_defconfig
powerpc                      bamboo_defconfig
riscv             nommu_k210_sdcard_defconfig
mips                       lemote2f_defconfig
arm                          imote2_defconfig
openrisc                  or1klitex_defconfig
sh                          urquell_defconfig
arm                         at91_dt_defconfig
powerpc                          g5_defconfig
powerpc                     mpc83xx_defconfig
mips                           ip32_defconfig
arm                             pxa_defconfig
sh                          rsk7269_defconfig
sh                        edosk7760_defconfig
sh                            hp6xx_defconfig
xtensa                  nommu_kc705_defconfig
arm                           corgi_defconfig
arm                     eseries_pxa_defconfig
mips                           rs90_defconfig
arm                        mini2440_defconfig
powerpc                     tqm8560_defconfig
powerpc                  iss476-smp_defconfig
arm                         hackkit_defconfig
nios2                            alldefconfig
powerpc                     sequoia_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
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
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20210311
x86_64               randconfig-a001-20210311
x86_64               randconfig-a005-20210311
x86_64               randconfig-a002-20210311
x86_64               randconfig-a003-20210311
x86_64               randconfig-a004-20210311
i386                 randconfig-a001-20210311
i386                 randconfig-a005-20210311
i386                 randconfig-a003-20210311
i386                 randconfig-a002-20210311
i386                 randconfig-a004-20210311
i386                 randconfig-a006-20210311
i386                 randconfig-a013-20210311
i386                 randconfig-a016-20210311
i386                 randconfig-a011-20210311
i386                 randconfig-a014-20210311
i386                 randconfig-a015-20210311
i386                 randconfig-a012-20210311
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a011-20210311
x86_64               randconfig-a016-20210311
x86_64               randconfig-a013-20210311
x86_64               randconfig-a015-20210311
x86_64               randconfig-a014-20210311
x86_64               randconfig-a012-20210311

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
