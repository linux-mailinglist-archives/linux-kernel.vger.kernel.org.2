Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0A538842A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 02:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhESAzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 20:55:51 -0400
Received: from mga03.intel.com ([134.134.136.65]:55938 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229485AbhESAzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 20:55:47 -0400
IronPort-SDR: iXINgL8m/ImT6oc8pCsm+FeLtAl/ulUVHyGXz9poFeXFT/DF25ANhBHSZbr/dbE6L4H9s3BUoZ
 4nsxxlizpvfw==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="200918253"
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="200918253"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 17:54:26 -0700
IronPort-SDR: bJsS3WxwCEtgnTeD4WjhXKkCq7IoU5XFUb23p15exmRxHtxIaaMOcr4pYBdBdmRGPOuVQ9bJKW
 9c1FDIHMTkZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="461015864"
Received: from lkp-server01.sh.intel.com (HELO ddd90b05c979) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 18 May 2021 17:54:25 -0700
Received: from kbuild by ddd90b05c979 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ljATg-0002Q8-Fl; Wed, 19 May 2021 00:54:24 +0000
Date:   Wed, 19 May 2021 08:54:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/apic] BUILD SUCCESS
 1dcc917a0eed934c522d93bb05a9a7bb3c54f96c
Message-ID: <60a461b0.KnjL/iwqNoeBVSkL%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/apic
branch HEAD: 1dcc917a0eed934c522d93bb05a9a7bb3c54f96c  x86/idt: Rework IDT setup for boot CPU

elapsed time: 724m

configs tested: 200
configs skipped: 66

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                        spear6xx_defconfig
mips                           rs90_defconfig
arm                           omap1_defconfig
xtensa                       common_defconfig
microblaze                      mmu_defconfig
mips                        nlm_xlp_defconfig
powerpc64                           defconfig
m68k                          atari_defconfig
powerpc                     ep8248e_defconfig
alpha                               defconfig
arm                          lpd270_defconfig
sh                          rsk7264_defconfig
ia64                          tiger_defconfig
mips                        bcm47xx_defconfig
sh                          landisk_defconfig
arc                      axs103_smp_defconfig
mips                           xway_defconfig
csky                             alldefconfig
powerpc                     tqm8555_defconfig
sh                           se7722_defconfig
mips                         mpc30x_defconfig
um                            kunit_defconfig
powerpc                      makalu_defconfig
powerpc                 mpc8315_rdb_defconfig
mips                           ip27_defconfig
sparc64                          alldefconfig
mips                          rb532_defconfig
mips                            gpr_defconfig
sh                     magicpanelr2_defconfig
arm                          gemini_defconfig
sh                             espt_defconfig
sh                        apsh4ad0a_defconfig
sparc                       sparc32_defconfig
sh                              ul2_defconfig
sh                      rts7751r2d1_defconfig
xtensa                generic_kc705_defconfig
arm64                            alldefconfig
xtensa                    smp_lx200_defconfig
i386                                defconfig
sh                            hp6xx_defconfig
mips                           ip28_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                      cm5200_defconfig
arm                           viper_defconfig
arc                        nsimosci_defconfig
i386                             alldefconfig
openrisc                  or1klitex_defconfig
sh                          kfr2r09_defconfig
mips                      malta_kvm_defconfig
arm                             rpc_defconfig
powerpc                   lite5200b_defconfig
arm                          iop32x_defconfig
ia64                            zx1_defconfig
powerpc                 mpc834x_mds_defconfig
mips                   sb1250_swarm_defconfig
sh                          urquell_defconfig
arm                        realview_defconfig
mips                           ip32_defconfig
sh                          rsk7201_defconfig
arm                         shannon_defconfig
sh                   secureedge5410_defconfig
mips                       rbtx49xx_defconfig
arm                        multi_v7_defconfig
m68k                         apollo_defconfig
arm                           h3600_defconfig
arm                      footbridge_defconfig
arm                            hisi_defconfig
arm                          exynos_defconfig
powerpc                     tqm8541_defconfig
mips                        qi_lb60_defconfig
x86_64                            allnoconfig
m68k                           sun3_defconfig
arm                         lpc18xx_defconfig
mips                  maltasmvp_eva_defconfig
sh                          sdk7786_defconfig
csky                                defconfig
nios2                         3c120_defconfig
parisc                generic-64bit_defconfig
x86_64                              defconfig
arm                       multi_v4t_defconfig
arm                      integrator_defconfig
mips                     loongson2k_defconfig
sparc                               defconfig
arm                          ep93xx_defconfig
arm                           h5000_defconfig
xtensa                  nommu_kc705_defconfig
sh                           se7206_defconfig
x86_64                           allyesconfig
mips                malta_qemu_32r6_defconfig
powerpc                       eiger_defconfig
powerpc                        icon_defconfig
xtensa                    xip_kc705_defconfig
m68k                        mvme16x_defconfig
powerpc                    klondike_defconfig
powerpc                     tqm8560_defconfig
microblaze                          defconfig
powerpc                 mpc834x_itx_defconfig
nds32                               defconfig
s390                             allyesconfig
arm                         assabet_defconfig
arm                       imx_v4_v5_defconfig
sparc                       sparc64_defconfig
arm                          pxa168_defconfig
arm                          collie_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nios2                            allyesconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20210518
x86_64               randconfig-a004-20210518
x86_64               randconfig-a005-20210518
x86_64               randconfig-a001-20210518
x86_64               randconfig-a002-20210518
x86_64               randconfig-a006-20210518
i386                 randconfig-a003-20210518
i386                 randconfig-a001-20210518
i386                 randconfig-a005-20210518
i386                 randconfig-a004-20210518
i386                 randconfig-a002-20210518
i386                 randconfig-a006-20210518
i386                 randconfig-a003-20210519
i386                 randconfig-a001-20210519
i386                 randconfig-a005-20210519
i386                 randconfig-a004-20210519
i386                 randconfig-a002-20210519
i386                 randconfig-a006-20210519
x86_64               randconfig-a012-20210519
x86_64               randconfig-a015-20210519
x86_64               randconfig-a013-20210519
x86_64               randconfig-a011-20210519
x86_64               randconfig-a016-20210519
x86_64               randconfig-a014-20210519
i386                 randconfig-a014-20210518
i386                 randconfig-a016-20210518
i386                 randconfig-a011-20210518
i386                 randconfig-a015-20210518
i386                 randconfig-a012-20210518
i386                 randconfig-a013-20210518
i386                 randconfig-a014-20210519
i386                 randconfig-a016-20210519
i386                 randconfig-a011-20210519
i386                 randconfig-a015-20210519
i386                 randconfig-a012-20210519
i386                 randconfig-a013-20210519
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210519
x86_64               randconfig-b001-20210518
x86_64               randconfig-a015-20210518
x86_64               randconfig-a012-20210518
x86_64               randconfig-a013-20210518
x86_64               randconfig-a011-20210518
x86_64               randconfig-a016-20210518
x86_64               randconfig-a014-20210518
x86_64               randconfig-a003-20210519
x86_64               randconfig-a004-20210519
x86_64               randconfig-a005-20210519
x86_64               randconfig-a001-20210519
x86_64               randconfig-a002-20210519
x86_64               randconfig-a006-20210519

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
