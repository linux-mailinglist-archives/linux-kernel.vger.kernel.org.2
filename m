Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66E5E3D982C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 00:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbhG1WJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 18:09:13 -0400
Received: from mga14.intel.com ([192.55.52.115]:43875 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232059AbhG1WJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 18:09:13 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10059"; a="212485285"
X-IronPort-AV: E=Sophos;i="5.84,276,1620716400"; 
   d="scan'208";a="212485285"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2021 15:09:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,276,1620716400"; 
   d="scan'208";a="666092649"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 28 Jul 2021 15:09:09 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m8rjh-0008iO-0Q; Wed, 28 Jul 2021 22:09:09 +0000
Date:   Thu, 29 Jul 2021 06:08:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cpu] BUILD SUCCESS
 b7fe54f6c2d437082dcbecfbd832f38edd9caaf4
Message-ID: <6101d573.pBdgKKuC4Kfkb4w+%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cpu
branch HEAD: b7fe54f6c2d437082dcbecfbd832f38edd9caaf4  Documentation: Add L1D flushing Documentation

elapsed time: 726m

configs tested: 130
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210728
h8300                       h8s-sim_defconfig
powerpc                   bluestone_defconfig
um                             i386_defconfig
powerpc                         ps3_defconfig
powerpc                      chrp32_defconfig
sparc64                          alldefconfig
mips                       rbtx49xx_defconfig
m68k                            mac_defconfig
sh                     sh7710voipgw_defconfig
mips                           ip28_defconfig
arm                           spitz_defconfig
arm                         palmz72_defconfig
sh                           sh2007_defconfig
h8300                               defconfig
arm                       imx_v4_v5_defconfig
mips                        workpad_defconfig
arc                    vdk_hs38_smp_defconfig
arm                          ep93xx_defconfig
powerpc                     kmeter1_defconfig
sh                          kfr2r09_defconfig
m68k                          amiga_defconfig
mips                          malta_defconfig
powerpc                       holly_defconfig
powerpc                     tqm8560_defconfig
arm                         orion5x_defconfig
powerpc                    sam440ep_defconfig
powerpc                  mpc866_ads_defconfig
m68k                        m5407c3_defconfig
arc                 nsimosci_hs_smp_defconfig
mips                            e55_defconfig
m68k                          multi_defconfig
mips                         tb0287_defconfig
arm                         hackkit_defconfig
sh                   secureedge5410_defconfig
arm                           viper_defconfig
m68k                          hp300_defconfig
sh                            shmin_defconfig
arm                        neponset_defconfig
arm                            lart_defconfig
arm                            hisi_defconfig
powerpc                       eiger_defconfig
openrisc                    or1ksim_defconfig
powerpc                 mpc836x_mds_defconfig
arm                         lpc18xx_defconfig
powerpc                    mvme5100_defconfig
arm                        mvebu_v7_defconfig
powerpc                      makalu_defconfig
mips                           gcw0_defconfig
powerpc                      mgcoge_defconfig
x86_64                           alldefconfig
i386                             alldefconfig
arm                         s5pv210_defconfig
powerpc                    gamecube_defconfig
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
x86_64               randconfig-a006-20210728
x86_64               randconfig-a003-20210728
x86_64               randconfig-a001-20210728
x86_64               randconfig-a004-20210728
x86_64               randconfig-a005-20210728
x86_64               randconfig-a002-20210728
i386                 randconfig-a005-20210728
i386                 randconfig-a003-20210728
i386                 randconfig-a004-20210728
i386                 randconfig-a002-20210728
i386                 randconfig-a001-20210728
i386                 randconfig-a006-20210728
i386                 randconfig-a016-20210728
i386                 randconfig-a012-20210728
i386                 randconfig-a013-20210728
i386                 randconfig-a014-20210728
i386                 randconfig-a011-20210728
i386                 randconfig-a015-20210728
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c001-20210728
x86_64               randconfig-a016-20210728
x86_64               randconfig-a011-20210728
x86_64               randconfig-a014-20210728
x86_64               randconfig-a013-20210728
x86_64               randconfig-a012-20210728
x86_64               randconfig-a015-20210728

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
