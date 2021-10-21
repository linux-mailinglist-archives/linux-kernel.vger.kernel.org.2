Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F794436B61
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 21:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbhJUTg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 15:36:58 -0400
Received: from mga07.intel.com ([134.134.136.100]:53281 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230020AbhJUTg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 15:36:57 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10144"; a="292581590"
X-IronPort-AV: E=Sophos;i="5.87,170,1631602800"; 
   d="scan'208";a="292581590"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2021 12:34:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,170,1631602800"; 
   d="scan'208";a="484337061"
Received: from lkp-server02.sh.intel.com (HELO 08b2c502c3de) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 21 Oct 2021 12:34:40 -0700
Received: from kbuild by 08b2c502c3de with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mddpn-000Ejg-JQ; Thu, 21 Oct 2021 19:34:39 +0000
Date:   Fri, 22 Oct 2021 03:34:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:for-next/kspp-misc-fixes] BUILD SUCCESS
 50740d5de6145cb88e69ccb29c586f10c401e3ee
Message-ID: <6171c0b8.Xs4wQTYhYCBNKwkz%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git for-next/kspp-misc-fixes
branch HEAD: 50740d5de6145cb88e69ccb29c586f10c401e3ee  dmaengine: pxa_dma: Prefer struct_size over open coded arithmetic

elapsed time: 1159m

configs tested: 183
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allmodconfig
arm                              allyesconfig
i386                 randconfig-c001-20211021
sh                         microdev_defconfig
arm                        mvebu_v5_defconfig
powerpc                       eiger_defconfig
ia64                      gensparse_defconfig
arm                         shannon_defconfig
arm                             pxa_defconfig
m68k                        mvme16x_defconfig
arm                       imx_v6_v7_defconfig
powerpc                     asp8347_defconfig
powerpc                    amigaone_defconfig
mips                        maltaup_defconfig
arm                      pxa255-idp_defconfig
arm                            hisi_defconfig
s390                             alldefconfig
sh                           se7780_defconfig
powerpc                      mgcoge_defconfig
arm                         lubbock_defconfig
sh                             shx3_defconfig
i386                                defconfig
powerpc                   currituck_defconfig
arm                          exynos_defconfig
sh                          lboxre2_defconfig
sparc                               defconfig
arm                       aspeed_g4_defconfig
arm                        clps711x_defconfig
arc                      axs103_smp_defconfig
arm                            xcep_defconfig
arm                        magician_defconfig
x86_64                           allyesconfig
m68k                          sun3x_defconfig
arm                         mv78xx0_defconfig
sh                            hp6xx_defconfig
powerpc                      ppc44x_defconfig
arm                  colibri_pxa300_defconfig
powerpc                   bluestone_defconfig
sh                ecovec24-romimage_defconfig
powerpc                     sequoia_defconfig
xtensa                  cadence_csp_defconfig
powerpc                 mpc8272_ads_defconfig
mips                          rm200_defconfig
ia64                         bigsur_defconfig
arm                            dove_defconfig
powerpc                     ksi8560_defconfig
sh                 kfr2r09-romimage_defconfig
csky                             alldefconfig
powerpc                      ppc40x_defconfig
parisc                           alldefconfig
powerpc                    klondike_defconfig
mips                        bcm47xx_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                    adder875_defconfig
mips                malta_qemu_32r6_defconfig
arc                            hsdk_defconfig
xtensa                       common_defconfig
arm                            mmp2_defconfig
powerpc                     tqm8548_defconfig
openrisc                 simple_smp_defconfig
mips                        omega2p_defconfig
mips                         mpc30x_defconfig
um                                  defconfig
arm                         orion5x_defconfig
sh                          sdk7780_defconfig
powerpc                 mpc832x_mds_defconfig
arm                        cerfcube_defconfig
xtensa                  nommu_kc705_defconfig
powerpc                          g5_defconfig
sparc                       sparc64_defconfig
arm                           viper_defconfig
mips                           ip28_defconfig
mips                         tb0219_defconfig
m68k                       m5208evb_defconfig
mips                       rbtx49xx_defconfig
um                               alldefconfig
mips                            ar7_defconfig
powerpc                       holly_defconfig
mips                       capcella_defconfig
xtensa                          iss_defconfig
nios2                         3c120_defconfig
sh                               allmodconfig
sparc                       sparc32_defconfig
arm                  colibri_pxa270_defconfig
powerpc                      pmac32_defconfig
arm                          gemini_defconfig
arm                        spear6xx_defconfig
powerpc                      ppc6xx_defconfig
arm                        trizeps4_defconfig
parisc                              defconfig
m68k                          atari_defconfig
mips                        qi_lb60_defconfig
m68k                                defconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                 mpc837x_mds_defconfig
ia64                            zx1_defconfig
powerpc                      obs600_defconfig
sh                          kfr2r09_defconfig
sh                             espt_defconfig
parisc                generic-64bit_defconfig
powerpc                     tqm8540_defconfig
powerpc                         wii_defconfig
powerpc                          allmodconfig
arm                        multi_v5_defconfig
mips                          ath79_defconfig
powerpc               mpc834x_itxgp_defconfig
ia64                             alldefconfig
arc                        nsimosci_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
arc                              allyesconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
xtensa                           allyesconfig
s390                             allyesconfig
s390                                defconfig
s390                             allmodconfig
parisc                           allyesconfig
sparc                            allyesconfig
i386                              debian-10.3
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
x86_64               randconfig-a013-20211021
x86_64               randconfig-a015-20211021
x86_64               randconfig-a011-20211021
x86_64               randconfig-a014-20211021
x86_64               randconfig-a016-20211021
x86_64               randconfig-a012-20211021
i386                 randconfig-a012-20211021
i386                 randconfig-a013-20211021
i386                 randconfig-a011-20211021
i386                 randconfig-a016-20211021
i386                 randconfig-a015-20211021
i386                 randconfig-a014-20211021
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
powerpc              randconfig-c003-20211021
riscv                randconfig-c006-20211021
arm                  randconfig-c002-20211021
x86_64               randconfig-c007-20211021
mips                 randconfig-c004-20211021
s390                 randconfig-c005-20211021
i386                 randconfig-c001-20211021
x86_64               randconfig-a002-20211021
x86_64               randconfig-a004-20211021
x86_64               randconfig-a005-20211021
x86_64               randconfig-a001-20211021
x86_64               randconfig-a006-20211021
x86_64               randconfig-a003-20211021
i386                 randconfig-a004-20211021
i386                 randconfig-a003-20211021
i386                 randconfig-a002-20211021
i386                 randconfig-a005-20211021
i386                 randconfig-a001-20211021
i386                 randconfig-a006-20211021
hexagon              randconfig-r045-20211021
hexagon              randconfig-r041-20211021

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
