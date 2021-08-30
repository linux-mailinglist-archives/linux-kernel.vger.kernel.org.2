Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3782E3FB1ED
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 09:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233830AbhH3HbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 03:31:19 -0400
Received: from mga03.intel.com ([134.134.136.65]:7720 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233318AbhH3HbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 03:31:17 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10091"; a="218266452"
X-IronPort-AV: E=Sophos;i="5.84,362,1620716400"; 
   d="scan'208";a="218266452"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2021 00:30:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,362,1620716400"; 
   d="scan'208";a="459196497"
Received: from lkp-server01.sh.intel.com (HELO 4fbc2b3ce5aa) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 30 Aug 2021 00:30:21 -0700
Received: from kbuild by 4fbc2b3ce5aa with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mKbkL-0004xM-0p; Mon, 30 Aug 2021 07:30:21 +0000
Date:   Mon, 30 Aug 2021 15:30:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD SUCCESS
 47fb0cfdb7a71a8a0ff8fe1d117363dc81f6ca77
Message-ID: <612c8900.6LKOWI2XHLKc+qvd%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
branch HEAD: 47fb0cfdb7a71a8a0ff8fe1d117363dc81f6ca77  Merge tag 'irqchip-5.15' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/core

elapsed time: 725m

configs tested: 125
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210829
mips                        qi_lb60_defconfig
sparc64                          alldefconfig
arm                          iop32x_defconfig
sh                           sh2007_defconfig
arm                          ixp4xx_defconfig
powerpc                    sam440ep_defconfig
alpha                            alldefconfig
m68k                            q40_defconfig
arm                         mv78xx0_defconfig
arm                          simpad_defconfig
arm                          collie_defconfig
mips                         tb0219_defconfig
powerpc                 mpc8272_ads_defconfig
arm                           sunxi_defconfig
sh                          r7780mp_defconfig
arm                          badge4_defconfig
mips                  decstation_64_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                 mpc8315_rdb_defconfig
um                           x86_64_defconfig
openrisc                            defconfig
arm                         vf610m4_defconfig
xtensa                          iss_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                   rts7751r2dplus_defconfig
sh                        edosk7760_defconfig
powerpc                  storcenter_defconfig
powerpc                          allmodconfig
s390                                defconfig
powerpc                      makalu_defconfig
powerpc                     powernv_defconfig
m68k                        m5307c3_defconfig
powerpc                mpc7448_hpc2_defconfig
mips                         tb0226_defconfig
sh                           se7780_defconfig
nios2                               defconfig
mips                           jazz_defconfig
powerpc                    gamecube_defconfig
powerpc                     mpc512x_defconfig
mips                         rt305x_defconfig
arc                     haps_hs_smp_defconfig
arm                        shmobile_defconfig
mips                           rs90_defconfig
arm                            hisi_defconfig
x86_64                              defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
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
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
x86_64               randconfig-a014-20210829
x86_64               randconfig-a016-20210829
x86_64               randconfig-a015-20210829
x86_64               randconfig-a012-20210829
x86_64               randconfig-a013-20210829
x86_64               randconfig-a011-20210829
i386                 randconfig-a011-20210829
i386                 randconfig-a016-20210829
i386                 randconfig-a012-20210829
i386                 randconfig-a014-20210829
i386                 randconfig-a013-20210829
i386                 randconfig-a015-20210829
arc                  randconfig-r043-20210829
riscv                randconfig-r042-20210829
s390                 randconfig-r044-20210829
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
s390                 randconfig-c005-20210829
i386                 randconfig-c001-20210829
arm                  randconfig-c002-20210829
riscv                randconfig-c006-20210829
x86_64               randconfig-c007-20210829
powerpc              randconfig-c003-20210829
mips                 randconfig-c004-20210829
x86_64               randconfig-a001-20210829
x86_64               randconfig-a006-20210829
x86_64               randconfig-a005-20210829
x86_64               randconfig-a003-20210829
x86_64               randconfig-a004-20210829
x86_64               randconfig-a002-20210829
i386                 randconfig-a001-20210829
i386                 randconfig-a006-20210829
i386                 randconfig-a005-20210829
i386                 randconfig-a004-20210829
i386                 randconfig-a003-20210829

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
