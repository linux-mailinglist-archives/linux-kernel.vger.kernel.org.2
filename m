Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 268BB379F2E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 07:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbhEKFa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 01:30:58 -0400
Received: from mga17.intel.com ([192.55.52.151]:19956 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230332AbhEKFa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 01:30:57 -0400
IronPort-SDR: o+Wup3PSqgWG+JKHAWYaCjtJbjyAEZZs+C9twWHIZIxb72w+qHQ7lHaCXH5BqRrkl370MvoWc4
 1qqqfRr0+sNA==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="179622537"
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="179622537"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 22:29:51 -0700
IronPort-SDR: JUniZbboKC+8WE/EVbxCafbzWLq+hUeTwenoZg8eTODCV9Fy4vc/yoXraB0sjOdcqGTdGb7nhA
 JpbTe9d09bag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="471016187"
Received: from lkp-server01.sh.intel.com (HELO f375d57c4ed4) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 10 May 2021 22:29:41 -0700
Received: from kbuild by f375d57c4ed4 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lgKxd-0000Z7-Aq; Tue, 11 May 2021 05:29:37 +0000
Date:   Tue, 11 May 2021 13:29:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:tglx-pc.2021.05.10a] BUILD REGRESSION
 650c7ee79df04a22835a23144ffb918a75ab04e6
Message-ID: <609a1635.iknYlwr69sz0Ojyz%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tglx-pc.2021.05.10a
branch HEAD: 650c7ee79df04a22835a23144ffb918a75ab04e6  preempt: Remove PREEMPT_COUNT from Kconfig

Error/Warning reports:

https://lore.kernel.org/lkml/202105110647.8rU44xvP-lkp@intel.com

Error/Warning in current branch:

arch/um/include/shared/kern_util.h:54:12: error: conflicting types for '__cant_sleep'
arch/um/kernel/process.c:221:5: error: conflicting types for '__cant_sleep'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- um-allmodconfig
|   |-- arch-um-include-shared-kern_util.h:error:conflicting-types-for-__cant_sleep
|   `-- arch-um-kernel-process.c:error:conflicting-types-for-__cant_sleep
`-- um-allyesconfig
    |-- arch-um-include-shared-kern_util.h:error:conflicting-types-for-__cant_sleep
    `-- arch-um-kernel-process.c:error:conflicting-types-for-__cant_sleep

elapsed time: 728m

configs tested: 166
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
i386                             allyesconfig
riscv                            allyesconfig
nds32                               defconfig
arm                           spitz_defconfig
h8300                            alldefconfig
m68k                                defconfig
sh                          lboxre2_defconfig
powerpc                 mpc8272_ads_defconfig
mips                malta_qemu_32r6_defconfig
sh                     sh7710voipgw_defconfig
arm                          simpad_defconfig
powerpc                 mpc836x_mds_defconfig
i386                                defconfig
ia64                      gensparse_defconfig
arm                        neponset_defconfig
powerpc                      obs600_defconfig
arm64                            alldefconfig
powerpc                mpc7448_hpc2_defconfig
arm                           tegra_defconfig
arm                            mps2_defconfig
powerpc                    sam440ep_defconfig
arm                       aspeed_g4_defconfig
sh                          polaris_defconfig
powerpc                     tqm5200_defconfig
arm                            xcep_defconfig
powerpc                      ppc44x_defconfig
arm                            qcom_defconfig
sh                          urquell_defconfig
arm                          exynos_defconfig
sparc                       sparc32_defconfig
riscv                             allnoconfig
mips                        workpad_defconfig
arm                       aspeed_g5_defconfig
arm                           u8500_defconfig
arm                          iop32x_defconfig
mips                          ath25_defconfig
powerpc                      chrp32_defconfig
sh                           se7343_defconfig
openrisc                    or1ksim_defconfig
xtensa                  nommu_kc705_defconfig
arm                             mxs_defconfig
parisc                generic-64bit_defconfig
ia64                             allyesconfig
arm                          pxa3xx_defconfig
sh                           se7751_defconfig
mips                            ar7_defconfig
ia64                          tiger_defconfig
powerpc                  mpc866_ads_defconfig
arm                            lart_defconfig
powerpc                    gamecube_defconfig
arm                            dove_defconfig
arm                        trizeps4_defconfig
arm                         at91_dt_defconfig
arm                       cns3420vb_defconfig
m68k                          sun3x_defconfig
arm                         lpc32xx_defconfig
arc                          axs101_defconfig
sh                      rts7751r2d1_defconfig
sh                   secureedge5410_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                          g5_defconfig
arm                      footbridge_defconfig
arm                       multi_v4t_defconfig
sh                        sh7757lcr_defconfig
mips                        nlm_xlp_defconfig
arm                         cm_x300_defconfig
nios2                            alldefconfig
arm                       imx_v6_v7_defconfig
nios2                               defconfig
mips                     loongson2k_defconfig
sh                   sh7724_generic_defconfig
arm                            hisi_defconfig
mips                         tb0226_defconfig
riscv                    nommu_k210_defconfig
arm                         bcm2835_defconfig
powerpc                       ebony_defconfig
sh                          r7785rp_defconfig
riscv                    nommu_virt_defconfig
arm                       versatile_defconfig
powerpc                 mpc834x_mds_defconfig
sh                               j2_defconfig
powerpc                   currituck_defconfig
mips                            gpr_defconfig
arm                          ixp4xx_defconfig
sh                              ul2_defconfig
powerpc                         ps3_defconfig
xtensa                       common_defconfig
ia64                             alldefconfig
arm                            mmp2_defconfig
m68k                         amcore_defconfig
powerpc                 canyonlands_defconfig
mips                 decstation_r4k_defconfig
sh                          rsk7201_defconfig
powerpc                    socrates_defconfig
powerpc                     pseries_defconfig
m68k                       m5275evb_defconfig
powerpc                     tqm8540_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
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
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20210510
x86_64               randconfig-a004-20210510
x86_64               randconfig-a001-20210510
x86_64               randconfig-a005-20210510
x86_64               randconfig-a002-20210510
x86_64               randconfig-a006-20210510
i386                 randconfig-a003-20210510
i386                 randconfig-a001-20210510
i386                 randconfig-a005-20210510
i386                 randconfig-a004-20210510
i386                 randconfig-a002-20210510
i386                 randconfig-a006-20210510
i386                 randconfig-a016-20210510
i386                 randconfig-a014-20210510
i386                 randconfig-a011-20210510
i386                 randconfig-a015-20210510
i386                 randconfig-a012-20210510
i386                 randconfig-a013-20210510
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
x86_64               randconfig-a015-20210510
x86_64               randconfig-a012-20210510
x86_64               randconfig-a011-20210510
x86_64               randconfig-a013-20210510
x86_64               randconfig-a016-20210510
x86_64               randconfig-a014-20210510

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
