Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3F0E3774DC
	for <lists+linux-kernel@lfdr.de>; Sun,  9 May 2021 03:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbhEIBdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 21:33:17 -0400
Received: from mga03.intel.com ([134.134.136.65]:59321 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229759AbhEIBdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 21:33:14 -0400
IronPort-SDR: vhyJShtV2W27bgkluYGKtdr6EJgRRyExPuFCe/zZoCr/uDA35P/++Jp44czbf0DFXAra4IFz6e
 OokD6yrVkg5Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9978"; a="199026463"
X-IronPort-AV: E=Sophos;i="5.82,284,1613462400"; 
   d="scan'208";a="199026463"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2021 18:32:12 -0700
IronPort-SDR: swby3WOD2EaDXzGCerY5RUdrmPrdomaE7CglGD+SUUPTmq7XicJ7ndymfiVTUltIwoS65qBHTK
 6Egthaw1mXaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,284,1613462400"; 
   d="scan'208";a="453782940"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 08 May 2021 18:32:11 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lfYIk-000BsC-HF; Sun, 09 May 2021 01:32:10 +0000
Date:   Sun, 09 May 2021 09:31:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 a95f54035376a5f67187bb9d0bc11134cedfa032
Message-ID: <60973b85.2Dau/QFhcJmE7S38%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: a95f54035376a5f67187bb9d0bc11134cedfa032  Merge branch 'locking/urgent'

elapsed time: 722m

configs tested: 168
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
riscv                            allyesconfig
i386                             allyesconfig
m68k                          sun3x_defconfig
sh                   sh7770_generic_defconfig
arc                           tb10x_defconfig
xtensa                           alldefconfig
mips                           ci20_defconfig
powerpc                     tqm8540_defconfig
arm                          simpad_defconfig
sh                        edosk7705_defconfig
m68k                       m5475evb_defconfig
powerpc                    mvme5100_defconfig
powerpc                     taishan_defconfig
arm                            hisi_defconfig
sh                   rts7751r2dplus_defconfig
arm                      jornada720_defconfig
powerpc                  mpc866_ads_defconfig
arm                            qcom_defconfig
mips                        qi_lb60_defconfig
sh                          rsk7203_defconfig
mips                           ip27_defconfig
mips                      pic32mzda_defconfig
powerpc                 mpc832x_mds_defconfig
arm                       aspeed_g4_defconfig
sparc                               defconfig
arm64                            alldefconfig
mips                        bcm47xx_defconfig
i386                             alldefconfig
powerpc                 xes_mpc85xx_defconfig
arm                           sama5_defconfig
powerpc                     ep8248e_defconfig
mips                         tb0226_defconfig
sh                          lboxre2_defconfig
arm                        mini2440_defconfig
s390                                defconfig
mips                      maltaaprp_defconfig
mips                     loongson2k_defconfig
ia64                            zx1_defconfig
mips                 decstation_r4k_defconfig
h8300                     edosk2674_defconfig
powerpc                    adder875_defconfig
m68k                         apollo_defconfig
powerpc                mpc7448_hpc2_defconfig
mips                            e55_defconfig
powerpc                      pmac32_defconfig
arm                       imx_v6_v7_defconfig
mips                     cu1000-neo_defconfig
um                               allyesconfig
arc                     nsimosci_hs_defconfig
sh                           se7751_defconfig
nios2                            allyesconfig
powerpc                 mpc834x_mds_defconfig
arm                        spear3xx_defconfig
arm                         socfpga_defconfig
m68k                        mvme16x_defconfig
powerpc                      ppc6xx_defconfig
mips                     cu1830-neo_defconfig
arm                         s3c6400_defconfig
sh                             espt_defconfig
mips                          rb532_defconfig
arm                         nhk8815_defconfig
arc                            hsdk_defconfig
arm                        magician_defconfig
arm                            dove_defconfig
arc                          axs103_defconfig
sh                   sh7724_generic_defconfig
alpha                            alldefconfig
arm                        shmobile_defconfig
arm                        vexpress_defconfig
openrisc                 simple_smp_defconfig
openrisc                    or1ksim_defconfig
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
sparc                            allyesconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210508
i386                 randconfig-a006-20210508
i386                 randconfig-a001-20210508
i386                 randconfig-a005-20210508
i386                 randconfig-a004-20210508
i386                 randconfig-a002-20210508
i386                 randconfig-a003-20210509
i386                 randconfig-a006-20210509
i386                 randconfig-a001-20210509
i386                 randconfig-a005-20210509
i386                 randconfig-a004-20210509
i386                 randconfig-a002-20210509
x86_64               randconfig-a014-20210508
x86_64               randconfig-a015-20210508
x86_64               randconfig-a011-20210508
x86_64               randconfig-a013-20210508
x86_64               randconfig-a012-20210508
x86_64               randconfig-a016-20210508
i386                 randconfig-a013-20210508
i386                 randconfig-a015-20210508
i386                 randconfig-a014-20210508
i386                 randconfig-a016-20210508
i386                 randconfig-a011-20210508
i386                 randconfig-a012-20210508
i386                 randconfig-a013-20210509
i386                 randconfig-a015-20210509
i386                 randconfig-a014-20210509
i386                 randconfig-a016-20210509
i386                 randconfig-a011-20210509
i386                 randconfig-a012-20210509
x86_64               randconfig-a005-20210509
x86_64               randconfig-a003-20210509
x86_64               randconfig-a001-20210509
x86_64               randconfig-a002-20210509
x86_64               randconfig-a006-20210509
x86_64               randconfig-a004-20210509
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                               allmodconfig
um                                allnoconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a005-20210508
x86_64               randconfig-a003-20210508
x86_64               randconfig-a001-20210508
x86_64               randconfig-a002-20210508
x86_64               randconfig-a006-20210508
x86_64               randconfig-a004-20210508
x86_64               randconfig-a014-20210509
x86_64               randconfig-a015-20210509
x86_64               randconfig-a011-20210509
x86_64               randconfig-a013-20210509
x86_64               randconfig-a012-20210509
x86_64               randconfig-a016-20210509

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
