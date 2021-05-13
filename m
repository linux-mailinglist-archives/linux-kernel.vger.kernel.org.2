Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C94DE37F320
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 08:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbhEMGiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 02:38:23 -0400
Received: from mga04.intel.com ([192.55.52.120]:1675 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230478AbhEMGiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 02:38:20 -0400
IronPort-SDR: CFeIVDzAt6W8/ayffqlBjYPo/PwZBh4qe/KyQ/F7CmptuFN0xgmn8/YJbIL/bHfpzf4ve6Onyw
 zbESKl9E/gbQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="197912037"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="197912037"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2021 23:37:11 -0700
IronPort-SDR: lEXXdkZtxSbUCZ4WLENT8jNFhHtNBa0smS7D61yTzSa4rFLB2QbCkzxBZytx0U6UTvOk0EqZVg
 Q/4Psh85DPWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="437526683"
Received: from lkp-server01.sh.intel.com (HELO ddd90b05c979) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 12 May 2021 23:37:09 -0700
Received: from kbuild by ddd90b05c979 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lh4y5-00007L-77; Thu, 13 May 2021 06:37:09 +0000
Date:   Thu, 13 May 2021 14:37:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 c43426334b3169b6c9e6855483aa7384ff09fd33
Message-ID: <609cc913.0ak2ieru7U0N+z4H%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
branch HEAD: c43426334b3169b6c9e6855483aa7384ff09fd33  x86: Fix leftover comment typos

elapsed time: 722m

configs tested: 153
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sparc64                             defconfig
powerpc                     tqm8555_defconfig
arm                         vf610m4_defconfig
nds32                               defconfig
arc                     haps_hs_smp_defconfig
mips                          rm200_defconfig
powerpc                      cm5200_defconfig
powerpc                      katmai_defconfig
sh                          lboxre2_defconfig
powerpc                      pcm030_defconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                      ppc64e_defconfig
powerpc                          allmodconfig
arm                        neponset_defconfig
arm                           h5000_defconfig
h8300                               defconfig
powerpc                     powernv_defconfig
sparc                       sparc64_defconfig
m68k                            mac_defconfig
powerpc                     kmeter1_defconfig
nios2                         3c120_defconfig
powerpc                 mpc834x_itx_defconfig
arm                      tct_hammer_defconfig
sh                         apsh4a3a_defconfig
mips                       bmips_be_defconfig
m68k                        mvme147_defconfig
mips                  decstation_64_defconfig
arm                         nhk8815_defconfig
riscv                            alldefconfig
arm                        vexpress_defconfig
mips                            gpr_defconfig
sh                           sh2007_defconfig
mips                           gcw0_defconfig
arm                          ixp4xx_defconfig
sh                        sh7785lcr_defconfig
mips                           ci20_defconfig
sh                         ap325rxa_defconfig
sparc                               defconfig
powerpc                          g5_defconfig
powerpc                 mpc834x_mds_defconfig
sh                           se7722_defconfig
sh                          polaris_defconfig
alpha                               defconfig
arm                         assabet_defconfig
mips                        bcm47xx_defconfig
arm                       mainstone_defconfig
arm                             mxs_defconfig
arc                         haps_hs_defconfig
sparc                       sparc32_defconfig
x86_64                           allyesconfig
sh                           se7343_defconfig
mips                      maltasmvp_defconfig
mips                         tb0219_defconfig
arm                         palmz72_defconfig
arm                          pxa910_defconfig
powerpc                 mpc836x_mds_defconfig
i386                             alldefconfig
sh                          sdk7780_defconfig
mips                           xway_defconfig
arm                         s5pv210_defconfig
powerpc                     mpc83xx_defconfig
arm                          simpad_defconfig
ia64                          tiger_defconfig
powerpc                       holly_defconfig
arm                   milbeaut_m10v_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
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
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20210512
x86_64               randconfig-a004-20210512
x86_64               randconfig-a001-20210512
x86_64               randconfig-a005-20210512
x86_64               randconfig-a002-20210512
x86_64               randconfig-a006-20210512
i386                 randconfig-a003-20210513
i386                 randconfig-a001-20210513
i386                 randconfig-a005-20210513
i386                 randconfig-a004-20210513
i386                 randconfig-a002-20210513
i386                 randconfig-a006-20210513
i386                 randconfig-a003-20210512
i386                 randconfig-a001-20210512
i386                 randconfig-a005-20210512
i386                 randconfig-a004-20210512
i386                 randconfig-a002-20210512
i386                 randconfig-a006-20210512
x86_64               randconfig-a012-20210513
x86_64               randconfig-a015-20210513
x86_64               randconfig-a011-20210513
x86_64               randconfig-a013-20210513
x86_64               randconfig-a016-20210513
x86_64               randconfig-a014-20210513
i386                 randconfig-a016-20210513
i386                 randconfig-a014-20210513
i386                 randconfig-a011-20210513
i386                 randconfig-a015-20210513
i386                 randconfig-a012-20210513
i386                 randconfig-a013-20210513
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a003-20210513
x86_64               randconfig-a004-20210513
x86_64               randconfig-a001-20210513
x86_64               randconfig-a005-20210513
x86_64               randconfig-a002-20210513
x86_64               randconfig-a006-20210513

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
