Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09ADC43F507
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 04:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbhJ2Co2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 22:44:28 -0400
Received: from mga09.intel.com ([134.134.136.24]:32901 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231348AbhJ2Co0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 22:44:26 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10151"; a="230433077"
X-IronPort-AV: E=Sophos;i="5.87,191,1631602800"; 
   d="scan'208";a="230433077"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2021 19:41:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,191,1631602800"; 
   d="scan'208";a="665664641"
Received: from lkp-server01.sh.intel.com (HELO 65f646ee03cf) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 28 Oct 2021 19:41:57 -0700
Received: from kbuild by 65f646ee03cf with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mgHq8-00003B-CO; Fri, 29 Oct 2021 02:41:56 +0000
Date:   Fri, 29 Oct 2021 10:41:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 5d1ceb3969b6b2e47e2df6d17790a7c5a20fcbb4
Message-ID: <617b5f68.HDAqW5YK31AwTgpy%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: 5d1ceb3969b6b2e47e2df6d17790a7c5a20fcbb4  x86: Fix __get_wchan() for !STACKTRACE

elapsed time: 3276m

configs tested: 150
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                 randconfig-c004-20211027
i386                 randconfig-c001-20211027
i386                 randconfig-c001-20211028
h8300                       h8s-sim_defconfig
powerpc                   motionpro_defconfig
arc                    vdk_hs38_smp_defconfig
sh                      rts7751r2d1_defconfig
xtensa                    smp_lx200_defconfig
mips                          malta_defconfig
xtensa                         virt_defconfig
ia64                          tiger_defconfig
arc                            hsdk_defconfig
arm                         lubbock_defconfig
arc                     nsimosci_hs_defconfig
powerpc                       ebony_defconfig
mips                malta_qemu_32r6_defconfig
arm                          pcm027_defconfig
arm                         lpc32xx_defconfig
arm                          badge4_defconfig
mips                         cobalt_defconfig
arm                         s3c6400_defconfig
powerpc                      ppc40x_defconfig
nios2                         3c120_defconfig
ia64                        generic_defconfig
powerpc                    gamecube_defconfig
arm                            dove_defconfig
arm                        trizeps4_defconfig
powerpc                     akebono_defconfig
powerpc                      tqm8xx_defconfig
openrisc                            defconfig
powerpc                     skiroot_defconfig
mips                       lemote2f_defconfig
mips                      fuloong2e_defconfig
sh                           se7751_defconfig
mips                        omega2p_defconfig
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
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
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
powerpc                           allnoconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
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
x86_64               randconfig-a002-20211028
x86_64               randconfig-a004-20211028
x86_64               randconfig-a005-20211028
x86_64               randconfig-a001-20211028
x86_64               randconfig-a006-20211028
x86_64               randconfig-a003-20211028
arc                  randconfig-r043-20211027
s390                 randconfig-r044-20211027
riscv                randconfig-r042-20211027
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
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                          rhel-8.3-func

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
