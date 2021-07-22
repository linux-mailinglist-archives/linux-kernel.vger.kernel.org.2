Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D56143D1F69
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 09:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbhGVHPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 03:15:54 -0400
Received: from mga18.intel.com ([134.134.136.126]:52430 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230048AbhGVHPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 03:15:53 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10052"; a="198861978"
X-IronPort-AV: E=Sophos;i="5.84,260,1620716400"; 
   d="scan'208";a="198861978"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2021 00:56:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,260,1620716400"; 
   d="scan'208";a="577135293"
Received: from lkp-server01.sh.intel.com (HELO b8b92b2878b0) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 22 Jul 2021 00:56:27 -0700
Received: from kbuild by b8b92b2878b0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m6TZC-0000z4-Tw; Thu, 22 Jul 2021 07:56:26 +0000
Date:   Thu, 22 Jul 2021 15:56:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:for-next/array-bounds] BUILD SUCCESS
 7609aa6c9b48cfb7ba1b5de78aac28aba2137f23
Message-ID: <60f9249d.mNOuA3M4eWxjIPuB%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git for-next/array-bounds
branch HEAD: 7609aa6c9b48cfb7ba1b5de78aac28aba2137f23  Makefile: Enable -Warray-bounds

elapsed time: 2033m

configs tested: 182
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
nds32                            alldefconfig
sh                         ap325rxa_defconfig
mips                           jazz_defconfig
arm                       cns3420vb_defconfig
mips                        vocore2_defconfig
powerpc                     mpc5200_defconfig
m68k                        m5307c3_defconfig
mips                     decstation_defconfig
powerpc                       ebony_defconfig
powerpc                      bamboo_defconfig
arm                      integrator_defconfig
arm                        multi_v7_defconfig
powerpc                      pasemi_defconfig
m68k                        mvme16x_defconfig
sh                          r7785rp_defconfig
sparc64                             defconfig
arc                     nsimosci_hs_defconfig
m68k                             allyesconfig
m68k                       m5208evb_defconfig
arm                           sama5_defconfig
mips                       rbtx49xx_defconfig
mips                          ath25_defconfig
powerpc                      tqm8xx_defconfig
powerpc                    ge_imp3a_defconfig
csky                             alldefconfig
h8300                               defconfig
sh                  sh7785lcr_32bit_defconfig
mips                           gcw0_defconfig
arm                        shmobile_defconfig
parisc                generic-64bit_defconfig
powerpc                     tqm8555_defconfig
arm                           h5000_defconfig
arc                              alldefconfig
powerpc                 mpc8313_rdb_defconfig
sh                               j2_defconfig
powerpc                       ppc64_defconfig
sh                          sdk7786_defconfig
arm                           stm32_defconfig
arm                           viper_defconfig
sh                          rsk7201_defconfig
arm                             mxs_defconfig
arm                       aspeed_g5_defconfig
powerpc                      ppc64e_defconfig
arm                            xcep_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                  mpc866_ads_defconfig
mips                     loongson2k_defconfig
sh                ecovec24-romimage_defconfig
arm                          ep93xx_defconfig
powerpc                         wii_defconfig
sh                           se7343_defconfig
mips                  cavium_octeon_defconfig
powerpc                      chrp32_defconfig
powerpc                       holly_defconfig
powerpc                      katmai_defconfig
mips                         mpc30x_defconfig
m68k                        m5407c3_defconfig
arm                        realview_defconfig
arm                            dove_defconfig
arm                  colibri_pxa270_defconfig
openrisc                 simple_smp_defconfig
mips                           ip28_defconfig
arm64                            alldefconfig
mips                     cu1000-neo_defconfig
riscv                    nommu_virt_defconfig
mips                 decstation_r4k_defconfig
xtensa                  nommu_kc705_defconfig
m68k                             alldefconfig
sh                          urquell_defconfig
sh                   sh7724_generic_defconfig
arm                       imx_v4_v5_defconfig
powerpc                     rainier_defconfig
mips                         tb0226_defconfig
arm                        multi_v5_defconfig
arm                         orion5x_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
x86_64                            allnoconfig
m68k                             allmodconfig
m68k                                defconfig
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
x86_64               randconfig-a003-20210720
x86_64               randconfig-a006-20210720
x86_64               randconfig-a001-20210720
x86_64               randconfig-a005-20210720
x86_64               randconfig-a004-20210720
x86_64               randconfig-a002-20210720
i386                 randconfig-a005-20210720
i386                 randconfig-a003-20210720
i386                 randconfig-a004-20210720
i386                 randconfig-a002-20210720
i386                 randconfig-a001-20210720
i386                 randconfig-a006-20210720
i386                 randconfig-a005-20210722
i386                 randconfig-a003-20210722
i386                 randconfig-a004-20210722
i386                 randconfig-a002-20210722
i386                 randconfig-a001-20210722
i386                 randconfig-a006-20210722
i386                 randconfig-a005-20210719
i386                 randconfig-a004-20210719
i386                 randconfig-a006-20210719
i386                 randconfig-a001-20210719
i386                 randconfig-a003-20210719
i386                 randconfig-a002-20210719
x86_64               randconfig-a011-20210721
x86_64               randconfig-a016-20210721
x86_64               randconfig-a013-20210721
x86_64               randconfig-a014-20210721
x86_64               randconfig-a012-20210721
x86_64               randconfig-a015-20210721
i386                 randconfig-a016-20210720
i386                 randconfig-a013-20210720
i386                 randconfig-a012-20210720
i386                 randconfig-a014-20210720
i386                 randconfig-a011-20210720
i386                 randconfig-a015-20210720
i386                 randconfig-a016-20210722
i386                 randconfig-a013-20210722
i386                 randconfig-a012-20210722
i386                 randconfig-a011-20210722
i386                 randconfig-a014-20210722
i386                 randconfig-a015-20210722
i386                 randconfig-a016-20210721
i386                 randconfig-a013-20210721
i386                 randconfig-a012-20210721
i386                 randconfig-a014-20210721
i386                 randconfig-a011-20210721
i386                 randconfig-a015-20210721
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
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
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210720
x86_64               randconfig-b001-20210722
x86_64               randconfig-a003-20210721
x86_64               randconfig-a006-20210721
x86_64               randconfig-a001-20210721
x86_64               randconfig-a005-20210721
x86_64               randconfig-a004-20210721
x86_64               randconfig-a002-20210721

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
