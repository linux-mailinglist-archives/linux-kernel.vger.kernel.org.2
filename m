Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1A52440713
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 05:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbhJ3DVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 23:21:52 -0400
Received: from mga02.intel.com ([134.134.136.20]:47951 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230506AbhJ3DVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 23:21:51 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10152"; a="217976881"
X-IronPort-AV: E=Sophos;i="5.87,194,1631602800"; 
   d="scan'208";a="217976881"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2021 20:19:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,194,1631602800"; 
   d="scan'208";a="499159580"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 29 Oct 2021 20:19:20 -0700
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mgetr-0000zo-Qu; Sat, 30 Oct 2021 03:19:19 +0000
Date:   Sat, 30 Oct 2021 11:19:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/apic] BUILD SUCCESS
 cc95a07fef06a2c7917acd827b3a8322772969eb
Message-ID: <617cb9a6.cEF8oqZ07ghlXMyz%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/apic
branch HEAD: cc95a07fef06a2c7917acd827b3a8322772969eb  x86/apic: Reduce cache line misses in __x2apic_send_IPI_mask()

elapsed time: 1146m

configs tested: 177
configs skipped: 120

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211028
powerpc              randconfig-c003-20211028
s390                       zfcpdump_defconfig
powerpc                 mpc8272_ads_defconfig
arc                              alldefconfig
sh                            shmin_defconfig
powerpc                 canyonlands_defconfig
mips                        vocore2_defconfig
powerpc               mpc834x_itxgp_defconfig
m68k                         amcore_defconfig
sh                        apsh4ad0a_defconfig
arm                        magician_defconfig
mips                   sb1250_swarm_defconfig
arc                                 defconfig
mips                  decstation_64_defconfig
sh                        edosk7705_defconfig
arm                       omap2plus_defconfig
powerpc                     redwood_defconfig
m68k                          atari_defconfig
mips                        jmr3927_defconfig
um                           x86_64_defconfig
mips                      fuloong2e_defconfig
arm                           h3600_defconfig
arm                         s5pv210_defconfig
s390                             alldefconfig
xtensa                         virt_defconfig
ia64                          tiger_defconfig
arc                            hsdk_defconfig
arm                         lubbock_defconfig
arc                     nsimosci_hs_defconfig
powerpc                      obs600_defconfig
mips                      bmips_stb_defconfig
arm                             rpc_defconfig
arm                         socfpga_defconfig
mips                      malta_kvm_defconfig
arm                            pleb_defconfig
openrisc                    or1ksim_defconfig
sh                 kfr2r09-romimage_defconfig
sh                         apsh4a3a_defconfig
powerpc                mpc7448_hpc2_defconfig
h8300                            alldefconfig
sh                          lboxre2_defconfig
arm                             pxa_defconfig
sh                          polaris_defconfig
mips                          rm200_defconfig
mips                malta_qemu_32r6_defconfig
m68k                        mvme147_defconfig
arm                         shannon_defconfig
powerpc                     tqm8541_defconfig
mips                             allyesconfig
sh                               j2_defconfig
arm                        multi_v5_defconfig
arm                     davinci_all_defconfig
arm                       aspeed_g5_defconfig
arm                           omap1_defconfig
arm                          lpd270_defconfig
arm                  colibri_pxa300_defconfig
riscv                            alldefconfig
arm                       cns3420vb_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                     kmeter1_defconfig
powerpc                    klondike_defconfig
powerpc                 mpc8560_ads_defconfig
arm                           stm32_defconfig
microblaze                      mmu_defconfig
mips                         tb0287_defconfig
arm                       imx_v4_v5_defconfig
sh                           se7750_defconfig
arm                          pcm027_defconfig
ia64                         bigsur_defconfig
powerpc                    ge_imp3a_defconfig
powerpc                    socrates_defconfig
arm64                            alldefconfig
powerpc                      arches_defconfig
powerpc                     tqm8548_defconfig
arm                  randconfig-c002-20211028
arm                  randconfig-c002-20211029
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
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
s390                                defconfig
parisc                           allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                              debian-10.3
i386                             allyesconfig
arc                              allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20211028
x86_64               randconfig-a004-20211028
x86_64               randconfig-a005-20211028
x86_64               randconfig-a001-20211028
x86_64               randconfig-a006-20211028
x86_64               randconfig-a003-20211028
i386                 randconfig-a004-20211028
i386                 randconfig-a003-20211028
i386                 randconfig-a002-20211028
i386                 randconfig-a006-20211028
i386                 randconfig-a001-20211028
i386                 randconfig-a005-20211028
x86_64               randconfig-a015-20211029
x86_64               randconfig-a013-20211029
x86_64               randconfig-a011-20211029
x86_64               randconfig-a014-20211029
x86_64               randconfig-a012-20211029
x86_64               randconfig-a016-20211029
i386                 randconfig-a012-20211029
i386                 randconfig-a013-20211029
i386                 randconfig-a011-20211029
i386                 randconfig-a015-20211029
i386                 randconfig-a016-20211029
i386                 randconfig-a014-20211029
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
arm                  randconfig-c002-20211028
powerpc              randconfig-c003-20211028
riscv                randconfig-c006-20211028
x86_64               randconfig-c007-20211028
mips                 randconfig-c004-20211028
s390                 randconfig-c005-20211028
i386                 randconfig-c001-20211028
arm                  randconfig-c002-20211029
powerpc              randconfig-c003-20211029
riscv                randconfig-c006-20211029
x86_64               randconfig-c007-20211029
mips                 randconfig-c004-20211029
s390                 randconfig-c005-20211029
i386                 randconfig-c001-20211029
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
hexagon              randconfig-r045-20211029
hexagon              randconfig-r041-20211029
hexagon              randconfig-r045-20211028
riscv                randconfig-r042-20211028
s390                 randconfig-r044-20211028
hexagon              randconfig-r041-20211028

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
