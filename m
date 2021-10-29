Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6759443F592
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 05:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbhJ2D4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 23:56:33 -0400
Received: from mga07.intel.com ([134.134.136.100]:47606 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231611AbhJ2D4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 23:56:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10151"; a="294042368"
X-IronPort-AV: E=Sophos;i="5.87,191,1631602800"; 
   d="scan'208";a="294042368"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2021 20:54:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,191,1631602800"; 
   d="scan'208";a="447971846"
Received: from lkp-server01.sh.intel.com (HELO 65f646ee03cf) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 28 Oct 2021 20:54:00 -0700
Received: from kbuild by 65f646ee03cf with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mgIxr-000075-Hr; Fri, 29 Oct 2021 03:53:59 +0000
Date:   Fri, 29 Oct 2021 11:53:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/core] BUILD SUCCESS
 ca136cac37eb51649d52d5bc4271c55e30ed354c
Message-ID: <617b7029.EN26KWe/5REOIhI/%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
branch HEAD: ca136cac37eb51649d52d5bc4271c55e30ed354c  vmlinux.lds.h: Have ORC lookup cover entire _etext - _stext

elapsed time: 2493m

configs tested: 219
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allmodconfig
arm                              allyesconfig
mips                 randconfig-c004-20211027
i386                 randconfig-c001-20211027
i386                 randconfig-c001-20211028
powerpc              randconfig-c003-20211028
mips                        workpad_defconfig
mips                malta_qemu_32r6_defconfig
mips                         tb0226_defconfig
mips                      maltasmvp_defconfig
powerpc                 mpc836x_rdk_defconfig
mips                         db1xxx_defconfig
mips                          rm200_defconfig
parisc                generic-32bit_defconfig
powerpc                   microwatt_defconfig
m68k                            q40_defconfig
powerpc                          g5_defconfig
m68k                         amcore_defconfig
sh                            hp6xx_defconfig
mips                 decstation_r4k_defconfig
sh                      rts7751r2d1_defconfig
xtensa                    smp_lx200_defconfig
mips                          malta_defconfig
powerpc                     skiroot_defconfig
arm                             pxa_defconfig
m68k                          amiga_defconfig
sh                            titan_defconfig
sparc64                          alldefconfig
arm                          ixp4xx_defconfig
sh                          r7785rp_defconfig
arm                           stm32_defconfig
arm                          pxa168_defconfig
mips                         cobalt_defconfig
sh                         apsh4a3a_defconfig
mips                           rs90_defconfig
powerpc                     mpc83xx_defconfig
mips                            gpr_defconfig
arm                          collie_defconfig
arm                              alldefconfig
mips                     loongson2k_defconfig
sparc                       sparc64_defconfig
arm                        cerfcube_defconfig
powerpc                   currituck_defconfig
arm                         nhk8815_defconfig
arc                 nsimosci_hs_smp_defconfig
arm                         shannon_defconfig
mips                         tb0287_defconfig
sh                                  defconfig
arc                              alldefconfig
mips                           ip32_defconfig
mips                      loongson3_defconfig
powerpc                       ebony_defconfig
arm                          pcm027_defconfig
arm                         lpc32xx_defconfig
arm                          badge4_defconfig
sh                          rsk7203_defconfig
powerpc                      mgcoge_defconfig
powerpc                      ppc44x_defconfig
powerpc                      cm5200_defconfig
powerpc                      ppc40x_defconfig
powerpc                     tqm8560_defconfig
arc                          axs101_defconfig
powerpc                      pcm030_defconfig
arm                         s3c6400_defconfig
arm                         at91_dt_defconfig
mips                  maltasmvp_eva_defconfig
mips                      bmips_stb_defconfig
powerpc                 mpc8315_rdb_defconfig
m68k                          multi_defconfig
powerpc                    amigaone_defconfig
powerpc                 xes_mpc85xx_defconfig
mips                     decstation_defconfig
arc                           tb10x_defconfig
sh                           se7750_defconfig
sh                           se7343_defconfig
powerpc64                        alldefconfig
powerpc                     kilauea_defconfig
arm                        clps711x_defconfig
sh                           se7721_defconfig
arm                             mxs_defconfig
arm                           omap1_defconfig
arm                           h5000_defconfig
sh                           sh2007_defconfig
arm                     davinci_all_defconfig
arm                       aspeed_g5_defconfig
arm                          lpd270_defconfig
sh                             sh03_defconfig
powerpc                    mvme5100_defconfig
arm                      integrator_defconfig
arc                          axs103_defconfig
powerpc                     akebono_defconfig
powerpc                      tqm8xx_defconfig
openrisc                            defconfig
arc                            hsdk_defconfig
mips                       lemote2f_defconfig
mips                         rt305x_defconfig
mips                         tb0219_defconfig
arm                          ep93xx_defconfig
riscv             nommu_k210_sdcard_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                 mpc834x_itx_defconfig
m68k                        mvme16x_defconfig
microblaze                      mmu_defconfig
mips                     cu1830-neo_defconfig
arm                  randconfig-c002-20211028
arm                  randconfig-c002-20211027
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
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
sh                               allmodconfig
xtensa                           allyesconfig
parisc                              defconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
s390                             allmodconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20211028
x86_64               randconfig-a004-20211028
x86_64               randconfig-a005-20211028
x86_64               randconfig-a001-20211028
x86_64               randconfig-a006-20211028
x86_64               randconfig-a003-20211028
i386                 randconfig-a004-20211028
i386                 randconfig-a003-20211028
i386                 randconfig-a002-20211028
i386                 randconfig-a006-20211028
i386                 randconfig-a001-20211028
i386                 randconfig-a005-20211028
x86_64               randconfig-a013-20211027
x86_64               randconfig-a016-20211027
x86_64               randconfig-a015-20211027
x86_64               randconfig-a011-20211027
x86_64               randconfig-a014-20211027
x86_64               randconfig-a012-20211027
i386                 randconfig-a012-20211027
i386                 randconfig-a013-20211027
i386                 randconfig-a011-20211027
i386                 randconfig-a016-20211027
i386                 randconfig-a015-20211027
i386                 randconfig-a014-20211027
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
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
riscv                randconfig-c006-20211027
powerpc              randconfig-c003-20211027
arm                  randconfig-c002-20211027
mips                 randconfig-c004-20211027
x86_64               randconfig-c007-20211027
i386                 randconfig-c001-20211027
s390                 randconfig-c005-20211027
arm                  randconfig-c002-20211028
powerpc              randconfig-c003-20211028
riscv                randconfig-c006-20211028
x86_64               randconfig-c007-20211028
mips                 randconfig-c004-20211028
s390                 randconfig-c005-20211028
i386                 randconfig-c001-20211028
x86_64               randconfig-a002-20211027
x86_64               randconfig-a004-20211027
x86_64               randconfig-a005-20211027
x86_64               randconfig-a006-20211027
x86_64               randconfig-a001-20211027
x86_64               randconfig-a003-20211027
i386                 randconfig-a003-20211027
i386                 randconfig-a004-20211027
i386                 randconfig-a002-20211027
i386                 randconfig-a005-20211027
i386                 randconfig-a001-20211027
i386                 randconfig-a006-20211027
x86_64               randconfig-a015-20211028
x86_64               randconfig-a013-20211028
x86_64               randconfig-a011-20211028
x86_64               randconfig-a014-20211028
x86_64               randconfig-a012-20211028
x86_64               randconfig-a016-20211028
i386                 randconfig-a012-20211028
i386                 randconfig-a013-20211028
i386                 randconfig-a011-20211028
i386                 randconfig-a015-20211028
i386                 randconfig-a016-20211028
i386                 randconfig-a014-20211028
hexagon              randconfig-r045-20211028
riscv                randconfig-r042-20211028
s390                 randconfig-r044-20211028
hexagon              randconfig-r041-20211028
hexagon              randconfig-r045-20211027
hexagon              randconfig-r041-20211027

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
