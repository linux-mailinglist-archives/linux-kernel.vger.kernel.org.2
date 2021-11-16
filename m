Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD177452CB0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 09:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbhKPI3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 03:29:08 -0500
Received: from mga04.intel.com ([192.55.52.120]:19551 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231926AbhKPI3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 03:29:06 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10169"; a="232369844"
X-IronPort-AV: E=Sophos;i="5.87,238,1631602800"; 
   d="scan'208";a="232369844"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2021 00:26:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,238,1631602800"; 
   d="scan'208";a="454363841"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 16 Nov 2021 00:26:07 -0800
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mmtn4-0000ER-JU; Tue, 16 Nov 2021 08:26:06 +0000
Date:   Tue, 16 Nov 2021 16:26:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/sgx] BUILD SUCCESS
 688542e29fae655a8be25832f6a9959bdd308dd8
Message-ID: <61936b18.jLamIbLeLrnbPZye%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/sgx
branch HEAD: 688542e29fae655a8be25832f6a9959bdd308dd8  selftests/sgx: Add test for multiple TCS entry

elapsed time: 727m

configs tested: 189
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211115
i386                 randconfig-c001-20211116
m68k                             alldefconfig
powerpc                 linkstation_defconfig
ia64                                defconfig
mips                         db1xxx_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                        cell_defconfig
arm                       omap2plus_defconfig
sparc                               defconfig
arm                       cns3420vb_defconfig
arm                        mini2440_defconfig
sh                            shmin_defconfig
powerpc                    adder875_defconfig
sparc                            alldefconfig
powerpc                 mpc836x_mds_defconfig
arm                         nhk8815_defconfig
arm                         lubbock_defconfig
sh                             shx3_defconfig
sh                          lboxre2_defconfig
arm                       netwinder_defconfig
powerpc                mpc7448_hpc2_defconfig
arc                                 defconfig
m68k                        m5307c3_defconfig
powerpc                     stx_gp3_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                         cm_x300_defconfig
m68k                          atari_defconfig
sh                             espt_defconfig
arm                        vexpress_defconfig
h8300                    h8300h-sim_defconfig
sh                               j2_defconfig
powerpc                      ppc6xx_defconfig
mips                          ath25_defconfig
openrisc                 simple_smp_defconfig
sh                         ecovec24_defconfig
m68k                       m5475evb_defconfig
arm                            xcep_defconfig
arm                        spear3xx_defconfig
m68k                       m5208evb_defconfig
powerpc                     ppa8548_defconfig
arm                       aspeed_g4_defconfig
mips                     decstation_defconfig
sh                         apsh4a3a_defconfig
sparc64                             defconfig
m68k                       m5275evb_defconfig
arm                        magician_defconfig
mips                           ip22_defconfig
m68k                            mac_defconfig
arm                          badge4_defconfig
sh                           sh2007_defconfig
powerpc                     ksi8560_defconfig
powerpc                     kilauea_defconfig
arm                      tct_hammer_defconfig
sh                          sdk7780_defconfig
powerpc                      cm5200_defconfig
powerpc                   microwatt_defconfig
mips                       bmips_be_defconfig
um                               alldefconfig
arm                     eseries_pxa_defconfig
powerpc                 xes_mpc85xx_defconfig
x86_64                           allyesconfig
powerpc                     taishan_defconfig
arm                         at91_dt_defconfig
m68k                         amcore_defconfig
sh                   sh7770_generic_defconfig
xtensa                         virt_defconfig
mips                             allyesconfig
powerpc                   lite5200b_defconfig
mips                           ip32_defconfig
powerpc                     pq2fads_defconfig
m68k                        mvme16x_defconfig
arm                         palmz72_defconfig
powerpc                  iss476-smp_defconfig
arm                           tegra_defconfig
h8300                               defconfig
mips                      maltaaprp_defconfig
powerpc                    ge_imp3a_defconfig
sh                          rsk7203_defconfig
m68k                        m5407c3_defconfig
sh                        sh7763rdp_defconfig
mips                         mpc30x_defconfig
sh                     sh7710voipgw_defconfig
arm                  randconfig-c002-20211115
arm                  randconfig-c002-20211116
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
h8300                            allyesconfig
xtensa                           allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                              debian-10.3
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64               randconfig-a005-20211115
x86_64               randconfig-a003-20211115
x86_64               randconfig-a002-20211115
x86_64               randconfig-a001-20211115
x86_64               randconfig-a006-20211115
x86_64               randconfig-a004-20211115
i386                 randconfig-a006-20211115
i386                 randconfig-a003-20211115
i386                 randconfig-a005-20211115
i386                 randconfig-a001-20211115
i386                 randconfig-a004-20211115
i386                 randconfig-a002-20211115
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
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c007-20211115
i386                 randconfig-c001-20211115
arm                  randconfig-c002-20211115
riscv                randconfig-c006-20211115
powerpc              randconfig-c003-20211115
s390                 randconfig-c005-20211115
mips                 randconfig-c004-20211115
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
x86_64               randconfig-a002-20211116
x86_64               randconfig-a006-20211116
x86_64               randconfig-a004-20211116
x86_64               randconfig-a015-20211115
x86_64               randconfig-a013-20211115
x86_64               randconfig-a011-20211115
x86_64               randconfig-a012-20211115
x86_64               randconfig-a016-20211115
x86_64               randconfig-a014-20211115
i386                 randconfig-a014-20211115
i386                 randconfig-a016-20211115
i386                 randconfig-a012-20211115
i386                 randconfig-a013-20211115
i386                 randconfig-a011-20211115
i386                 randconfig-a015-20211115
hexagon              randconfig-r045-20211115
hexagon              randconfig-r041-20211115
s390                 randconfig-r044-20211115
riscv                randconfig-r042-20211115

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
