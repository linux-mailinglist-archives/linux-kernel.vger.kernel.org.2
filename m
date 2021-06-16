Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD753A9A12
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 14:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbhFPMVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 08:21:45 -0400
Received: from mga02.intel.com ([134.134.136.20]:55094 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229503AbhFPMVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 08:21:44 -0400
IronPort-SDR: L3CgAByTahumH9Hk2QsFf+5dd0rEcswNvJLcIbZGfCMKItzNZ/1GhBNVyKjCOZuYk/RnQ6MOOQ
 YJIdVTgj21Gg==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="193285324"
X-IronPort-AV: E=Sophos;i="5.83,277,1616482800"; 
   d="scan'208";a="193285324"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 05:19:37 -0700
IronPort-SDR: CkdffldyRYGUtj1dZrtjrrCz2kh254UAgmtTGwy/t8OdbpFsIK4RNygwRnYZ/o/6sy/xXfuD0D
 WVV6LI/CLzMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,277,1616482800"; 
   d="scan'208";a="484858976"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 16 Jun 2021 05:19:35 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ltUW7-0001BI-8h; Wed, 16 Jun 2021 12:19:35 +0000
Date:   Wed, 16 Jun 2021 20:18:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rcu/next] BUILD SUCCESS
 1617cca67a6e38397eb47f91bfa5e25e358e427d
Message-ID: <60c9ec2d.mbK+QIPnUzl+9apW%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: 1617cca67a6e38397eb47f91bfa5e25e358e427d  torture: Apply CONFIG_KCSAN_STRICT to kvm.sh --kcsan argument

elapsed time: 727m

configs tested: 157
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                       omap2plus_defconfig
powerpc                    socrates_defconfig
arm                           h3600_defconfig
arm                         s5pv210_defconfig
i386                                defconfig
arm                             ezx_defconfig
powerpc                    ge_imp3a_defconfig
powerpc                   bluestone_defconfig
sh                          r7785rp_defconfig
sh                        sh7785lcr_defconfig
h8300                            allyesconfig
mips                  cavium_octeon_defconfig
arm                          pcm027_defconfig
powerpc                      ppc64e_defconfig
xtensa                  audio_kc705_defconfig
sh                 kfr2r09-romimage_defconfig
mips                        omega2p_defconfig
arm                         lpc32xx_defconfig
powerpc                   currituck_defconfig
um                               alldefconfig
powerpc                  mpc885_ads_defconfig
powerpc                      ep88xc_defconfig
mips                           rs90_defconfig
powerpc                       ppc64_defconfig
sh                             shx3_defconfig
sh                           se7721_defconfig
nds32                               defconfig
powerpc                          g5_defconfig
arm                            hisi_defconfig
xtensa                          iss_defconfig
powerpc                     kmeter1_defconfig
sparc                       sparc32_defconfig
powerpc64                        alldefconfig
mips                 decstation_r4k_defconfig
powerpc                   lite5200b_defconfig
arm                        neponset_defconfig
m68k                         apollo_defconfig
mips                          rm200_defconfig
sh                          sdk7786_defconfig
powerpc                      arches_defconfig
alpha                               defconfig
arm                         s3c2410_defconfig
arm                            zeus_defconfig
m68k                          atari_defconfig
arm                        mvebu_v5_defconfig
ia64                            zx1_defconfig
powerpc                     ksi8560_defconfig
ia64                             alldefconfig
h8300                       h8s-sim_defconfig
arm                           u8500_defconfig
powerpc                       holly_defconfig
powerpc                        fsp2_defconfig
powerpc                     sbc8548_defconfig
s390                             alldefconfig
riscv             nommu_k210_sdcard_defconfig
powerpc                        warp_defconfig
powerpc                     tqm8560_defconfig
powerpc                      ppc44x_defconfig
m68k                          sun3x_defconfig
arm                          exynos_defconfig
sh                           se7343_defconfig
arm                              alldefconfig
s390                          debug_defconfig
powerpc                 mpc832x_mds_defconfig
sparc                       sparc64_defconfig
riscv                          rv32_defconfig
powerpc                 mpc85xx_cds_defconfig
sh                           se7751_defconfig
xtensa                    smp_lx200_defconfig
x86_64                           alldefconfig
mips                       bmips_be_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nios2                            allyesconfig
csky                                defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
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
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a001-20210615
x86_64               randconfig-a004-20210615
x86_64               randconfig-a002-20210615
x86_64               randconfig-a003-20210615
x86_64               randconfig-a006-20210615
x86_64               randconfig-a005-20210615
i386                 randconfig-a002-20210615
i386                 randconfig-a006-20210615
i386                 randconfig-a004-20210615
i386                 randconfig-a001-20210615
i386                 randconfig-a005-20210615
i386                 randconfig-a003-20210615
i386                 randconfig-a015-20210615
i386                 randconfig-a013-20210615
i386                 randconfig-a016-20210615
i386                 randconfig-a012-20210615
i386                 randconfig-a014-20210615
i386                 randconfig-a011-20210615
i386                 randconfig-a015-20210616
i386                 randconfig-a013-20210616
i386                 randconfig-a016-20210616
i386                 randconfig-a012-20210616
i386                 randconfig-a014-20210616
i386                 randconfig-a011-20210616
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210615
x86_64               randconfig-a004-20210616
x86_64               randconfig-a001-20210616
x86_64               randconfig-a002-20210616
x86_64               randconfig-a003-20210616
x86_64               randconfig-a006-20210616
x86_64               randconfig-a005-20210616
x86_64               randconfig-a015-20210615
x86_64               randconfig-a011-20210615
x86_64               randconfig-a012-20210615
x86_64               randconfig-a014-20210615
x86_64               randconfig-a016-20210615
x86_64               randconfig-a013-20210615

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
