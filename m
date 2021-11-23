Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE60645A379
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 14:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235563AbhKWNOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 08:14:04 -0500
Received: from mga14.intel.com ([192.55.52.115]:42502 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233911AbhKWNOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 08:14:02 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10176"; a="235254755"
X-IronPort-AV: E=Sophos;i="5.87,257,1631602800"; 
   d="scan'208";a="235254755"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 05:10:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,257,1631602800"; 
   d="scan'208";a="552953882"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 23 Nov 2021 05:10:38 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mpVZF-0001sA-Rs; Tue, 23 Nov 2021 13:10:37 +0000
Date:   Tue, 23 Nov 2021 21:10:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:for-next/kspp-misc-fixes] BUILD SUCCESS
 c29f563fd085d28c49bf2c1c8799d15c4b437f1e
Message-ID: <619ce82c.Wz5FmbhTuTnTPMoy%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git for-next/kspp-misc-fixes
branch HEAD: c29f563fd085d28c49bf2c1c8799d15c4b437f1e  Makefile: Enable -Wcast-function-type

elapsed time: 722m

configs tested: 198
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211123
sh                          landisk_defconfig
mips                      pic32mzda_defconfig
mips                        bcm47xx_defconfig
arc                          axs103_defconfig
powerpc                      tqm8xx_defconfig
arm                         socfpga_defconfig
arm                          pcm027_defconfig
powerpc                        fsp2_defconfig
mips                  decstation_64_defconfig
sh                         ecovec24_defconfig
nios2                         3c120_defconfig
sh                         microdev_defconfig
xtensa                    smp_lx200_defconfig
mips                       capcella_defconfig
h8300                            alldefconfig
arm                         hackkit_defconfig
arm                        shmobile_defconfig
ia64                             alldefconfig
xtensa                  nommu_kc705_defconfig
powerpc                     akebono_defconfig
mips                      malta_kvm_defconfig
powerpc                 mpc8315_rdb_defconfig
sh                          lboxre2_defconfig
powerpc                          allyesconfig
sh                      rts7751r2d1_defconfig
powerpc                     pq2fads_defconfig
powerpc                      pasemi_defconfig
mips                            ar7_defconfig
powerpc                     rainier_defconfig
arm                         s5pv210_defconfig
alpha                               defconfig
arm                          simpad_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                      chrp32_defconfig
sh                           se7343_defconfig
powerpc                     tqm8560_defconfig
powerpc                     mpc512x_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                      pcm030_defconfig
powerpc                      ep88xc_defconfig
m68k                         amcore_defconfig
powerpc                  mpc885_ads_defconfig
xtensa                generic_kc705_defconfig
powerpc                 mpc834x_mds_defconfig
sh                          kfr2r09_defconfig
powerpc                 mpc832x_rdb_defconfig
sparc64                          alldefconfig
sh                           se7712_defconfig
mips                        qi_lb60_defconfig
arm                        vexpress_defconfig
h8300                               defconfig
arm                            xcep_defconfig
m68k                          multi_defconfig
mips                     loongson2k_defconfig
powerpc                   lite5200b_defconfig
arm                           h5000_defconfig
arm                          badge4_defconfig
s390                       zfcpdump_defconfig
arm                       aspeed_g4_defconfig
arc                              alldefconfig
ia64                            zx1_defconfig
mips                          ath79_defconfig
arm                          moxart_defconfig
powerpc                    adder875_defconfig
powerpc                    socrates_defconfig
sh                         apsh4a3a_defconfig
sh                           sh2007_defconfig
arm                       mainstone_defconfig
powerpc                        warp_defconfig
powerpc                mpc7448_hpc2_defconfig
arm                          pxa168_defconfig
arm                         orion5x_defconfig
arm                     eseries_pxa_defconfig
arm                           sama5_defconfig
arm                      tct_hammer_defconfig
mips                      maltasmvp_defconfig
riscv                          rv32_defconfig
ia64                        generic_defconfig
arm                        mvebu_v5_defconfig
arm                     am200epdkit_defconfig
arc                        nsimosci_defconfig
arm                          gemini_defconfig
arm                            lart_defconfig
microblaze                          defconfig
powerpc                 mpc837x_rdb_defconfig
arm                  randconfig-c002-20211123
arm                  randconfig-c002-20211122
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
csky                                defconfig
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
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a001-20211123
x86_64               randconfig-a003-20211123
x86_64               randconfig-a006-20211123
x86_64               randconfig-a004-20211123
x86_64               randconfig-a005-20211123
x86_64               randconfig-a002-20211123
i386                 randconfig-a001-20211123
i386                 randconfig-a002-20211123
i386                 randconfig-a005-20211123
i386                 randconfig-a006-20211123
i386                 randconfig-a004-20211123
i386                 randconfig-a003-20211123
x86_64               randconfig-a014-20211122
x86_64               randconfig-a011-20211122
x86_64               randconfig-a012-20211122
x86_64               randconfig-a016-20211122
x86_64               randconfig-a013-20211122
x86_64               randconfig-a015-20211122
i386                 randconfig-a016-20211122
i386                 randconfig-a015-20211122
i386                 randconfig-a012-20211122
i386                 randconfig-a013-20211122
i386                 randconfig-a014-20211122
i386                 randconfig-a011-20211122
arc                  randconfig-r043-20211122
s390                 randconfig-r044-20211122
riscv                randconfig-r042-20211122
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
s390                 randconfig-c005-20211123
i386                 randconfig-c001-20211123
powerpc              randconfig-c003-20211123
arm                  randconfig-c002-20211123
riscv                randconfig-c006-20211123
x86_64               randconfig-c007-20211123
mips                 randconfig-c004-20211123
i386                 randconfig-a001-20211122
i386                 randconfig-a002-20211122
i386                 randconfig-a005-20211122
i386                 randconfig-a006-20211122
i386                 randconfig-a004-20211122
i386                 randconfig-a003-20211122
x86_64               randconfig-a014-20211123
x86_64               randconfig-a011-20211123
x86_64               randconfig-a012-20211123
x86_64               randconfig-a016-20211123
x86_64               randconfig-a013-20211123
x86_64               randconfig-a015-20211123
i386                 randconfig-a016-20211123
i386                 randconfig-a015-20211123
i386                 randconfig-a012-20211123
i386                 randconfig-a013-20211123
i386                 randconfig-a014-20211123
i386                 randconfig-a011-20211123
x86_64               randconfig-a001-20211122
x86_64               randconfig-a003-20211122
x86_64               randconfig-a006-20211122
x86_64               randconfig-a004-20211122
x86_64               randconfig-a005-20211122
x86_64               randconfig-a002-20211122
hexagon              randconfig-r045-20211123
s390                 randconfig-r044-20211123
hexagon              randconfig-r041-20211123
riscv                randconfig-r042-20211123

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
