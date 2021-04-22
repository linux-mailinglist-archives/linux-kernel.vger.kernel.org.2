Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87B18367AFF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 09:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235054AbhDVHXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 03:23:08 -0400
Received: from mga09.intel.com ([134.134.136.24]:5988 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229629AbhDVHXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 03:23:03 -0400
IronPort-SDR: 7/3QsbM8ZZXdR1ca7NlAHziJ7nPwMnRZs3qfjelVv346CQFvBW5UiV/OmaCb5//la3n1DRTq4z
 eUPB44yb8FSg==
X-IronPort-AV: E=McAfee;i="6200,9189,9961"; a="195953009"
X-IronPort-AV: E=Sophos;i="5.82,241,1613462400"; 
   d="scan'208";a="195953009"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 00:22:28 -0700
IronPort-SDR: ilypC+zpf/6kHVzjccUWYzD1hZJxHKMWpSN6gJfeUEwFrhX3CbGeJFdvhF44V+KR+l9kyYSlKj
 BiA9st6h8F8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,242,1613462400"; 
   d="scan'208";a="427821173"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 22 Apr 2021 00:22:27 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lZTfO-00042T-Dk; Thu, 22 Apr 2021 07:22:26 +0000
Date:   Thu, 22 Apr 2021 15:22:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2021.04.20a] BUILD SUCCESS
 fe7d174b033dcf9367759b3c14febb31525aad39
Message-ID: <6081241d.oOxkbUWAx2gngOgX%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2021.04.20a
branch HEAD: fe7d174b033dcf9367759b3c14febb31525aad39  rcu/tree_plugin: Don't handle the case of 'all' CPU range

elapsed time: 723m

configs tested: 148
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
arm                            lart_defconfig
mips                malta_qemu_32r6_defconfig
mips                          malta_defconfig
sh                             shx3_defconfig
powerpc                      ppc44x_defconfig
um                                  defconfig
mips                        workpad_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                   currituck_defconfig
riscv                             allnoconfig
powerpc                 mpc837x_mds_defconfig
powerpc                      pcm030_defconfig
arm                         s3c6400_defconfig
xtensa                          iss_defconfig
mips                      loongson3_defconfig
powerpc                  iss476-smp_defconfig
arm                              alldefconfig
arm                       omap2plus_defconfig
arm                      tct_hammer_defconfig
mips                           rs90_defconfig
arm                      integrator_defconfig
arm                      footbridge_defconfig
h8300                    h8300h-sim_defconfig
xtensa                              defconfig
powerpc                 mpc836x_rdk_defconfig
powerpc                      mgcoge_defconfig
powerpc                         wii_defconfig
arm                  colibri_pxa270_defconfig
openrisc                    or1ksim_defconfig
powerpc                     asp8347_defconfig
ia64                          tiger_defconfig
mips                        nlm_xlr_defconfig
mips                  decstation_64_defconfig
nios2                               defconfig
sparc                               defconfig
m68k                          hp300_defconfig
mips                           xway_defconfig
powerpc                  storcenter_defconfig
mips                           ci20_defconfig
arm                         lpc18xx_defconfig
mips                      bmips_stb_defconfig
arm                        mvebu_v7_defconfig
xtensa                  nommu_kc705_defconfig
sh                          sdk7780_defconfig
sh                            titan_defconfig
arm                         lpc32xx_defconfig
arm                           h5000_defconfig
powerpc                     tqm8548_defconfig
sh                     magicpanelr2_defconfig
arm                         cm_x300_defconfig
arc                        vdk_hs38_defconfig
arc                        nsim_700_defconfig
mips                        maltaup_defconfig
mips                        bcm47xx_defconfig
powerpc                 canyonlands_defconfig
mips                           jazz_defconfig
arm                         s3c2410_defconfig
powerpc                 mpc836x_mds_defconfig
mips                             allyesconfig
powerpc                     skiroot_defconfig
mips                      maltaaprp_defconfig
powerpc                       maple_defconfig
sh                           se7206_defconfig
sh                          sdk7786_defconfig
powerpc                     ksi8560_defconfig
arc                          axs103_defconfig
i386                             alldefconfig
arc                      axs103_smp_defconfig
m68k                         apollo_defconfig
sh                           sh2007_defconfig
sh                           se7722_defconfig
openrisc                         alldefconfig
powerpc                      acadia_defconfig
mips                            e55_defconfig
sh                            migor_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
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
s390                                defconfig
sparc                            allyesconfig
i386                                defconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20210421
x86_64               randconfig-a002-20210421
x86_64               randconfig-a001-20210421
x86_64               randconfig-a005-20210421
x86_64               randconfig-a006-20210421
x86_64               randconfig-a003-20210421
i386                 randconfig-a005-20210421
i386                 randconfig-a002-20210421
i386                 randconfig-a001-20210421
i386                 randconfig-a006-20210421
i386                 randconfig-a004-20210421
i386                 randconfig-a003-20210421
i386                 randconfig-a012-20210421
i386                 randconfig-a014-20210421
i386                 randconfig-a011-20210421
i386                 randconfig-a013-20210421
i386                 randconfig-a015-20210421
i386                 randconfig-a016-20210421
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a015-20210421
x86_64               randconfig-a016-20210421
x86_64               randconfig-a011-20210421
x86_64               randconfig-a014-20210421
x86_64               randconfig-a013-20210421
x86_64               randconfig-a012-20210421

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
