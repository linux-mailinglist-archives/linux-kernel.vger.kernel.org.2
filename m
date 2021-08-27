Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9A993F93B1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 06:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbhH0E1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 00:27:53 -0400
Received: from mga04.intel.com ([192.55.52.120]:46860 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232670AbhH0E1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 00:27:52 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10088"; a="216045425"
X-IronPort-AV: E=Sophos;i="5.84,355,1620716400"; 
   d="scan'208";a="216045425"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2021 21:27:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,355,1620716400"; 
   d="scan'208";a="528171017"
Received: from lkp-server01.sh.intel.com (HELO 4fbc2b3ce5aa) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Aug 2021 21:27:03 -0700
Received: from kbuild by 4fbc2b3ce5aa with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mJTSI-0001wl-KU; Fri, 27 Aug 2021 04:27:02 +0000
Date:   Fri, 27 Aug 2021 12:26:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS
 127c92feb74a6721f62587f1b89128808f049cf1
Message-ID: <6128695e.0ZGKtaW7ksdEzqTv%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
branch HEAD: 127c92feb74a6721f62587f1b89128808f049cf1  Merge tag 'timers-v5.15' of https://git.linaro.org/people/daniel.lezcano/linux into timers/core

elapsed time: 721m

configs tested: 210
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210826
i386                 randconfig-c001-20210827
powerpc              randconfig-c003-20210826
sh                           se7722_defconfig
powerpc                     powernv_defconfig
powerpc                        warp_defconfig
mips                      loongson3_defconfig
um                             i386_defconfig
powerpc                 mpc834x_itx_defconfig
sh                         microdev_defconfig
arm                       netwinder_defconfig
arm                         mv78xx0_defconfig
x86_64                           allyesconfig
powerpc                      bamboo_defconfig
arm                          badge4_defconfig
arc                          axs103_defconfig
arm                    vt8500_v6_v7_defconfig
xtensa                    xip_kc705_defconfig
mips                     loongson1b_defconfig
powerpc                      ppc64e_defconfig
parisc                generic-32bit_defconfig
arm                          ep93xx_defconfig
powerpc                         ps3_defconfig
sh                               alldefconfig
arm                            lart_defconfig
sh                         apsh4a3a_defconfig
arm                           viper_defconfig
powerpc                    amigaone_defconfig
m68k                       m5249evb_defconfig
arm                            mmp2_defconfig
powerpc                       eiger_defconfig
powerpc                 canyonlands_defconfig
nds32                            alldefconfig
powerpc                    ge_imp3a_defconfig
sh                          rsk7269_defconfig
powerpc                 mpc837x_mds_defconfig
arm                      integrator_defconfig
m68k                            q40_defconfig
sh                             sh03_defconfig
arm                           spitz_defconfig
arm                       multi_v4t_defconfig
um                           x86_64_defconfig
powerpc                   lite5200b_defconfig
riscv                    nommu_virt_defconfig
arm                         vf610m4_defconfig
arm                          collie_defconfig
sh                          rsk7264_defconfig
arm                      pxa255-idp_defconfig
powerpc                    gamecube_defconfig
arm                        spear3xx_defconfig
arm                            zeus_defconfig
h8300                     edosk2674_defconfig
powerpc                     pq2fads_defconfig
arm                         bcm2835_defconfig
mips                        jmr3927_defconfig
mips                       bmips_be_defconfig
powerpc                      pcm030_defconfig
openrisc                  or1klitex_defconfig
arm                        realview_defconfig
m68k                            mac_defconfig
mips                      pistachio_defconfig
ia64                          tiger_defconfig
s390                          debug_defconfig
powerpc                 mpc8272_ads_defconfig
arc                            hsdk_defconfig
arm                           h5000_defconfig
arm                            mps2_defconfig
powerpc                 mpc836x_mds_defconfig
xtensa                generic_kc705_defconfig
arm                         lpc18xx_defconfig
powerpc                          g5_defconfig
xtensa                          iss_defconfig
ia64                      gensparse_defconfig
powerpc                     akebono_defconfig
arm                             ezx_defconfig
powerpc                 mpc85xx_cds_defconfig
mips                           ip28_defconfig
arc                    vdk_hs38_smp_defconfig
powerpc                   microwatt_defconfig
m68k                        m5272c3_defconfig
xtensa                  nommu_kc705_defconfig
riscv                    nommu_k210_defconfig
sh                          landisk_defconfig
arm                           corgi_defconfig
sh                ecovec24-romimage_defconfig
mips                            e55_defconfig
arm                        oxnas_v6_defconfig
sh                          sdk7780_defconfig
mips                          malta_defconfig
powerpc                        icon_defconfig
mips                         tb0287_defconfig
sh                      rts7751r2d1_defconfig
nios2                         3c120_defconfig
sh                            hp6xx_defconfig
mips                      maltasmvp_defconfig
arm                       aspeed_g4_defconfig
sh                           se7724_defconfig
powerpc                    mvme5100_defconfig
arm                     am200epdkit_defconfig
arc                          axs101_defconfig
mips                         tb0219_defconfig
nios2                         10m50_defconfig
sh                   secureedge5410_defconfig
arm                         shannon_defconfig
arm                             pxa_defconfig
powerpc                      pmac32_defconfig
mips                        vocore2_defconfig
powerpc                     pseries_defconfig
arm                           omap1_defconfig
powerpc                  storcenter_defconfig
arm                       spear13xx_defconfig
ia64                             alldefconfig
arm                          pcm027_defconfig
sparc                       sparc64_defconfig
microblaze                      mmu_defconfig
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
x86_64               randconfig-a005-20210826
x86_64               randconfig-a006-20210826
x86_64               randconfig-a001-20210826
x86_64               randconfig-a003-20210826
x86_64               randconfig-a004-20210826
x86_64               randconfig-a002-20210826
i386                 randconfig-a006-20210826
i386                 randconfig-a001-20210826
i386                 randconfig-a002-20210826
i386                 randconfig-a005-20210826
i386                 randconfig-a003-20210826
i386                 randconfig-a004-20210826
x86_64               randconfig-a014-20210827
x86_64               randconfig-a015-20210827
x86_64               randconfig-a016-20210827
x86_64               randconfig-a013-20210827
x86_64               randconfig-a012-20210827
x86_64               randconfig-a011-20210827
arc                  randconfig-r043-20210827
riscv                randconfig-r042-20210827
s390                 randconfig-r044-20210827
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
i386                 randconfig-c001-20210826
s390                 randconfig-c005-20210826
arm                  randconfig-c002-20210826
riscv                randconfig-c006-20210826
powerpc              randconfig-c003-20210826
x86_64               randconfig-c007-20210826
mips                 randconfig-c004-20210826
s390                 randconfig-c005-20210827
i386                 randconfig-c001-20210827
arm                  randconfig-c002-20210827
riscv                randconfig-c006-20210827
powerpc              randconfig-c003-20210827
x86_64               randconfig-c007-20210827
mips                 randconfig-c004-20210827
x86_64               randconfig-a014-20210826
x86_64               randconfig-a015-20210826
x86_64               randconfig-a016-20210826
x86_64               randconfig-a013-20210826
x86_64               randconfig-a012-20210826
x86_64               randconfig-a011-20210826
i386                 randconfig-a011-20210826
i386                 randconfig-a016-20210826
i386                 randconfig-a012-20210826
i386                 randconfig-a014-20210826
i386                 randconfig-a013-20210826
i386                 randconfig-a015-20210826
hexagon              randconfig-r041-20210826
hexagon              randconfig-r045-20210826
riscv                randconfig-r042-20210826
s390                 randconfig-r044-20210826

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
