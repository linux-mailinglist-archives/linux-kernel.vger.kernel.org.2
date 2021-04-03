Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0C83535BD
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 01:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236861AbhDCXSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 19:18:16 -0400
Received: from mga14.intel.com ([192.55.52.115]:6372 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236625AbhDCXSN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 19:18:13 -0400
IronPort-SDR: KCqwAHaiZSWW5eI1G/oKfDKUioSwBPQfBJ+2r+ZjRDgaByE6A+HdRaNYzUo2eUWSQUslV+DKNM
 gxxfCL+Dl/4w==
X-IronPort-AV: E=McAfee;i="6000,8403,9943"; a="192145528"
X-IronPort-AV: E=Sophos;i="5.81,303,1610438400"; 
   d="scan'208";a="192145528"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2021 16:18:09 -0700
IronPort-SDR: Xm5BSIkBuFbRvVxJJDfppZzKY34p7q/GPprsmcwKqOx8Fp1aB/YRo1+5twGh17it7N4zVO71SI
 l2tGeyTSWEHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,303,1610438400"; 
   d="scan'208";a="440050917"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 03 Apr 2021 16:18:08 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lSpWp-0007vR-WF; Sat, 03 Apr 2021 23:18:08 +0000
Date:   Sun, 04 Apr 2021 07:17:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 cba793347389e4beafac9f2ee6ecd3e74d8715c1
Message-ID: <6068f796.e/fGrXV83ZnH/D0H%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: cba793347389e4beafac9f2ee6ecd3e74d8715c1  Merge branch 'perf/core'

elapsed time: 726m

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
riscv                            allmodconfig
x86_64                           allyesconfig
i386                             allyesconfig
riscv                            allyesconfig
powerpc                     powernv_defconfig
mips                      malta_kvm_defconfig
m68k                        mvme16x_defconfig
powerpc                      ppc40x_defconfig
mips                         tb0226_defconfig
arm                             rpc_defconfig
xtensa                       common_defconfig
powerpc                     ksi8560_defconfig
arm                          lpd270_defconfig
ia64                             allmodconfig
m68k                         amcore_defconfig
m68k                       bvme6000_defconfig
arm                       spear13xx_defconfig
powerpc                     ppa8548_defconfig
sh                          polaris_defconfig
sh                         ap325rxa_defconfig
sh                          urquell_defconfig
mips                        bcm47xx_defconfig
arm                            mps2_defconfig
sh                 kfr2r09-romimage_defconfig
sh                          sdk7780_defconfig
powerpc                     ep8248e_defconfig
powerpc                          g5_defconfig
arm                        shmobile_defconfig
m68k                         apollo_defconfig
s390                             allmodconfig
xtensa                          iss_defconfig
sh                          rsk7201_defconfig
powerpc                   bluestone_defconfig
sh                          rsk7269_defconfig
sh                           se7751_defconfig
mips                        omega2p_defconfig
arm                        mvebu_v7_defconfig
um                            kunit_defconfig
powerpc                      chrp32_defconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                     taishan_defconfig
mips                             allmodconfig
arm                          ep93xx_defconfig
nds32                            alldefconfig
arm                       netwinder_defconfig
mips                         mpc30x_defconfig
sh                            migor_defconfig
powerpc                 mpc836x_mds_defconfig
xtensa                  nommu_kc705_defconfig
sh                           se7712_defconfig
powerpc                     tqm8555_defconfig
arm                         mv78xx0_defconfig
arm                          pxa910_defconfig
sh                           se7705_defconfig
mips                     decstation_defconfig
powerpc                      ppc64e_defconfig
arm                        multi_v5_defconfig
arm                         nhk8815_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                     pseries_defconfig
powerpc                     sbc8548_defconfig
powerpc                      ep88xc_defconfig
parisc                generic-32bit_defconfig
sh                           sh2007_defconfig
arm                         hackkit_defconfig
arm                          moxart_defconfig
arm                           stm32_defconfig
sh                            hp6xx_defconfig
mips                           ip22_defconfig
sh                   sh7724_generic_defconfig
arm                      jornada720_defconfig
arc                        nsim_700_defconfig
arc                           tb10x_defconfig
ia64                                defconfig
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
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20210404
i386                 randconfig-a003-20210404
i386                 randconfig-a001-20210404
i386                 randconfig-a004-20210404
i386                 randconfig-a005-20210404
i386                 randconfig-a002-20210404
i386                 randconfig-a006-20210403
i386                 randconfig-a003-20210403
i386                 randconfig-a001-20210403
i386                 randconfig-a004-20210403
i386                 randconfig-a002-20210403
i386                 randconfig-a005-20210403
x86_64               randconfig-a014-20210403
x86_64               randconfig-a015-20210403
x86_64               randconfig-a011-20210403
x86_64               randconfig-a013-20210403
x86_64               randconfig-a012-20210403
x86_64               randconfig-a016-20210403
i386                 randconfig-a014-20210404
i386                 randconfig-a016-20210404
i386                 randconfig-a011-20210404
i386                 randconfig-a012-20210404
i386                 randconfig-a015-20210404
i386                 randconfig-a013-20210404
i386                 randconfig-a014-20210403
i386                 randconfig-a011-20210403
i386                 randconfig-a016-20210403
i386                 randconfig-a012-20210403
i386                 randconfig-a013-20210403
i386                 randconfig-a015-20210403
x86_64               randconfig-a004-20210404
x86_64               randconfig-a003-20210404
x86_64               randconfig-a005-20210404
x86_64               randconfig-a001-20210404
x86_64               randconfig-a002-20210404
x86_64               randconfig-a006-20210404
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
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
x86_64               randconfig-a004-20210403
x86_64               randconfig-a005-20210403
x86_64               randconfig-a003-20210403
x86_64               randconfig-a001-20210403
x86_64               randconfig-a002-20210403
x86_64               randconfig-a006-20210403
x86_64               randconfig-a014-20210404
x86_64               randconfig-a015-20210404
x86_64               randconfig-a013-20210404
x86_64               randconfig-a011-20210404
x86_64               randconfig-a012-20210404
x86_64               randconfig-a016-20210404

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
