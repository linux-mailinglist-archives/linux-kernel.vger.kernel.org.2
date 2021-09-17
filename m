Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4136C40EECC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 03:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242343AbhIQBfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 21:35:33 -0400
Received: from mga06.intel.com ([134.134.136.31]:18463 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240318AbhIQBf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 21:35:27 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10109"; a="283708126"
X-IronPort-AV: E=Sophos;i="5.85,299,1624345200"; 
   d="scan'208";a="283708126"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2021 18:34:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,299,1624345200"; 
   d="scan'208";a="433971690"
Received: from lkp-server01.sh.intel.com (HELO 285e7b116627) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 16 Sep 2021 18:34:04 -0700
Received: from kbuild by 285e7b116627 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mR2lP-0001cP-W8; Fri, 17 Sep 2021 01:34:03 +0000
Date:   Fri, 17 Sep 2021 09:33:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2021.09.13b] BUILD SUCCESS
 09f94349dd9dd3bdd178edfacb47e246fb402f0b
Message-ID: <6143f055.WE+oTfiDcnqLy6aA%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2021.09.13b
branch HEAD: 09f94349dd9dd3bdd178edfacb47e246fb402f0b  EXP softirq: More aggressively update tick

elapsed time: 4407m

configs tested: 210
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210914
nds32                            alldefconfig
parisc                generic-64bit_defconfig
powerpc                          g5_defconfig
mips                         mpc30x_defconfig
powerpc                      acadia_defconfig
sh                        sh7785lcr_defconfig
powerpc                      chrp32_defconfig
arm                         bcm2835_defconfig
arm                         at91_dt_defconfig
sh                           se7780_defconfig
sh                   sh7724_generic_defconfig
sh                          kfr2r09_defconfig
sh                     sh7710voipgw_defconfig
mips                 decstation_r4k_defconfig
arm                       aspeed_g4_defconfig
sparc                            alldefconfig
mips                          rb532_defconfig
powerpc                     ksi8560_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                  mpc885_ads_defconfig
mips                         rt305x_defconfig
mips                     loongson1b_defconfig
powerpc                   lite5200b_defconfig
powerpc                  mpc866_ads_defconfig
arm                         vf610m4_defconfig
sh                      rts7751r2d1_defconfig
arm                          gemini_defconfig
arm                           h3600_defconfig
arm                         lubbock_defconfig
powerpc                           allnoconfig
powerpc                 mpc836x_rdk_defconfig
sh                           se7705_defconfig
arm                            qcom_defconfig
arc                 nsimosci_hs_smp_defconfig
arm                        magician_defconfig
arm                           corgi_defconfig
m68k                        m5307c3_defconfig
m68k                            mac_defconfig
xtensa                          iss_defconfig
arm                         axm55xx_defconfig
arm                           sama5_defconfig
arm                          ixp4xx_defconfig
arm                          lpd270_defconfig
arc                          axs101_defconfig
alpha                            alldefconfig
powerpc                    mvme5100_defconfig
microblaze                      mmu_defconfig
um                                  defconfig
mips                        omega2p_defconfig
ia64                        generic_defconfig
sh                           se7721_defconfig
mips                  cavium_octeon_defconfig
nios2                         3c120_defconfig
arm                             rpc_defconfig
arm                        realview_defconfig
arm                            hisi_defconfig
sh                           se7206_defconfig
arc                         haps_hs_defconfig
m68k                          sun3x_defconfig
arm                        neponset_defconfig
sh                          r7785rp_defconfig
m68k                       m5275evb_defconfig
arm                           spitz_defconfig
arm                        spear6xx_defconfig
mips                           xway_defconfig
arm                            mmp2_defconfig
powerpc                        fsp2_defconfig
arc                              alldefconfig
x86_64               randconfig-c001-20210914
arm                  randconfig-c002-20210914
x86_64               randconfig-c001-20210916
arm                  randconfig-c002-20210916
i386                 randconfig-c001-20210916
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
arc                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allmodconfig
s390                                defconfig
s390                             allyesconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64               randconfig-a002-20210915
x86_64               randconfig-a003-20210915
x86_64               randconfig-a004-20210915
x86_64               randconfig-a006-20210915
x86_64               randconfig-a005-20210915
x86_64               randconfig-a001-20210915
i386                 randconfig-a004-20210913
i386                 randconfig-a005-20210913
i386                 randconfig-a002-20210913
i386                 randconfig-a006-20210913
i386                 randconfig-a003-20210913
i386                 randconfig-a001-20210913
x86_64               randconfig-a013-20210914
x86_64               randconfig-a016-20210914
x86_64               randconfig-a012-20210914
x86_64               randconfig-a011-20210914
x86_64               randconfig-a014-20210914
x86_64               randconfig-a015-20210914
x86_64               randconfig-a016-20210916
x86_64               randconfig-a013-20210916
x86_64               randconfig-a012-20210916
x86_64               randconfig-a011-20210916
x86_64               randconfig-a014-20210916
x86_64               randconfig-a015-20210916
i386                 randconfig-a016-20210914
i386                 randconfig-a015-20210914
i386                 randconfig-a011-20210914
i386                 randconfig-a012-20210914
i386                 randconfig-a013-20210914
i386                 randconfig-a014-20210914
i386                 randconfig-a016-20210916
i386                 randconfig-a015-20210916
i386                 randconfig-a011-20210916
i386                 randconfig-a012-20210916
i386                 randconfig-a013-20210916
i386                 randconfig-a014-20210916
x86_64               randconfig-a002-20210913
x86_64               randconfig-a003-20210913
x86_64               randconfig-a006-20210913
x86_64               randconfig-a004-20210913
x86_64               randconfig-a005-20210913
x86_64               randconfig-a001-20210913
arc                  randconfig-r043-20210913
riscv                randconfig-r042-20210916
s390                 randconfig-r044-20210916
arc                  randconfig-r043-20210916
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allyesconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
riscv                randconfig-c006-20210914
x86_64               randconfig-c007-20210914
powerpc              randconfig-c003-20210914
arm                  randconfig-c002-20210914
i386                 randconfig-c001-20210914
s390                 randconfig-c005-20210914
x86_64               randconfig-a002-20210916
x86_64               randconfig-a003-20210916
x86_64               randconfig-a006-20210916
x86_64               randconfig-a004-20210916
x86_64               randconfig-a005-20210916
x86_64               randconfig-a001-20210916
i386                 randconfig-a004-20210914
i386                 randconfig-a005-20210914
i386                 randconfig-a006-20210914
i386                 randconfig-a002-20210914
i386                 randconfig-a001-20210914
i386                 randconfig-a003-20210914
i386                 randconfig-a004-20210916
i386                 randconfig-a005-20210916
i386                 randconfig-a006-20210916
i386                 randconfig-a002-20210916
i386                 randconfig-a003-20210916
i386                 randconfig-a001-20210916
x86_64               randconfig-a002-20210914
x86_64               randconfig-a003-20210914
x86_64               randconfig-a004-20210914
x86_64               randconfig-a006-20210914
x86_64               randconfig-a005-20210914
x86_64               randconfig-a001-20210914
x86_64               randconfig-a016-20210913
x86_64               randconfig-a013-20210913
x86_64               randconfig-a012-20210913
x86_64               randconfig-a011-20210913
x86_64               randconfig-a014-20210913
x86_64               randconfig-a015-20210913
hexagon              randconfig-r045-20210914
hexagon              randconfig-r041-20210914
riscv                randconfig-r042-20210913
hexagon              randconfig-r045-20210913
s390                 randconfig-r044-20210913
hexagon              randconfig-r041-20210913

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
