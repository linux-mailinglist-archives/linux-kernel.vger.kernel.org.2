Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 767EC32CAF5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 04:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbhCDDnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 22:43:37 -0500
Received: from mga17.intel.com ([192.55.52.151]:11266 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232804AbhCDDn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 22:43:27 -0500
IronPort-SDR: 7fOSqSpIlY7exakFz/FpaisNyF1XjvtN7ibWsTuRYVcOXEkEkOJorRIcUsnHdCLv7GCPeAOYHX
 uErzh2kO1xkw==
X-IronPort-AV: E=McAfee;i="6000,8403,9912"; a="167232033"
X-IronPort-AV: E=Sophos;i="5.81,221,1610438400"; 
   d="scan'208";a="167232033"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 19:42:47 -0800
IronPort-SDR: gMHdX4xTnJtt2xkWmZ9DDC3HcwZkNeg5f2h7R3sq07bkVYL7q4oyWFdFWk181c648PzXkoV7JM
 hfNIkSdkPinQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,221,1610438400"; 
   d="scan'208";a="435645666"
Received: from lkp-server02.sh.intel.com (HELO 2482ff9f8ac0) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Mar 2021 19:42:46 -0800
Received: from kbuild by 2482ff9f8ac0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lHesv-0001yc-DI; Thu, 04 Mar 2021 03:42:45 +0000
Date:   Thu, 04 Mar 2021 11:42:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:auto-latest] BUILD SUCCESS
 43e65ddac19c665411ed8554a21155fc0ec3a286
Message-ID: <60405719.ga+SLmi9L8taiPll%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git auto-latest
branch HEAD: 43e65ddac19c665411ed8554a21155fc0ec3a286  Merge branch 'locking/core'

elapsed time: 1031m

configs tested: 154
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                         at91_dt_defconfig
powerpc                 mpc832x_mds_defconfig
sh                              ul2_defconfig
m68k                        mvme16x_defconfig
arm                          pcm027_defconfig
arm                      pxa255-idp_defconfig
arm                         s5pv210_defconfig
xtensa                           alldefconfig
arm                       spear13xx_defconfig
powerpc                  mpc885_ads_defconfig
i386                             alldefconfig
powerpc                    klondike_defconfig
sparc                       sparc64_defconfig
powerpc                       eiger_defconfig
m68k                            q40_defconfig
mips                     loongson1c_defconfig
arm                          pxa168_defconfig
powerpc                     skiroot_defconfig
powerpc                       maple_defconfig
xtensa                         virt_defconfig
sh                          rsk7203_defconfig
csky                             alldefconfig
powerpc                  iss476-smp_defconfig
sh                      rts7751r2d1_defconfig
arm                        clps711x_defconfig
arc                            hsdk_defconfig
arm                         lpc32xx_defconfig
arc                     nsimosci_hs_defconfig
powerpc                     mpc5200_defconfig
powerpc                      tqm8xx_defconfig
sh                           se7751_defconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                      cm5200_defconfig
powerpc                     tqm8555_defconfig
arm                         socfpga_defconfig
arm                           sama5_defconfig
sh                   secureedge5410_defconfig
ia64                            zx1_defconfig
mips                      maltaaprp_defconfig
sh                             sh03_defconfig
arc                    vdk_hs38_smp_defconfig
microblaze                          defconfig
sh                        sh7757lcr_defconfig
mips                     loongson1b_defconfig
arm                             mxs_defconfig
sh                        sh7763rdp_defconfig
riscv                            allmodconfig
mips                           ip27_defconfig
arm                            pleb_defconfig
ia64                        generic_defconfig
powerpc                         wii_defconfig
sh                           sh2007_defconfig
sh                           se7705_defconfig
h8300                     edosk2674_defconfig
arm                          pxa910_defconfig
mips                        nlm_xlp_defconfig
arm                        shmobile_defconfig
nds32                             allnoconfig
arm                          exynos_defconfig
microblaze                      mmu_defconfig
arm                        oxnas_v6_defconfig
mips                malta_kvm_guest_defconfig
arm                      footbridge_defconfig
alpha                            allyesconfig
powerpc                        cell_defconfig
arm                         orion5x_defconfig
arc                          axs101_defconfig
arm                          pxa3xx_defconfig
mips                     cu1830-neo_defconfig
arc                        vdk_hs38_defconfig
nds32                               defconfig
c6x                              allyesconfig
powerpc                      chrp32_defconfig
arm                           tegra_defconfig
sh                     magicpanelr2_defconfig
xtensa                           allyesconfig
sh                         ap325rxa_defconfig
powerpc                     ep8248e_defconfig
arm                        multi_v5_defconfig
arm                        trizeps4_defconfig
alpha                            alldefconfig
powerpc                  storcenter_defconfig
m68k                           sun3_defconfig
arm                          collie_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
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
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20210303
i386                 randconfig-a003-20210303
i386                 randconfig-a002-20210303
i386                 randconfig-a004-20210303
i386                 randconfig-a006-20210303
i386                 randconfig-a001-20210303
x86_64               randconfig-a013-20210303
x86_64               randconfig-a016-20210303
x86_64               randconfig-a015-20210303
x86_64               randconfig-a014-20210303
x86_64               randconfig-a012-20210303
x86_64               randconfig-a011-20210303
i386                 randconfig-a016-20210303
i386                 randconfig-a012-20210303
i386                 randconfig-a014-20210303
i386                 randconfig-a013-20210303
i386                 randconfig-a011-20210303
i386                 randconfig-a015-20210303
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20210303
x86_64               randconfig-a001-20210303
x86_64               randconfig-a004-20210303
x86_64               randconfig-a002-20210303
x86_64               randconfig-a005-20210303
x86_64               randconfig-a003-20210303

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
