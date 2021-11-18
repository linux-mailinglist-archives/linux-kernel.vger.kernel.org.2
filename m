Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDFCC4554DA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 07:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243419AbhKRGio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 01:38:44 -0500
Received: from mga02.intel.com ([134.134.136.20]:14467 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242471AbhKRGij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 01:38:39 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10171"; a="221337899"
X-IronPort-AV: E=Sophos;i="5.87,243,1631602800"; 
   d="scan'208";a="221337899"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2021 22:35:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,243,1631602800"; 
   d="scan'208";a="495246687"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 17 Nov 2021 22:35:37 -0800
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mnb1E-0002md-O2; Thu, 18 Nov 2021 06:35:36 +0000
Date:   Thu, 18 Nov 2021 14:35:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/fpu] BUILD SUCCESS
 0fe4ff885f8a50082d9dc241b657472894caba16
Message-ID: <6195f425.Nc5sXVjMPMDo53ni%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/fpu
branch HEAD: 0fe4ff885f8a50082d9dc241b657472894caba16  x86/fpu: Correct AVX512 state tracking

elapsed time: 722m

configs tested: 231
configs skipped: 70

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211118
i386                 randconfig-c001-20211117
mips                           ip27_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                         s5pv210_defconfig
arm                        cerfcube_defconfig
sh                           se7343_defconfig
sh                ecovec24-romimage_defconfig
m68k                          multi_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                      jornada720_defconfig
sh                          rsk7269_defconfig
riscv                            alldefconfig
powerpc                     stx_gp3_defconfig
arc                     nsimosci_hs_defconfig
arm                         hackkit_defconfig
xtensa                    xip_kc705_defconfig
sh                        edosk7760_defconfig
arm                       aspeed_g5_defconfig
mips                         mpc30x_defconfig
i386                             allyesconfig
m68k                        mvme16x_defconfig
mips                        vocore2_defconfig
mips                         cobalt_defconfig
powerpc                      pasemi_defconfig
mips                           jazz_defconfig
mips                malta_qemu_32r6_defconfig
sparc                       sparc64_defconfig
i386                                defconfig
m68k                          atari_defconfig
mips                       rbtx49xx_defconfig
arm                          badge4_defconfig
powerpc                     tqm8540_defconfig
powerpc                     mpc512x_defconfig
riscv                    nommu_k210_defconfig
arm                           sama7_defconfig
arm                        mvebu_v7_defconfig
sh                        sh7785lcr_defconfig
sh                          kfr2r09_defconfig
riscv                             allnoconfig
mips                          ath79_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                    ge_imp3a_defconfig
sh                   secureedge5410_defconfig
mips                      loongson3_defconfig
i386                             alldefconfig
arm                         lpc18xx_defconfig
arm                         socfpga_defconfig
sh                             espt_defconfig
sh                            hp6xx_defconfig
mips                           ip22_defconfig
sh                   sh7724_generic_defconfig
mips                      malta_kvm_defconfig
powerpc                 mpc832x_mds_defconfig
h8300                    h8300h-sim_defconfig
m68k                           sun3_defconfig
sh                          lboxre2_defconfig
mips                           gcw0_defconfig
arm                         axm55xx_defconfig
powerpc                      obs600_defconfig
powerpc                     tqm8555_defconfig
mips                      maltaaprp_defconfig
sh                                  defconfig
mips                            ar7_defconfig
powerpc                 mpc8560_ads_defconfig
mips                        bcm47xx_defconfig
powerpc                     tqm8548_defconfig
powerpc                     akebono_defconfig
powerpc                      chrp32_defconfig
powerpc                mpc7448_hpc2_defconfig
sh                              ul2_defconfig
powerpc                    socrates_defconfig
powerpc                    klondike_defconfig
sh                          sdk7786_defconfig
arm                        mvebu_v5_defconfig
arm                          iop32x_defconfig
mips                      fuloong2e_defconfig
ia64                          tiger_defconfig
csky                             alldefconfig
m68k                       m5475evb_defconfig
m68k                        m5307c3_defconfig
m68k                          amiga_defconfig
powerpc                      arches_defconfig
arm                      integrator_defconfig
m68k                                defconfig
arm                         lubbock_defconfig
arm                          simpad_defconfig
mips                  cavium_octeon_defconfig
powerpc                    amigaone_defconfig
arc                 nsimosci_hs_smp_defconfig
m68k                        mvme147_defconfig
powerpc                 canyonlands_defconfig
mips                     cu1000-neo_defconfig
arm                       netwinder_defconfig
arm                  colibri_pxa270_defconfig
m68k                          hp300_defconfig
arm                       imx_v6_v7_defconfig
arm                             mxs_defconfig
arm                           tegra_defconfig
mips                     decstation_defconfig
mips                         db1xxx_defconfig
sh                        sh7763rdp_defconfig
arm                          pxa910_defconfig
mips                           mtx1_defconfig
parisc                generic-64bit_defconfig
powerpc                     asp8347_defconfig
arm                           stm32_defconfig
arm                        magician_defconfig
arm                         assabet_defconfig
mips                     cu1830-neo_defconfig
mips                         bigsur_defconfig
powerpc                      cm5200_defconfig
arm                          exynos_defconfig
openrisc                         alldefconfig
powerpc                      mgcoge_defconfig
xtensa                          iss_defconfig
xtensa                              defconfig
arm                  randconfig-c002-20211117
arm                  randconfig-c002-20211118
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
sparc                            allyesconfig
sparc                               defconfig
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a005-20211117
x86_64               randconfig-a003-20211117
x86_64               randconfig-a002-20211117
x86_64               randconfig-a001-20211117
x86_64               randconfig-a006-20211117
x86_64               randconfig-a004-20211117
i386                 randconfig-a006-20211117
i386                 randconfig-a003-20211117
i386                 randconfig-a005-20211117
i386                 randconfig-a001-20211117
i386                 randconfig-a004-20211117
i386                 randconfig-a002-20211117
x86_64               randconfig-a015-20211118
x86_64               randconfig-a012-20211118
x86_64               randconfig-a011-20211118
x86_64               randconfig-a013-20211118
x86_64               randconfig-a016-20211118
x86_64               randconfig-a014-20211118
i386                 randconfig-a016-20211118
i386                 randconfig-a014-20211118
i386                 randconfig-a012-20211118
i386                 randconfig-a011-20211118
i386                 randconfig-a013-20211118
i386                 randconfig-a015-20211118
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
i386                 randconfig-c001-20211118
x86_64               randconfig-c007-20211118
arm                  randconfig-c002-20211118
s390                 randconfig-c005-20211118
powerpc              randconfig-c003-20211118
riscv                randconfig-c006-20211118
mips                 randconfig-c004-20211118
x86_64               randconfig-c007-20211117
i386                 randconfig-c001-20211117
arm                  randconfig-c002-20211117
riscv                randconfig-c006-20211117
powerpc              randconfig-c003-20211117
s390                 randconfig-c005-20211117
mips                 randconfig-c004-20211117
x86_64               randconfig-a005-20211118
x86_64               randconfig-a003-20211118
x86_64               randconfig-a001-20211118
x86_64               randconfig-a002-20211118
x86_64               randconfig-a006-20211118
x86_64               randconfig-a004-20211118
i386                 randconfig-a006-20211118
i386                 randconfig-a003-20211118
i386                 randconfig-a001-20211118
i386                 randconfig-a005-20211118
i386                 randconfig-a004-20211118
i386                 randconfig-a002-20211118
x86_64               randconfig-a015-20211117
x86_64               randconfig-a013-20211117
x86_64               randconfig-a011-20211117
x86_64               randconfig-a012-20211117
x86_64               randconfig-a016-20211117
x86_64               randconfig-a014-20211117
i386                 randconfig-a014-20211117
i386                 randconfig-a016-20211117
i386                 randconfig-a012-20211117
i386                 randconfig-a013-20211117
i386                 randconfig-a011-20211117
i386                 randconfig-a015-20211117
hexagon              randconfig-r045-20211117
hexagon              randconfig-r041-20211117
s390                 randconfig-r044-20211117
riscv                randconfig-r042-20211117
hexagon              randconfig-r045-20211118
hexagon              randconfig-r041-20211118

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
