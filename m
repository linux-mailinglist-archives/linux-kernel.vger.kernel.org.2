Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B602C3FFB9E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 10:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348162AbhICIPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 04:15:42 -0400
Received: from mga14.intel.com ([192.55.52.115]:39885 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348122AbhICIPl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 04:15:41 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10095"; a="219065805"
X-IronPort-AV: E=Sophos;i="5.85,264,1624345200"; 
   d="scan'208";a="219065805"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 01:14:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,264,1624345200"; 
   d="scan'208";a="543409359"
Received: from lkp-server01.sh.intel.com (HELO 2115029a3e5c) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 03 Sep 2021 01:14:39 -0700
Received: from kbuild by 2115029a3e5c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mM4LO-0000ET-MV; Fri, 03 Sep 2021 08:14:38 +0000
Date:   Fri, 03 Sep 2021 16:14:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 d7109fe3a0991a0f7b4ac099b78c908e3b619787
Message-ID: <6131d94a.iQ6Cw9kRHqaGfTqI%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: d7109fe3a0991a0f7b4ac099b78c908e3b619787  x86/platform: Increase maximum GPIO number for X86_64

elapsed time: 722m

configs tested: 179
configs skipped: 69

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
i386                 randconfig-c001-20210903
i386                 randconfig-c001-20210902
arm                         shannon_defconfig
powerpc                    mvme5100_defconfig
powerpc                       ppc64_defconfig
m68k                        m5272c3_defconfig
xtensa                              defconfig
um                                  defconfig
sh                          landisk_defconfig
arm                      tct_hammer_defconfig
powerpc                       eiger_defconfig
arm                       spear13xx_defconfig
microblaze                          defconfig
sh                   rts7751r2dplus_defconfig
arc                          axs101_defconfig
powerpc                   motionpro_defconfig
mips                          malta_defconfig
mips                          ath25_defconfig
mips                      fuloong2e_defconfig
s390                             alldefconfig
sh                        dreamcast_defconfig
arm                           viper_defconfig
powerpc                  mpc885_ads_defconfig
sh                      rts7751r2d1_defconfig
ia64                        generic_defconfig
mips                         mpc30x_defconfig
sh                           se7343_defconfig
arm                          ixp4xx_defconfig
sh                   secureedge5410_defconfig
sh                   sh7770_generic_defconfig
arm                            hisi_defconfig
powerpc                      pmac32_defconfig
mips                         cobalt_defconfig
sh                        edosk7705_defconfig
mips                  maltasmvp_eva_defconfig
sh                          sdk7786_defconfig
powerpc                      ppc40x_defconfig
powerpc64                        alldefconfig
arm                            xcep_defconfig
powerpc                   microwatt_defconfig
arm                              allmodconfig
arm                       multi_v4t_defconfig
sh                            hp6xx_defconfig
arm                          ep93xx_defconfig
powerpc                         wii_defconfig
powerpc                     stx_gp3_defconfig
powerpc                         ps3_defconfig
powerpc                      pcm030_defconfig
sh                           se7751_defconfig
mips                        jmr3927_defconfig
sh                   sh7724_generic_defconfig
arm                       cns3420vb_defconfig
arm                         nhk8815_defconfig
powerpc                      pasemi_defconfig
powerpc                      obs600_defconfig
arm                           sama7_defconfig
h8300                            alldefconfig
m68k                        m5307c3_defconfig
arm                            lart_defconfig
powerpc                     mpc83xx_defconfig
xtensa                       common_defconfig
m68k                        stmark2_defconfig
arm                     davinci_all_defconfig
mips                           gcw0_defconfig
nds32                               defconfig
sh                           se7724_defconfig
arm                          pcm027_defconfig
arm                          collie_defconfig
arm                         socfpga_defconfig
m68k                       m5475evb_defconfig
riscv                            alldefconfig
i386                             alldefconfig
arm                       aspeed_g5_defconfig
m68k                       m5275evb_defconfig
mips                        bcm63xx_defconfig
arm                         hackkit_defconfig
arm                        spear6xx_defconfig
arm                             ezx_defconfig
powerpc                     tqm8548_defconfig
arm                         s3c6400_defconfig
sh                             sh03_defconfig
mips                           jazz_defconfig
m68k                          multi_defconfig
mips                       capcella_defconfig
powerpc                     sequoia_defconfig
mips                       rbtx49xx_defconfig
m68k                            mac_defconfig
arm                           tegra_defconfig
sh                          rsk7201_defconfig
arm                     eseries_pxa_defconfig
powerpc                     redwood_defconfig
arm                         s3c2410_defconfig
sh                           se7619_defconfig
arm                                 defconfig
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
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
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
i386                 randconfig-a012-20210903
i386                 randconfig-a015-20210903
i386                 randconfig-a011-20210903
i386                 randconfig-a013-20210903
i386                 randconfig-a014-20210903
i386                 randconfig-a016-20210903
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
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
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
i386                 randconfig-a012-20210902
i386                 randconfig-a015-20210902
i386                 randconfig-a011-20210902
i386                 randconfig-a013-20210902
i386                 randconfig-a014-20210902
i386                 randconfig-a016-20210902
hexagon              randconfig-r045-20210903
hexagon              randconfig-r041-20210903

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
