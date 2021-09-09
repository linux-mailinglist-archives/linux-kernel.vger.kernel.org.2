Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B994405BD1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 19:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241133AbhIIRM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 13:12:57 -0400
Received: from mga17.intel.com ([192.55.52.151]:43238 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240791AbhIIRM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 13:12:56 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10102"; a="201048939"
X-IronPort-AV: E=Sophos;i="5.85,280,1624345200"; 
   d="scan'208";a="201048939"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2021 10:11:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,280,1624345200"; 
   d="scan'208";a="525613371"
Received: from lkp-server01.sh.intel.com (HELO 730d49888f40) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 09 Sep 2021 10:11:45 -0700
Received: from kbuild by 730d49888f40 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mONaT-0003N5-7i; Thu, 09 Sep 2021 17:11:45 +0000
Date:   Fri, 10 Sep 2021 01:11:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 34b1999da935a33be6239226bfa6cd4f704c5c88
Message-ID: <613a4030.SpOSzQtIhLCBV1pO%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 34b1999da935a33be6239226bfa6cd4f704c5c88  x86/mm: Fix kern_addr_valid() to cope with existing but not present entries

elapsed time: 1310m

configs tested: 116
configs skipped: 87

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
i386                 randconfig-c001-20210908
mips                           gcw0_defconfig
sh                           se7722_defconfig
powerpc                     taishan_defconfig
arm                          exynos_defconfig
powerpc                     mpc5200_defconfig
powerpc                      pcm030_defconfig
arm                        spear6xx_defconfig
alpha                            allyesconfig
s390                                defconfig
arc                        nsimosci_defconfig
mips                         tb0287_defconfig
powerpc                  mpc866_ads_defconfig
sh                             sh03_defconfig
powerpc                 mpc834x_mds_defconfig
riscv                            allmodconfig
xtensa                generic_kc705_defconfig
mips                  maltasmvp_eva_defconfig
powerpc                 mpc832x_mds_defconfig
sh                           sh2007_defconfig
m68k                           sun3_defconfig
powerpc                     kilauea_defconfig
mips                      fuloong2e_defconfig
powerpc                      obs600_defconfig
powerpc                 canyonlands_defconfig
arm                         socfpga_defconfig
sh                          rsk7264_defconfig
mips                           xway_defconfig
mips                          rb532_defconfig
sh                           se7750_defconfig
mips                        workpad_defconfig
powerpc                        warp_defconfig
arm                         mv78xx0_defconfig
sh                           se7343_defconfig
sh                      rts7751r2d1_defconfig
arc                      axs103_smp_defconfig
sh                          sdk7780_defconfig
powerpc                        fsp2_defconfig
arm                       netwinder_defconfig
arm                        keystone_defconfig
arm                    vt8500_v6_v7_defconfig
arm                            qcom_defconfig
sh                        apsh4ad0a_defconfig
arm                        spear3xx_defconfig
x86_64               randconfig-c001-20210908
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
nios2                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allmodconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20210908
x86_64               randconfig-a006-20210908
x86_64               randconfig-a003-20210908
x86_64               randconfig-a001-20210908
x86_64               randconfig-a005-20210908
x86_64               randconfig-a002-20210908
i386                 randconfig-a005-20210908
i386                 randconfig-a004-20210908
i386                 randconfig-a006-20210908
i386                 randconfig-a002-20210908
i386                 randconfig-a001-20210908
i386                 randconfig-a003-20210908
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
s390                 randconfig-c005-20210908
powerpc              randconfig-c003-20210908
mips                 randconfig-c004-20210908
i386                 randconfig-c001-20210908
x86_64               randconfig-a016-20210908
x86_64               randconfig-a011-20210908
x86_64               randconfig-a012-20210908
x86_64               randconfig-a015-20210908
x86_64               randconfig-a014-20210908
x86_64               randconfig-a013-20210908
i386                 randconfig-a012-20210908
i386                 randconfig-a015-20210908
i386                 randconfig-a011-20210908
i386                 randconfig-a013-20210908
i386                 randconfig-a014-20210908
i386                 randconfig-a016-20210908
s390                 randconfig-r044-20210908
riscv                randconfig-r042-20210908
hexagon              randconfig-r045-20210908
hexagon              randconfig-r041-20210908

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
