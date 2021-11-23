Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B157A45B07B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 00:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239920AbhKWXyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 18:54:07 -0500
Received: from mga07.intel.com ([134.134.136.100]:32704 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232735AbhKWXyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 18:54:06 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10177"; a="298570180"
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="298570180"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 15:50:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="674668095"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 23 Nov 2021 15:50:56 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mpfYt-0002TH-St; Tue, 23 Nov 2021 23:50:55 +0000
Date:   Wed, 24 Nov 2021 07:49:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 8c92606ab81086db00cbb73347d124b4eb169b7e
Message-ID: <619d7e20.iblIsvuXb13ffoVN%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: 8c92606ab81086db00cbb73347d124b4eb169b7e  sched/cpuacct: Make user/system times in cpuacct.stat more precise

elapsed time: 723m

configs tested: 198
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211123
sh                      rts7751r2d1_defconfig
sh                        apsh4ad0a_defconfig
arm                         vf610m4_defconfig
powerpc                     mpc83xx_defconfig
mips                         rt305x_defconfig
arm                         at91_dt_defconfig
arm                        mvebu_v5_defconfig
riscv                    nommu_virt_defconfig
powerpc                       eiger_defconfig
sh                           se7722_defconfig
mips                      fuloong2e_defconfig
powerpc                      bamboo_defconfig
mips                          ath25_defconfig
sh                             shx3_defconfig
powerpc                 mpc836x_mds_defconfig
sh                           se7705_defconfig
powerpc                    adder875_defconfig
mips                        maltaup_defconfig
sparc                       sparc64_defconfig
sparc64                          alldefconfig
mips                           gcw0_defconfig
arm                          pxa3xx_defconfig
powerpc                 linkstation_defconfig
arm                        magician_defconfig
sh                           se7343_defconfig
ia64                             alldefconfig
arm                           stm32_defconfig
xtensa                       common_defconfig
sh                         ecovec24_defconfig
m68k                        stmark2_defconfig
powerpc                     pq2fads_defconfig
powerpc                      pasemi_defconfig
mips                            ar7_defconfig
sh                          lboxre2_defconfig
h8300                     edosk2674_defconfig
arm                         hackkit_defconfig
m68k                            q40_defconfig
arc                            hsdk_defconfig
mips                       capcella_defconfig
mips                     cu1830-neo_defconfig
nios2                         3c120_defconfig
m68k                       m5249evb_defconfig
xtensa                    smp_lx200_defconfig
powerpc                     tqm8555_defconfig
arm                          badge4_defconfig
nds32                            alldefconfig
powerpc                      pcm030_defconfig
m68k                       m5475evb_defconfig
m68k                       bvme6000_defconfig
riscv             nommu_k210_sdcard_defconfig
powerpc                       ebony_defconfig
openrisc                            defconfig
arc                        nsim_700_defconfig
powerpc                      acadia_defconfig
arm                         orion5x_defconfig
sh                          rsk7264_defconfig
mips                          rm200_defconfig
mips                           xway_defconfig
parisc                generic-32bit_defconfig
powerpc                     kmeter1_defconfig
powerpc                      walnut_defconfig
powerpc64                           defconfig
ia64                            zx1_defconfig
sh                              ul2_defconfig
mips                     decstation_defconfig
mips                      pic32mzda_defconfig
powerpc                      arches_defconfig
arm                         s3c2410_defconfig
powerpc                     kilauea_defconfig
arm                         cm_x300_defconfig
powerpc                      chrp32_defconfig
mips                     loongson2k_defconfig
powerpc                   lite5200b_defconfig
arm                          pcm027_defconfig
arm                           h5000_defconfig
powerpc                    ge_imp3a_defconfig
ia64                          tiger_defconfig
mips                       rbtx49xx_defconfig
arm                  colibri_pxa270_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                      ppc64e_defconfig
openrisc                 simple_smp_defconfig
arm                         axm55xx_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                     pseries_defconfig
arm                        oxnas_v6_defconfig
arm                       mainstone_defconfig
powerpc                        warp_defconfig
powerpc                mpc7448_hpc2_defconfig
arm                          pxa168_defconfig
sh                          r7785rp_defconfig
ia64                        generic_defconfig
powerpc                   currituck_defconfig
riscv                          rv32_defconfig
sh                           se7750_defconfig
arm                        realview_defconfig
powerpc                     stx_gp3_defconfig
um                                  defconfig
sh                   rts7751r2dplus_defconfig
arc                        vdk_hs38_defconfig
powerpc                     redwood_defconfig
sh                         apsh4a3a_defconfig
arm                       cns3420vb_defconfig
powerpc                          g5_defconfig
s390                       zfcpdump_defconfig
mips                           mtx1_defconfig
arm                            xcep_defconfig
mips                       bmips_be_defconfig
mips                           ip32_defconfig
arc                     nsimosci_hs_defconfig
mips                      maltaaprp_defconfig
arm                              alldefconfig
arm                  randconfig-c002-20211123
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
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
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
x86_64               randconfig-a001-20211123
x86_64               randconfig-a003-20211123
x86_64               randconfig-a006-20211123
x86_64               randconfig-a004-20211123
x86_64               randconfig-a005-20211123
x86_64               randconfig-a002-20211123
i386                 randconfig-a001-20211123
i386                 randconfig-a002-20211123
i386                 randconfig-a005-20211123
i386                 randconfig-a006-20211123
i386                 randconfig-a004-20211123
i386                 randconfig-a003-20211123
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
s390                 randconfig-c005-20211123
i386                 randconfig-c001-20211123
powerpc              randconfig-c003-20211123
arm                  randconfig-c002-20211123
riscv                randconfig-c006-20211123
x86_64               randconfig-c007-20211123
mips                 randconfig-c004-20211123
x86_64               randconfig-a014-20211123
x86_64               randconfig-a011-20211123
x86_64               randconfig-a012-20211123
x86_64               randconfig-a016-20211123
x86_64               randconfig-a013-20211123
x86_64               randconfig-a015-20211123
i386                 randconfig-a016-20211123
i386                 randconfig-a015-20211123
i386                 randconfig-a012-20211123
i386                 randconfig-a013-20211123
i386                 randconfig-a014-20211123
i386                 randconfig-a011-20211123
hexagon              randconfig-r045-20211123
s390                 randconfig-r044-20211123
hexagon              randconfig-r041-20211123
riscv                randconfig-r042-20211123

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
