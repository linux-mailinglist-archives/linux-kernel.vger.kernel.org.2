Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFD60404441
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 06:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236175AbhIIEYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 00:24:41 -0400
Received: from mga06.intel.com ([134.134.136.31]:57738 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229466AbhIIEYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 00:24:39 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10101"; a="281685900"
X-IronPort-AV: E=Sophos;i="5.85,279,1624345200"; 
   d="scan'208";a="281685900"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2021 21:23:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,279,1624345200"; 
   d="scan'208";a="466219968"
Received: from lkp-server01.sh.intel.com (HELO 730d49888f40) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 08 Sep 2021 21:23:29 -0700
Received: from kbuild by 730d49888f40 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mOBax-0002wY-Up; Thu, 09 Sep 2021 04:23:27 +0000
Date:   Thu, 09 Sep 2021 12:23:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/urgent] BUILD SUCCESS
 39ff83f2f6cc5cc1458dfcea9697f96338210beb
Message-ID: <61398c29.vuB+N3Yn48ZO9PZ7%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git timers/urgent
branch HEAD: 39ff83f2f6cc5cc1458dfcea9697f96338210beb  time: Handle negative seconds correctly in timespec64_to_ns()

elapsed time: 752m

configs tested: 157
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allmodconfig
arm                              allyesconfig
i386                 randconfig-c001-20210908
nds32                            alldefconfig
mips                      bmips_stb_defconfig
powerpc                     rainier_defconfig
powerpc                     tqm8548_defconfig
arm                       multi_v4t_defconfig
powerpc                      obs600_defconfig
powerpc                      walnut_defconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                       ppc64_defconfig
h8300                    h8300h-sim_defconfig
sh                        edosk7705_defconfig
sh                           se7750_defconfig
sh                           se7722_defconfig
mips                     loongson1c_defconfig
powerpc                       holly_defconfig
m68k                                defconfig
arm                         nhk8815_defconfig
sh                           se7751_defconfig
mips                         bigsur_defconfig
m68k                          amiga_defconfig
arm                            pleb_defconfig
m68k                            mac_defconfig
arm                           sama5_defconfig
powerpc                     taishan_defconfig
m68k                        m5272c3_defconfig
microblaze                      mmu_defconfig
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
s390                          debug_defconfig
powerpc                      mgcoge_defconfig
powerpc                   lite5200b_defconfig
arm                             rpc_defconfig
arm                     am200epdkit_defconfig
powerpc                     skiroot_defconfig
mips                      fuloong2e_defconfig
powerpc                 canyonlands_defconfig
arm                         socfpga_defconfig
sh                          rsk7264_defconfig
mips                           xway_defconfig
mips                          rb532_defconfig
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
ia64                          tiger_defconfig
mips                       capcella_defconfig
powerpc                         wii_defconfig
mips                          ath25_defconfig
mips                       lemote2f_defconfig
arm                    vt8500_v6_v7_defconfig
arm                            qcom_defconfig
sh                        apsh4ad0a_defconfig
arm                        spear3xx_defconfig
x86_64               randconfig-c001-20210908
arm                  randconfig-c002-20210908
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
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
arc                  randconfig-r043-20210908
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
riscv                randconfig-r042-20210908
hexagon              randconfig-r045-20210908
s390                 randconfig-r044-20210908
hexagon              randconfig-r041-20210908

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
