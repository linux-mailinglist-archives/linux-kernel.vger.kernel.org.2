Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0C637606B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 08:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234835AbhEGGem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 02:34:42 -0400
Received: from mga17.intel.com ([192.55.52.151]:59828 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234796AbhEGGeK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 02:34:10 -0400
IronPort-SDR: nV4xifjvWFLPPwpPNeXqw9hL9xix+dU6Srwwt/qE0OEmYGQE3ulfaN9q74jZL8ROx6SCh0szzj
 EDsCtXPgN2Cg==
X-IronPort-AV: E=McAfee;i="6200,9189,9976"; a="178902651"
X-IronPort-AV: E=Sophos;i="5.82,279,1613462400"; 
   d="scan'208";a="178902651"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2021 23:33:09 -0700
IronPort-SDR: Ck/fR8ZQCsJ77Vt9NKK3Z1CRwsU2SEgymqSogw3Cq/OCmNrfTOSV4jYwpmTAacoKxfdgcfOUF2
 ZCuFWQhZAO5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,279,1613462400"; 
   d="scan'208";a="407324403"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 06 May 2021 23:33:08 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1leu2t-000B5u-I1; Fri, 07 May 2021 06:33:07 +0000
Date:   Fri, 07 May 2021 14:32:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/urgent] BUILD SUCCESS
 51cf94d16860a324e97d1b670d88f1f2b643bc32
Message-ID: <6094df19.S2V9V5j/wimYIkzq%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/urgent
branch HEAD: 51cf94d16860a324e97d1b670d88f1f2b643bc32  futex: Make syscall entry points less convoluted

elapsed time: 728m

configs tested: 152
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
riscv                            allmodconfig
riscv                            allyesconfig
i386                             allyesconfig
arm                       imx_v4_v5_defconfig
parisc                           alldefconfig
m68k                         amcore_defconfig
microblaze                          defconfig
mips                     cu1000-neo_defconfig
arm                     am200epdkit_defconfig
um                            kunit_defconfig
powerpc                     ppa8548_defconfig
arm                          imote2_defconfig
powerpc                 mpc834x_itx_defconfig
sh                          r7780mp_defconfig
arm                         palmz72_defconfig
powerpc                 mpc834x_mds_defconfig
arm                              alldefconfig
mips                          rb532_defconfig
arm                             ezx_defconfig
riscv             nommu_k210_sdcard_defconfig
mips                      maltasmvp_defconfig
arm                            zeus_defconfig
openrisc                  or1klitex_defconfig
arm                        spear6xx_defconfig
powerpc                     ep8248e_defconfig
arm                         orion5x_defconfig
arm                        multi_v7_defconfig
mips                         bigsur_defconfig
arm                           sama5_defconfig
m68k                       m5249evb_defconfig
arm                      integrator_defconfig
sh                      rts7751r2d1_defconfig
mips                     loongson1c_defconfig
sparc64                          alldefconfig
arm                         hackkit_defconfig
arm                        shmobile_defconfig
powerpc                 mpc832x_rdb_defconfig
mips                           jazz_defconfig
arc                                 defconfig
arm                          gemini_defconfig
sh                            migor_defconfig
mips                        vocore2_defconfig
mips                        nlm_xlp_defconfig
sh                                  defconfig
arc                        vdk_hs38_defconfig
arm                          moxart_defconfig
powerpc                      obs600_defconfig
arm                       imx_v6_v7_defconfig
sh                          sdk7780_defconfig
powerpc                     rainier_defconfig
powerpc                      katmai_defconfig
powerpc                        warp_defconfig
microblaze                      mmu_defconfig
ia64                        generic_defconfig
mips                        bcm47xx_defconfig
arm                          exynos_defconfig
powerpc                    ge_imp3a_defconfig
x86_64                              defconfig
mips                       bmips_be_defconfig
arc                              alldefconfig
m68k                        m5272c3_defconfig
arc                        nsimosci_defconfig
mips                     cu1830-neo_defconfig
arc                            hsdk_defconfig
arm                        realview_defconfig
m68k                       m5275evb_defconfig
arm                       multi_v4t_defconfig
riscv                    nommu_k210_defconfig
sh                           se7751_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                    sam440ep_defconfig
sh                 kfr2r09-romimage_defconfig
mips                         cobalt_defconfig
mips                           ip22_defconfig
s390                          debug_defconfig
mips                         mpc30x_defconfig
powerpc                 mpc837x_mds_defconfig
sh                              ul2_defconfig
arm                          simpad_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
xtensa                           allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210506
i386                 randconfig-a006-20210506
i386                 randconfig-a001-20210506
i386                 randconfig-a005-20210506
i386                 randconfig-a004-20210506
i386                 randconfig-a002-20210506
x86_64               randconfig-a014-20210506
x86_64               randconfig-a015-20210506
x86_64               randconfig-a012-20210506
x86_64               randconfig-a013-20210506
x86_64               randconfig-a011-20210506
x86_64               randconfig-a016-20210506
i386                 randconfig-a015-20210506
i386                 randconfig-a013-20210506
i386                 randconfig-a016-20210506
i386                 randconfig-a014-20210506
i386                 randconfig-a012-20210506
i386                 randconfig-a011-20210506
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a001-20210506
x86_64               randconfig-a003-20210506
x86_64               randconfig-a005-20210506
x86_64               randconfig-a002-20210506
x86_64               randconfig-a006-20210506
x86_64               randconfig-a004-20210506

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
