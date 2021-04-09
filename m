Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B264B35A4CB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 19:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234352AbhDIRka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 13:40:30 -0400
Received: from mga09.intel.com ([134.134.136.24]:30397 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234333AbhDIRk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 13:40:26 -0400
IronPort-SDR: RkFaa+GmRb5965WgEIE/ndJU6Gr7RTsezsYT9TSUFJ+v6hTBdh8q9hS7+xiEVRlBjO6B3Ftfpm
 4VCarbSBOFGg==
X-IronPort-AV: E=McAfee;i="6000,8403,9949"; a="193923591"
X-IronPort-AV: E=Sophos;i="5.82,210,1613462400"; 
   d="scan'208";a="193923591"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 10:40:09 -0700
IronPort-SDR: n9DPyLYPo30Wx4Uks8qS93+odrWpeGzLbr6BLtXVZjVujA1i5+XObLj6Ddjfd2N2fhVX3O+l0U
 gAE6tWB4OA4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,210,1613462400"; 
   d="scan'208";a="397559251"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 09 Apr 2021 10:40:08 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lUv71-000H7h-Nz; Fri, 09 Apr 2021 17:40:07 +0000
Date:   Sat, 10 Apr 2021 01:39:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:testing/xfs-series] BUILD SUCCESS
 387b2370698815b609f6e035e28a47980ee9b36d
Message-ID: <60709159.OK4jmGqmURkYBtcI%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/xfs-series
branch HEAD: 387b2370698815b609f6e035e28a47980ee9b36d  xfs: Replace one-element arrays with flexible-array members (test patch 1)

elapsed time: 725m

configs tested: 184
configs skipped: 4

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
mips                malta_kvm_guest_defconfig
sh                          landisk_defconfig
arm                      tct_hammer_defconfig
mips                     loongson1b_defconfig
mips                         tb0226_defconfig
openrisc                  or1klitex_defconfig
xtensa                    xip_kc705_defconfig
arm                            hisi_defconfig
powerpc                      pmac32_defconfig
arm                          lpd270_defconfig
nios2                            alldefconfig
m68k                         apollo_defconfig
mips                        omega2p_defconfig
mips                        nlm_xlr_defconfig
powerpc                 mpc8315_rdb_defconfig
mips                        workpad_defconfig
sh                          rsk7203_defconfig
arm                        spear6xx_defconfig
sh                          sdk7786_defconfig
arm                         lubbock_defconfig
powerpc                          allmodconfig
arm                       aspeed_g4_defconfig
arm                       omap2plus_defconfig
xtensa                generic_kc705_defconfig
powerpc                      pcm030_defconfig
arc                 nsimosci_hs_smp_defconfig
xtensa                  nommu_kc705_defconfig
nios2                               defconfig
sh                      rts7751r2d1_defconfig
powerpc                   motionpro_defconfig
sh                         ap325rxa_defconfig
powerpc                      tqm8xx_defconfig
openrisc                         alldefconfig
arm                            mmp2_defconfig
um                             i386_defconfig
powerpc                    sam440ep_defconfig
powerpc                    socrates_defconfig
arm64                            alldefconfig
powerpc                       ppc64_defconfig
arm                          ixp4xx_defconfig
mips                         cobalt_defconfig
sh                           se7206_defconfig
mips                      fuloong2e_defconfig
arm                           sama5_defconfig
mips                      maltasmvp_defconfig
m68k                                defconfig
sh                                  defconfig
powerpc                 mpc8313_rdb_defconfig
arm                            dove_defconfig
arm                  colibri_pxa270_defconfig
sh                           se7619_defconfig
powerpc                      chrp32_defconfig
arm                         socfpga_defconfig
arm                            pleb_defconfig
arm                            xcep_defconfig
arm                          ep93xx_defconfig
mips                            e55_defconfig
arm                       imx_v4_v5_defconfig
mips                           ip27_defconfig
mips                         mpc30x_defconfig
s390                                defconfig
riscv                    nommu_k210_defconfig
arc                            hsdk_defconfig
riscv             nommu_k210_sdcard_defconfig
arm                        multi_v5_defconfig
h8300                               defconfig
powerpc                         ps3_defconfig
arm                         at91_dt_defconfig
powerpc                      obs600_defconfig
arm                        mini2440_defconfig
microblaze                      mmu_defconfig
powerpc                 mpc832x_rdb_defconfig
sh                ecovec24-romimage_defconfig
powerpc                     pseries_defconfig
powerpc                     tqm8548_defconfig
powerpc                  iss476-smp_defconfig
mips                     cu1830-neo_defconfig
arc                        nsim_700_defconfig
arm                       netwinder_defconfig
arm                  colibri_pxa300_defconfig
powerpc                 mpc8540_ads_defconfig
m68k                         amcore_defconfig
microblaze                          defconfig
sh                        sh7785lcr_defconfig
ia64                             allyesconfig
m68k                       m5208evb_defconfig
openrisc                            defconfig
ia64                          tiger_defconfig
sh                   sh7770_generic_defconfig
powerpc                 canyonlands_defconfig
powerpc                    mvme5100_defconfig
csky                                defconfig
arm                        cerfcube_defconfig
mips                      maltaaprp_defconfig
sh                          urquell_defconfig
arc                      axs103_smp_defconfig
powerpc                     taishan_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                     ppa8548_defconfig
mips                           xway_defconfig
powerpc                       eiger_defconfig
mips                       rbtx49xx_defconfig
powerpc                     ksi8560_defconfig
mips                           ip28_defconfig
powerpc                    adder875_defconfig
arm                         mv78xx0_defconfig
arm                       multi_v4t_defconfig
xtensa                  cadence_csp_defconfig
powerpc64                           defconfig
sh                          sdk7780_defconfig
sh                   secureedge5410_defconfig
arm                       versatile_defconfig
arc                        nsimosci_defconfig
ia64                                defconfig
ia64                             allmodconfig
m68k                             allmodconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
arc                                 defconfig
xtensa                           allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20210409
i386                 randconfig-a003-20210409
i386                 randconfig-a001-20210409
i386                 randconfig-a004-20210409
i386                 randconfig-a002-20210409
i386                 randconfig-a005-20210409
x86_64               randconfig-a014-20210409
x86_64               randconfig-a015-20210409
x86_64               randconfig-a012-20210409
x86_64               randconfig-a011-20210409
x86_64               randconfig-a013-20210409
x86_64               randconfig-a016-20210409
i386                 randconfig-a014-20210409
i386                 randconfig-a011-20210409
i386                 randconfig-a016-20210409
i386                 randconfig-a012-20210409
i386                 randconfig-a013-20210409
i386                 randconfig-a015-20210409
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20210409
x86_64               randconfig-a005-20210409
x86_64               randconfig-a003-20210409
x86_64               randconfig-a001-20210409
x86_64               randconfig-a002-20210409
x86_64               randconfig-a006-20210409

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
