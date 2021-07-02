Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCCC3BA2DE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 17:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbhGBPqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 11:46:23 -0400
Received: from mga06.intel.com ([134.134.136.31]:2758 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232107AbhGBPqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 11:46:21 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10033"; a="269877327"
X-IronPort-AV: E=Sophos;i="5.83,317,1616482800"; 
   d="scan'208";a="269877327"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2021 08:42:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,317,1616482800"; 
   d="scan'208";a="644973037"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 02 Jul 2021 08:42:49 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lzLJY-000B8a-Ov; Fri, 02 Jul 2021 15:42:48 +0000
Date:   Fri, 02 Jul 2021 23:42:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:for-next/Warray-bounds] BUILD SUCCESS
 b361f88a791546ec92ee82ffc36857a56697455e
Message-ID: <60df33e9.TqcDOZg7JjepghRy%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git for-next/Warray-bounds
branch HEAD: b361f88a791546ec92ee82ffc36857a56697455e  Makefile: Enable -Warray-bounds

elapsed time: 724m

configs tested: 191
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                     mpc5200_defconfig
powerpc                 mpc8313_rdb_defconfig
arm                        mvebu_v5_defconfig
arm                          ixp4xx_defconfig
microblaze                      mmu_defconfig
powerpc                  mpc866_ads_defconfig
xtensa                generic_kc705_defconfig
sh                          sdk7780_defconfig
sh                         microdev_defconfig
arm                        cerfcube_defconfig
arm                  colibri_pxa270_defconfig
arm                           stm32_defconfig
s390                             allmodconfig
powerpc                         wii_defconfig
powerpc                   currituck_defconfig
mips                 decstation_r4k_defconfig
sh                          polaris_defconfig
openrisc                    or1ksim_defconfig
powerpc                 mpc836x_mds_defconfig
xtensa                  nommu_kc705_defconfig
arm                       omap2plus_defconfig
powerpc                 linkstation_defconfig
sh                        sh7763rdp_defconfig
sh                             espt_defconfig
arm                           u8500_defconfig
arm                          iop32x_defconfig
sh                          landisk_defconfig
m68k                       m5208evb_defconfig
nios2                            allyesconfig
mips                malta_qemu_32r6_defconfig
mips                           ip32_defconfig
powerpc                 mpc834x_mds_defconfig
mips                         bigsur_defconfig
s390                             allyesconfig
ia64                        generic_defconfig
arc                     nsimosci_hs_defconfig
arc                        vdk_hs38_defconfig
sh                        apsh4ad0a_defconfig
arm                         lpc32xx_defconfig
arm                         orion5x_defconfig
h8300                       h8s-sim_defconfig
sh                               j2_defconfig
powerpc                          g5_defconfig
ia64                         bigsur_defconfig
arm                        spear6xx_defconfig
xtensa                    smp_lx200_defconfig
powerpc                      acadia_defconfig
arc                              alldefconfig
arm                            dove_defconfig
mips                         tb0287_defconfig
arm                       imx_v4_v5_defconfig
arm                       mainstone_defconfig
arm                        shmobile_defconfig
mips                           jazz_defconfig
riscv                            alldefconfig
sh                          rsk7203_defconfig
sh                           se7724_defconfig
powerpc               mpc834x_itxgp_defconfig
sh                        sh7785lcr_defconfig
arm                              alldefconfig
sh                          urquell_defconfig
sh                ecovec24-romimage_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                  storcenter_defconfig
mips                      pistachio_defconfig
sh                     magicpanelr2_defconfig
sh                   sh7724_generic_defconfig
arc                     haps_hs_smp_defconfig
mips                      malta_kvm_defconfig
openrisc                            defconfig
powerpc                     pseries_defconfig
openrisc                 simple_smp_defconfig
arm                       aspeed_g4_defconfig
sh                          rsk7269_defconfig
powerpc                   lite5200b_defconfig
mips                        qi_lb60_defconfig
xtensa                              defconfig
powerpc                     mpc512x_defconfig
m68k                         apollo_defconfig
xtensa                           alldefconfig
arm64                            alldefconfig
arm                            pleb_defconfig
arm                        neponset_defconfig
xtensa                  cadence_csp_defconfig
mips                        maltaup_defconfig
powerpc                     tqm8555_defconfig
mips                          ath79_defconfig
mips                         cobalt_defconfig
sparc64                             defconfig
powerpc                      katmai_defconfig
x86_64                            allnoconfig
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
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
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
x86_64               randconfig-a002-20210630
x86_64               randconfig-a001-20210630
x86_64               randconfig-a004-20210630
x86_64               randconfig-a005-20210630
x86_64               randconfig-a006-20210630
x86_64               randconfig-a003-20210630
i386                 randconfig-a004-20210630
i386                 randconfig-a001-20210630
i386                 randconfig-a003-20210630
i386                 randconfig-a002-20210630
i386                 randconfig-a005-20210630
i386                 randconfig-a006-20210630
x86_64               randconfig-a015-20210702
x86_64               randconfig-a012-20210702
x86_64               randconfig-a014-20210702
x86_64               randconfig-a011-20210702
x86_64               randconfig-a016-20210702
x86_64               randconfig-a013-20210702
i386                 randconfig-a015-20210701
i386                 randconfig-a016-20210701
i386                 randconfig-a011-20210701
i386                 randconfig-a012-20210701
i386                 randconfig-a013-20210701
i386                 randconfig-a014-20210701
i386                 randconfig-a014-20210630
i386                 randconfig-a011-20210630
i386                 randconfig-a016-20210630
i386                 randconfig-a012-20210630
i386                 randconfig-a013-20210630
i386                 randconfig-a015-20210630
i386                 randconfig-a015-20210702
i386                 randconfig-a016-20210702
i386                 randconfig-a011-20210702
i386                 randconfig-a012-20210702
i386                 randconfig-a013-20210702
i386                 randconfig-a014-20210702
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210702
x86_64               randconfig-b001-20210630
x86_64               randconfig-a004-20210702
x86_64               randconfig-a005-20210702
x86_64               randconfig-a002-20210702
x86_64               randconfig-a006-20210702
x86_64               randconfig-a003-20210702
x86_64               randconfig-a001-20210702
x86_64               randconfig-a012-20210630
x86_64               randconfig-a015-20210630
x86_64               randconfig-a016-20210630
x86_64               randconfig-a013-20210630
x86_64               randconfig-a011-20210630
x86_64               randconfig-a014-20210630

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
