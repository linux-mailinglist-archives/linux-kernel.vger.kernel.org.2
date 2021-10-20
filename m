Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45C1443470E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 10:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbhJTIkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 04:40:46 -0400
Received: from mga11.intel.com ([192.55.52.93]:4850 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229555AbhJTIko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 04:40:44 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10142"; a="226188462"
X-IronPort-AV: E=Sophos;i="5.87,166,1631602800"; 
   d="scan'208";a="226188462"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2021 01:38:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,166,1631602800"; 
   d="scan'208";a="444273283"
Received: from lkp-server02.sh.intel.com (HELO 08b2c502c3de) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 20 Oct 2021 01:38:27 -0700
Received: from kbuild by 08b2c502c3de with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1md77D-000DBb-7m; Wed, 20 Oct 2021 08:38:27 +0000
Date:   Wed, 20 Oct 2021 16:37:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/core] BUILD SUCCESS WITH WARNING
 5197fcd09ab6dcc4df79edec7e8e27575276374c
Message-ID: <616fd55b.i0O5M6qvLBtWAS2T%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git locking/core
branch HEAD: 5197fcd09ab6dcc4df79edec7e8e27575276374c  locking/rwsem: Fix comments about reader optimistic lock stealing conditions

Warning in current branch:

arch/arm64/include/asm/syscall_wrapper.h:76:32: warning: no previous prototype for '__arm64_sys_futex_waitv' [-Wmissing-prototypes]

possible Warning in current branch (please contact us if interested):

kernel/futex/pi.c:723:3-9: preceding lock on line 821

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm64-defconfig
|   `-- arch-arm64-include-asm-syscall_wrapper.h:warning:no-previous-prototype-for-__arm64_sys_futex_waitv
|-- arm64-randconfig-r022-20211019
|   `-- arch-arm64-include-asm-syscall_wrapper.h:warning:no-previous-prototype-for-__arm64_sys_futex_waitv
|-- arm64-randconfig-s032-20211019
|   `-- arch-arm64-include-asm-syscall_wrapper.h:warning:no-previous-prototype-for-__arm64_sys_futex_waitv
|-- i386-randconfig-c001-20211019
|   `-- kernel-futex-pi.c:preceding-lock-on-line
`-- x86_64-randconfig-c002-20211019
    `-- kernel-futex-pi.c:preceding-lock-on-line

elapsed time: 987m

configs tested: 116
configs skipped: 3

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211019
i386                             alldefconfig
arc                                 defconfig
powerpc                      mgcoge_defconfig
sh                          r7780mp_defconfig
mips                           gcw0_defconfig
powerpc                 xes_mpc85xx_defconfig
arm                           u8500_defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                     ksi8560_defconfig
powerpc                       maple_defconfig
m68k                        m5407c3_defconfig
arm                         lubbock_defconfig
parisc                generic-64bit_defconfig
sh                              ul2_defconfig
arc                     nsimosci_hs_defconfig
arm                     davinci_all_defconfig
sh                          polaris_defconfig
arm                           corgi_defconfig
sh                        edosk7760_defconfig
arm                       mainstone_defconfig
arm                          pcm027_defconfig
arm                        mvebu_v7_defconfig
sh                            hp6xx_defconfig
arm                      integrator_defconfig
arm                  randconfig-c002-20211019
x86_64               randconfig-c001-20211019
ia64                             allmodconfig
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
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20211020
i386                 randconfig-a003-20211020
i386                 randconfig-a002-20211020
i386                 randconfig-a005-20211020
i386                 randconfig-a006-20211020
i386                 randconfig-a001-20211020
x86_64               randconfig-a015-20211019
x86_64               randconfig-a012-20211019
x86_64               randconfig-a016-20211019
x86_64               randconfig-a014-20211019
x86_64               randconfig-a013-20211019
x86_64               randconfig-a011-20211019
i386                 randconfig-a014-20211019
i386                 randconfig-a016-20211019
i386                 randconfig-a011-20211019
i386                 randconfig-a015-20211019
i386                 randconfig-a012-20211019
i386                 randconfig-a013-20211019
arc                  randconfig-r043-20211019
s390                 randconfig-r044-20211019
riscv                randconfig-r042-20211019
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20211019
x86_64               randconfig-a006-20211019
x86_64               randconfig-a005-20211019
x86_64               randconfig-a001-20211019
x86_64               randconfig-a002-20211019
x86_64               randconfig-a003-20211019
i386                 randconfig-a001-20211019
i386                 randconfig-a003-20211019
i386                 randconfig-a004-20211019
i386                 randconfig-a005-20211019
i386                 randconfig-a002-20211019
i386                 randconfig-a006-20211019
riscv                randconfig-r042-20211020
s390                 randconfig-r044-20211020
hexagon              randconfig-r045-20211020
hexagon              randconfig-r041-20211020
hexagon              randconfig-r041-20211019
hexagon              randconfig-r045-20211019

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
