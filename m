Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDB314005D5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 21:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239237AbhICTbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 15:31:38 -0400
Received: from mga18.intel.com ([134.134.136.126]:9298 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239073AbhICTbg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 15:31:36 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10096"; a="206616584"
X-IronPort-AV: E=Sophos;i="5.85,266,1624345200"; 
   d="scan'208";a="206616584"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 12:30:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,266,1624345200"; 
   d="scan'208";a="521833065"
Received: from lkp-server01.sh.intel.com (HELO 2115029a3e5c) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 03 Sep 2021 12:30:35 -0700
Received: from kbuild by 2115029a3e5c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mMEtW-0000lk-CX; Fri, 03 Sep 2021 19:30:34 +0000
Date:   Sat, 04 Sep 2021 03:29:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 ee0f507188b804b76d45078abd4e967a40642009
Message-ID: <613277ad.3IV0QIB2L95gkylC%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: ee0f507188b804b76d45078abd4e967a40642009  Merge branch 'x86/urgent'

elapsed time: 1361m

configs tested: 137
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210904
mips                  maltasmvp_eva_defconfig
mips                         cobalt_defconfig
openrisc                    or1ksim_defconfig
arm                        multi_v7_defconfig
arm                         axm55xx_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                     rainier_defconfig
mips                         tb0226_defconfig
m68k                        m5272c3_defconfig
mips                        bcm63xx_defconfig
mips                        workpad_defconfig
powerpc                    gamecube_defconfig
powerpc                      acadia_defconfig
arm                       versatile_defconfig
sh                        sh7757lcr_defconfig
sh                           se7206_defconfig
microblaze                      mmu_defconfig
arm                          collie_defconfig
powerpc                 mpc836x_mds_defconfig
arm                  colibri_pxa300_defconfig
sh                          polaris_defconfig
arm                       imx_v6_v7_defconfig
mips                    maltaup_xpa_defconfig
powerpc                     mpc83xx_defconfig
arm                        clps711x_defconfig
um                                  defconfig
m68k                             allyesconfig
i386                             alldefconfig
arm                       aspeed_g5_defconfig
m68k                       m5275evb_defconfig
arm                    vt8500_v6_v7_defconfig
arm                            lart_defconfig
sh                         ecovec24_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                      makalu_defconfig
powerpc                     tqm8541_defconfig
openrisc                  or1klitex_defconfig
powerpc                    adder875_defconfig
arm                           omap1_defconfig
arm                           spitz_defconfig
arm                        spear3xx_defconfig
mips                       capcella_defconfig
powerpc                     sequoia_defconfig
mips                       rbtx49xx_defconfig
m68k                            mac_defconfig
arm                           tegra_defconfig
sh                          rsk7201_defconfig
xtensa                generic_kc705_defconfig
parisc                generic-32bit_defconfig
arm                          exynos_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
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
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
sparc                               defconfig
i386                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20210902
x86_64               randconfig-a006-20210902
x86_64               randconfig-a003-20210902
x86_64               randconfig-a005-20210902
x86_64               randconfig-a001-20210902
x86_64               randconfig-a002-20210902
x86_64               randconfig-a016-20210903
x86_64               randconfig-a011-20210903
x86_64               randconfig-a012-20210903
x86_64               randconfig-a015-20210903
x86_64               randconfig-a014-20210903
x86_64               randconfig-a013-20210903
riscv                randconfig-r042-20210903
s390                 randconfig-r044-20210903
arc                  randconfig-r043-20210903
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                                  kexec

clang tested configs:
s390                 randconfig-c005-20210904
mips                 randconfig-c004-20210904
powerpc              randconfig-c003-20210904
x86_64               randconfig-c007-20210904
i386                 randconfig-c001-20210904
arm                  randconfig-c002-20210904
riscv                randconfig-c006-20210904
x86_64               randconfig-a004-20210903
x86_64               randconfig-a006-20210903
x86_64               randconfig-a003-20210903
x86_64               randconfig-a005-20210903
x86_64               randconfig-a001-20210903
x86_64               randconfig-a002-20210903
i386                 randconfig-a005-20210903
i386                 randconfig-a004-20210903
i386                 randconfig-a006-20210903
i386                 randconfig-a002-20210903
i386                 randconfig-a001-20210903
i386                 randconfig-a003-20210903
hexagon              randconfig-r045-20210903
hexagon              randconfig-r041-20210903

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
