Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB50C3EC98D
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 16:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238139AbhHOOZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 10:25:14 -0400
Received: from mga02.intel.com ([134.134.136.20]:45721 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232907AbhHOOZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 10:25:13 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10077"; a="202943903"
X-IronPort-AV: E=Sophos;i="5.84,322,1620716400"; 
   d="scan'208";a="202943903"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2021 07:24:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,322,1620716400"; 
   d="scan'208";a="592243582"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 15 Aug 2021 07:24:40 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mFH44-000Prs-1G; Sun, 15 Aug 2021 14:24:40 +0000
Date:   Sun, 15 Aug 2021 22:24:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/urgent] BUILD SUCCESS
 7a3dc4f35bf8e1a07e5c3f8ecc8ac923f48493fe
Message-ID: <6119238c.zkczyE5hnq4bYHf6%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/urgent
branch HEAD: 7a3dc4f35bf8e1a07e5c3f8ecc8ac923f48493fe  driver core: Add missing kernel doc for device::msi_lock

elapsed time: 3077m

configs tested: 185
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210812
i386                 randconfig-c001-20210813
powerpc                     mpc5200_defconfig
m68k                          hp300_defconfig
sh                        edosk7760_defconfig
powerpc                     asp8347_defconfig
arm                     am200epdkit_defconfig
powerpc                     tqm8541_defconfig
m68k                          amiga_defconfig
mips                        bcm47xx_defconfig
xtensa                           alldefconfig
sh                              ul2_defconfig
powerpc                 mpc8540_ads_defconfig
ia64                                defconfig
arm                       imx_v6_v7_defconfig
mips                           rs90_defconfig
parisc                generic-32bit_defconfig
mips                        workpad_defconfig
openrisc                  or1klitex_defconfig
m68k                        m5407c3_defconfig
powerpc                    klondike_defconfig
mips                     loongson1c_defconfig
arm                          ep93xx_defconfig
arm                          iop32x_defconfig
arm                     davinci_all_defconfig
arm                       omap2plus_defconfig
powerpc                     pq2fads_defconfig
mips                  maltasmvp_eva_defconfig
h8300                            alldefconfig
powerpc                     tqm5200_defconfig
powerpc                      walnut_defconfig
mips                      bmips_stb_defconfig
sh                           se7619_defconfig
arm                         orion5x_defconfig
xtensa                           allyesconfig
arm                       imx_v4_v5_defconfig
powerpc                      ep88xc_defconfig
powerpc                     rainier_defconfig
sh                            shmin_defconfig
h8300                               defconfig
sh                          rsk7269_defconfig
ia64                          tiger_defconfig
arm                             rpc_defconfig
powerpc                      ppc40x_defconfig
arm                          simpad_defconfig
arm                        clps711x_defconfig
sh                           se7750_defconfig
powerpc                    socrates_defconfig
riscv                             allnoconfig
powerpc                     ksi8560_defconfig
powerpc                 mpc837x_rdb_defconfig
arc                              alldefconfig
mips                           ip22_defconfig
powerpc                 mpc85xx_cds_defconfig
sh                          urquell_defconfig
mips                     decstation_defconfig
powerpc                         wii_defconfig
arm                          exynos_defconfig
powerpc                     redwood_defconfig
mips                         tb0226_defconfig
arm                      jornada720_defconfig
mips                           ip27_defconfig
powerpc                      obs600_defconfig
arm                           stm32_defconfig
m68k                       bvme6000_defconfig
arm                         axm55xx_defconfig
powerpc                    amigaone_defconfig
mips                  decstation_64_defconfig
powerpc                 mpc837x_mds_defconfig
arm                          pxa3xx_defconfig
mips                         cobalt_defconfig
openrisc                    or1ksim_defconfig
mips                        nlm_xlp_defconfig
arm                         bcm2835_defconfig
arm                            pleb_defconfig
arc                        nsim_700_defconfig
mips                 decstation_r4k_defconfig
arm                         lpc18xx_defconfig
arm                        cerfcube_defconfig
sh                           sh2007_defconfig
powerpc                    ge_imp3a_defconfig
xtensa                         virt_defconfig
arm                            mmp2_defconfig
m68k                        mvme147_defconfig
powerpc                 canyonlands_defconfig
openrisc                 simple_smp_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
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
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20210814
i386                 randconfig-a002-20210814
i386                 randconfig-a001-20210814
i386                 randconfig-a003-20210814
i386                 randconfig-a006-20210814
i386                 randconfig-a005-20210814
i386                 randconfig-a004-20210813
i386                 randconfig-a003-20210813
i386                 randconfig-a001-20210813
i386                 randconfig-a002-20210813
i386                 randconfig-a006-20210813
i386                 randconfig-a005-20210813
x86_64               randconfig-a011-20210813
x86_64               randconfig-a013-20210813
x86_64               randconfig-a012-20210813
x86_64               randconfig-a016-20210813
x86_64               randconfig-a015-20210813
x86_64               randconfig-a014-20210813
i386                 randconfig-a011-20210814
i386                 randconfig-a015-20210814
i386                 randconfig-a013-20210814
i386                 randconfig-a014-20210814
i386                 randconfig-a016-20210814
i386                 randconfig-a012-20210814
i386                 randconfig-a011-20210813
i386                 randconfig-a015-20210813
i386                 randconfig-a014-20210813
i386                 randconfig-a013-20210813
i386                 randconfig-a016-20210813
i386                 randconfig-a012-20210813
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c001-20210814
x86_64               randconfig-c001-20210813
x86_64               randconfig-a006-20210813
x86_64               randconfig-a004-20210813
x86_64               randconfig-a003-20210813
x86_64               randconfig-a002-20210813
x86_64               randconfig-a005-20210813
x86_64               randconfig-a001-20210813
x86_64               randconfig-a013-20210814
x86_64               randconfig-a011-20210814
x86_64               randconfig-a016-20210814
x86_64               randconfig-a012-20210814
x86_64               randconfig-a014-20210814
x86_64               randconfig-a015-20210814
x86_64               randconfig-a011-20210812
x86_64               randconfig-a013-20210812
x86_64               randconfig-a012-20210812
x86_64               randconfig-a016-20210812
x86_64               randconfig-a015-20210812
x86_64               randconfig-a014-20210812

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
