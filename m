Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEF3D33FAE0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 23:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbhCQWRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 18:17:43 -0400
Received: from mga03.intel.com ([134.134.136.65]:49265 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229608AbhCQWRW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 18:17:22 -0400
IronPort-SDR: IXL/NgRmhRI4IBfvQrqXRnrycUvH5y5ekbTrP4kG1rhd+VshKyw3wzC4Kam9i3KRIhc+KtlzPv
 LmP11LIECoUA==
X-IronPort-AV: E=McAfee;i="6000,8403,9926"; a="189602548"
X-IronPort-AV: E=Sophos;i="5.81,257,1610438400"; 
   d="scan'208";a="189602548"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2021 15:17:21 -0700
IronPort-SDR: T0ZLvr4+TgvmgtvtCD92EzFtNTI10s/mIkakqn4L7/PR2GH37qq6gcVidN6ZXFllcet9aSq6Mx
 YnQUie/sOrgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,257,1610438400"; 
   d="scan'208";a="433575954"
Received: from lkp-server02.sh.intel.com (HELO 1c294c63cb86) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 17 Mar 2021 15:17:20 -0700
Received: from kbuild by 1c294c63cb86 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lMeTf-0000so-Vc; Wed, 17 Mar 2021 22:17:19 +0000
Date:   Thu, 18 Mar 2021 06:16:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/core] BUILD SUCCESS
 4faf62b1ef1a9367f7dcf8b7ce509980dfdcee83
Message-ID: <60527fcd.yS/J9PuOKu8aRuKL%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
branch HEAD: 4faf62b1ef1a9367f7dcf8b7ce509980dfdcee83  locking/rwsem: Fix comment typo

elapsed time: 722m

configs tested: 187
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
i386                             allyesconfig
riscv                            allyesconfig
nds32                            alldefconfig
arm                      pxa255-idp_defconfig
arm                         lpc32xx_defconfig
sh                     sh7710voipgw_defconfig
powerpc                 mpc8540_ads_defconfig
arm                         at91_dt_defconfig
arc                            hsdk_defconfig
mips                        nlm_xlr_defconfig
sh                              ul2_defconfig
powerpc                    ge_imp3a_defconfig
arm                     am200epdkit_defconfig
powerpc                     skiroot_defconfig
powerpc                     ksi8560_defconfig
sh                           se7721_defconfig
h8300                     edosk2674_defconfig
powerpc                     redwood_defconfig
mips                        qi_lb60_defconfig
powerpc                     taishan_defconfig
powerpc                          allmodconfig
mips                            gpr_defconfig
m68k                       bvme6000_defconfig
powerpc                      acadia_defconfig
arm                          pxa910_defconfig
sh                         ecovec24_defconfig
powerpc                 xes_mpc85xx_defconfig
arm                            mmp2_defconfig
arm                         palmz72_defconfig
arm                          iop32x_defconfig
arm                        neponset_defconfig
powerpc                     kilauea_defconfig
powerpc                      ppc40x_defconfig
sh                        edosk7705_defconfig
mips                         bigsur_defconfig
riscv                            alldefconfig
powerpc                     ep8248e_defconfig
powerpc                     stx_gp3_defconfig
powerpc                        icon_defconfig
powerpc                 mpc832x_mds_defconfig
sh                   secureedge5410_defconfig
arm                          ep93xx_defconfig
mips                         cobalt_defconfig
parisc                generic-64bit_defconfig
powerpc                     asp8347_defconfig
arm                           tegra_defconfig
powerpc                      pmac32_defconfig
mips                           gcw0_defconfig
sh                         apsh4a3a_defconfig
powerpc                         wii_defconfig
powerpc                       eiger_defconfig
mips                       bmips_be_defconfig
m68k                        stmark2_defconfig
mips                           ip28_defconfig
powerpc                    adder875_defconfig
arm                         assabet_defconfig
arc                              alldefconfig
arm                       multi_v4t_defconfig
sh                           se7619_defconfig
arm                          moxart_defconfig
mips                           ip32_defconfig
ia64                         bigsur_defconfig
arm                        multi_v7_defconfig
arm                       imx_v4_v5_defconfig
powerpc                      chrp32_defconfig
mips                     loongson1b_defconfig
h8300                    h8300h-sim_defconfig
sh                        sh7757lcr_defconfig
powerpc                       ebony_defconfig
arm                      footbridge_defconfig
mips                        bcm47xx_defconfig
powerpc                mpc7448_hpc2_defconfig
xtensa                              defconfig
arm                         lpc18xx_defconfig
sh                          lboxre2_defconfig
powerpc                     tqm8541_defconfig
alpha                            alldefconfig
arm                         lubbock_defconfig
ia64                            zx1_defconfig
sh                             espt_defconfig
riscv                             allnoconfig
arc                        nsimosci_defconfig
powerpc                    sam440ep_defconfig
arm                         bcm2835_defconfig
powerpc                 mpc8560_ads_defconfig
arm                          ixp4xx_defconfig
mips                        vocore2_defconfig
powerpc                     mpc5200_defconfig
powerpc                   motionpro_defconfig
nios2                            alldefconfig
mips                           ip27_defconfig
xtensa                       common_defconfig
m68k                                defconfig
m68k                            q40_defconfig
m68k                          atari_defconfig
nios2                         3c120_defconfig
mips                            ar7_defconfig
mips                        maltaup_defconfig
arm                           stm32_defconfig
mips                          ath25_defconfig
powerpc64                        alldefconfig
s390                       zfcpdump_defconfig
microblaze                          defconfig
sh                         ap325rxa_defconfig
sh                          rsk7269_defconfig
powerpc                    socrates_defconfig
mips                           xway_defconfig
m68k                        m5272c3_defconfig
mips                   sb1250_swarm_defconfig
mips                      malta_kvm_defconfig
arm                            lart_defconfig
arm                           spitz_defconfig
sh                  sh7785lcr_32bit_defconfig
arc                         haps_hs_defconfig
arm                         vf610m4_defconfig
xtensa                           alldefconfig
arm                          collie_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
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
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20210317
x86_64               randconfig-a001-20210317
x86_64               randconfig-a005-20210317
x86_64               randconfig-a004-20210317
x86_64               randconfig-a003-20210317
x86_64               randconfig-a002-20210317
i386                 randconfig-a001-20210317
i386                 randconfig-a005-20210317
i386                 randconfig-a002-20210317
i386                 randconfig-a003-20210317
i386                 randconfig-a004-20210317
i386                 randconfig-a006-20210317
i386                 randconfig-a013-20210317
i386                 randconfig-a016-20210317
i386                 randconfig-a011-20210317
i386                 randconfig-a012-20210317
i386                 randconfig-a015-20210317
i386                 randconfig-a014-20210317
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a011-20210317
x86_64               randconfig-a016-20210317
x86_64               randconfig-a013-20210317
x86_64               randconfig-a014-20210317
x86_64               randconfig-a015-20210317
x86_64               randconfig-a012-20210317

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
