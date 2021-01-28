Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA93307554
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 12:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbhA1L6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 06:58:23 -0500
Received: from mga06.intel.com ([134.134.136.31]:61294 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229757AbhA1L6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 06:58:21 -0500
IronPort-SDR: 8uKIZTbr2mBTVHF7D+O+9l1DwPd5QpIMOlZhgV6A/rgB5d9TR3JSC/kFndHVeTb91Vz+UUmTdI
 n6OYQ4kjclDQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9877"; a="241746576"
X-IronPort-AV: E=Sophos;i="5.79,382,1602572400"; 
   d="scan'208";a="241746576"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 03:57:06 -0800
IronPort-SDR: 5qFpF2lkfPhW3uDzkCTItIN/z+qd39FPKcQ5SKYsauhI8z4HCFzLIGoBrpTFOWUbziaGHWfCrc
 sUdwRLD+5e7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,382,1602572400"; 
   d="scan'208";a="403462815"
Received: from lkp-server02.sh.intel.com (HELO 625d3a354f04) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 28 Jan 2021 03:57:05 -0800
Received: from kbuild by 625d3a354f04 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l55v6-0002rm-Q7; Thu, 28 Jan 2021 11:57:04 +0000
Date:   Thu, 28 Jan 2021 19:56:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/misc] BUILD SUCCESS
 02a16aa13574c8526beadfc9ae8cc9b66315fa2d
Message-ID: <6012a671.lkN5N+RBDhyPqPCY%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/misc
branch HEAD: 02a16aa13574c8526beadfc9ae8cc9b66315fa2d  x86/MSR: Filter MSR writes through X86_IOC_WRMSR_REGS ioctl too

elapsed time: 721m

configs tested: 136
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                         rt305x_defconfig
sh                           se7724_defconfig
arm                           u8500_defconfig
h8300                    h8300h-sim_defconfig
mips                      loongson3_defconfig
powerpc                     stx_gp3_defconfig
powerpc                      mgcoge_defconfig
powerpc                          g5_defconfig
arm                     eseries_pxa_defconfig
xtensa                    xip_kc705_defconfig
mips                            gpr_defconfig
arm                          pxa910_defconfig
m68k                        mvme16x_defconfig
sparc                            alldefconfig
arm                        vexpress_defconfig
mips                          rb532_defconfig
um                             i386_defconfig
mips                    maltaup_xpa_defconfig
mips                       bmips_be_defconfig
powerpc                     mpc83xx_defconfig
sh                            migor_defconfig
powerpc                     ppa8548_defconfig
xtensa                           allyesconfig
mips                      pic32mzda_defconfig
powerpc                     pseries_defconfig
arm                          ep93xx_defconfig
openrisc                    or1ksim_defconfig
sh                         apsh4a3a_defconfig
arm                       aspeed_g5_defconfig
arm                        mvebu_v5_defconfig
m68k                       m5275evb_defconfig
powerpc                      ppc44x_defconfig
sh                            titan_defconfig
arc                           tb10x_defconfig
m68k                        mvme147_defconfig
m68k                        m5272c3_defconfig
powerpc                   lite5200b_defconfig
m68k                            mac_defconfig
xtensa                         virt_defconfig
mips                       capcella_defconfig
parisc                generic-32bit_defconfig
microblaze                      mmu_defconfig
c6x                        evmc6474_defconfig
powerpc                      tqm8xx_defconfig
arm                          moxart_defconfig
mips                         bigsur_defconfig
arc                        nsim_700_defconfig
ia64                         bigsur_defconfig
powerpc                 canyonlands_defconfig
powerpc                  mpc885_ads_defconfig
nios2                         3c120_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                 mpc8313_rdb_defconfig
arc                            hsdk_defconfig
mips                        bcm63xx_defconfig
powerpc                    sam440ep_defconfig
arm                           tegra_defconfig
mips                          ath79_defconfig
sh                          r7780mp_defconfig
mips                       lemote2f_defconfig
mips                 decstation_r4k_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                             allyesconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210128
i386                 randconfig-a006-20210128
i386                 randconfig-a001-20210128
i386                 randconfig-a002-20210128
i386                 randconfig-a004-20210128
i386                 randconfig-a005-20210128
x86_64               randconfig-a012-20210128
x86_64               randconfig-a015-20210128
x86_64               randconfig-a016-20210128
x86_64               randconfig-a011-20210128
x86_64               randconfig-a013-20210128
x86_64               randconfig-a014-20210128
i386                 randconfig-a013-20210128
i386                 randconfig-a011-20210128
i386                 randconfig-a012-20210128
i386                 randconfig-a016-20210128
i386                 randconfig-a014-20210128
i386                 randconfig-a015-20210128
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a002-20210128
x86_64               randconfig-a003-20210128
x86_64               randconfig-a001-20210128
x86_64               randconfig-a005-20210128
x86_64               randconfig-a006-20210128
x86_64               randconfig-a004-20210128

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
