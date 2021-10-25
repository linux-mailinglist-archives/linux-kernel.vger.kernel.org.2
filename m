Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45B1143925D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 11:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbhJYJba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 05:31:30 -0400
Received: from mga09.intel.com ([134.134.136.24]:53105 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231917AbhJYJb1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 05:31:27 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10147"; a="229468666"
X-IronPort-AV: E=Sophos;i="5.87,179,1631602800"; 
   d="scan'208";a="229468666"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 02:29:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,179,1631602800"; 
   d="scan'208";a="596406506"
Received: from lkp-server02.sh.intel.com (HELO 74392981b700) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 25 Oct 2021 02:29:04 -0700
Received: from kbuild by 74392981b700 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mewHv-0001aR-GA; Mon, 25 Oct 2021 09:29:03 +0000
Date:   Mon, 25 Oct 2021 17:28:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2021.10.13a] BUILD SUCCESS
 e62f19bebdd17fbd2289db98395e2ab3c0a0527a
Message-ID: <617678c1.nTJx5/B1wC1Tsz6Y%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2021.10.13a
branch HEAD: e62f19bebdd17fbd2289db98395e2ab3c0a0527a  fixup! clocksource: Forgive repeated long-latency watchdog clocksource reads

elapsed time: 1814m

configs tested: 156
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allmodconfig
arm                              allyesconfig
i386                 randconfig-c001-20211025
sh                         ap325rxa_defconfig
powerpc                      pcm030_defconfig
mips                     decstation_defconfig
powerpc                      arches_defconfig
sh                            migor_defconfig
powerpc                      pmac32_defconfig
powerpc                      walnut_defconfig
m68k                         amcore_defconfig
arc                        nsim_700_defconfig
powerpc                        cell_defconfig
s390                          debug_defconfig
powerpc                 mpc832x_rdb_defconfig
sh                           se7751_defconfig
xtensa                          iss_defconfig
powerpc                 mpc837x_rdb_defconfig
sh                           se7705_defconfig
mips                      pic32mzda_defconfig
mips                      bmips_stb_defconfig
arm                           h5000_defconfig
xtensa                generic_kc705_defconfig
arm                           h3600_defconfig
mips                        vocore2_defconfig
sh                        sh7757lcr_defconfig
mips                         bigsur_defconfig
sh                              ul2_defconfig
i386                             alldefconfig
powerpc                 mpc8313_rdb_defconfig
sparc                       sparc32_defconfig
sparc64                          alldefconfig
sh                        sh7785lcr_defconfig
openrisc                    or1ksim_defconfig
xtensa                  cadence_csp_defconfig
powerpc                 mpc8315_rdb_defconfig
arm                          ep93xx_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                    mvme5100_defconfig
sh                        sh7763rdp_defconfig
mips                         tb0226_defconfig
powerpc                     tqm8560_defconfig
arm                        multi_v7_defconfig
powerpc                 mpc8272_ads_defconfig
arm                            xcep_defconfig
powerpc                     kmeter1_defconfig
openrisc                         alldefconfig
powerpc                     tqm8548_defconfig
arm                       spear13xx_defconfig
mips                 decstation_r4k_defconfig
riscv                               defconfig
powerpc                   bluestone_defconfig
nios2                         3c120_defconfig
arc                      axs103_smp_defconfig
powerpc                      obs600_defconfig
mips                          rm200_defconfig
arm                          moxart_defconfig
mips                     loongson1c_defconfig
sh                            shmin_defconfig
mips                            gpr_defconfig
powerpc                     kilauea_defconfig
mips                    maltaup_xpa_defconfig
mips                           ip32_defconfig
sh                            titan_defconfig
arc                           tb10x_defconfig
ia64                         bigsur_defconfig
arm                         s3c2410_defconfig
arm                          ixp4xx_defconfig
powerpc                     ppa8548_defconfig
arm                  randconfig-c002-20211025
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
nios2                               defconfig
nds32                             allnoconfig
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
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
s390                             allmodconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20211024
x86_64               randconfig-a004-20211024
x86_64               randconfig-a005-20211024
x86_64               randconfig-a006-20211024
x86_64               randconfig-a001-20211024
x86_64               randconfig-a003-20211024
i386                 randconfig-a003-20211024
i386                 randconfig-a004-20211024
i386                 randconfig-a002-20211024
i386                 randconfig-a005-20211024
i386                 randconfig-a006-20211024
i386                 randconfig-a001-20211024
x86_64               randconfig-a013-20211025
x86_64               randconfig-a015-20211025
x86_64               randconfig-a011-20211025
x86_64               randconfig-a014-20211025
x86_64               randconfig-a016-20211025
x86_64               randconfig-a012-20211025
i386                 randconfig-a012-20211025
i386                 randconfig-a013-20211025
i386                 randconfig-a011-20211025
i386                 randconfig-a016-20211025
i386                 randconfig-a015-20211025
i386                 randconfig-a014-20211025
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
riscv                randconfig-c006-20211025
powerpc              randconfig-c003-20211025
arm                  randconfig-c002-20211025
x86_64               randconfig-c007-20211025
mips                 randconfig-c004-20211025
i386                 randconfig-c001-20211025
s390                 randconfig-c005-20211025
i386                 randconfig-a003-20211025
i386                 randconfig-a004-20211025
i386                 randconfig-a002-20211025
i386                 randconfig-a005-20211025
i386                 randconfig-a001-20211025
i386                 randconfig-a006-20211025
hexagon              randconfig-r045-20211025
hexagon              randconfig-r041-20211025

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
