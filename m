Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1B13FA5A4
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 14:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234262AbhH1M3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 08:29:19 -0400
Received: from mga02.intel.com ([134.134.136.20]:25131 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234249AbhH1M3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 08:29:17 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10089"; a="205306036"
X-IronPort-AV: E=Sophos;i="5.84,359,1620716400"; 
   d="scan'208";a="205306036"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2021 05:28:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,359,1620716400"; 
   d="scan'208";a="517920110"
Received: from lkp-server01.sh.intel.com (HELO 4fbc2b3ce5aa) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 28 Aug 2021 05:28:25 -0700
Received: from kbuild by 4fbc2b3ce5aa with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mJxRh-0003Qj-9T; Sat, 28 Aug 2021 12:28:25 +0000
Date:   Sat, 28 Aug 2021 20:27:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:smp/core] BUILD SUCCESS
 7625eccd1852ac84d3aa6a06ffc2f710e683b3fe
Message-ID: <612a2bb8.6f7DVdtmo0fndqHJ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp/core
branch HEAD: 7625eccd1852ac84d3aa6a06ffc2f710e683b3fe  mm: Replace deprecated CPU-hotplug functions.

elapsed time: 732m

configs tested: 160
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                                 defconfig
i386                 randconfig-c001-20210827
nios2                               defconfig
mips                           xway_defconfig
x86_64                           alldefconfig
arm                  colibri_pxa270_defconfig
arm                         lpc18xx_defconfig
m68k                       m5275evb_defconfig
mips                         mpc30x_defconfig
mips                           ip32_defconfig
m68k                        m5272c3_defconfig
arm                         at91_dt_defconfig
mips                      fuloong2e_defconfig
sh                ecovec24-romimage_defconfig
powerpc                          g5_defconfig
sh                         ecovec24_defconfig
arm                       imx_v4_v5_defconfig
mips                        maltaup_defconfig
arm                         palmz72_defconfig
powerpc                      tqm8xx_defconfig
mips                     loongson1b_defconfig
arm                         s5pv210_defconfig
xtensa                           alldefconfig
sh                        edosk7705_defconfig
sh                           se7722_defconfig
sh                           se7751_defconfig
ia64                        generic_defconfig
sh                          rsk7201_defconfig
sh                           se7780_defconfig
powerpc                        warp_defconfig
m68k                        mvme147_defconfig
arm                          badge4_defconfig
xtensa                       common_defconfig
arm                        spear6xx_defconfig
mips                         db1xxx_defconfig
arm                         vf610m4_defconfig
xtensa                              defconfig
um                                  defconfig
arm                         bcm2835_defconfig
powerpc                      makalu_defconfig
m68k                          multi_defconfig
nds32                             allnoconfig
sh                         apsh4a3a_defconfig
arm                        keystone_defconfig
sh                           sh2007_defconfig
powerpc                     akebono_defconfig
nios2                         3c120_defconfig
arc                        vdk_hs38_defconfig
sh                         ap325rxa_defconfig
sh                        sh7763rdp_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                      bamboo_defconfig
powerpc                      ppc64e_defconfig
arc                    vdk_hs38_smp_defconfig
arm                        vexpress_defconfig
powerpc                      ppc44x_defconfig
powerpc                      ppc6xx_defconfig
sh                           se7343_defconfig
arm                         nhk8815_defconfig
powerpc                          allmodconfig
microblaze                          defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
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
powerpc                           allnoconfig
x86_64               randconfig-a006-20210828
x86_64               randconfig-a001-20210828
x86_64               randconfig-a005-20210828
x86_64               randconfig-a003-20210828
x86_64               randconfig-a004-20210828
x86_64               randconfig-a002-20210828
i386                 randconfig-a001-20210828
i386                 randconfig-a006-20210828
i386                 randconfig-a002-20210828
i386                 randconfig-a005-20210828
i386                 randconfig-a003-20210828
i386                 randconfig-a004-20210828
x86_64               randconfig-a014-20210827
x86_64               randconfig-a015-20210827
x86_64               randconfig-a016-20210827
x86_64               randconfig-a013-20210827
x86_64               randconfig-a012-20210827
x86_64               randconfig-a011-20210827
i386                 randconfig-a011-20210827
i386                 randconfig-a016-20210827
i386                 randconfig-a012-20210827
i386                 randconfig-a014-20210827
i386                 randconfig-a013-20210827
i386                 randconfig-a015-20210827
arc                  randconfig-r043-20210827
riscv                randconfig-r042-20210827
s390                 randconfig-r044-20210827
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
s390                 randconfig-c005-20210827
i386                 randconfig-c001-20210827
arm                  randconfig-c002-20210827
riscv                randconfig-c006-20210827
powerpc              randconfig-c003-20210827
x86_64               randconfig-c007-20210827
mips                 randconfig-c004-20210827
x86_64               randconfig-a005-20210827
x86_64               randconfig-a001-20210827
x86_64               randconfig-a006-20210827
x86_64               randconfig-a003-20210827
x86_64               randconfig-a004-20210827
x86_64               randconfig-a002-20210827
i386                 randconfig-a006-20210827
i386                 randconfig-a001-20210827
i386                 randconfig-a002-20210827
i386                 randconfig-a005-20210827
i386                 randconfig-a004-20210827
i386                 randconfig-a003-20210827
i386                 randconfig-a011-20210828
i386                 randconfig-a016-20210828
i386                 randconfig-a012-20210828
i386                 randconfig-a014-20210828
i386                 randconfig-a013-20210828
i386                 randconfig-a015-20210828

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
