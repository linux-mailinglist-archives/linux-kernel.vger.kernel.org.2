Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A824A43DB98
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 08:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhJ1G5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 02:57:03 -0400
Received: from mga17.intel.com ([192.55.52.151]:46087 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229626AbhJ1G5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 02:57:02 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10150"; a="211111446"
X-IronPort-AV: E=Sophos;i="5.87,189,1631602800"; 
   d="scan'208";a="211111446"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 23:54:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,189,1631602800"; 
   d="scan'208";a="487006425"
Received: from lkp-server01.sh.intel.com (HELO 3b851179dbd8) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 27 Oct 2021 23:54:24 -0700
Received: from kbuild by 3b851179dbd8 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mfzIt-0001hN-Sx; Thu, 28 Oct 2021 06:54:23 +0000
Date:   Thu, 28 Oct 2021 14:54:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:for-next/kspp-misc-fixes] BUILD SUCCESS
 2ac5fb35cd520ab1851c9a4816c523b65276052f
Message-ID: <617a4911.uAzshpph9WMzyrXm%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git for-next/kspp-misc-fixes
branch HEAD: 2ac5fb35cd520ab1851c9a4816c523b65276052f  firmware/psci: fix application of sizeof to pointer

elapsed time: 1931m

configs tested: 145
configs skipped: 3

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
sh                      rts7751r2d1_defconfig
xtensa                    smp_lx200_defconfig
mips                          malta_defconfig
powerpc                     skiroot_defconfig
mips                         tb0287_defconfig
nios2                            alldefconfig
powerpc                     ep8248e_defconfig
powerpc                        fsp2_defconfig
sh                           se7721_defconfig
sh                          r7785rp_defconfig
arm                           stm32_defconfig
arm                          pxa168_defconfig
mips                         cobalt_defconfig
mips                     loongson2k_defconfig
arc                 nsimosci_hs_smp_defconfig
sparc                       sparc64_defconfig
arm                        cerfcube_defconfig
powerpc                   currituck_defconfig
arm                         nhk8815_defconfig
arm                         shannon_defconfig
sh                                  defconfig
arc                              alldefconfig
mips                           ip32_defconfig
mips                      loongson3_defconfig
powerpc                       ebony_defconfig
mips                malta_qemu_32r6_defconfig
arm                          pcm027_defconfig
arm                         lpc32xx_defconfig
arm                          badge4_defconfig
arm                    vt8500_v6_v7_defconfig
arm                     davinci_all_defconfig
arc                         haps_hs_defconfig
arc                            hsdk_defconfig
arm                          lpd270_defconfig
arm                         s3c6400_defconfig
powerpc                      ppc40x_defconfig
arm                         at91_dt_defconfig
mips                  maltasmvp_eva_defconfig
m68k                          amiga_defconfig
mips                      bmips_stb_defconfig
powerpc                 mpc8315_rdb_defconfig
m68k                          multi_defconfig
i386                             alldefconfig
powerpc                 mpc832x_rdb_defconfig
arm                       aspeed_g5_defconfig
mips                         tb0226_defconfig
openrisc                    or1ksim_defconfig
arm                        clps711x_defconfig
powerpc                      ppc44x_defconfig
xtensa                    xip_kc705_defconfig
mips                     decstation_defconfig
powerpc                      bamboo_defconfig
mips                          ath25_defconfig
powerpc                     akebono_defconfig
powerpc                      tqm8xx_defconfig
openrisc                            defconfig
mips                       lemote2f_defconfig
mips                     cu1830-neo_defconfig
mips                          rm200_defconfig
riscv             nommu_k210_sdcard_defconfig
arm                  randconfig-c002-20211027
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
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
s390                                defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
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
x86_64               randconfig-a013-20211027
x86_64               randconfig-a015-20211027
x86_64               randconfig-a011-20211027
x86_64               randconfig-a014-20211027
x86_64               randconfig-a016-20211027
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
riscv                            allyesconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
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
hexagon              randconfig-r045-20211027
hexagon              randconfig-r041-20211027

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
