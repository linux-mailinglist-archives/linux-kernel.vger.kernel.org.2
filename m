Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD82B3BE5B8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 11:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbhGGJkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 05:40:31 -0400
Received: from mga07.intel.com ([134.134.136.100]:20659 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230502AbhGGJka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 05:40:30 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10037"; a="273116192"
X-IronPort-AV: E=Sophos;i="5.83,331,1616482800"; 
   d="scan'208";a="273116192"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2021 02:37:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,331,1616482800"; 
   d="scan'208";a="410492209"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 07 Jul 2021 02:37:44 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m13zz-000DVi-NL; Wed, 07 Jul 2021 09:37:43 +0000
Date:   Wed, 07 Jul 2021 17:37:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:for-next/kspp] BUILD SUCCESS
 f1469e568bf6dcbdff9fd7cd7d2cc9ca9d06efeb
Message-ID: <60e575c3.EwHKGJn3ukxM6A+H%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git for-next/kspp
branch HEAD: f1469e568bf6dcbdff9fd7cd7d2cc9ca9d06efeb  Input: Fix fall-through warning for Clang

elapsed time: 721m

configs tested: 145
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm64                               defconfig
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                       maple_defconfig
mips                        omega2p_defconfig
arm                            hisi_defconfig
xtensa                           alldefconfig
sh                           se7721_defconfig
sh                          rsk7203_defconfig
powerpc                 xes_mpc85xx_defconfig
arm                           h5000_defconfig
h8300                            alldefconfig
m68k                       bvme6000_defconfig
powerpc                     tqm8560_defconfig
sh                        sh7757lcr_defconfig
powerpc                 mpc85xx_cds_defconfig
sh                           se7206_defconfig
ia64                      gensparse_defconfig
powerpc                    ge_imp3a_defconfig
xtensa                       common_defconfig
arm                      jornada720_defconfig
sh                      rts7751r2d1_defconfig
powerpc                     sequoia_defconfig
arm                           spitz_defconfig
powerpc                     skiroot_defconfig
s390                                defconfig
arm                          moxart_defconfig
powerpc                      walnut_defconfig
sh                          sdk7780_defconfig
m68k                          atari_defconfig
xtensa                  cadence_csp_defconfig
sh                               alldefconfig
arm                            pleb_defconfig
alpha                               defconfig
sh                            shmin_defconfig
sh                          polaris_defconfig
mips                      fuloong2e_defconfig
mips                          malta_defconfig
arm                      integrator_defconfig
arc                          axs101_defconfig
sh                          landisk_defconfig
sh                           se7724_defconfig
powerpc                     pseries_defconfig
powerpc                 canyonlands_defconfig
powerpc                       ppc64_defconfig
arm                        vexpress_defconfig
powerpc                         wii_defconfig
powerpc                        icon_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                   motionpro_defconfig
sh                           se7750_defconfig
microblaze                      mmu_defconfig
m68k                        stmark2_defconfig
sh                           se7722_defconfig
m68k                        m5407c3_defconfig
powerpc                    klondike_defconfig
arm                      pxa255-idp_defconfig
mips                        nlm_xlp_defconfig
m68k                          amiga_defconfig
sh                ecovec24-romimage_defconfig
arm                           omap1_defconfig
mips                         mpc30x_defconfig
arm                        multi_v5_defconfig
parisc                              defconfig
arm                          pcm027_defconfig
mips                          rb532_defconfig
arm                         lpc32xx_defconfig
nds32                            alldefconfig
mips                          rm200_defconfig
sh                         microdev_defconfig
powerpc                          g5_defconfig
arm                        mvebu_v7_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20210706
i386                 randconfig-a006-20210706
i386                 randconfig-a001-20210706
i386                 randconfig-a003-20210706
i386                 randconfig-a005-20210706
i386                 randconfig-a002-20210706
x86_64               randconfig-a015-20210706
x86_64               randconfig-a014-20210706
x86_64               randconfig-a012-20210706
x86_64               randconfig-a011-20210706
x86_64               randconfig-a016-20210706
x86_64               randconfig-a013-20210706
i386                 randconfig-a015-20210706
i386                 randconfig-a016-20210706
i386                 randconfig-a012-20210706
i386                 randconfig-a011-20210706
i386                 randconfig-a014-20210706
i386                 randconfig-a013-20210706
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
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210706
x86_64               randconfig-a002-20210706
x86_64               randconfig-a003-20210706
x86_64               randconfig-a001-20210706
x86_64               randconfig-a004-20210706
x86_64               randconfig-a005-20210706
x86_64               randconfig-a006-20210706

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
