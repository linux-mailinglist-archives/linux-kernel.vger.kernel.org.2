Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DECE3407A1D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 20:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233684AbhIKSke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 14:40:34 -0400
Received: from mga14.intel.com ([192.55.52.115]:2317 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233438AbhIKSkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 14:40:33 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10104"; a="221004968"
X-IronPort-AV: E=Sophos;i="5.85,285,1624345200"; 
   d="scan'208";a="221004968"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2021 11:39:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,285,1624345200"; 
   d="scan'208";a="697739536"
Received: from lkp-server01.sh.intel.com (HELO 730d49888f40) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 11 Sep 2021 11:39:19 -0700
Received: from kbuild by 730d49888f40 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mP7uI-0005j5-Dm; Sat, 11 Sep 2021 18:39:18 +0000
Date:   Sun, 12 Sep 2021 02:39:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:smp/urgent] BUILD SUCCESS
 c9871c800f65fffed40f3df3e1eb38984f95cfcf
Message-ID: <613cf7c8.iKZxeM+gZgDiO/ZG%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp/urgent
branch HEAD: c9871c800f65fffed40f3df3e1eb38984f95cfcf  Documentation: core-api/cpuhotplug: Rewrite the API section

elapsed time: 1158m

configs tested: 171
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allmodconfig
arm                              allyesconfig
powerpc              randconfig-c003-20210911
i386                 randconfig-c001-20210911
i386                 randconfig-c001-20210910
xtensa                    xip_kc705_defconfig
mips                        bcm47xx_defconfig
powerpc                     tqm8548_defconfig
arm                      jornada720_defconfig
arm                          imote2_defconfig
powerpc                   bluestone_defconfig
um                             i386_defconfig
arm                         s5pv210_defconfig
powerpc                 mpc837x_rdb_defconfig
i386                             allyesconfig
openrisc                  or1klitex_defconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                     sequoia_defconfig
arm                      integrator_defconfig
powerpc                     akebono_defconfig
nios2                         3c120_defconfig
sh                         ap325rxa_defconfig
m68k                          atari_defconfig
h8300                    h8300h-sim_defconfig
m68k                          multi_defconfig
arm                         s3c6400_defconfig
xtensa                    smp_lx200_defconfig
powerpc                    gamecube_defconfig
sh                            migor_defconfig
microblaze                      mmu_defconfig
sh                          rsk7264_defconfig
arc                    vdk_hs38_smp_defconfig
arm                           stm32_defconfig
arm                         assabet_defconfig
mips                       rbtx49xx_defconfig
s390                       zfcpdump_defconfig
mips                      pic32mzda_defconfig
mips                         db1xxx_defconfig
xtensa                  cadence_csp_defconfig
arm                        multi_v7_defconfig
sh                          urquell_defconfig
mips                          malta_defconfig
mips                 decstation_r4k_defconfig
arm                          lpd270_defconfig
mips                         tb0287_defconfig
sh                           se7712_defconfig
powerpc                     tqm8541_defconfig
m68k                             alldefconfig
m68k                       m5475evb_defconfig
powerpc                   microwatt_defconfig
mips                          ath25_defconfig
arm                         lpc18xx_defconfig
powerpc                      bamboo_defconfig
um                                  defconfig
arm                          badge4_defconfig
powerpc                     ksi8560_defconfig
ia64                             alldefconfig
mips                      maltasmvp_defconfig
arm                          collie_defconfig
mips                        workpad_defconfig
arm                         palmz72_defconfig
arm                       versatile_defconfig
x86_64               randconfig-c001-20210910
arm                  randconfig-c002-20210910
x86_64               randconfig-c001-20210911
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
s390                                defconfig
parisc                           allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a002-20210911
x86_64               randconfig-a003-20210911
x86_64               randconfig-a004-20210911
x86_64               randconfig-a006-20210911
x86_64               randconfig-a005-20210911
x86_64               randconfig-a001-20210911
i386                 randconfig-a004-20210911
i386                 randconfig-a005-20210911
i386                 randconfig-a002-20210911
i386                 randconfig-a006-20210911
i386                 randconfig-a001-20210911
i386                 randconfig-a003-20210911
x86_64               randconfig-a013-20210910
x86_64               randconfig-a016-20210910
x86_64               randconfig-a012-20210910
x86_64               randconfig-a011-20210910
x86_64               randconfig-a014-20210910
x86_64               randconfig-a015-20210910
i386                 randconfig-a016-20210910
i386                 randconfig-a011-20210910
i386                 randconfig-a012-20210910
i386                 randconfig-a013-20210910
i386                 randconfig-a014-20210910
riscv                randconfig-r042-20210910
s390                 randconfig-r044-20210910
arc                  randconfig-r043-20210910
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
x86_64               randconfig-c007-20210910
mips                 randconfig-c004-20210910
powerpc              randconfig-c003-20210910
i386                 randconfig-c001-20210910
s390                 randconfig-c005-20210910
x86_64               randconfig-c007-20210911
mips                 randconfig-c004-20210911
powerpc              randconfig-c003-20210911
i386                 randconfig-c001-20210911
s390                 randconfig-c005-20210911
x86_64               randconfig-a002-20210910
x86_64               randconfig-a003-20210910
x86_64               randconfig-a004-20210910
x86_64               randconfig-a006-20210910
x86_64               randconfig-a001-20210910
i386                 randconfig-a004-20210910
i386                 randconfig-a005-20210910
i386                 randconfig-a002-20210910
i386                 randconfig-a006-20210910
i386                 randconfig-a001-20210910
i386                 randconfig-a003-20210910
x86_64               randconfig-a013-20210911
x86_64               randconfig-a016-20210911
x86_64               randconfig-a012-20210911
x86_64               randconfig-a011-20210911
x86_64               randconfig-a014-20210911
x86_64               randconfig-a015-20210911
i386                 randconfig-a016-20210911
i386                 randconfig-a011-20210911
i386                 randconfig-a015-20210911
i386                 randconfig-a012-20210911
i386                 randconfig-a013-20210911
i386                 randconfig-a014-20210911
hexagon              randconfig-r045-20210910
hexagon              randconfig-r041-20210910

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
