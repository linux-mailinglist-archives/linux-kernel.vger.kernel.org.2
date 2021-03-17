Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 571DC33EADB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 08:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbhCQHxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 03:53:52 -0400
Received: from mga04.intel.com ([192.55.52.120]:4577 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230185AbhCQHxd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 03:53:33 -0400
IronPort-SDR: tXcMbu7nbsjHtooh29rEpudR2ICsjmvA5+xA32yt8/leEGN3nQLwsTXcuJHljdxptheUS7eXTe
 7yTtwCQv661A==
X-IronPort-AV: E=McAfee;i="6000,8403,9925"; a="187040757"
X-IronPort-AV: E=Sophos;i="5.81,255,1610438400"; 
   d="scan'208";a="187040757"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2021 00:53:33 -0700
IronPort-SDR: TRIQLlk2lCbAVYlrDJYDHNbPi1pzfiZArh16cNV+5Ph0RYQqvr9MaqawvEhi+cxuiHsAoBqB4u
 +8yiR9BlQwVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,255,1610438400"; 
   d="scan'208";a="602136140"
Received: from lkp-server02.sh.intel.com (HELO 1c294c63cb86) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 17 Mar 2021 00:53:32 -0700
Received: from kbuild by 1c294c63cb86 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lMQzj-0000Yl-GY; Wed, 17 Mar 2021 07:53:31 +0000
Date:   Wed, 17 Mar 2021 15:52:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 c1d72652bf64d0332425c0e692a46833003d096e
Message-ID: <6051b557.+IE64d43aMDlhq1L%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: c1d72652bf64d0332425c0e692a46833003d096e  Merge branch 'irq/core'

elapsed time: 721m

configs tested: 129
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
arm                         hackkit_defconfig
sh                               j2_defconfig
arm                         vf610m4_defconfig
powerpc                      pmac32_defconfig
arm                          gemini_defconfig
arc                              allyesconfig
nios2                         3c120_defconfig
parisc                generic-32bit_defconfig
powerpc                      ppc6xx_defconfig
microblaze                      mmu_defconfig
csky                             alldefconfig
powerpc                  storcenter_defconfig
powerpc                       ppc64_defconfig
powerpc                         ps3_defconfig
sh                           se7206_defconfig
arm                       netwinder_defconfig
arm                           spitz_defconfig
mips                        nlm_xlp_defconfig
mips                     loongson1b_defconfig
mips                     loongson1c_defconfig
powerpc                     tqm8555_defconfig
powerpc                      ppc40x_defconfig
mips                           ip32_defconfig
sh                            hp6xx_defconfig
xtensa                generic_kc705_defconfig
sh                        edosk7760_defconfig
openrisc                            defconfig
powerpc                      bamboo_defconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                   bluestone_defconfig
mips                         tb0219_defconfig
arm                         assabet_defconfig
mips                      pistachio_defconfig
mips                  decstation_64_defconfig
mips                         tb0287_defconfig
arm                        clps711x_defconfig
powerpc                 mpc8313_rdb_defconfig
arm                          ep93xx_defconfig
powerpc                     mpc512x_defconfig
arm                         orion5x_defconfig
sh                          sdk7780_defconfig
mips                            ar7_defconfig
sh                           se7712_defconfig
parisc                           allyesconfig
s390                                defconfig
mips                         bigsur_defconfig
powerpc                     ep8248e_defconfig
powerpc                      cm5200_defconfig
sparc64                             defconfig
arm                            mps2_defconfig
mips                     cu1000-neo_defconfig
xtensa                  cadence_csp_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                     pseries_defconfig
arm                        neponset_defconfig
arm                        trizeps4_defconfig
sh                        edosk7705_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
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
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20210316
i386                 randconfig-a005-20210316
i386                 randconfig-a002-20210316
i386                 randconfig-a003-20210316
i386                 randconfig-a004-20210316
i386                 randconfig-a006-20210316
x86_64               randconfig-a011-20210316
x86_64               randconfig-a016-20210316
x86_64               randconfig-a013-20210316
x86_64               randconfig-a014-20210316
x86_64               randconfig-a015-20210316
x86_64               randconfig-a012-20210316
i386                 randconfig-a013-20210316
i386                 randconfig-a016-20210316
i386                 randconfig-a011-20210316
i386                 randconfig-a012-20210316
i386                 randconfig-a015-20210316
i386                 randconfig-a014-20210316
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20210316
x86_64               randconfig-a001-20210316
x86_64               randconfig-a005-20210316
x86_64               randconfig-a004-20210316
x86_64               randconfig-a003-20210316
x86_64               randconfig-a002-20210316

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
