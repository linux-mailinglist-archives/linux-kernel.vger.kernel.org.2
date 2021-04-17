Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84645362DE1
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 07:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbhDQFam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 01:30:42 -0400
Received: from mga04.intel.com ([192.55.52.120]:64508 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229614AbhDQFak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 01:30:40 -0400
IronPort-SDR: vD3Snqn/IcwpSqX9dbfMEUCLtmv5KHbeYxlzG0xnl2mSkVStiPXfLcxZVKZj2hOwSfbJRHsf7p
 jyfmaTs51eXg==
X-IronPort-AV: E=McAfee;i="6200,9189,9956"; a="193023097"
X-IronPort-AV: E=Sophos;i="5.82,228,1613462400"; 
   d="scan'208";a="193023097"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 22:30:14 -0700
IronPort-SDR: yMGxqIRO9qLtbR+Ku5MhnHnlyBE4BSPQs84py/jAF1jJH8byhRoUvqrDOCqVQ+zKuGkpWI1Bys
 6UDtQovnTJQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,228,1613462400"; 
   d="scan'208";a="419377714"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 16 Apr 2021 22:30:13 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lXdX2-0000he-Q8; Sat, 17 Apr 2021 05:30:12 +0000
Date:   Sat, 17 Apr 2021 13:29:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:perf/core] BUILD SUCCESS
 5deac80d4571dffb51f452f0027979d72259a1b9
Message-ID: <607a723f.ORw4SEQQ2xkhTS7U%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
branch HEAD: 5deac80d4571dffb51f452f0027979d72259a1b9  perf/amd/uncore: Fix sysfs type mismatch

elapsed time: 725m

configs tested: 161
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
riscv                            allmodconfig
i386                             allyesconfig
riscv                            allyesconfig
powerpc                       ebony_defconfig
powerpc                     ksi8560_defconfig
powerpc                      pasemi_defconfig
m68k                          amiga_defconfig
ia64                          tiger_defconfig
mips                  decstation_64_defconfig
powerpc                        icon_defconfig
mips                       capcella_defconfig
sh                        edosk7705_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                      chrp32_defconfig
mips                           gcw0_defconfig
mips                         bigsur_defconfig
h8300                    h8300h-sim_defconfig
arm                          lpd270_defconfig
arc                        nsimosci_defconfig
arm                         lpc18xx_defconfig
mips                           ip27_defconfig
powerpc                 mpc8272_ads_defconfig
arm                        magician_defconfig
xtensa                       common_defconfig
sh                     magicpanelr2_defconfig
powerpc                      arches_defconfig
arm                        vexpress_defconfig
powerpc                       eiger_defconfig
sh                            hp6xx_defconfig
arm                        trizeps4_defconfig
arm                     davinci_all_defconfig
sh                           se7750_defconfig
powerpc                      pcm030_defconfig
arm                       aspeed_g5_defconfig
powerpc                 mpc834x_mds_defconfig
arm                       imx_v4_v5_defconfig
sh                          sdk7780_defconfig
m68k                        mvme147_defconfig
arm                           sama5_defconfig
ia64                        generic_defconfig
csky                                defconfig
mips                           ip32_defconfig
sh                             shx3_defconfig
powerpc                     mpc512x_defconfig
powerpc                       holly_defconfig
um                               alldefconfig
arm                            mps2_defconfig
arc                     nsimosci_hs_defconfig
arm                        multi_v7_defconfig
arm                         socfpga_defconfig
sh                ecovec24-romimage_defconfig
xtensa                    smp_lx200_defconfig
powerpc                     sbc8548_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                      ppc44x_defconfig
m68k                            q40_defconfig
arc                         haps_hs_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                 mpc8315_rdb_defconfig
sparc                       sparc64_defconfig
sh                        sh7757lcr_defconfig
arm                              alldefconfig
powerpc                 mpc8540_ads_defconfig
mips                            ar7_defconfig
mips                     cu1000-neo_defconfig
powerpc                     sequoia_defconfig
powerpc                     mpc83xx_defconfig
powerpc                 canyonlands_defconfig
powerpc                        cell_defconfig
sh                        sh7785lcr_defconfig
s390                       zfcpdump_defconfig
arm                        clps711x_defconfig
sh                           se7724_defconfig
sh                   sh7770_generic_defconfig
xtensa                              defconfig
s390                          debug_defconfig
openrisc                  or1klitex_defconfig
arm64                            alldefconfig
sh                          r7785rp_defconfig
powerpc                          g5_defconfig
mips                        maltaup_defconfig
i386                             alldefconfig
arm                        shmobile_defconfig
mips                      pic32mzda_defconfig
m68k                          atari_defconfig
openrisc                            defconfig
arm                         s3c2410_defconfig
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
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210416
i386                 randconfig-a006-20210416
i386                 randconfig-a001-20210416
i386                 randconfig-a005-20210416
i386                 randconfig-a004-20210416
i386                 randconfig-a002-20210416
x86_64               randconfig-a014-20210416
x86_64               randconfig-a015-20210416
x86_64               randconfig-a011-20210416
x86_64               randconfig-a013-20210416
x86_64               randconfig-a012-20210416
x86_64               randconfig-a016-20210416
i386                 randconfig-a015-20210416
i386                 randconfig-a014-20210416
i386                 randconfig-a013-20210416
i386                 randconfig-a012-20210416
i386                 randconfig-a016-20210416
i386                 randconfig-a011-20210416
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a003-20210416
x86_64               randconfig-a002-20210416
x86_64               randconfig-a005-20210416
x86_64               randconfig-a001-20210416
x86_64               randconfig-a006-20210416
x86_64               randconfig-a004-20210416

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
