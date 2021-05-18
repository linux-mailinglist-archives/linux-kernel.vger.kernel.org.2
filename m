Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 047353881D4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 23:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352359AbhERVJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 17:09:38 -0400
Received: from mga01.intel.com ([192.55.52.88]:42651 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352353AbhERVJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 17:09:37 -0400
IronPort-SDR: H4tPuMehza4tlPYpz/gKReQEfK+BxeknrlkanH/bSNqGedaNy0/I9qFJ7uwacLr/IWT+LE6Vjs
 ZKH9Z46Iyr5A==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="221881751"
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="221881751"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 14:08:19 -0700
IronPort-SDR: USwaHoHEehAoR4Pv/2YqaKnDUva8Ge4rRjFCLseU2/mzATHKc6n7+Pz7Blo+RWVGWTzxn9sCEn
 yMmbnMMzgh7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="411446688"
Received: from lkp-server01.sh.intel.com (HELO ddd90b05c979) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 18 May 2021 14:08:17 -0700
Received: from kbuild by ddd90b05c979 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lj6wq-0002LJ-VC; Tue, 18 May 2021 21:08:16 +0000
Date:   Wed, 19 May 2021 05:07:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 58b9d0b9cdddce0a4d54477665dbbec8dc4ae068
Message-ID: <60a42ca0.sTWcxGRfiMJiwqt9%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 58b9d0b9cdddce0a4d54477665dbbec8dc4ae068  Merge branch 'irq/core'

elapsed time: 940m

configs tested: 241
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                         tb0219_defconfig
arm                          moxart_defconfig
parisc                              defconfig
openrisc                            defconfig
m68k                          multi_defconfig
arm                        spear6xx_defconfig
mips                           rs90_defconfig
arm                           omap1_defconfig
xtensa                       common_defconfig
microblaze                      mmu_defconfig
mips                        nlm_xlp_defconfig
powerpc64                           defconfig
m68k                          atari_defconfig
powerpc                     ep8248e_defconfig
arm                          lpd270_defconfig
alpha                               defconfig
arm                       omap2plus_defconfig
csky                                defconfig
sh                           se7722_defconfig
mips                         mpc30x_defconfig
um                            kunit_defconfig
powerpc                      makalu_defconfig
powerpc                 mpc8315_rdb_defconfig
m68k                          hp300_defconfig
powerpc                     pq2fads_defconfig
arc                      axs103_smp_defconfig
powerpc                    socrates_defconfig
arm                       imx_v6_v7_defconfig
arm64                            alldefconfig
powerpc                 mpc8272_ads_defconfig
arm                         vf610m4_defconfig
mips                         cobalt_defconfig
powerpc                  iss476-smp_defconfig
arm                          gemini_defconfig
sh                             espt_defconfig
sh                        apsh4ad0a_defconfig
sparc                       sparc32_defconfig
sh                              ul2_defconfig
sh                      rts7751r2d1_defconfig
xtensa                generic_kc705_defconfig
xtensa                    smp_lx200_defconfig
i386                                defconfig
sh                            hp6xx_defconfig
mips                           ip28_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                      cm5200_defconfig
arm                           viper_defconfig
arc                        nsimosci_defconfig
i386                             alldefconfig
openrisc                  or1klitex_defconfig
sh                          kfr2r09_defconfig
mips                      malta_kvm_defconfig
arm                             rpc_defconfig
arm                         lubbock_defconfig
mips                           ip32_defconfig
arm                            mps2_defconfig
mips                           ip22_defconfig
sh                          urquell_defconfig
arm                        realview_defconfig
sh                          rsk7201_defconfig
mips                     decstation_defconfig
arc                            hsdk_defconfig
arm                             ezx_defconfig
mips                        nlm_xlr_defconfig
mips                            gpr_defconfig
mips                        vocore2_defconfig
ia64                                defconfig
m68k                       m5249evb_defconfig
sparc                            alldefconfig
x86_64                            allnoconfig
powerpc                     kmeter1_defconfig
arm                         socfpga_defconfig
sh                               alldefconfig
powerpc                   currituck_defconfig
arm                            dove_defconfig
arc                     nsimosci_hs_defconfig
powerpc                     rainier_defconfig
mips                        maltaup_defconfig
m68k                         amcore_defconfig
sh                           se7721_defconfig
m68k                         apollo_defconfig
arm                           h3600_defconfig
arm                      footbridge_defconfig
arm                            hisi_defconfig
arm                          exynos_defconfig
arm                       aspeed_g4_defconfig
sh                          polaris_defconfig
alpha                            alldefconfig
openrisc                    or1ksim_defconfig
powerpc                      ppc6xx_defconfig
powerpc                      acadia_defconfig
arm                         s3c2410_defconfig
powerpc                     redwood_defconfig
mips                  maltasmvp_eva_defconfig
arm                        multi_v5_defconfig
mips                           ci20_defconfig
powerpc                    ge_imp3a_defconfig
mips                     cu1830-neo_defconfig
powerpc                 mpc832x_rdb_defconfig
sh                           se7343_defconfig
arm                          pxa168_defconfig
arm                         axm55xx_defconfig
arc                         haps_hs_defconfig
arm                           u8500_defconfig
powerpc                         wii_defconfig
arm                          simpad_defconfig
powerpc                     tqm8541_defconfig
mips                        qi_lb60_defconfig
m68k                           sun3_defconfig
arm                        clps711x_defconfig
mips                           mtx1_defconfig
arm                          ixp4xx_defconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                        cell_defconfig
sh                     sh7710voipgw_defconfig
sh                        sh7785lcr_defconfig
arm                         nhk8815_defconfig
nios2                         3c120_defconfig
parisc                generic-64bit_defconfig
x86_64                              defconfig
arm                       multi_v4t_defconfig
arm                      integrator_defconfig
mips                     loongson2k_defconfig
sparc                               defconfig
arm                          ep93xx_defconfig
arm                           h5000_defconfig
xtensa                  nommu_kc705_defconfig
arm                       aspeed_g5_defconfig
powerpc                      ppc64e_defconfig
sh                           se7206_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                       eiger_defconfig
powerpc                        icon_defconfig
x86_64                           allyesconfig
powerpc                       maple_defconfig
powerpc                     tqm5200_defconfig
arm                        keystone_defconfig
mips                       lemote2f_defconfig
nios2                         10m50_defconfig
mips                        workpad_defconfig
sh                          rsk7269_defconfig
sh                         apsh4a3a_defconfig
powerpc                      bamboo_defconfig
powerpc                     mpc83xx_defconfig
riscv                             allnoconfig
xtensa                    xip_kc705_defconfig
m68k                        mvme16x_defconfig
powerpc                    klondike_defconfig
powerpc                     tqm8560_defconfig
microblaze                          defconfig
sh                          r7785rp_defconfig
powerpc                 mpc837x_rdb_defconfig
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
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20210518
x86_64               randconfig-a004-20210518
x86_64               randconfig-a005-20210518
x86_64               randconfig-a001-20210518
x86_64               randconfig-a002-20210518
x86_64               randconfig-a006-20210518
i386                 randconfig-a003-20210518
i386                 randconfig-a001-20210518
i386                 randconfig-a005-20210518
i386                 randconfig-a004-20210518
i386                 randconfig-a002-20210518
i386                 randconfig-a006-20210518
i386                 randconfig-a003-20210519
i386                 randconfig-a001-20210519
i386                 randconfig-a005-20210519
i386                 randconfig-a004-20210519
i386                 randconfig-a002-20210519
i386                 randconfig-a006-20210519
x86_64               randconfig-a012-20210519
x86_64               randconfig-a015-20210519
x86_64               randconfig-a013-20210519
x86_64               randconfig-a011-20210519
x86_64               randconfig-a016-20210519
x86_64               randconfig-a014-20210519
i386                 randconfig-a014-20210519
i386                 randconfig-a016-20210519
i386                 randconfig-a011-20210519
i386                 randconfig-a015-20210519
i386                 randconfig-a012-20210519
i386                 randconfig-a013-20210519
i386                 randconfig-a014-20210518
i386                 randconfig-a016-20210518
i386                 randconfig-a011-20210518
i386                 randconfig-a015-20210518
i386                 randconfig-a012-20210518
i386                 randconfig-a013-20210518
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                               allmodconfig
um                               allyesconfig
um                                allnoconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210518
x86_64               randconfig-b001-20210519
x86_64               randconfig-a015-20210518
x86_64               randconfig-a012-20210518
x86_64               randconfig-a013-20210518
x86_64               randconfig-a011-20210518
x86_64               randconfig-a016-20210518
x86_64               randconfig-a014-20210518

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
