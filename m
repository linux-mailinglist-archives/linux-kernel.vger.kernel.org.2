Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3DF238875E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 08:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbhESGM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 02:12:59 -0400
Received: from mga07.intel.com ([134.134.136.100]:32440 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232146AbhESGM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 02:12:57 -0400
IronPort-SDR: SY6wj122t/jYPX4sd1fiWAoRjg3h9MxizH23krt1dhFEKT4J14SO67eshgOz+rFlfKMC0F39uA
 BZbzoRA+9ZIw==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="264815748"
X-IronPort-AV: E=Sophos;i="5.82,312,1613462400"; 
   d="scan'208";a="264815748"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 23:11:18 -0700
IronPort-SDR: c6hFkFgLYghYiPhFbt42QFNpZMTwzq3onRHytCwaI/k2JHkS65B82Wk0ME32MvxUk6R5ocAyg7
 DrXFJWKPco7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,312,1613462400"; 
   d="scan'208";a="439820948"
Received: from lkp-server02.sh.intel.com (HELO 1b329be5b008) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 18 May 2021 23:11:16 -0700
Received: from kbuild by 1b329be5b008 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ljFQJ-00003f-P3; Wed, 19 May 2021 06:11:15 +0000
Date:   Wed, 19 May 2021 14:10:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2021.05.14b] BUILD SUCCESS
 3cd497c7f2d8b6906f6d0e78bc7772b2f434aa09
Message-ID: <60a4abe9.grWY5Eli/lJ5H10N%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2021.05.14b
branch HEAD: 3cd497c7f2d8b6906f6d0e78bc7772b2f434aa09  tools/memory-model: Document data_race(READ_ONCE())

elapsed time: 720m

configs tested: 182
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                        spear6xx_defconfig
mips                           rs90_defconfig
arm                           omap1_defconfig
xtensa                       common_defconfig
microblaze                      mmu_defconfig
mips                        nlm_xlp_defconfig
parisc                           alldefconfig
arm                        mini2440_defconfig
arm                     am200epdkit_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                      ppc44x_defconfig
arm                       aspeed_g4_defconfig
arc                         haps_hs_defconfig
arm                         lubbock_defconfig
sh                          rsk7201_defconfig
um                               allmodconfig
sh                         ap325rxa_defconfig
powerpc                     powernv_defconfig
arm                          imote2_defconfig
sh                           se7722_defconfig
mips                         mpc30x_defconfig
um                            kunit_defconfig
powerpc                      makalu_defconfig
powerpc                 mpc8315_rdb_defconfig
mips                           ip27_defconfig
sparc64                          alldefconfig
mips                          rb532_defconfig
mips                            gpr_defconfig
sh                     magicpanelr2_defconfig
sh                      rts7751r2d1_defconfig
xtensa                generic_kc705_defconfig
arm64                            alldefconfig
xtensa                    smp_lx200_defconfig
i386                                defconfig
sh                            hp6xx_defconfig
powerpc                 mpc837x_mds_defconfig
sh                  sh7785lcr_32bit_defconfig
mips                     loongson2k_defconfig
m68k                       m5475evb_defconfig
powerpc                   lite5200b_defconfig
arm                           u8500_defconfig
um                                  defconfig
arc                      axs103_smp_defconfig
arm                          iop32x_defconfig
ia64                            zx1_defconfig
powerpc                 mpc834x_mds_defconfig
mips                   sb1250_swarm_defconfig
arm                         socfpga_defconfig
sh                               alldefconfig
powerpc                   currituck_defconfig
arm                            dove_defconfig
arc                     nsimosci_hs_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                     rainier_defconfig
mips                        maltaup_defconfig
m68k                         amcore_defconfig
sh                           se7721_defconfig
arm                         shannon_defconfig
sh                   secureedge5410_defconfig
mips                       rbtx49xx_defconfig
arm                        multi_v7_defconfig
sh                          polaris_defconfig
alpha                            alldefconfig
alpha                               defconfig
mips                        nlm_xlr_defconfig
openrisc                    or1ksim_defconfig
powerpc                    ge_imp3a_defconfig
mips                     cu1830-neo_defconfig
arm                          gemini_defconfig
powerpc                 mpc832x_rdb_defconfig
sh                           se7343_defconfig
arm                          pxa168_defconfig
arm                         lpc18xx_defconfig
mips                  maltasmvp_eva_defconfig
sh                          sdk7786_defconfig
csky                                defconfig
nios2                         3c120_defconfig
parisc                generic-64bit_defconfig
arm                       multi_v4t_defconfig
arm                      integrator_defconfig
x86_64                              defconfig
arm                       aspeed_g5_defconfig
powerpc                      ppc64e_defconfig
arm                      footbridge_defconfig
mips                           ip32_defconfig
xtensa                    xip_kc705_defconfig
m68k                        mvme16x_defconfig
powerpc                    klondike_defconfig
powerpc                     tqm8560_defconfig
microblaze                          defconfig
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
nios2                            allyesconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210519
i386                 randconfig-a001-20210519
i386                 randconfig-a005-20210519
i386                 randconfig-a004-20210519
i386                 randconfig-a002-20210519
i386                 randconfig-a006-20210519
i386                 randconfig-a003-20210518
i386                 randconfig-a001-20210518
i386                 randconfig-a005-20210518
i386                 randconfig-a004-20210518
i386                 randconfig-a002-20210518
i386                 randconfig-a006-20210518
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
x86_64               randconfig-a003-20210518
x86_64               randconfig-a004-20210518
x86_64               randconfig-a005-20210518
x86_64               randconfig-a001-20210518
x86_64               randconfig-a002-20210518
x86_64               randconfig-a006-20210518
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                                allnoconfig
um                               allyesconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210519
x86_64               randconfig-a003-20210519
x86_64               randconfig-a004-20210519
x86_64               randconfig-a005-20210519
x86_64               randconfig-a001-20210519
x86_64               randconfig-a002-20210519
x86_64               randconfig-a006-20210519
x86_64               randconfig-a015-20210518
x86_64               randconfig-a012-20210518
x86_64               randconfig-a013-20210518
x86_64               randconfig-a011-20210518
x86_64               randconfig-a016-20210518
x86_64               randconfig-a014-20210518

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
