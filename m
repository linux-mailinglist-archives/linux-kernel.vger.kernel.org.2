Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3E7334E5D0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 12:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbhC3Kwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 06:52:44 -0400
Received: from mga17.intel.com ([192.55.52.151]:30935 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231749AbhC3Kwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 06:52:31 -0400
IronPort-SDR: kLNd0QQ57LodFRtLiQGqlFbQ/JCCfFt1zBnl8UeuqHDPwOeVmenhmODWv/Zcaiq0yzw0WIe0WJ
 2NxgdAOU6UKA==
X-IronPort-AV: E=McAfee;i="6000,8403,9938"; a="171760091"
X-IronPort-AV: E=Sophos;i="5.81,290,1610438400"; 
   d="scan'208";a="171760091"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 03:52:30 -0700
IronPort-SDR: oYcoW620DWKKBN/2Q4Tyns6WetBaWYMV4jWqaM1IM9iUEUzNcWlRbSu2bDFIk1Xo+RIN4Xegsa
 F545qXNvnCgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,290,1610438400"; 
   d="scan'208";a="376796209"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 30 Mar 2021 03:52:29 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lRBz2-0005Er-99; Tue, 30 Mar 2021 10:52:28 +0000
Date:   Tue, 30 Mar 2021 18:51:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/apic] BUILD SUCCESS
 9a98bc2cf08a095367449b3548c3d9ad4ad2cd20
Message-ID: <606302bd.WD2S0mLBDovqnmb4%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/apic
branch HEAD: 9a98bc2cf08a095367449b3548c3d9ad4ad2cd20  x86/vector: Add a sanity check to prevent IRQ2 allocations

elapsed time: 728m

configs tested: 170
configs skipped: 66

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
powerpc                     sequoia_defconfig
powerpc                    gamecube_defconfig
xtensa                          iss_defconfig
powerpc                 mpc834x_mds_defconfig
m68k                       m5208evb_defconfig
powerpc                 mpc832x_mds_defconfig
arm                         vf610m4_defconfig
arm                        cerfcube_defconfig
arm                          lpd270_defconfig
m68k                        stmark2_defconfig
powerpc                      pasemi_defconfig
xtensa                  audio_kc705_defconfig
arm                        magician_defconfig
arm                       spear13xx_defconfig
powerpc                           allnoconfig
nios2                         3c120_defconfig
sh                          polaris_defconfig
sh                 kfr2r09-romimage_defconfig
mips                        maltaup_defconfig
arc                     nsimosci_hs_defconfig
mips                   sb1250_swarm_defconfig
arc                        vdk_hs38_defconfig
mips                       capcella_defconfig
arm                         lubbock_defconfig
powerpc                       ppc64_defconfig
arm                           h5000_defconfig
arm                         orion5x_defconfig
powerpc                    klondike_defconfig
mips                      loongson3_defconfig
xtensa                  cadence_csp_defconfig
powerpc                 mpc836x_mds_defconfig
mips                             allyesconfig
powerpc                      chrp32_defconfig
sh                                  defconfig
arm                            qcom_defconfig
arm                           sama5_defconfig
arc                        nsim_700_defconfig
mips                          ath25_defconfig
xtensa                generic_kc705_defconfig
arm                         lpc18xx_defconfig
powerpc                     rainier_defconfig
um                                  defconfig
arm                         shannon_defconfig
powerpc                     akebono_defconfig
arm                         socfpga_defconfig
m68k                          atari_defconfig
arc                    vdk_hs38_smp_defconfig
sparc64                             defconfig
arm                         hackkit_defconfig
m68k                             alldefconfig
parisc                generic-64bit_defconfig
riscv                    nommu_virt_defconfig
alpha                               defconfig
arc                          axs101_defconfig
mips                           xway_defconfig
arm                      pxa255-idp_defconfig
powerpc                 canyonlands_defconfig
sh                               alldefconfig
sh                          r7780mp_defconfig
arm                        spear6xx_defconfig
arc                         haps_hs_defconfig
mips                          malta_defconfig
arm                         cm_x300_defconfig
arm                      footbridge_defconfig
arm                          iop32x_defconfig
mips                      pistachio_defconfig
s390                       zfcpdump_defconfig
arm                      tct_hammer_defconfig
x86_64                           alldefconfig
m68k                        mvme147_defconfig
powerpc                 mpc836x_rdk_defconfig
nios2                            alldefconfig
arm                          collie_defconfig
arm                             pxa_defconfig
alpha                            alldefconfig
powerpc                    mvme5100_defconfig
powerpc                      acadia_defconfig
sh                           se7343_defconfig
arm                           tegra_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                                defconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a004-20210330
x86_64               randconfig-a003-20210330
x86_64               randconfig-a002-20210330
x86_64               randconfig-a001-20210330
x86_64               randconfig-a005-20210330
x86_64               randconfig-a006-20210330
x86_64               randconfig-a002-20210329
x86_64               randconfig-a003-20210329
x86_64               randconfig-a006-20210329
x86_64               randconfig-a001-20210329
x86_64               randconfig-a005-20210329
x86_64               randconfig-a004-20210329
i386                 randconfig-a004-20210330
i386                 randconfig-a006-20210330
i386                 randconfig-a003-20210330
i386                 randconfig-a002-20210330
i386                 randconfig-a001-20210330
i386                 randconfig-a005-20210330
i386                 randconfig-a003-20210329
i386                 randconfig-a004-20210329
i386                 randconfig-a002-20210329
i386                 randconfig-a006-20210329
i386                 randconfig-a005-20210329
i386                 randconfig-a001-20210329
i386                 randconfig-a014-20210329
i386                 randconfig-a011-20210329
i386                 randconfig-a015-20210329
i386                 randconfig-a016-20210329
i386                 randconfig-a013-20210329
i386                 randconfig-a012-20210329
i386                 randconfig-a015-20210330
i386                 randconfig-a011-20210330
i386                 randconfig-a014-20210330
i386                 randconfig-a013-20210330
i386                 randconfig-a016-20210330
i386                 randconfig-a012-20210330
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a012-20210330
x86_64               randconfig-a015-20210330
x86_64               randconfig-a014-20210330
x86_64               randconfig-a016-20210330
x86_64               randconfig-a013-20210330
x86_64               randconfig-a011-20210330

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
