Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78C244305EA
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 03:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244790AbhJQBei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 21:34:38 -0400
Received: from mga18.intel.com ([134.134.136.126]:32969 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244775AbhJQBeg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 21:34:36 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10139"; a="215015190"
X-IronPort-AV: E=Sophos;i="5.85,379,1624345200"; 
   d="scan'208";a="215015190"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2021 18:32:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,379,1624345200"; 
   d="scan'208";a="660922237"
Received: from lkp-server02.sh.intel.com (HELO 08b2c502c3de) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 16 Oct 2021 18:32:25 -0700
Received: from kbuild by 08b2c502c3de with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mbv2H-0009qB-9U; Sun, 17 Oct 2021 01:32:25 +0000
Date:   Sun, 17 Oct 2021 09:32:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 b2381acd3fd9bacd2c63f53b2c610c89959b31cc
Message-ID: <616b7d18.7DQuSRMAxq7HXjW+%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: b2381acd3fd9bacd2c63f53b2c610c89959b31cc  x86/fpu: Mask out the invalid MXCSR bits properly

elapsed time: 727m

configs tested: 157
configs skipped: 72

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211016
sh                                  defconfig
riscv                            alldefconfig
mips                        maltaup_defconfig
arm                           tegra_defconfig
arm                          collie_defconfig
sparc                               defconfig
arc                          axs101_defconfig
arm                        keystone_defconfig
xtensa                          iss_defconfig
powerpc                 canyonlands_defconfig
sh                           se7721_defconfig
sh                          landisk_defconfig
mips                     loongson1b_defconfig
mips                           xway_defconfig
ia64                        generic_defconfig
arm                           h5000_defconfig
arc                         haps_hs_defconfig
arm                  colibri_pxa270_defconfig
sh                        edosk7705_defconfig
sh                         ap325rxa_defconfig
sh                           se7751_defconfig
m68k                        m5272c3_defconfig
arm                           viper_defconfig
sparc64                             defconfig
riscv                             allnoconfig
mips                            e55_defconfig
powerpc                     kmeter1_defconfig
arm                            zeus_defconfig
arm                         s5pv210_defconfig
mips                             allmodconfig
m68k                                defconfig
arm                         cm_x300_defconfig
powerpc                    gamecube_defconfig
powerpc                 mpc837x_mds_defconfig
mips                   sb1250_swarm_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                     sequoia_defconfig
riscv                               defconfig
microblaze                      mmu_defconfig
powerpc                   bluestone_defconfig
xtensa                    xip_kc705_defconfig
sh                          kfr2r09_defconfig
mips                     cu1000-neo_defconfig
sh                 kfr2r09-romimage_defconfig
powerpc                     asp8347_defconfig
sparc                       sparc64_defconfig
mips                     decstation_defconfig
m68k                       bvme6000_defconfig
mips                           ip32_defconfig
mips                            gpr_defconfig
h8300                            allyesconfig
mips                           gcw0_defconfig
powerpc                  iss476-smp_defconfig
powerpc                  mpc866_ads_defconfig
arc                 nsimosci_hs_smp_defconfig
sh                          sdk7786_defconfig
ia64                          tiger_defconfig
powerpc                 mpc837x_rdb_defconfig
x86_64               randconfig-c001-20211016
arm                  randconfig-c002-20211017
i386                 randconfig-c001-20211017
x86_64               randconfig-c001-20211017
arm                  randconfig-c002-20211016
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                                defconfig
sparc                            allyesconfig
i386                                defconfig
i386                             allyesconfig
mips                             allyesconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20211016
x86_64               randconfig-a004-20211016
x86_64               randconfig-a001-20211016
x86_64               randconfig-a005-20211016
x86_64               randconfig-a002-20211016
x86_64               randconfig-a003-20211016
i386                 randconfig-a003-20211016
i386                 randconfig-a001-20211016
i386                 randconfig-a005-20211016
i386                 randconfig-a004-20211016
i386                 randconfig-a002-20211016
i386                 randconfig-a006-20211016
x86_64               randconfig-a012-20211017
x86_64               randconfig-a015-20211017
x86_64               randconfig-a016-20211017
x86_64               randconfig-a014-20211017
x86_64               randconfig-a011-20211017
x86_64               randconfig-a013-20211017
i386                 randconfig-a016-20211017
i386                 randconfig-a014-20211017
i386                 randconfig-a011-20211017
i386                 randconfig-a015-20211017
i386                 randconfig-a012-20211017
i386                 randconfig-a013-20211017
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
mips                 randconfig-c004-20211017
arm                  randconfig-c002-20211017
i386                 randconfig-c001-20211017
s390                 randconfig-c005-20211017
x86_64               randconfig-c007-20211017
powerpc              randconfig-c003-20211017
riscv                randconfig-c006-20211017
i386                 randconfig-a003-20211017
i386                 randconfig-a001-20211017
i386                 randconfig-a005-20211017
i386                 randconfig-a004-20211017
i386                 randconfig-a002-20211017
i386                 randconfig-a006-20211017
x86_64               randconfig-a012-20211016
x86_64               randconfig-a015-20211016
x86_64               randconfig-a016-20211016
x86_64               randconfig-a014-20211016
x86_64               randconfig-a011-20211016
x86_64               randconfig-a013-20211016
i386                 randconfig-a016-20211016
i386                 randconfig-a014-20211016
i386                 randconfig-a011-20211016
i386                 randconfig-a015-20211016
i386                 randconfig-a012-20211016
i386                 randconfig-a013-20211016
x86_64               randconfig-a006-20211017
x86_64               randconfig-a004-20211017
x86_64               randconfig-a001-20211017
x86_64               randconfig-a005-20211017
x86_64               randconfig-a002-20211017
x86_64               randconfig-a003-20211017
hexagon              randconfig-r041-20211016
s390                 randconfig-r044-20211016
riscv                randconfig-r042-20211016
hexagon              randconfig-r045-20211016
hexagon              randconfig-r041-20211017
hexagon              randconfig-r045-20211017

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
