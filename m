Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4CE93BF143
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 23:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbhGGVOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 17:14:08 -0400
Received: from mga03.intel.com ([134.134.136.65]:4322 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231493AbhGGVOB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 17:14:01 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10037"; a="209428757"
X-IronPort-AV: E=Sophos;i="5.84,221,1620716400"; 
   d="scan'208";a="209428757"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2021 14:11:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,221,1620716400"; 
   d="scan'208";a="628152124"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 07 Jul 2021 14:11:19 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m1EpC-000Dnz-Kg; Wed, 07 Jul 2021 21:11:18 +0000
Date:   Thu, 08 Jul 2021 05:11:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 5a9105c89dc34600c63d043bbc3636d45fad5d75
Message-ID: <60e61874.yLLzvQN1KqRep6sJ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 5a9105c89dc34600c63d043bbc3636d45fad5d75  Merge branch 'locking/urgent'

elapsed time: 726m

configs tested: 137
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                      arches_defconfig
arm                          pcm027_defconfig
powerpc                       holly_defconfig
m68k                       bvme6000_defconfig
sh                             shx3_defconfig
riscv                    nommu_k210_defconfig
parisc                           alldefconfig
arm                            lart_defconfig
sh                         ecovec24_defconfig
sh                           se7721_defconfig
sh                      rts7751r2d1_defconfig
powerpc                     sequoia_defconfig
arm                           spitz_defconfig
powerpc                     skiroot_defconfig
s390                                defconfig
mips                         tb0219_defconfig
powerpc                    amigaone_defconfig
x86_64                           alldefconfig
m68k                       m5275evb_defconfig
arm                             ezx_defconfig
arm                         bcm2835_defconfig
mips                        qi_lb60_defconfig
mips                           rs90_defconfig
openrisc                 simple_smp_defconfig
arm                         orion5x_defconfig
powerpc                   bluestone_defconfig
mips                          rb532_defconfig
sh                              ul2_defconfig
mips                      maltaaprp_defconfig
sh                          lboxre2_defconfig
arc                        vdk_hs38_defconfig
powerpc                 mpc8272_ads_defconfig
arm                      tct_hammer_defconfig
sparc                               defconfig
sh                           se7343_defconfig
sh                           se7206_defconfig
arc                           tb10x_defconfig
sh                   rts7751r2dplus_defconfig
riscv                          rv32_defconfig
powerpc                     ppa8548_defconfig
m68k                             allyesconfig
mips                  maltasmvp_eva_defconfig
mips                            ar7_defconfig
arm                            xcep_defconfig
arm                       multi_v4t_defconfig
mips                           ip27_defconfig
powerpc               mpc834x_itxgp_defconfig
m68k                          amiga_defconfig
arm                       netwinder_defconfig
powerpc                   currituck_defconfig
powerpc                           allnoconfig
mips                         rt305x_defconfig
xtensa                generic_kc705_defconfig
sh                           se7751_defconfig
arm                       versatile_defconfig
m68k                        stmark2_defconfig
arc                              allyesconfig
um                             i386_defconfig
arm                      footbridge_defconfig
mips                       rbtx49xx_defconfig
sh                        apsh4ad0a_defconfig
arm                         lpc32xx_defconfig
xtensa                           alldefconfig
mips                malta_qemu_32r6_defconfig
powerpc                      cm5200_defconfig
powerpc                          g5_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
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
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a004-20210707
x86_64               randconfig-a002-20210707
x86_64               randconfig-a005-20210707
x86_64               randconfig-a006-20210707
x86_64               randconfig-a003-20210707
x86_64               randconfig-a001-20210707
i386                 randconfig-a004-20210707
i386                 randconfig-a006-20210707
i386                 randconfig-a001-20210707
i386                 randconfig-a003-20210707
i386                 randconfig-a005-20210707
i386                 randconfig-a002-20210707
i386                 randconfig-a015-20210707
i386                 randconfig-a016-20210707
i386                 randconfig-a012-20210707
i386                 randconfig-a011-20210707
i386                 randconfig-a014-20210707
i386                 randconfig-a013-20210707
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210707
x86_64               randconfig-a015-20210707
x86_64               randconfig-a014-20210707
x86_64               randconfig-a012-20210707
x86_64               randconfig-a011-20210707
x86_64               randconfig-a016-20210707
x86_64               randconfig-a013-20210707

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
