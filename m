Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D776B3EAD08
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 00:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238161AbhHLWTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 18:19:35 -0400
Received: from mga14.intel.com ([192.55.52.115]:41558 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229471AbhHLWTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 18:19:30 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10074"; a="215189897"
X-IronPort-AV: E=Sophos;i="5.84,317,1620716400"; 
   d="scan'208";a="215189897"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2021 15:19:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,317,1620716400"; 
   d="scan'208";a="676973081"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 12 Aug 2021 15:19:03 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mEJ2U-000N3l-EP; Thu, 12 Aug 2021 22:19:02 +0000
Date:   Fri, 13 Aug 2021 06:18:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/misc] BUILD SUCCESS
 a729691b541f6e63043beae72e635635abe5dc09
Message-ID: <61159e48.FC7q/hi23JwugX3a%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/misc
branch HEAD: a729691b541f6e63043beae72e635635abe5dc09  x86/reboot: Limit Dell Optiplex 990 quirk to early BIOS versions

elapsed time: 724m

configs tested: 144
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210812
arm                    vt8500_v6_v7_defconfig
openrisc                            defconfig
powerpc                     taishan_defconfig
ia64                             alldefconfig
powerpc                     ppa8548_defconfig
ia64                             allmodconfig
arm                       aspeed_g5_defconfig
mips                        omega2p_defconfig
powerpc                        warp_defconfig
powerpc                     stx_gp3_defconfig
xtensa                  nommu_kc705_defconfig
m68k                          hp300_defconfig
sh                         apsh4a3a_defconfig
powerpc                   lite5200b_defconfig
powerpc                        fsp2_defconfig
powerpc                 canyonlands_defconfig
arm                        mvebu_v5_defconfig
xtensa                       common_defconfig
sh                            hp6xx_defconfig
powerpc                     tqm8560_defconfig
sh                        sh7785lcr_defconfig
sh                   sh7724_generic_defconfig
powerpc                 mpc8540_ads_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                          simpad_defconfig
m68k                       m5208evb_defconfig
x86_64                           alldefconfig
powerpc                     pseries_defconfig
mips                            gpr_defconfig
mips                      maltaaprp_defconfig
m68k                        mvme147_defconfig
mips                         tb0226_defconfig
mips                  decstation_64_defconfig
mips                        bcm63xx_defconfig
arm                      jornada720_defconfig
sh                          polaris_defconfig
arc                            hsdk_defconfig
sh                        sh7757lcr_defconfig
sh                           se7780_defconfig
s390                          debug_defconfig
openrisc                  or1klitex_defconfig
arc                    vdk_hs38_smp_defconfig
csky                                defconfig
mips                           ip32_defconfig
xtensa                              defconfig
arm                         socfpga_defconfig
mips                      malta_kvm_defconfig
arm                            hisi_defconfig
x86_64                            allnoconfig
m68k                        m5272c3_defconfig
m68k                                defconfig
sh                          landisk_defconfig
arm                             mxs_defconfig
mips                           ci20_defconfig
mips                           ip22_defconfig
powerpc                   motionpro_defconfig
mips                     decstation_defconfig
powerpc64                           defconfig
arm                           stm32_defconfig
arm                      integrator_defconfig
alpha                            alldefconfig
powerpc                       ebony_defconfig
mips                            ar7_defconfig
arm                        oxnas_v6_defconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
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
x86_64               randconfig-a006-20210812
x86_64               randconfig-a004-20210812
x86_64               randconfig-a003-20210812
x86_64               randconfig-a005-20210812
x86_64               randconfig-a002-20210812
x86_64               randconfig-a001-20210812
i386                 randconfig-a004-20210812
i386                 randconfig-a003-20210812
i386                 randconfig-a002-20210812
i386                 randconfig-a001-20210812
i386                 randconfig-a006-20210812
i386                 randconfig-a005-20210812
i386                 randconfig-a004-20210811
i386                 randconfig-a001-20210811
i386                 randconfig-a002-20210811
i386                 randconfig-a003-20210811
i386                 randconfig-a006-20210811
i386                 randconfig-a005-20210811
i386                 randconfig-a011-20210812
i386                 randconfig-a015-20210812
i386                 randconfig-a013-20210812
i386                 randconfig-a014-20210812
i386                 randconfig-a016-20210812
i386                 randconfig-a012-20210812
riscv                    nommu_k210_defconfig
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
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c001-20210812
x86_64               randconfig-a011-20210812
x86_64               randconfig-a013-20210812
x86_64               randconfig-a012-20210812
x86_64               randconfig-a016-20210812
x86_64               randconfig-a015-20210812
x86_64               randconfig-a014-20210812

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
