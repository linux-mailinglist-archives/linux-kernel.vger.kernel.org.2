Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF4B37F36C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 09:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbhEMHMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 03:12:25 -0400
Received: from mga03.intel.com ([134.134.136.65]:47170 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229786AbhEMHMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 03:12:24 -0400
IronPort-SDR: N9CISe9hM7F9JZ1cTiTDNEIhYS4cRalmqW94L0KUQezsqgKlNcNbeHaQYOaZ8i0Yd5Sf0dE5Un
 grnU7O7MSOcA==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="199943715"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="199943715"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 00:11:11 -0700
IronPort-SDR: 1RiMIDcPjBHQSLWi22M1rhmFK3pf6pU+sxQSGRIazdato4cWetwZ+vLloQ+8juj5D8bgX6lkhG
 hKDDKi0NC0pQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="437535412"
Received: from lkp-server01.sh.intel.com (HELO ddd90b05c979) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 13 May 2021 00:11:10 -0700
Received: from kbuild by ddd90b05c979 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lh5Uz-000081-Ig; Thu, 13 May 2021 07:11:09 +0000
Date:   Thu, 13 May 2021 15:10:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/core] BUILD SUCCESS
 f4addd54b1617067f735ad194a3580a2db7b8bf5
Message-ID: <609cd100.rrA5/F02Wm6vumJV%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
branch HEAD: f4addd54b1617067f735ad194a3580a2db7b8bf5  selftests: futex: Expand timeout test

elapsed time: 729m

configs tested: 130
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
powerpc                      pcm030_defconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                      ppc64e_defconfig
powerpc                          allmodconfig
arm                        neponset_defconfig
arm                           h5000_defconfig
h8300                               defconfig
nds32                               defconfig
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
i386                 randconfig-a003-20210513
i386                 randconfig-a001-20210513
i386                 randconfig-a005-20210513
i386                 randconfig-a004-20210513
i386                 randconfig-a002-20210513
i386                 randconfig-a006-20210513
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
x86_64                           allyesconfig

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
