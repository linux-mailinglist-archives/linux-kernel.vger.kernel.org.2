Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 294F243AEC8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 11:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234095AbhJZJQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 05:16:39 -0400
Received: from mga07.intel.com ([134.134.136.100]:37610 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231459AbhJZJQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 05:16:35 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10148"; a="293322058"
X-IronPort-AV: E=Sophos;i="5.87,182,1631602800"; 
   d="scan'208";a="293322058"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 02:14:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,182,1631602800"; 
   d="scan'208";a="497232899"
Received: from lkp-server01.sh.intel.com (HELO 9372cb945ed7) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 26 Oct 2021 02:14:10 -0700
Received: from kbuild by 9372cb945ed7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mfIX4-0000FD-7Y; Tue, 26 Oct 2021 09:14:10 +0000
Date:   Tue, 26 Oct 2021 17:13:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS
 a8da61cee95e627ed3d4274861428013aa9604ea
Message-ID: <6177c6cb.zvoyYhA+m7wlIL6U%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
branch HEAD: a8da61cee95e627ed3d4274861428013aa9604ea  Merge tag 'timers-v5.16-rc1' into timers/core

elapsed time: 2472m

configs tested: 187
configs skipped: 3

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
arm                       aspeed_g4_defconfig
powerpc                 mpc8313_rdb_defconfig
arc                 nsimosci_hs_smp_defconfig
arm                           viper_defconfig
sh                     magicpanelr2_defconfig
powerpc                      walnut_defconfig
m68k                         amcore_defconfig
arc                        nsim_700_defconfig
powerpc                        cell_defconfig
powerpc                  mpc885_ads_defconfig
arm                     davinci_all_defconfig
mips                     loongson2k_defconfig
powerpc64                           defconfig
arm                           sama7_defconfig
s390                          debug_defconfig
powerpc                 mpc832x_rdb_defconfig
sh                           se7751_defconfig
xtensa                          iss_defconfig
powerpc                 mpc837x_rdb_defconfig
nios2                            alldefconfig
arm                       mainstone_defconfig
mips                          rb532_defconfig
arm                           sunxi_defconfig
xtensa                generic_kc705_defconfig
arm                           h3600_defconfig
mips                      bmips_stb_defconfig
mips                        vocore2_defconfig
sh                        sh7757lcr_defconfig
mips                         bigsur_defconfig
sh                              ul2_defconfig
arm                         socfpga_defconfig
powerpc                      mgcoge_defconfig
arm                           sama5_defconfig
powerpc                      katmai_defconfig
arm                        neponset_defconfig
powerpc                 mpc836x_mds_defconfig
i386                             alldefconfig
sparc                       sparc32_defconfig
sparc64                          alldefconfig
sh                        sh7785lcr_defconfig
openrisc                    or1ksim_defconfig
xtensa                  cadence_csp_defconfig
powerpc                 mpc8315_rdb_defconfig
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
arm                           h5000_defconfig
powerpc                         ps3_defconfig
sh                          rsk7269_defconfig
sparc                            alldefconfig
xtensa                       common_defconfig
ia64                            zx1_defconfig
arm                    vt8500_v6_v7_defconfig
sh                   sh7724_generic_defconfig
mips                           ci20_defconfig
sh                          lboxre2_defconfig
arm                          pxa3xx_defconfig
powerpc                        warp_defconfig
arm                        mvebu_v7_defconfig
arm                            dove_defconfig
mips                          ath79_defconfig
mips                           ip28_defconfig
sh                           se7206_defconfig
sh                                  defconfig
sh                             espt_defconfig
powerpc                         wii_defconfig
mips                    maltaup_xpa_defconfig
arm                          ep93xx_defconfig
mips                           ip32_defconfig
arm                  randconfig-c002-20211025
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
nios2                               defconfig
nds32                             allnoconfig
arc                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                              debian-10.3
i386                             allyesconfig
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
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
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
x86_64               randconfig-a002-20211025
x86_64               randconfig-a004-20211025
x86_64               randconfig-a005-20211025
x86_64               randconfig-a006-20211025
x86_64               randconfig-a001-20211025
x86_64               randconfig-a003-20211025
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
