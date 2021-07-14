Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C70A3C7AC0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 03:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237223AbhGNBEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 21:04:21 -0400
Received: from mga01.intel.com ([192.55.52.88]:62229 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237180AbhGNBEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 21:04:20 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10044"; a="232073425"
X-IronPort-AV: E=Sophos;i="5.84,237,1620716400"; 
   d="scan'208";a="232073425"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2021 18:01:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,237,1620716400"; 
   d="scan'208";a="654586949"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 13 Jul 2021 18:01:28 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m3THE-000IJU-3V; Wed, 14 Jul 2021 01:01:28 +0000
Date:   Wed, 14 Jul 2021 09:01:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:auto-latest] BUILD SUCCESS
 dd9ced4003dd74bdd5a59f005b7ad34fb2d02226
Message-ID: <60ee3757.FPALmJ8mDslgmjs5%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git auto-latest
branch HEAD: dd9ced4003dd74bdd5a59f005b7ad34fb2d02226  Merge branch 'core/urgent'

elapsed time: 720m

configs tested: 140
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
sh                           se7705_defconfig
riscv                    nommu_k210_defconfig
mips                           gcw0_defconfig
powerpc                    amigaone_defconfig
mips                           ip32_defconfig
arm                              alldefconfig
arm                    vt8500_v6_v7_defconfig
arm                       netwinder_defconfig
xtensa                           alldefconfig
sh                            migor_defconfig
powerpc                      tqm8xx_defconfig
openrisc                         alldefconfig
powerpc                      mgcoge_defconfig
arm                         lubbock_defconfig
arm                           spitz_defconfig
mips                           ip28_defconfig
sh                           se7751_defconfig
arm                         palmz72_defconfig
powerpc                     skiroot_defconfig
arm                         nhk8815_defconfig
arm                         shannon_defconfig
powerpc                      pasemi_defconfig
sh                          r7780mp_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                          lpd270_defconfig
powerpc                    adder875_defconfig
m68k                        m5272c3_defconfig
h8300                            alldefconfig
mips                          ath79_defconfig
powerpc                 mpc834x_mds_defconfig
mips                     loongson1b_defconfig
ia64                                defconfig
arm                             mxs_defconfig
mips                     cu1000-neo_defconfig
powerpc                     kmeter1_defconfig
powerpc                 mpc8315_rdb_defconfig
s390                       zfcpdump_defconfig
powerpc                     tqm5200_defconfig
arm                         vf610m4_defconfig
sh                  sh7785lcr_32bit_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                    klondike_defconfig
m68k                       m5249evb_defconfig
powerpc                      ppc40x_defconfig
arm                           viper_defconfig
arm                         bcm2835_defconfig
sh                ecovec24-romimage_defconfig
sparc                            alldefconfig
powerpc                      bamboo_defconfig
arm                        oxnas_v6_defconfig
arm                         orion5x_defconfig
arm                        mvebu_v5_defconfig
arm                   milbeaut_m10v_defconfig
openrisc                 simple_smp_defconfig
powerpc                    socrates_defconfig
mips                      fuloong2e_defconfig
mips                         db1xxx_defconfig
sh                        dreamcast_defconfig
arm                            mps2_defconfig
mips                         bigsur_defconfig
m68k                        m5407c3_defconfig
powerpc                      cm5200_defconfig
powerpc                       holly_defconfig
mips                 decstation_r4k_defconfig
ia64                             allmodconfig
ia64                             allyesconfig
x86_64                            allnoconfig
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
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20210713
i386                 randconfig-a004-20210713
i386                 randconfig-a006-20210713
i386                 randconfig-a001-20210713
i386                 randconfig-a002-20210713
i386                 randconfig-a003-20210713
x86_64               randconfig-a013-20210713
x86_64               randconfig-a014-20210713
x86_64               randconfig-a012-20210713
x86_64               randconfig-a015-20210713
x86_64               randconfig-a016-20210713
x86_64               randconfig-a011-20210713
i386                 randconfig-a015-20210713
i386                 randconfig-a014-20210713
i386                 randconfig-a011-20210713
i386                 randconfig-a013-20210713
i386                 randconfig-a012-20210713
i386                 randconfig-a016-20210713
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210713
x86_64               randconfig-a005-20210713
x86_64               randconfig-a004-20210713
x86_64               randconfig-a003-20210713
x86_64               randconfig-a002-20210713
x86_64               randconfig-a006-20210713
x86_64               randconfig-a001-20210713

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
