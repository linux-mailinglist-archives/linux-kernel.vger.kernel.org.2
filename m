Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05A74460508
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 07:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343611AbhK1Gre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 01:47:34 -0500
Received: from mga02.intel.com ([134.134.136.20]:35914 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244853AbhK1Gpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 01:45:33 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10181"; a="223040330"
X-IronPort-AV: E=Sophos;i="5.87,270,1631602800"; 
   d="scan'208";a="223040330"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2021 22:42:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,270,1631602800"; 
   d="scan'208";a="476345189"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 27 Nov 2021 22:42:16 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mrDtA-000AQU-2I; Sun, 28 Nov 2021 06:42:16 +0000
Date:   Sun, 28 Nov 2021 14:41:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:for-next/kspp-misc-fixes] BUILD SUCCESS
 5c9a39a1ff78d32e645774c7eb213c831b51b1ee
Message-ID: <61a3249a.c7K27mr7Jb/svHab%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git for-next/kspp-misc-fixes
branch HEAD: 5c9a39a1ff78d32e645774c7eb213c831b51b1ee  ASoC: SOF: topology: Replace zero-length array with flexible-array member

elapsed time: 723m

configs tested: 149
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                      tqm8xx_defconfig
powerpc                      pcm030_defconfig
mips                         cobalt_defconfig
arm                        spear6xx_defconfig
mips                         tb0226_defconfig
sh                         ecovec24_defconfig
arm                        oxnas_v6_defconfig
sh                           se7722_defconfig
mips                        jmr3927_defconfig
arc                           tb10x_defconfig
m68k                          multi_defconfig
mips                  cavium_octeon_defconfig
sh                           se7206_defconfig
sh                          rsk7203_defconfig
x86_64                           alldefconfig
arm                        spear3xx_defconfig
mips                     decstation_defconfig
powerpc                     pseries_defconfig
sh                            hp6xx_defconfig
mips                         tb0287_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                      ep88xc_defconfig
sh                ecovec24-romimage_defconfig
powerpc                      ppc64e_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc                     skiroot_defconfig
powerpc                 mpc85xx_cds_defconfig
arc                          axs103_defconfig
powerpc                      mgcoge_defconfig
arm                            mmp2_defconfig
mips                            gpr_defconfig
ia64                             alldefconfig
um                                  defconfig
xtensa                  cadence_csp_defconfig
xtensa                generic_kc705_defconfig
sh                         ap325rxa_defconfig
mips                           ip27_defconfig
h8300                               defconfig
m68k                                defconfig
riscv                    nommu_k210_defconfig
mips                         db1xxx_defconfig
powerpc                     taishan_defconfig
riscv             nommu_k210_sdcard_defconfig
sh                        edosk7705_defconfig
powerpc                    adder875_defconfig
xtensa                    xip_kc705_defconfig
powerpc               mpc834x_itxgp_defconfig
sh                          sdk7786_defconfig
arm                        cerfcube_defconfig
nds32                            alldefconfig
powerpc                 mpc8540_ads_defconfig
powerpc                     mpc512x_defconfig
openrisc                 simple_smp_defconfig
i386                             allyesconfig
arm                         socfpga_defconfig
arm                          gemini_defconfig
powerpc                mpc7448_hpc2_defconfig
arm                       spear13xx_defconfig
arm                  randconfig-c002-20211128
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
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
s390                             allmodconfig
s390                                defconfig
parisc                           allyesconfig
s390                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a011-20211128
x86_64               randconfig-a014-20211128
x86_64               randconfig-a012-20211128
x86_64               randconfig-a016-20211128
x86_64               randconfig-a013-20211128
x86_64               randconfig-a015-20211128
i386                 randconfig-a015-20211128
i386                 randconfig-a016-20211128
i386                 randconfig-a013-20211128
i386                 randconfig-a012-20211128
i386                 randconfig-a014-20211128
i386                 randconfig-a011-20211128
i386                 randconfig-a016-20211126
i386                 randconfig-a015-20211126
i386                 randconfig-a012-20211126
i386                 randconfig-a013-20211126
i386                 randconfig-a014-20211126
i386                 randconfig-a011-20211126
arc                  randconfig-r043-20211128
s390                 randconfig-r044-20211128
riscv                randconfig-r042-20211128
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
s390                 randconfig-c005-20211128
i386                 randconfig-c001-20211128
riscv                randconfig-c006-20211128
arm                  randconfig-c002-20211128
powerpc              randconfig-c003-20211128
x86_64               randconfig-c007-20211128
mips                 randconfig-c004-20211128
i386                 randconfig-a001-20211128
i386                 randconfig-a002-20211128
i386                 randconfig-a006-20211128
i386                 randconfig-a005-20211128
i386                 randconfig-a004-20211128
i386                 randconfig-a003-20211128
x86_64               randconfig-a001-20211128
x86_64               randconfig-a006-20211128
x86_64               randconfig-a003-20211128
x86_64               randconfig-a005-20211128
x86_64               randconfig-a004-20211128
x86_64               randconfig-a002-20211128

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
