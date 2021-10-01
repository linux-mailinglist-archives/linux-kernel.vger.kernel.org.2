Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9464241EB45
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 12:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353688AbhJAK7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 06:59:44 -0400
Received: from mga01.intel.com ([192.55.52.88]:55254 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353421AbhJAK7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 06:59:43 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10123"; a="247957392"
X-IronPort-AV: E=Sophos;i="5.85,337,1624345200"; 
   d="scan'208";a="247957392"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2021 03:57:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,337,1624345200"; 
   d="scan'208";a="564892585"
Received: from lkp-server01.sh.intel.com (HELO 72c3bd3cf19c) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 01 Oct 2021 03:57:58 -0700
Received: from kbuild by 72c3bd3cf19c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mWGEn-000163-NG; Fri, 01 Oct 2021 10:57:57 +0000
Date:   Fri, 01 Oct 2021 18:57:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2021.09.16a] BUILD SUCCESS
 caa7c63eaf761874b766ef8f123114e80a23619c
Message-ID: <6156e99c.EOvL4j0paiqq4TyX%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2021.09.16a
branch HEAD: caa7c63eaf761874b766ef8f123114e80a23619c  EXP rcu-tasks: Don't remove tasks with pending IPIs from holdout list

elapsed time: 1317m

configs tested: 253
configs skipped: 47

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allmodconfig
arm                              allyesconfig
i386                 randconfig-c001-20211001
i386                 randconfig-c001-20210930
powerpc              randconfig-c003-20210930
arm                         s3c6400_defconfig
mips                malta_qemu_32r6_defconfig
sh                   secureedge5410_defconfig
m68k                         amcore_defconfig
sh                            shmin_defconfig
mips                     loongson2k_defconfig
arm                       imx_v6_v7_defconfig
mips                         mpc30x_defconfig
mips                          rb532_defconfig
arm                     eseries_pxa_defconfig
sh                   sh7770_generic_defconfig
x86_64                              defconfig
mips                        vocore2_defconfig
arm                        spear3xx_defconfig
sh                           se7722_defconfig
alpha                            alldefconfig
arm                           h3600_defconfig
arm                          ep93xx_defconfig
sh                                  defconfig
riscv                            alldefconfig
powerpc                      cm5200_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                     kilauea_defconfig
sh                          rsk7264_defconfig
ia64                                defconfig
mips                           xway_defconfig
mips                      bmips_stb_defconfig
arm                          exynos_defconfig
riscv             nommu_k210_sdcard_defconfig
xtensa                              defconfig
mips                          ath79_defconfig
microblaze                          defconfig
powerpc                 linkstation_defconfig
i386                                defconfig
arm                       mainstone_defconfig
mips                     loongson1b_defconfig
powerpc                      ppc64e_defconfig
sh                           se7780_defconfig
arm                          gemini_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                      ppc40x_defconfig
arm                           viper_defconfig
arm                       imx_v4_v5_defconfig
arm                           corgi_defconfig
sh                        sh7763rdp_defconfig
arm                        magician_defconfig
mips                          ath25_defconfig
powerpc                     stx_gp3_defconfig
mips                         tb0287_defconfig
powerpc                     powernv_defconfig
arm                        oxnas_v6_defconfig
arm                        spear6xx_defconfig
sh                            titan_defconfig
sh                             espt_defconfig
arm                            mmp2_defconfig
powerpc                        icon_defconfig
arm                            zeus_defconfig
sh                           se7724_defconfig
sparc                            allyesconfig
arm                   milbeaut_m10v_defconfig
arm                          iop32x_defconfig
mips                         cobalt_defconfig
h8300                       h8s-sim_defconfig
arm                         bcm2835_defconfig
arm                            lart_defconfig
sparc64                             defconfig
arm                           tegra_defconfig
m68k                         apollo_defconfig
powerpc                 mpc8560_ads_defconfig
mips                     cu1000-neo_defconfig
mips                        qi_lb60_defconfig
s390                          debug_defconfig
sh                         ap325rxa_defconfig
powerpc                        cell_defconfig
powerpc                     ksi8560_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                      pcm030_defconfig
powerpc                     mpc83xx_defconfig
s390                       zfcpdump_defconfig
powerpc                      tqm8xx_defconfig
m68k                            q40_defconfig
arm                  colibri_pxa270_defconfig
sh                        edosk7705_defconfig
arm                  colibri_pxa300_defconfig
arm                         at91_dt_defconfig
sh                ecovec24-romimage_defconfig
arm                             ezx_defconfig
arm                         assabet_defconfig
m68k                       m5475evb_defconfig
mips                       rbtx49xx_defconfig
powerpc                     skiroot_defconfig
ia64                             allmodconfig
m68k                        m5272c3_defconfig
sh                              ul2_defconfig
sh                     magicpanelr2_defconfig
m68k                        m5307c3_defconfig
sh                           se7751_defconfig
ia64                          tiger_defconfig
arm                          simpad_defconfig
powerpc                     ep8248e_defconfig
parisc                generic-64bit_defconfig
powerpc                     pseries_defconfig
m68k                        stmark2_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                           u8500_defconfig
xtensa                       common_defconfig
arc                        nsimosci_defconfig
arm                              alldefconfig
arm                        mvebu_v5_defconfig
arm                        mvebu_v7_defconfig
csky                                defconfig
ia64                             alldefconfig
mips                        workpad_defconfig
powerpc                     tqm8541_defconfig
ia64                             allyesconfig
powerpc                 mpc836x_mds_defconfig
powerpc                    socrates_defconfig
um                             i386_defconfig
sh                        apsh4ad0a_defconfig
mips                       bmips_be_defconfig
mips                       lemote2f_defconfig
powerpc                   motionpro_defconfig
powerpc                     tqm5200_defconfig
powerpc64                           defconfig
x86_64                           alldefconfig
mips                            e55_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc                      obs600_defconfig
ia64                        generic_defconfig
sh                            hp6xx_defconfig
powerpc                     redwood_defconfig
mips                            gpr_defconfig
arm                       omap2plus_defconfig
sh                          r7780mp_defconfig
xtensa                    xip_kc705_defconfig
arc                         haps_hs_defconfig
arc                           tb10x_defconfig
arm                  randconfig-c002-20210930
x86_64               randconfig-c001-20210930
x86_64               randconfig-c001-20211001
arm                  randconfig-c002-20211001
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                                defconfig
parisc                           allyesconfig
s390                             allmodconfig
s390                             allyesconfig
sparc                               defconfig
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64               randconfig-a003-20211001
x86_64               randconfig-a005-20211001
x86_64               randconfig-a001-20211001
x86_64               randconfig-a002-20211001
x86_64               randconfig-a004-20211001
x86_64               randconfig-a006-20211001
x86_64               randconfig-a004-20210930
x86_64               randconfig-a001-20210930
x86_64               randconfig-a002-20210930
x86_64               randconfig-a005-20210930
x86_64               randconfig-a006-20210930
x86_64               randconfig-a003-20210930
i386                 randconfig-a003-20210930
i386                 randconfig-a001-20210930
i386                 randconfig-a004-20210930
i386                 randconfig-a002-20210930
i386                 randconfig-a006-20210930
i386                 randconfig-a005-20210930
i386                 randconfig-a001-20211001
i386                 randconfig-a003-20211001
i386                 randconfig-a005-20211001
i386                 randconfig-a002-20211001
i386                 randconfig-a004-20211001
i386                 randconfig-a006-20211001
arc                  randconfig-r043-20210930
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
x86_64               randconfig-c007-20211001
i386                 randconfig-c001-20211001
arm                  randconfig-c002-20211001
s390                 randconfig-c005-20211001
powerpc              randconfig-c003-20211001
riscv                randconfig-c006-20211001
mips                 randconfig-c004-20211001
i386                 randconfig-c001-20210930
arm                  randconfig-c002-20210930
powerpc              randconfig-c003-20210930
mips                 randconfig-c004-20210930
s390                 randconfig-c005-20210930
riscv                randconfig-c006-20210930
x86_64               randconfig-c007-20210930
x86_64               randconfig-a015-20210930
x86_64               randconfig-a011-20210930
x86_64               randconfig-a012-20210930
x86_64               randconfig-a013-20210930
x86_64               randconfig-a016-20210930
x86_64               randconfig-a014-20210930
x86_64               randconfig-a015-20211001
x86_64               randconfig-a012-20211001
x86_64               randconfig-a016-20211001
x86_64               randconfig-a014-20211001
x86_64               randconfig-a013-20211001
x86_64               randconfig-a011-20211001
i386                 randconfig-a014-20210930
i386                 randconfig-a013-20210930
i386                 randconfig-a011-20210930
i386                 randconfig-a015-20210930
i386                 randconfig-a016-20210930
i386                 randconfig-a012-20210930
i386                 randconfig-a013-20211001
i386                 randconfig-a016-20211001
i386                 randconfig-a014-20211001
i386                 randconfig-a012-20211001
i386                 randconfig-a011-20211001
i386                 randconfig-a015-20211001
riscv                randconfig-r042-20210930
hexagon              randconfig-r041-20210930
s390                 randconfig-r044-20210930
hexagon              randconfig-r045-20210930
hexagon              randconfig-r045-20211001
hexagon              randconfig-r041-20211001
s390                 randconfig-r044-20211001
riscv                randconfig-r042-20211001

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
