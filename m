Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E64234849E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 23:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235196AbhCXW2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 18:28:41 -0400
Received: from mga12.intel.com ([192.55.52.136]:12611 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229882AbhCXW2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 18:28:10 -0400
IronPort-SDR: ltehXEO7mnzPpo9d/EytfXU3v8fmjMZgrpMFMDjX9N+0PCQIMywFJbYnkJOR7ueWA6rfRi4v1X
 dfaxiiFsO+jA==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="170149917"
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="170149917"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 15:28:10 -0700
IronPort-SDR: LrlLWatOhezvqFQCdAa8p2naWSYWwmVa+6kzzzCkI9eYhFQ3LGNZsnAHoU3vU2b5qXrnOebP5F
 3EkYxv92Vfow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="443139398"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Mar 2021 15:28:08 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lPByy-0001ZP-5c; Wed, 24 Mar 2021 22:28:08 +0000
Date:   Thu, 25 Mar 2021 06:28:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/sgx] BUILD SUCCESS
 f33dece70e11ce82a09cb1ea2d7c32347b82c67e
Message-ID: <605bbcf1.by4BRMctIPXxPLXv%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/sgx
branch HEAD: f33dece70e11ce82a09cb1ea2d7c32347b82c67e  selftests/sgx: Use getauxval() to simplify test code

elapsed time: 720m

configs tested: 190
configs skipped: 2

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
powerpc                         ps3_defconfig
um                           x86_64_defconfig
s390                             allmodconfig
ia64                         bigsur_defconfig
powerpc                     tqm8560_defconfig
powerpc                     mpc5200_defconfig
powerpc                     akebono_defconfig
sh                          rsk7203_defconfig
sh                             shx3_defconfig
arm                         orion5x_defconfig
mips                        workpad_defconfig
nds32                             allnoconfig
powerpc                 mpc8313_rdb_defconfig
mips                     cu1000-neo_defconfig
arm                        mini2440_defconfig
powerpc                      obs600_defconfig
arm                           h3600_defconfig
arc                    vdk_hs38_smp_defconfig
powerpc                      pmac32_defconfig
sh                        sh7785lcr_defconfig
mips                         tb0287_defconfig
sh                ecovec24-romimage_defconfig
mips                        qi_lb60_defconfig
arm                        vexpress_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                      tct_hammer_defconfig
arm                             mxs_defconfig
sh                            titan_defconfig
mips                 decstation_r4k_defconfig
arm                         cm_x300_defconfig
openrisc                  or1klitex_defconfig
powerpc                 linkstation_defconfig
powerpc                   lite5200b_defconfig
sparc                            alldefconfig
mips                          rb532_defconfig
sparc                       sparc32_defconfig
m68k                        m5272c3_defconfig
mips                            e55_defconfig
m68k                          hp300_defconfig
arc                           tb10x_defconfig
mips                        bcm63xx_defconfig
h8300                       h8s-sim_defconfig
mips                      pic32mzda_defconfig
arm                       versatile_defconfig
arm                          collie_defconfig
sh                            hp6xx_defconfig
um                            kunit_defconfig
arm                          lpd270_defconfig
sh                          sdk7780_defconfig
powerpc                  storcenter_defconfig
powerpc                     kilauea_defconfig
mips                   sb1250_swarm_defconfig
ia64                             allmodconfig
powerpc                     pseries_defconfig
mips                        jmr3927_defconfig
powerpc                     taishan_defconfig
powerpc                 mpc834x_mds_defconfig
m68k                          multi_defconfig
m68k                            q40_defconfig
mips                     loongson1b_defconfig
m68k                        m5407c3_defconfig
arm                      footbridge_defconfig
arm                          simpad_defconfig
arc                     haps_hs_smp_defconfig
m68k                       m5475evb_defconfig
powerpc                    klondike_defconfig
arm                     am200epdkit_defconfig
mips                       bmips_be_defconfig
arm                           h5000_defconfig
xtensa                         virt_defconfig
powerpc                 mpc8540_ads_defconfig
sh                          sdk7786_defconfig
arm                           stm32_defconfig
sh                           se7721_defconfig
powerpc                 mpc85xx_cds_defconfig
sh                   rts7751r2dplus_defconfig
mips                      maltaaprp_defconfig
nios2                         3c120_defconfig
sh                          landisk_defconfig
mips                             allyesconfig
sh                   secureedge5410_defconfig
arm                      integrator_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                      arches_defconfig
h8300                    h8300h-sim_defconfig
arm                          ixp4xx_defconfig
arm                          pxa168_defconfig
arm                         lpc18xx_defconfig
mips                           rs90_defconfig
mips                       capcella_defconfig
arm                         axm55xx_defconfig
arm64                            alldefconfig
mips                     loongson1c_defconfig
powerpc                      makalu_defconfig
mips                     cu1830-neo_defconfig
powerpc64                           defconfig
mips                          ath25_defconfig
powerpc                           allnoconfig
mips                  maltasmvp_eva_defconfig
riscv                               defconfig
ia64                             alldefconfig
riscv                          rv32_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc                     stx_gp3_defconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
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
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a002-20210323
x86_64               randconfig-a003-20210323
x86_64               randconfig-a006-20210323
x86_64               randconfig-a001-20210323
x86_64               randconfig-a004-20210323
x86_64               randconfig-a005-20210323
i386                 randconfig-a003-20210323
i386                 randconfig-a004-20210323
i386                 randconfig-a001-20210323
i386                 randconfig-a002-20210323
i386                 randconfig-a006-20210323
i386                 randconfig-a005-20210323
i386                 randconfig-a004-20210324
i386                 randconfig-a003-20210324
i386                 randconfig-a001-20210324
i386                 randconfig-a002-20210324
i386                 randconfig-a006-20210324
i386                 randconfig-a005-20210324
x86_64               randconfig-a012-20210324
x86_64               randconfig-a015-20210324
x86_64               randconfig-a014-20210324
x86_64               randconfig-a013-20210324
x86_64               randconfig-a016-20210324
x86_64               randconfig-a011-20210324
i386                 randconfig-a014-20210324
i386                 randconfig-a011-20210324
i386                 randconfig-a015-20210324
i386                 randconfig-a016-20210324
i386                 randconfig-a013-20210324
i386                 randconfig-a012-20210324
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a002-20210324
x86_64               randconfig-a003-20210324
x86_64               randconfig-a001-20210324
x86_64               randconfig-a006-20210324
x86_64               randconfig-a005-20210324
x86_64               randconfig-a004-20210324
x86_64               randconfig-a012-20210323
x86_64               randconfig-a015-20210323
x86_64               randconfig-a013-20210323
x86_64               randconfig-a014-20210323
x86_64               randconfig-a011-20210323
x86_64               randconfig-a016-20210323

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
