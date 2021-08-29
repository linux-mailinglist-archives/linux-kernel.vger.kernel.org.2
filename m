Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC2A3FA84F
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 05:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbhH2Dfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 23:35:41 -0400
Received: from mga01.intel.com ([192.55.52.88]:20897 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231558AbhH2Dfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 23:35:40 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10090"; a="240363148"
X-IronPort-AV: E=Sophos;i="5.84,360,1620716400"; 
   d="scan'208";a="240363148"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2021 20:34:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,360,1620716400"; 
   d="scan'208";a="518163797"
Received: from lkp-server01.sh.intel.com (HELO 4fbc2b3ce5aa) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 28 Aug 2021 20:34:47 -0700
Received: from kbuild by 4fbc2b3ce5aa with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mKBao-0003zI-Nh; Sun, 29 Aug 2021 03:34:46 +0000
Date:   Sun, 29 Aug 2021 11:34:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS
 d25a025201ed98f4b93775e0999a3f2135702106
Message-ID: <612b0033.UO8O7+IgwZ3wq+wb%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
branch HEAD: d25a025201ed98f4b93775e0999a3f2135702106  clocksource: Make clocksource watchdog test safe for slow-HZ systems

elapsed time: 723m

configs tested: 130
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210827
sh                           se7705_defconfig
powerpc                        fsp2_defconfig
xtensa                    smp_lx200_defconfig
sh                              ul2_defconfig
sh                        sh7785lcr_defconfig
sh                           se7780_defconfig
powerpc                      bamboo_defconfig
arm                            xcep_defconfig
sh                            hp6xx_defconfig
arm                          simpad_defconfig
powerpc                      makalu_defconfig
mips                     cu1830-neo_defconfig
sh                          sdk7780_defconfig
x86_64                           alldefconfig
powerpc                   microwatt_defconfig
mips                          ath25_defconfig
openrisc                 simple_smp_defconfig
sh                 kfr2r09-romimage_defconfig
powerpc                       ebony_defconfig
sh                             espt_defconfig
arm                        mvebu_v7_defconfig
arm                             mxs_defconfig
mips                     loongson1c_defconfig
sh                        edosk7705_defconfig
arm                        mini2440_defconfig
arm                          iop32x_defconfig
xtensa                           alldefconfig
x86_64                           allyesconfig
nds32                             allnoconfig
mips                     loongson1b_defconfig
alpha                               defconfig
xtensa                              defconfig
m68k                       m5249evb_defconfig
powerpc                       ppc64_defconfig
arm                        cerfcube_defconfig
powerpc                      chrp32_defconfig
arc                     haps_hs_smp_defconfig
mips                    maltaup_xpa_defconfig
powerpc                     kilauea_defconfig
arm                           sunxi_defconfig
mips                        bcm47xx_defconfig
openrisc                    or1ksim_defconfig
m68k                                defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
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
i386                 randconfig-a011-20210827
i386                 randconfig-a016-20210827
i386                 randconfig-a012-20210827
i386                 randconfig-a014-20210827
i386                 randconfig-a013-20210827
i386                 randconfig-a015-20210827
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
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
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
i386                 randconfig-a011-20210828
i386                 randconfig-a016-20210828
i386                 randconfig-a012-20210828
i386                 randconfig-a014-20210828
i386                 randconfig-a013-20210828
i386                 randconfig-a015-20210828

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
