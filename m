Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A95E32AE55
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1838171AbhCBXFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 18:05:41 -0500
Received: from mga02.intel.com ([134.134.136.20]:36116 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2360752AbhCBW1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 17:27:34 -0500
IronPort-SDR: 3CRjPIgJsDTGLStvFZi8ibRt6XRwknKbqR76ba43ht7SNPhx9bbUt2UoU1fbOUrcCX8beoMe9h
 AU4oul0CxorQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="174139775"
X-IronPort-AV: E=Sophos;i="5.81,218,1610438400"; 
   d="scan'208";a="174139775"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 14:26:23 -0800
IronPort-SDR: dma4y0ep2sQI5Y2/W0TEwD3k/DttpqXinksHueTZnyHHgmZEVkaT3d9PMgWopyQ1AaPBDBK4LR
 BDBsyFBz8/Kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,218,1610438400"; 
   d="scan'208";a="406942074"
Received: from lkp-server02.sh.intel.com (HELO 2482ff9f8ac0) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 02 Mar 2021 14:26:20 -0800
Received: from kbuild by 2482ff9f8ac0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lHDTA-0000i1-92; Tue, 02 Mar 2021 22:26:20 +0000
Date:   Wed, 03 Mar 2021 06:25:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/mm] BUILD SUCCESS
 a78eda76b92b81ae3515bcda43a36d671e287c1c
Message-ID: <603ebb6d.xDlG9kfpE7RoeYBV%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/mm
branch HEAD: a78eda76b92b81ae3515bcda43a36d671e287c1c  Merge branch 'locking/core' into x86/mm, to fix conflicts

elapsed time: 722m

configs tested: 119
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                         tb0287_defconfig
sh                          rsk7269_defconfig
arm                            xcep_defconfig
mips                       capcella_defconfig
mips                         tb0226_defconfig
arc                        nsim_700_defconfig
arm                        keystone_defconfig
ia64                             alldefconfig
arm                            mps2_defconfig
arm                    vt8500_v6_v7_defconfig
m68k                        mvme16x_defconfig
powerpc                    klondike_defconfig
powerpc                      pmac32_defconfig
mips                        bcm63xx_defconfig
xtensa                    xip_kc705_defconfig
powerpc                 mpc8272_ads_defconfig
sh                          r7780mp_defconfig
sh                           se7751_defconfig
ia64                                defconfig
mips                     cu1000-neo_defconfig
s390                       zfcpdump_defconfig
sh                      rts7751r2d1_defconfig
sparc                               defconfig
c6x                              alldefconfig
powerpc                      mgcoge_defconfig
mips                           jazz_defconfig
arm                           omap1_defconfig
arm                         mv78xx0_defconfig
riscv             nommu_k210_sdcard_defconfig
powerpc                 mpc837x_mds_defconfig
nios2                         10m50_defconfig
arm                        realview_defconfig
sh                   sh7770_generic_defconfig
arm                         s5pv210_defconfig
openrisc                 simple_smp_defconfig
m68k                        stmark2_defconfig
mips                           ip27_defconfig
m68k                        m5307c3_defconfig
m68k                             allmodconfig
ia64                         bigsur_defconfig
arm                  colibri_pxa270_defconfig
sh                        sh7757lcr_defconfig
arm                            pleb_defconfig
powerpc                     mpc512x_defconfig
m68k                          multi_defconfig
arm                          imote2_defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20210302
x86_64               randconfig-a001-20210302
x86_64               randconfig-a004-20210302
x86_64               randconfig-a002-20210302
x86_64               randconfig-a005-20210302
x86_64               randconfig-a003-20210302
i386                 randconfig-a005-20210302
i386                 randconfig-a003-20210302
i386                 randconfig-a002-20210302
i386                 randconfig-a004-20210302
i386                 randconfig-a006-20210302
i386                 randconfig-a001-20210302
i386                 randconfig-a016-20210302
i386                 randconfig-a012-20210302
i386                 randconfig-a014-20210302
i386                 randconfig-a013-20210302
i386                 randconfig-a011-20210302
i386                 randconfig-a015-20210302
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a013-20210302
x86_64               randconfig-a016-20210302
x86_64               randconfig-a015-20210302
x86_64               randconfig-a014-20210302
x86_64               randconfig-a012-20210302
x86_64               randconfig-a011-20210302

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
