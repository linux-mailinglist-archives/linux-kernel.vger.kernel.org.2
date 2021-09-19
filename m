Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6EA9410B47
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 13:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbhISL3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 07:29:48 -0400
Received: from mga11.intel.com ([192.55.52.93]:47045 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230051AbhISL3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 07:29:47 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10111"; a="219819853"
X-IronPort-AV: E=Sophos;i="5.85,305,1624345200"; 
   d="scan'208";a="219819853"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2021 04:28:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,305,1624345200"; 
   d="scan'208";a="701954213"
Received: from lkp-server01.sh.intel.com (HELO 285e7b116627) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 19 Sep 2021 04:28:21 -0700
Received: from kbuild by 285e7b116627 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mRuzc-0005SR-Lh; Sun, 19 Sep 2021 11:28:20 +0000
Date:   Sun, 19 Sep 2021 19:27:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD SUCCESS
 e739f98b4b11337a4e3865364b8922a9e5ad32b6
Message-ID: <61471e9a.BWzZ/Gy7U5jLVhOU%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
branch HEAD: e739f98b4b11337a4e3865364b8922a9e5ad32b6  genirq: Move prio assignment into the newly created thread

elapsed time: 2704m

configs tested: 260
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210918
i386                 randconfig-c001-20210916
arm                       omap2plus_defconfig
powerpc                      ep88xc_defconfig
arm                        spear6xx_defconfig
powerpc                 mpc8313_rdb_defconfig
riscv                    nommu_virt_defconfig
powerpc                     tqm8540_defconfig
ia64                                defconfig
mips                      pic32mzda_defconfig
sh                          r7785rp_defconfig
powerpc                      ppc6xx_defconfig
arm                          simpad_defconfig
powerpc                  mpc866_ads_defconfig
powerpc                 xes_mpc85xx_defconfig
mips                      malta_kvm_defconfig
powerpc                     taishan_defconfig
mips                           ip32_defconfig
arm                          ixp4xx_defconfig
powerpc                     tqm5200_defconfig
arm                           h3600_defconfig
powerpc                        warp_defconfig
arm                       multi_v4t_defconfig
arm                          pxa910_defconfig
mips                   sb1250_swarm_defconfig
s390                          debug_defconfig
arc                     haps_hs_smp_defconfig
arm                           omap1_defconfig
powerpc                         wii_defconfig
powerpc                 mpc837x_mds_defconfig
arm                         orion5x_defconfig
arm                       mainstone_defconfig
arm                            qcom_defconfig
um                           x86_64_defconfig
arm                          pcm027_defconfig
powerpc                 mpc8315_rdb_defconfig
arm                             mxs_defconfig
arm                   milbeaut_m10v_defconfig
sh                          lboxre2_defconfig
m68k                        m5307c3_defconfig
m68k                        mvme16x_defconfig
powerpc                        fsp2_defconfig
sh                      rts7751r2d1_defconfig
sh                           se7750_defconfig
mips                        omega2p_defconfig
arm                      pxa255-idp_defconfig
m68k                       m5208evb_defconfig
openrisc                            defconfig
m68k                       bvme6000_defconfig
arc                            hsdk_defconfig
arm                        neponset_defconfig
powerpc                      pmac32_defconfig
ia64                        generic_defconfig
arm                        vexpress_defconfig
m68k                        m5272c3_defconfig
mips                           ip27_defconfig
arm64                            alldefconfig
mips                           rs90_defconfig
powerpc                      ppc40x_defconfig
arm                            zeus_defconfig
powerpc                      tqm8xx_defconfig
arm                        mvebu_v5_defconfig
powerpc                     sequoia_defconfig
arm                        mini2440_defconfig
arm                         cm_x300_defconfig
m68k                         apollo_defconfig
mips                             allyesconfig
powerpc                mpc7448_hpc2_defconfig
ia64                            zx1_defconfig
powerpc                       maple_defconfig
arm                             pxa_defconfig
arc                 nsimosci_hs_smp_defconfig
arm                           tegra_defconfig
sh                           se7780_defconfig
powerpc                      chrp32_defconfig
sh                          sdk7786_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                        spear3xx_defconfig
arc                                 defconfig
sh                          kfr2r09_defconfig
arm                       cns3420vb_defconfig
sh                        apsh4ad0a_defconfig
powerpc                     mpc83xx_defconfig
mips                     loongson1b_defconfig
mips                           xway_defconfig
um                                  defconfig
arc                     nsimosci_hs_defconfig
xtensa                  audio_kc705_defconfig
arm                  colibri_pxa270_defconfig
powerpc                     ppa8548_defconfig
arm                         palmz72_defconfig
mips                          ath79_defconfig
powerpc                    adder875_defconfig
powerpc                    socrates_defconfig
powerpc                       eiger_defconfig
mips                         cobalt_defconfig
mips                  maltasmvp_eva_defconfig
arc                           tb10x_defconfig
xtensa                           alldefconfig
powerpc                     skiroot_defconfig
ia64                             allmodconfig
powerpc                 linkstation_defconfig
powerpc                     mpc512x_defconfig
arm                        oxnas_v6_defconfig
powerpc                        cell_defconfig
arm                          pxa168_defconfig
x86_64               randconfig-c001-20210918
arm                  randconfig-c002-20210918
x86_64               randconfig-c001-20210919
i386                 randconfig-c001-20210919
arm                  randconfig-c002-20210919
x86_64               randconfig-c001-20210916
arm                  randconfig-c002-20210916
ia64                             allyesconfig
m68k                                defconfig
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
h8300                            allyesconfig
sh                               allmodconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                                defconfig
s390                             allmodconfig
s390                             allyesconfig
parisc                           allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20210919
x86_64               randconfig-a004-20210919
x86_64               randconfig-a006-20210919
x86_64               randconfig-a003-20210919
x86_64               randconfig-a001-20210919
x86_64               randconfig-a005-20210919
i386                 randconfig-a004-20210919
i386                 randconfig-a005-20210919
i386                 randconfig-a002-20210919
i386                 randconfig-a006-20210919
i386                 randconfig-a001-20210919
i386                 randconfig-a003-20210919
i386                 randconfig-a004-20210917
i386                 randconfig-a005-20210917
i386                 randconfig-a006-20210917
i386                 randconfig-a002-20210917
i386                 randconfig-a003-20210917
i386                 randconfig-a001-20210917
x86_64               randconfig-a013-20210918
x86_64               randconfig-a016-20210918
x86_64               randconfig-a012-20210918
x86_64               randconfig-a011-20210918
x86_64               randconfig-a014-20210918
x86_64               randconfig-a015-20210918
i386                 randconfig-a016-20210916
i386                 randconfig-a015-20210916
i386                 randconfig-a011-20210916
i386                 randconfig-a012-20210916
i386                 randconfig-a013-20210916
i386                 randconfig-a014-20210916
i386                 randconfig-a016-20210918
i386                 randconfig-a012-20210918
i386                 randconfig-a011-20210918
i386                 randconfig-a015-20210918
i386                 randconfig-a013-20210918
i386                 randconfig-a014-20210918
riscv                randconfig-r042-20210916
s390                 randconfig-r044-20210916
arc                  randconfig-r043-20210916
riscv                    nommu_k210_defconfig
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
x86_64                           allyesconfig

clang tested configs:
riscv                randconfig-c006-20210917
x86_64               randconfig-c007-20210917
mips                 randconfig-c004-20210917
powerpc              randconfig-c003-20210917
arm                  randconfig-c002-20210917
i386                 randconfig-c001-20210917
s390                 randconfig-c005-20210917
riscv                randconfig-c006-20210918
x86_64               randconfig-c007-20210918
powerpc              randconfig-c003-20210918
mips                 randconfig-c004-20210918
i386                 randconfig-c001-20210918
arm                  randconfig-c002-20210918
s390                 randconfig-c005-20210918
riscv                randconfig-c006-20210919
x86_64               randconfig-c007-20210919
powerpc              randconfig-c003-20210919
mips                 randconfig-c004-20210919
i386                 randconfig-c001-20210919
arm                  randconfig-c002-20210919
s390                 randconfig-c005-20210919
x86_64               randconfig-a002-20210916
x86_64               randconfig-a003-20210916
x86_64               randconfig-a006-20210916
x86_64               randconfig-a004-20210916
x86_64               randconfig-a005-20210916
x86_64               randconfig-a001-20210916
x86_64               randconfig-a002-20210918
x86_64               randconfig-a004-20210918
x86_64               randconfig-a006-20210918
x86_64               randconfig-a003-20210918
x86_64               randconfig-a001-20210918
x86_64               randconfig-a005-20210918
i386                 randconfig-a004-20210916
i386                 randconfig-a005-20210916
i386                 randconfig-a006-20210916
i386                 randconfig-a002-20210916
i386                 randconfig-a003-20210916
i386                 randconfig-a001-20210916
i386                 randconfig-a004-20210918
i386                 randconfig-a005-20210918
i386                 randconfig-a002-20210918
i386                 randconfig-a006-20210918
i386                 randconfig-a001-20210918
i386                 randconfig-a003-20210918
x86_64               randconfig-a016-20210917
x86_64               randconfig-a013-20210917
x86_64               randconfig-a012-20210917
x86_64               randconfig-a011-20210917
x86_64               randconfig-a014-20210917
x86_64               randconfig-a015-20210917
x86_64               randconfig-a013-20210919
x86_64               randconfig-a016-20210919
x86_64               randconfig-a012-20210919
x86_64               randconfig-a011-20210919
x86_64               randconfig-a014-20210919
x86_64               randconfig-a015-20210919
i386                 randconfig-a016-20210919
i386                 randconfig-a012-20210919
i386                 randconfig-a011-20210919
i386                 randconfig-a015-20210919
i386                 randconfig-a013-20210919
i386                 randconfig-a014-20210919
hexagon              randconfig-r045-20210918
hexagon              randconfig-r041-20210918
hexagon              randconfig-r045-20210916
hexagon              randconfig-r041-20210916

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
