Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0143FA59A
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 14:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234140AbhH1MLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 08:11:22 -0400
Received: from mga06.intel.com ([134.134.136.31]:13917 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234148AbhH1MLT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 08:11:19 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10089"; a="279106879"
X-IronPort-AV: E=Sophos;i="5.84,359,1620716400"; 
   d="scan'208";a="279106879"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2021 05:10:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,359,1620716400"; 
   d="scan'208";a="458231068"
Received: from lkp-server01.sh.intel.com (HELO 4fbc2b3ce5aa) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 28 Aug 2021 05:10:25 -0700
Received: from kbuild by 4fbc2b3ce5aa with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mJxAG-0003Pf-Ps; Sat, 28 Aug 2021 12:10:24 +0000
Date:   Sat, 28 Aug 2021 20:10:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 b542e383d8c005f06a131e2b40d5889b812f19c6
Message-ID: <612a279d.h60G6LE+lLha8cYX%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: b542e383d8c005f06a131e2b40d5889b812f19c6  eventfd: Make signal recursion protection a task bit

elapsed time: 743m

configs tested: 160
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210827
arc                            hsdk_defconfig
arm                         lpc32xx_defconfig
sh                           sh2007_defconfig
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
mips                     loongson2k_defconfig
arc                         haps_hs_defconfig
powerpc                     sbc8548_defconfig
arm                         lubbock_defconfig
powerpc                      katmai_defconfig
m68k                        mvme147_defconfig
sh                           se7722_defconfig
sh                           se7751_defconfig
ia64                        generic_defconfig
sh                          rsk7201_defconfig
sh                           se7780_defconfig
powerpc                        warp_defconfig
arm                          badge4_defconfig
xtensa                       common_defconfig
arm                         bcm2835_defconfig
powerpc                      makalu_defconfig
m68k                          multi_defconfig
nds32                             allnoconfig
sh                         apsh4a3a_defconfig
arm                        keystone_defconfig
sh                        edosk7705_defconfig
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
powerpc                 mpc836x_rdk_defconfig
arm                         s3c6400_defconfig
powerpc                       holly_defconfig
powerpc                      ppc6xx_defconfig
sh                           se7343_defconfig
arm                         nhk8815_defconfig
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
powerpc                          allmodconfig
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
