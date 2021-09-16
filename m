Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E14A940ED76
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 00:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241209AbhIPWlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 18:41:22 -0400
Received: from mga18.intel.com ([134.134.136.126]:30580 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241183AbhIPWlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 18:41:19 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10109"; a="209767852"
X-IronPort-AV: E=Sophos;i="5.85,299,1624345200"; 
   d="scan'208";a="209767852"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2021 15:39:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,299,1624345200"; 
   d="scan'208";a="545890874"
Received: from lkp-server01.sh.intel.com (HELO 285e7b116627) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Sep 2021 15:39:57 -0700
Received: from kbuild by 285e7b116627 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mR02u-0001Tm-LA; Thu, 16 Sep 2021 22:39:56 +0000
Date:   Fri, 17 Sep 2021 06:39:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:objtool/core] BUILD SUCCESS
 55a918e61cf45f28157a2f0bb2535fa79e4a137d
Message-ID: <6143c7b1.F/1BMQp4Od2RgfP1%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool/core
branch HEAD: 55a918e61cf45f28157a2f0bb2535fa79e4a137d  objtool: Support pv_opsindirect calls for noinstr

elapsed time: 1946m

configs tested: 184
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210916
sh                                  defconfig
arm                     am200epdkit_defconfig
powerpc                     mpc83xx_defconfig
arm                          lpd270_defconfig
arm                        clps711x_defconfig
powerpc                 mpc8313_rdb_defconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                      cm5200_defconfig
sh                        edosk7705_defconfig
x86_64                           allyesconfig
arm                  colibri_pxa300_defconfig
arc                                 defconfig
arm                         mv78xx0_defconfig
arm                       spear13xx_defconfig
powerpc                     skiroot_defconfig
sh                     magicpanelr2_defconfig
sh                          polaris_defconfig
powerpc                 mpc8560_ads_defconfig
arm                         lubbock_defconfig
arm                          ep93xx_defconfig
arc                              alldefconfig
powerpc                      ppc44x_defconfig
sh                          landisk_defconfig
um                           x86_64_defconfig
powerpc                     ep8248e_defconfig
arm                        mvebu_v7_defconfig
arc                        nsimosci_defconfig
s390                          debug_defconfig
powerpc                 mpc8272_ads_defconfig
mips                         db1xxx_defconfig
sh                           se7712_defconfig
powerpc                     tqm8555_defconfig
arm                          pxa910_defconfig
m68k                          hp300_defconfig
arm                         lpc18xx_defconfig
sparc                            allyesconfig
powerpc                    klondike_defconfig
arm                   milbeaut_m10v_defconfig
arc                     nsimosci_hs_defconfig
s390                       zfcpdump_defconfig
sh                           se7724_defconfig
powerpc                     tqm5200_defconfig
sh                   sh7770_generic_defconfig
powerpc                      acadia_defconfig
sh                          lboxre2_defconfig
powerpc                  mpc885_ads_defconfig
arm                         cm_x300_defconfig
sh                               alldefconfig
m68k                         amcore_defconfig
arm                        oxnas_v6_defconfig
sh                           se7206_defconfig
powerpc                    socrates_defconfig
arm                       netwinder_defconfig
arc                        vdk_hs38_defconfig
csky                             alldefconfig
powerpc                     ppa8548_defconfig
xtensa                  cadence_csp_defconfig
arm                         bcm2835_defconfig
riscv                            alldefconfig
sparc                       sparc32_defconfig
m68k                           sun3_defconfig
ia64                      gensparse_defconfig
powerpc                      tqm8xx_defconfig
mips                      bmips_stb_defconfig
arm                      pxa255-idp_defconfig
sh                            hp6xx_defconfig
mips                  cavium_octeon_defconfig
nios2                         3c120_defconfig
arm                             rpc_defconfig
arm                        realview_defconfig
arm                            hisi_defconfig
sh                           se7751_defconfig
powerpc                     rainier_defconfig
powerpc                   microwatt_defconfig
xtensa                           alldefconfig
sh                           se7722_defconfig
arm                       versatile_defconfig
sh                              ul2_defconfig
sh                         ecovec24_defconfig
sh                          sdk7780_defconfig
arm                           u8500_defconfig
powerpc                       holly_defconfig
h8300                               defconfig
sh                          rsk7203_defconfig
m68k                       m5249evb_defconfig
powerpc                      bamboo_defconfig
sparc64                          alldefconfig
m68k                                defconfig
powerpc                      chrp32_defconfig
openrisc                         alldefconfig
m68k                       m5475evb_defconfig
powerpc                     pseries_defconfig
mips                           ip27_defconfig
arm                       imx_v6_v7_defconfig
m68k                            mac_defconfig
mips                        nlm_xlr_defconfig
powerpc                     asp8347_defconfig
openrisc                 simple_smp_defconfig
m68k                             alldefconfig
sh                            shmin_defconfig
sh                        dreamcast_defconfig
x86_64               randconfig-c001-20210916
arm                  randconfig-c002-20210916
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                                defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
sparc                               defconfig
i386                                defconfig
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a016-20210916
x86_64               randconfig-a013-20210916
x86_64               randconfig-a012-20210916
x86_64               randconfig-a011-20210916
x86_64               randconfig-a014-20210916
x86_64               randconfig-a015-20210916
i386                 randconfig-a016-20210916
i386                 randconfig-a015-20210916
i386                 randconfig-a011-20210916
i386                 randconfig-a012-20210916
i386                 randconfig-a013-20210916
i386                 randconfig-a014-20210916
riscv                randconfig-r042-20210916
s390                 randconfig-r044-20210916
arc                  randconfig-r043-20210916
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
riscv                randconfig-c006-20210916
x86_64               randconfig-c007-20210916
mips                 randconfig-c004-20210916
powerpc              randconfig-c003-20210916
arm                  randconfig-c002-20210916
i386                 randconfig-c001-20210916
s390                 randconfig-c005-20210916
x86_64               randconfig-a002-20210916
x86_64               randconfig-a003-20210916
x86_64               randconfig-a006-20210916
x86_64               randconfig-a004-20210916
x86_64               randconfig-a005-20210916
x86_64               randconfig-a001-20210916
i386                 randconfig-a004-20210916
i386                 randconfig-a005-20210916
i386                 randconfig-a006-20210916
i386                 randconfig-a002-20210916
i386                 randconfig-a003-20210916
i386                 randconfig-a001-20210916
hexagon              randconfig-r045-20210916
hexagon              randconfig-r041-20210916

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
