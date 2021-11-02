Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1219E442DA7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 13:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbhKBMSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 08:18:13 -0400
Received: from mga06.intel.com ([134.134.136.31]:56061 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229778AbhKBMSL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 08:18:11 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10155"; a="292080128"
X-IronPort-AV: E=Sophos;i="5.87,202,1631602800"; 
   d="scan'208";a="292080128"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2021 05:15:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,202,1631602800"; 
   d="scan'208";a="599477382"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 02 Nov 2021 05:15:35 -0700
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mhshS-0004VS-Nu; Tue, 02 Nov 2021 12:15:34 +0000
Date:   Tue, 02 Nov 2021 20:15:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu-merge.2021.11.01a] BUILD SUCCESS
 5ebaa2ad1a3afbe6f939cf4c33bf024a4ba9dac7
Message-ID: <61812bd8.DbbKzH1us6e3zyZi%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu-merge.2021.11.01a
branch HEAD: 5ebaa2ad1a3afbe6f939cf4c33bf024a4ba9dac7  Merge commit '9b3c4ab3045e953670c7de9c1165fae5358a7237' into rcu-merge.2021.11.01a

elapsed time: 720m

configs tested: 168
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211101
powerpc                          allyesconfig
powerpc                     powernv_defconfig
arm                        shmobile_defconfig
mips                            ar7_defconfig
powerpc                   currituck_defconfig
powerpc                      bamboo_defconfig
powerpc                      katmai_defconfig
mips                 decstation_r4k_defconfig
powerpc                        icon_defconfig
arc                        nsimosci_defconfig
m68k                        m5307c3_defconfig
mips                           mtx1_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                     ep8248e_defconfig
sh                  sh7785lcr_32bit_defconfig
h8300                       h8s-sim_defconfig
powerpc                 mpc8540_ads_defconfig
csky                                defconfig
powerpc                 mpc837x_mds_defconfig
arm                       spear13xx_defconfig
arm                        mvebu_v7_defconfig
mips                      loongson3_defconfig
mips                      maltasmvp_defconfig
m68k                        stmark2_defconfig
arc                          axs103_defconfig
powerpc                   bluestone_defconfig
arm                          moxart_defconfig
s390                             allmodconfig
riscv                             allnoconfig
powerpc                    sam440ep_defconfig
m68k                          atari_defconfig
arm                            mmp2_defconfig
mips                        jmr3927_defconfig
arm                             ezx_defconfig
arc                        vdk_hs38_defconfig
powerpc                 mpc8272_ads_defconfig
mips                           xway_defconfig
sh                        apsh4ad0a_defconfig
xtensa                  audio_kc705_defconfig
mips                           gcw0_defconfig
arm                           corgi_defconfig
sh                            shmin_defconfig
arm                         s3c2410_defconfig
powerpc                      tqm8xx_defconfig
m68k                          hp300_defconfig
parisc                generic-64bit_defconfig
arm                  colibri_pxa270_defconfig
xtensa                           alldefconfig
s390                          debug_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                      acadia_defconfig
arm                           h5000_defconfig
arc                              alldefconfig
sh                            hp6xx_defconfig
m68k                            q40_defconfig
arm                       aspeed_g5_defconfig
sh                            titan_defconfig
mips                       capcella_defconfig
powerpc                     tqm8548_defconfig
powerpc                      ep88xc_defconfig
arm                           spitz_defconfig
arm                      jornada720_defconfig
ia64                        generic_defconfig
arm                           omap1_defconfig
sh                           sh2007_defconfig
sh                        sh7785lcr_defconfig
m68k                          multi_defconfig
powerpc                    gamecube_defconfig
ia64                            zx1_defconfig
mips                        vocore2_defconfig
sh                           se7780_defconfig
mips                     decstation_defconfig
arm                          ep93xx_defconfig
powerpc                   microwatt_defconfig
s390                             alldefconfig
arm                         orion5x_defconfig
arm                  randconfig-c002-20211101
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
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a012-20211101
x86_64               randconfig-a015-20211101
x86_64               randconfig-a016-20211101
x86_64               randconfig-a013-20211101
x86_64               randconfig-a011-20211101
x86_64               randconfig-a014-20211101
i386                 randconfig-a016-20211101
i386                 randconfig-a014-20211101
i386                 randconfig-a015-20211101
i386                 randconfig-a013-20211101
i386                 randconfig-a011-20211101
i386                 randconfig-a012-20211101
arc                  randconfig-r043-20211101
riscv                randconfig-r042-20211101
s390                 randconfig-r044-20211101
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
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
mips                 randconfig-c004-20211102
arm                  randconfig-c002-20211102
i386                 randconfig-c001-20211102
s390                 randconfig-c005-20211102
powerpc              randconfig-c003-20211102
riscv                randconfig-c006-20211102
x86_64               randconfig-c007-20211102
mips                 randconfig-c004-20211101
arm                  randconfig-c002-20211101
i386                 randconfig-c001-20211101
s390                 randconfig-c005-20211101
powerpc              randconfig-c003-20211101
riscv                randconfig-c006-20211101
x86_64               randconfig-c007-20211101
x86_64               randconfig-a004-20211101
x86_64               randconfig-a006-20211101
x86_64               randconfig-a001-20211101
x86_64               randconfig-a002-20211101
x86_64               randconfig-a003-20211101
x86_64               randconfig-a005-20211101
i386                 randconfig-a005-20211101
i386                 randconfig-a001-20211101
i386                 randconfig-a003-20211101
i386                 randconfig-a004-20211101
i386                 randconfig-a006-20211101
i386                 randconfig-a002-20211101
hexagon              randconfig-r041-20211101
hexagon              randconfig-r045-20211101

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
