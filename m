Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3655B3C87F2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 17:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239675AbhGNPvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 11:51:50 -0400
Received: from mga03.intel.com ([134.134.136.65]:47184 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232318AbhGNPvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 11:51:48 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10045"; a="210415770"
X-IronPort-AV: E=Sophos;i="5.84,239,1620716400"; 
   d="scan'208";a="210415770"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 08:48:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,239,1620716400"; 
   d="scan'208";a="412826070"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 14 Jul 2021 08:48:55 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m3h82-000Iqp-Hm; Wed, 14 Jul 2021 15:48:54 +0000
Date:   Wed, 14 Jul 2021 23:48:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:for-next/clang-fallthrough] BUILD SUCCESS WITH
 WARNING 55f90d1997bd37b67f366b4e235e5e30faf51e69
Message-ID: <60ef0750.I8J+C6KAtb0xVOAa%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git for-next/clang-fallthrough
branch HEAD: 55f90d1997bd37b67f366b4e235e5e30faf51e69  Makefile: Enable -Wimplicit-fallthrough for Clang

possible Warning in current branch:

arch/powerpc/platforms/powermac/smp.c:149:3: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
drivers/dma/mpc512x_dma.c:816:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
drivers/usb/gadget/udc/fsl_qe_udc.c:589:4: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]

Warning ids grouped by kconfigs:

clang_recent_errors
`-- powerpc-randconfig-r006-20210713
    |-- arch-powerpc-platforms-powermac-smp.c:warning:unannotated-fall-through-between-switch-labels
    |-- drivers-dma-mpc512x_dma.c:warning:unannotated-fall-through-between-switch-labels
    `-- drivers-usb-gadget-udc-fsl_qe_udc.c:warning:unannotated-fall-through-between-switch-labels

elapsed time: 726m

configs tested: 147
configs skipped: 3

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
riscv             nommu_k210_sdcard_defconfig
arm                  colibri_pxa270_defconfig
microblaze                          defconfig
ia64                             alldefconfig
powerpc                 mpc832x_mds_defconfig
arc                    vdk_hs38_smp_defconfig
arm                       netwinder_defconfig
sh                           se7705_defconfig
riscv                    nommu_k210_defconfig
mips                           gcw0_defconfig
powerpc                    amigaone_defconfig
mips                           ip32_defconfig
arm                              alldefconfig
h8300                     edosk2674_defconfig
powerpc                   bluestone_defconfig
arm                        clps711x_defconfig
mips                     loongson2k_defconfig
powerpc                       ppc64_defconfig
arc                           tb10x_defconfig
sh                                  defconfig
mips                           ip27_defconfig
arm                           stm32_defconfig
powerpc                     tqm8555_defconfig
arm                        mini2440_defconfig
powerpc                         ps3_defconfig
sh                          r7785rp_defconfig
sh                           se7343_defconfig
powerpc                    adder875_defconfig
m68k                        m5272c3_defconfig
h8300                            alldefconfig
mips                          ath79_defconfig
powerpc                      tqm8xx_defconfig
powerpc                     redwood_defconfig
ia64                                defconfig
s390                             allmodconfig
mips                            gpr_defconfig
powerpc                 linkstation_defconfig
mips                        qi_lb60_defconfig
sh                        dreamcast_defconfig
xtensa                           allyesconfig
m68k                       m5208evb_defconfig
mips                      pic32mzda_defconfig
mips                        vocore2_defconfig
powerpc                    socrates_defconfig
mips                      fuloong2e_defconfig
mips                         db1xxx_defconfig
powerpc                 mpc834x_mds_defconfig
arm                            mps2_defconfig
arm                         socfpga_defconfig
powerpc                     pq2fads_defconfig
m68k                        m5307c3_defconfig
sh                            hp6xx_defconfig
powerpc                  mpc866_ads_defconfig
arm                            lart_defconfig
mips                       capcella_defconfig
arc                              alldefconfig
sh                        edosk7705_defconfig
mips                      maltaaprp_defconfig
powerpc                       maple_defconfig
powerpc                      cm5200_defconfig
arm                        neponset_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
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
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
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
i386                 randconfig-a005-20210713
i386                 randconfig-a004-20210713
i386                 randconfig-a006-20210713
i386                 randconfig-a001-20210713
i386                 randconfig-a002-20210713
i386                 randconfig-a003-20210713
x86_64               randconfig-a013-20210713
x86_64               randconfig-a014-20210713
x86_64               randconfig-a012-20210713
x86_64               randconfig-a015-20210713
x86_64               randconfig-a016-20210713
x86_64               randconfig-a011-20210713
i386                 randconfig-a014-20210714
i386                 randconfig-a015-20210714
i386                 randconfig-a011-20210714
i386                 randconfig-a013-20210714
i386                 randconfig-a012-20210714
i386                 randconfig-a016-20210714
i386                 randconfig-a015-20210713
i386                 randconfig-a014-20210713
i386                 randconfig-a011-20210713
i386                 randconfig-a013-20210713
i386                 randconfig-a012-20210713
i386                 randconfig-a016-20210713
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
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210713
x86_64               randconfig-a005-20210713
x86_64               randconfig-a004-20210713
x86_64               randconfig-a003-20210713
x86_64               randconfig-a002-20210713
x86_64               randconfig-a006-20210713
x86_64               randconfig-a001-20210713
x86_64               randconfig-a013-20210714
x86_64               randconfig-a015-20210714
x86_64               randconfig-a012-20210714
x86_64               randconfig-a014-20210714
x86_64               randconfig-a016-20210714
x86_64               randconfig-a011-20210714

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
