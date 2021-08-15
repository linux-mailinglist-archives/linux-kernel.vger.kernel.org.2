Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B59A3EC8E3
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 14:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237818AbhHOMNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 08:13:11 -0400
Received: from mga04.intel.com ([192.55.52.120]:41440 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229597AbhHOMNK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 08:13:10 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10076"; a="213887034"
X-IronPort-AV: E=Sophos;i="5.84,322,1620716400"; 
   d="scan'208";a="213887034"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2021 05:12:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,322,1620716400"; 
   d="scan'208";a="678639769"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 15 Aug 2021 05:12:39 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mFF0I-000PoN-K8; Sun, 15 Aug 2021 12:12:38 +0000
Date:   Sun, 15 Aug 2021 20:12:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:core/debugobjects] BUILD SUCCESS
 4bedcc28469a24fe481a8a31b3584e6070457ddb
Message-ID: <61190497.rpUCdk1cdvjSgssQ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/debugobjects
branch HEAD: 4bedcc28469a24fe481a8a31b3584e6070457ddb  debugobjects: Make them PREEMPT_RT aware

elapsed time: 3109m

configs tested: 290
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210814
i386                 randconfig-c001-20210812
i386                 randconfig-c001-20210815
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
mips                            ar7_defconfig
arm64                            alldefconfig
arm                            pleb_defconfig
powerpc                       ppc64_defconfig
sh                   sh7770_generic_defconfig
sh                          landisk_defconfig
mips                         mpc30x_defconfig
powerpc                     ksi8560_defconfig
openrisc                  or1klitex_defconfig
m68k                        m5407c3_defconfig
powerpc                    klondike_defconfig
mips                     loongson1c_defconfig
arm                          ep93xx_defconfig
arm                          iop32x_defconfig
h8300                       h8s-sim_defconfig
riscv                    nommu_k210_defconfig
arm                        clps711x_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                 mpc837x_rdb_defconfig
mips                  maltasmvp_eva_defconfig
mips                         bigsur_defconfig
powerpc64                           defconfig
powerpc                        cell_defconfig
arm                         at91_dt_defconfig
powerpc                      mgcoge_defconfig
m68k                          sun3x_defconfig
xtensa                          iss_defconfig
arm                      jornada720_defconfig
arm                     davinci_all_defconfig
mips                        workpad_defconfig
arm                       omap2plus_defconfig
powerpc                     pq2fads_defconfig
h8300                            alldefconfig
mips                     cu1830-neo_defconfig
sparc                            alldefconfig
arm                          lpd270_defconfig
arm                          simpad_defconfig
m68k                        stmark2_defconfig
sh                          lboxre2_defconfig
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
sh                           se7750_defconfig
powerpc                    socrates_defconfig
riscv                             allnoconfig
sh                               alldefconfig
arm                         s3c6400_defconfig
arm                             mxs_defconfig
sparc                       sparc32_defconfig
arm                        multi_v5_defconfig
powerpc                      makalu_defconfig
powerpc                       maple_defconfig
powerpc                         wii_defconfig
i386                                defconfig
sparc                            allyesconfig
arm                           sama5_defconfig
powerpc                   microwatt_defconfig
mips                          ath25_defconfig
sh                          rsk7201_defconfig
h8300                            allyesconfig
sh                           se7206_defconfig
sh                                  defconfig
arm                           corgi_defconfig
xtensa                  audio_kc705_defconfig
powerpc                      pasemi_defconfig
powerpc                 mpc8272_ads_defconfig
mips                         db1xxx_defconfig
arm                           stm32_defconfig
arm                         mv78xx0_defconfig
powerpc                        icon_defconfig
arm                       aspeed_g4_defconfig
sh                  sh7785lcr_32bit_defconfig
mips                       lemote2f_defconfig
mips                          rm200_defconfig
mips                      loongson3_defconfig
mips                          ath79_defconfig
sh                          urquell_defconfig
mips                     decstation_defconfig
arm                          exynos_defconfig
riscv                    nommu_virt_defconfig
sh                        sh7785lcr_defconfig
sh                 kfr2r09-romimage_defconfig
mips                           xway_defconfig
parisc                generic-64bit_defconfig
arm                           h5000_defconfig
powerpc                     mpc512x_defconfig
sh                           se7705_defconfig
mips                      pic32mzda_defconfig
arm                            hisi_defconfig
openrisc                    or1ksim_defconfig
powerpc                     redwood_defconfig
mips                         tb0226_defconfig
mips                           ip27_defconfig
powerpc                      obs600_defconfig
m68k                       bvme6000_defconfig
arm                         axm55xx_defconfig
powerpc                    amigaone_defconfig
mips                  decstation_64_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                 canyonlands_defconfig
arm                          pxa3xx_defconfig
mips                         cobalt_defconfig
mips                        nlm_xlp_defconfig
powerpc                     powernv_defconfig
arm                        magician_defconfig
powerpc                       eiger_defconfig
ia64                         bigsur_defconfig
powerpc64                        alldefconfig
powerpc                 mpc836x_rdk_defconfig
mips                         tb0219_defconfig
arm                      tct_hammer_defconfig
arm                      integrator_defconfig
arm                          pxa910_defconfig
sh                   sh7724_generic_defconfig
sh                          sdk7780_defconfig
powerpc                        warp_defconfig
sh                          kfr2r09_defconfig
powerpc                     ep8248e_defconfig
arm                       spear13xx_defconfig
arm                         lpc18xx_defconfig
arm                        cerfcube_defconfig
sh                           sh2007_defconfig
powerpc                    ge_imp3a_defconfig
xtensa                         virt_defconfig
arm                            mmp2_defconfig
m68k                        mvme147_defconfig
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
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20210814
x86_64               randconfig-a006-20210814
x86_64               randconfig-a003-20210814
x86_64               randconfig-a001-20210814
x86_64               randconfig-a005-20210814
x86_64               randconfig-a002-20210814
x86_64               randconfig-a006-20210812
x86_64               randconfig-a004-20210812
x86_64               randconfig-a003-20210812
x86_64               randconfig-a005-20210812
x86_64               randconfig-a002-20210812
x86_64               randconfig-a001-20210812
i386                 randconfig-a004-20210814
i386                 randconfig-a002-20210814
i386                 randconfig-a001-20210814
i386                 randconfig-a003-20210814
i386                 randconfig-a006-20210814
i386                 randconfig-a005-20210814
i386                 randconfig-a004-20210815
i386                 randconfig-a001-20210815
i386                 randconfig-a002-20210815
i386                 randconfig-a003-20210815
i386                 randconfig-a006-20210815
i386                 randconfig-a005-20210815
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
x86_64               randconfig-a013-20210815
x86_64               randconfig-a011-20210815
x86_64               randconfig-a016-20210815
x86_64               randconfig-a012-20210815
x86_64               randconfig-a014-20210815
x86_64               randconfig-a015-20210815
x86_64               randconfig-a013-20210814
x86_64               randconfig-a011-20210814
x86_64               randconfig-a016-20210814
x86_64               randconfig-a012-20210814
x86_64               randconfig-a014-20210814
x86_64               randconfig-a015-20210814
i386                 randconfig-a011-20210815
i386                 randconfig-a015-20210815
i386                 randconfig-a014-20210815
i386                 randconfig-a013-20210815
i386                 randconfig-a016-20210815
i386                 randconfig-a012-20210815
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
riscv                            allyesconfig
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
x86_64               randconfig-c001-20210813
x86_64               randconfig-c001-20210814
x86_64               randconfig-c001-20210815
x86_64               randconfig-a004-20210815
x86_64               randconfig-a006-20210815
x86_64               randconfig-a003-20210815
x86_64               randconfig-a001-20210815
x86_64               randconfig-a002-20210815
x86_64               randconfig-a005-20210815
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
