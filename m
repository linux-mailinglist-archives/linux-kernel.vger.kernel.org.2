Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA243E376B
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Aug 2021 00:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbhHGWj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 18:39:29 -0400
Received: from mga11.intel.com ([192.55.52.93]:1104 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229899AbhHGWj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 18:39:27 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10069"; a="211426449"
X-IronPort-AV: E=Sophos;i="5.84,304,1620716400"; 
   d="scan'208";a="211426449"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2021 15:39:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,304,1620716400"; 
   d="scan'208";a="672966941"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 07 Aug 2021 15:39:08 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mCUyB-000IDY-P7; Sat, 07 Aug 2021 22:39:07 +0000
Date:   Sun, 08 Aug 2021 06:38:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2021.08.05a] BUILD REGRESSION
 4c05a30461b560deb441fb89a8517bb39971515d
Message-ID: <610f0b5b.UeadPmxgjadLmDnb%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2021.08.05a
branch HEAD: 4c05a30461b560deb441fb89a8517bb39971515d  rcutorture: Don't cpuhp_remove_state() if cpuhp_setup_state() failed

possible Error/Warning in current branch:

kernel/cpu.c:170: undefined reference to `__udivdi3'
kernel/cpu.c:184: undefined reference to `__udivdi3'
kernel/cpu.c:733:45: error: passing 'const char [19]' to parameter of type 'void *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
ld: kernel/cpu.c:174: undefined reference to `__udivdi3'
ld: kernel/cpu.c:212: undefined reference to `__udivdi3'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- i386-randconfig-m021-20210804
|   |-- kernel-cpu.c:undefined-reference-to-__udivdi3
|   `-- ld:kernel-cpu.c:undefined-reference-to-__udivdi3
`-- i386-randconfig-r022-20210804
    |-- kernel-cpu.c:undefined-reference-to-__udivdi3
    `-- ld:kernel-cpu.c:undefined-reference-to-__udivdi3

clang_recent_errors
`-- hexagon-randconfig-r014-20210807
    `-- kernel-cpu.c:error:passing-const-char-to-parameter-of-type-void-discards-qualifiers-Werror-Wincompatible-pointer-types-discards-qualifiers

elapsed time: 1528m

configs tested: 225
configs skipped: 4

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210804
i386                 randconfig-c001-20210805
i386                 randconfig-c001-20210807
h8300                       h8s-sim_defconfig
arm                       mainstone_defconfig
arm                            pleb_defconfig
powerpc                 mpc832x_mds_defconfig
sh                            titan_defconfig
powerpc                           allnoconfig
arm                       aspeed_g4_defconfig
powerpc                  mpc866_ads_defconfig
powerpc                      mgcoge_defconfig
sparc                       sparc64_defconfig
sh                            migor_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                              alldefconfig
mips                malta_qemu_32r6_defconfig
sparc                            alldefconfig
ia64                             allmodconfig
mips                     loongson1b_defconfig
arm                           sama5_defconfig
sh                     sh7710voipgw_defconfig
arc                                 defconfig
arc                    vdk_hs38_smp_defconfig
arc                        nsim_700_defconfig
arm                          imote2_defconfig
arc                     haps_hs_smp_defconfig
powerpc                        warp_defconfig
arc                              alldefconfig
arm                         socfpga_defconfig
parisc                              defconfig
arm                       aspeed_g5_defconfig
arm                            dove_defconfig
xtensa                           alldefconfig
arm                       imx_v4_v5_defconfig
arm                         axm55xx_defconfig
powerpc                     tqm5200_defconfig
sh                        sh7763rdp_defconfig
h8300                    h8300h-sim_defconfig
riscv                            allmodconfig
powerpc                     mpc5200_defconfig
mips                           mtx1_defconfig
mips                          rb532_defconfig
m68k                            mac_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                    sam440ep_defconfig
powerpc                       ebony_defconfig
sh                   secureedge5410_defconfig
mips                        jmr3927_defconfig
mips                           ip28_defconfig
sh                           se7722_defconfig
sh                               j2_defconfig
mips                           xway_defconfig
s390                                defconfig
ia64                        generic_defconfig
powerpc                     tqm8555_defconfig
sh                        edosk7705_defconfig
powerpc                      tqm8xx_defconfig
mips                           gcw0_defconfig
powerpc                     pq2fads_defconfig
mips                        omega2p_defconfig
arm                          collie_defconfig
arm                   milbeaut_m10v_defconfig
powerpc                     taishan_defconfig
powerpc                     mpc83xx_defconfig
arm                         nhk8815_defconfig
arm                          gemini_defconfig
mips                       bmips_be_defconfig
parisc                           allyesconfig
powerpc               mpc834x_itxgp_defconfig
sh                        edosk7760_defconfig
arm                           tegra_defconfig
microblaze                          defconfig
csky                                defconfig
arm                     am200epdkit_defconfig
powerpc                          allmodconfig
arm                      jornada720_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                      obs600_defconfig
powerpc                      walnut_defconfig
arm                       spear13xx_defconfig
sh                          polaris_defconfig
m68k                       m5249evb_defconfig
arm                          badge4_defconfig
powerpc                          allyesconfig
powerpc                      arches_defconfig
arm                          pcm027_defconfig
xtensa                  audio_kc705_defconfig
x86_64                            allnoconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
s390                             allyesconfig
s390                             allmodconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
x86_64               randconfig-a002-20210805
x86_64               randconfig-a006-20210805
x86_64               randconfig-a004-20210805
x86_64               randconfig-a003-20210805
x86_64               randconfig-a001-20210805
x86_64               randconfig-a005-20210805
i386                 randconfig-a004-20210808
i386                 randconfig-a005-20210808
i386                 randconfig-a006-20210808
i386                 randconfig-a002-20210808
i386                 randconfig-a001-20210808
i386                 randconfig-a003-20210808
i386                 randconfig-a005-20210804
i386                 randconfig-a004-20210804
i386                 randconfig-a002-20210804
i386                 randconfig-a006-20210804
i386                 randconfig-a003-20210804
i386                 randconfig-a001-20210804
i386                 randconfig-a005-20210806
i386                 randconfig-a004-20210806
i386                 randconfig-a002-20210806
i386                 randconfig-a006-20210806
i386                 randconfig-a003-20210806
i386                 randconfig-a001-20210806
i386                 randconfig-a005-20210805
i386                 randconfig-a004-20210805
i386                 randconfig-a002-20210805
i386                 randconfig-a006-20210805
i386                 randconfig-a003-20210805
i386                 randconfig-a001-20210805
x86_64               randconfig-a012-20210804
x86_64               randconfig-a016-20210804
x86_64               randconfig-a011-20210804
x86_64               randconfig-a013-20210804
x86_64               randconfig-a014-20210804
x86_64               randconfig-a015-20210804
x86_64               randconfig-a016-20210808
x86_64               randconfig-a012-20210808
x86_64               randconfig-a013-20210808
x86_64               randconfig-a011-20210808
x86_64               randconfig-a014-20210808
x86_64               randconfig-a015-20210808
i386                 randconfig-a012-20210807
i386                 randconfig-a011-20210807
i386                 randconfig-a015-20210807
i386                 randconfig-a013-20210807
i386                 randconfig-a014-20210807
i386                 randconfig-a016-20210807
i386                 randconfig-a012-20210805
i386                 randconfig-a011-20210805
i386                 randconfig-a015-20210805
i386                 randconfig-a013-20210805
i386                 randconfig-a014-20210805
i386                 randconfig-a016-20210805
i386                 randconfig-a012-20210808
i386                 randconfig-a015-20210808
i386                 randconfig-a011-20210808
i386                 randconfig-a013-20210808
i386                 randconfig-a014-20210808
i386                 randconfig-a016-20210808
i386                 randconfig-a012-20210804
i386                 randconfig-a011-20210804
i386                 randconfig-a015-20210804
i386                 randconfig-a013-20210804
i386                 randconfig-a014-20210804
i386                 randconfig-a016-20210804
i386                 randconfig-a012-20210806
i386                 randconfig-a011-20210806
i386                 randconfig-a015-20210806
i386                 randconfig-a013-20210806
i386                 randconfig-a014-20210806
i386                 randconfig-a016-20210806
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c001-20210808
x86_64               randconfig-c001-20210805
x86_64               randconfig-c001-20210807
x86_64               randconfig-c001-20210806
x86_64               randconfig-c001-20210804
x86_64               randconfig-a002-20210804
x86_64               randconfig-a006-20210804
x86_64               randconfig-a004-20210804
x86_64               randconfig-a003-20210804
x86_64               randconfig-a001-20210804
x86_64               randconfig-a005-20210804
x86_64               randconfig-a002-20210808
x86_64               randconfig-a004-20210808
x86_64               randconfig-a006-20210808
x86_64               randconfig-a003-20210808
x86_64               randconfig-a001-20210808
x86_64               randconfig-a005-20210808
x86_64               randconfig-a012-20210805
x86_64               randconfig-a016-20210805
x86_64               randconfig-a011-20210805
x86_64               randconfig-a013-20210805
x86_64               randconfig-a014-20210805
x86_64               randconfig-a015-20210805

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
