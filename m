Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4D738851E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 05:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237594AbhESDKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 23:10:03 -0400
Received: from mga18.intel.com ([134.134.136.126]:21370 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237253AbhESDKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 23:10:01 -0400
IronPort-SDR: IGjbCt8vvZNiJaOhsuG+USasuR7ZRhXL7vQUG3uJ/7FSaJPDlFhvIs/u5bv4UCky6DObPz4BXm
 xYGSbgVls/1Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="188288396"
X-IronPort-AV: E=Sophos;i="5.82,311,1613462400"; 
   d="scan'208";a="188288396"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 20:08:42 -0700
IronPort-SDR: q3N5L24UZIVauLy+8NZGQAIEfYov2Tu78P086Efk54l6vGqhWrALowMdy/T3OTV14sHig8/BcE
 1GMCbJO30F8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,311,1613462400"; 
   d="scan'208";a="544370605"
Received: from lkp-server01.sh.intel.com (HELO ddd90b05c979) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 18 May 2021 20:08:41 -0700
Received: from kbuild by ddd90b05c979 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ljCZc-0002TR-Ap; Wed, 19 May 2021 03:08:40 +0000
Date:   Wed, 19 May 2021 11:08:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/splitlock] BUILD SUCCESS
 d28397eaf4c27947a1ffc720d42e8b3a33ae1e2a
Message-ID: <60a48136.9cEAhSIqEpYDvlR6%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/splitlock
branch HEAD: d28397eaf4c27947a1ffc720d42e8b3a33ae1e2a  Documentation/x86: Add ratelimit in buslock.rst

elapsed time: 720m

configs tested: 207
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
sh                          rsk7264_defconfig
ia64                          tiger_defconfig
mips                        bcm47xx_defconfig
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
arm                          gemini_defconfig
sh                             espt_defconfig
sh                        apsh4ad0a_defconfig
sparc                       sparc32_defconfig
sh                              ul2_defconfig
sh                      rts7751r2d1_defconfig
xtensa                generic_kc705_defconfig
arm64                            alldefconfig
xtensa                    smp_lx200_defconfig
i386                                defconfig
sh                            hp6xx_defconfig
mips                     loongson2k_defconfig
m68k                       m5475evb_defconfig
powerpc                   lite5200b_defconfig
arm                           u8500_defconfig
i386                             alldefconfig
openrisc                  or1klitex_defconfig
sh                          kfr2r09_defconfig
mips                      malta_kvm_defconfig
arm                             rpc_defconfig
sh                          urquell_defconfig
arm                        realview_defconfig
mips                           ip32_defconfig
sh                          rsk7201_defconfig
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
arm                          iop32x_defconfig
mips                       rbtx49xx_defconfig
arm                        multi_v7_defconfig
m68k                         apollo_defconfig
arm                           h3600_defconfig
arm                      footbridge_defconfig
arm                            hisi_defconfig
arm                          exynos_defconfig
arm                       aspeed_g4_defconfig
sh                          polaris_defconfig
alpha                            alldefconfig
mips                        nlm_xlr_defconfig
openrisc                    or1ksim_defconfig
alpha                               defconfig
powerpc                    ge_imp3a_defconfig
mips                     cu1830-neo_defconfig
powerpc                 mpc832x_rdb_defconfig
sh                           se7343_defconfig
arm                          pxa168_defconfig
arm                         lpc18xx_defconfig
mips                  maltasmvp_eva_defconfig
sh                          sdk7786_defconfig
csky                                defconfig
nios2                         3c120_defconfig
parisc                generic-64bit_defconfig
x86_64                              defconfig
arm                       multi_v4t_defconfig
arm                      integrator_defconfig
arm                       aspeed_g5_defconfig
powerpc                      ppc64e_defconfig
sh                           se7206_defconfig
x86_64                           allyesconfig
mips                malta_qemu_32r6_defconfig
powerpc                       eiger_defconfig
powerpc                        icon_defconfig
powerpc                       maple_defconfig
powerpc                     tqm5200_defconfig
arm                        keystone_defconfig
mips                       lemote2f_defconfig
xtensa                    xip_kc705_defconfig
m68k                        mvme16x_defconfig
powerpc                    klondike_defconfig
powerpc                     tqm8560_defconfig
microblaze                          defconfig
arm                       imx_v4_v5_defconfig
sparc                       sparc64_defconfig
arm                          collie_defconfig
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
riscv                             allnoconfig
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
x86_64               randconfig-b001-20210519
x86_64               randconfig-b001-20210518
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
