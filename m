Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C32A3455385
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 04:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242801AbhKRDsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 22:48:35 -0500
Received: from mga01.intel.com ([192.55.52.88]:63374 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238553AbhKRDse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 22:48:34 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10171"; a="257883592"
X-IronPort-AV: E=Sophos;i="5.87,243,1631602800"; 
   d="scan'208";a="257883592"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2021 19:45:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,243,1631602800"; 
   d="scan'208";a="672647867"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 17 Nov 2021 19:45:33 -0800
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mnYMe-0002dt-Nd; Thu, 18 Nov 2021 03:45:32 +0000
Date:   Thu, 18 Nov 2021 11:45:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/sgx] BUILD SUCCESS
 379e4de9e140850cf699dd390f21ea4b923c955d
Message-ID: <6195cc56.khgKdgysEKY5EZnl%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/sgx
branch HEAD: 379e4de9e140850cf699dd390f21ea4b923c955d  x86/sgx: Fix minor documentation issues

elapsed time: 727m

configs tested: 174
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211117
i386                 randconfig-c001-20211118
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
alpha                               defconfig
powerpc                     stx_gp3_defconfig
arc                     nsimosci_hs_defconfig
arm                         hackkit_defconfig
xtensa                    xip_kc705_defconfig
sh                        edosk7760_defconfig
arm                       aspeed_g5_defconfig
mips                         mpc30x_defconfig
powerpc                      pasemi_defconfig
mips                           jazz_defconfig
mips                malta_qemu_32r6_defconfig
sparc                       sparc64_defconfig
i386                                defconfig
sh                          kfr2r09_defconfig
riscv                             allnoconfig
mips                          ath79_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                    ge_imp3a_defconfig
um                           x86_64_defconfig
sh                   secureedge5410_defconfig
s390                             allmodconfig
mips                      loongson3_defconfig
sh                   sh7724_generic_defconfig
mips                      malta_kvm_defconfig
powerpc                 mpc832x_mds_defconfig
h8300                    h8300h-sim_defconfig
m68k                           sun3_defconfig
sh                          lboxre2_defconfig
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
csky                                defconfig
m68k                       m5475evb_defconfig
m68k                        m5307c3_defconfig
m68k                          amiga_defconfig
powerpc                      arches_defconfig
arm                      integrator_defconfig
m68k                                defconfig
sh                             espt_defconfig
arm                         lubbock_defconfig
mips                        bcm47xx_defconfig
arm                          simpad_defconfig
um                             i386_defconfig
powerpc                       holly_defconfig
xtensa                              defconfig
arm                            mps2_defconfig
arm                          collie_defconfig
sh                        edosk7705_defconfig
mips                  cavium_octeon_defconfig
mips                     cu1000-neo_defconfig
arm                       netwinder_defconfig
arm                  colibri_pxa270_defconfig
powerpc                      tqm8xx_defconfig
powerpc                  mpc866_ads_defconfig
arm                         s3c6400_defconfig
powerpc                      ppc6xx_defconfig
powerpc                     tqm8560_defconfig
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
mips                         tb0287_defconfig
powerpc64                           defconfig
powerpc                      acadia_defconfig
arm                       versatile_defconfig
arm                            dove_defconfig
arm                  randconfig-c002-20211117
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
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
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
arc                  randconfig-r043-20211117
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c007-20211117
i386                 randconfig-c001-20211117
arm                  randconfig-c002-20211117
riscv                randconfig-c006-20211117
powerpc              randconfig-c003-20211117
s390                 randconfig-c005-20211117
mips                 randconfig-c004-20211117
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

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
