Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D37441115
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Oct 2021 22:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbhJaVzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 17:55:12 -0400
Received: from mga12.intel.com ([192.55.52.136]:19005 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230025AbhJaVzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 17:55:11 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10154"; a="210971193"
X-IronPort-AV: E=Sophos;i="5.87,198,1631602800"; 
   d="scan'208";a="210971193"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2021 14:52:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,198,1631602800"; 
   d="scan'208";a="598834623"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 31 Oct 2021 14:52:35 -0700
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mhIkl-0002pa-3W; Sun, 31 Oct 2021 21:52:35 +0000
Date:   Mon, 01 Nov 2021 05:52:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/core] BUILD SUCCESS
 a72fdfd21e01c626273ddcf5ab740d4caef4be54
Message-ID: <617f100e.2fP65zZlaYIrEUN5%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
branch HEAD: a72fdfd21e01c626273ddcf5ab740d4caef4be54  selftests/x86/iopl: Adjust to the faked iopl CLI/STI usage

elapsed time: 1419m

configs tested: 169
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                         tb0287_defconfig
powerpc                 mpc8540_ads_defconfig
m68k                        m5407c3_defconfig
arc                        nsimosci_defconfig
sh                           se7721_defconfig
arm                           corgi_defconfig
arm                     am200epdkit_defconfig
powerpc                     mpc83xx_defconfig
xtensa                  cadence_csp_defconfig
arm                         axm55xx_defconfig
sparc                       sparc64_defconfig
sh                   sh7770_generic_defconfig
xtensa                           alldefconfig
arm                          pxa168_defconfig
mips                           ci20_defconfig
arm                    vt8500_v6_v7_defconfig
mips                  cavium_octeon_defconfig
powerpc                 mpc8313_rdb_defconfig
arm                             ezx_defconfig
sh                   secureedge5410_defconfig
arm                            mps2_defconfig
sh                      rts7751r2d1_defconfig
sh                           se7206_defconfig
i386                                defconfig
powerpc                     mpc512x_defconfig
riscv                          rv32_defconfig
sh                           se7780_defconfig
sh                           se7750_defconfig
mips                        workpad_defconfig
powerpc                      ppc64e_defconfig
arm                        keystone_defconfig
mips                        vocore2_defconfig
mips                      maltasmvp_defconfig
xtensa                generic_kc705_defconfig
sh                          rsk7269_defconfig
m68k                       m5208evb_defconfig
sh                        edosk7760_defconfig
s390                             alldefconfig
arm                       omap2plus_defconfig
m68k                          atari_defconfig
arm                         palmz72_defconfig
mips                           ip32_defconfig
powerpc                     ppa8548_defconfig
xtensa                  nommu_kc705_defconfig
h8300                     edosk2674_defconfig
powerpc                   lite5200b_defconfig
riscv                    nommu_virt_defconfig
xtensa                              defconfig
arm                         hackkit_defconfig
um                             i386_defconfig
arm                           omap1_defconfig
alpha                            allyesconfig
mips                         rt305x_defconfig
arm                         s3c6400_defconfig
sh                ecovec24-romimage_defconfig
ia64                      gensparse_defconfig
arm                      jornada720_defconfig
xtensa                    xip_kc705_defconfig
mips                         bigsur_defconfig
riscv             nommu_k210_sdcard_defconfig
powerpc                    socrates_defconfig
powerpc                     rainier_defconfig
sh                           se7619_defconfig
csky                                defconfig
powerpc                     redwood_defconfig
arm                        shmobile_defconfig
powerpc                     tqm5200_defconfig
arm                           tegra_defconfig
arm                        mvebu_v5_defconfig
mips                             allmodconfig
mips                  decstation_64_defconfig
powerpc                      arches_defconfig
xtensa                    smp_lx200_defconfig
powerpc                      katmai_defconfig
powerpc                        warp_defconfig
arm                        oxnas_v6_defconfig
mips                         db1xxx_defconfig
sh                          r7785rp_defconfig
arm                        multi_v5_defconfig
ia64                             alldefconfig
m68k                         apollo_defconfig
sh                            titan_defconfig
mips                        maltaup_defconfig
arm                          iop32x_defconfig
mips                   sb1250_swarm_defconfig
mips                             allyesconfig
arm                             rpc_defconfig
sh                        sh7757lcr_defconfig
arm                  randconfig-c002-20211031
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                               defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
parisc                              defconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                              debian-10.3
i386                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20211031
i386                 randconfig-a006-20211031
i386                 randconfig-a002-20211031
i386                 randconfig-a005-20211031
i386                 randconfig-a001-20211031
i386                 randconfig-a004-20211031
x86_64               randconfig-a005-20211031
x86_64               randconfig-a004-20211031
x86_64               randconfig-a002-20211031
x86_64               randconfig-a003-20211031
x86_64               randconfig-a001-20211031
x86_64               randconfig-a006-20211031
arc                  randconfig-r043-20211031
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allyesconfig
riscv                            allmodconfig
um                           x86_64_defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
powerpc              randconfig-c003-20211031
riscv                randconfig-c006-20211031
x86_64               randconfig-c007-20211031
mips                 randconfig-c004-20211031
s390                 randconfig-c005-20211031
arm                  randconfig-c002-20211031
i386                 randconfig-c001-20211031
x86_64               randconfig-a013-20211031
x86_64               randconfig-a015-20211031
x86_64               randconfig-a014-20211031
x86_64               randconfig-a011-20211031
x86_64               randconfig-a016-20211031
x86_64               randconfig-a012-20211031
i386                 randconfig-a013-20211031
i386                 randconfig-a012-20211031
i386                 randconfig-a014-20211031
i386                 randconfig-a015-20211031
i386                 randconfig-a011-20211031
i386                 randconfig-a016-20211031
riscv                randconfig-r042-20211031
s390                 randconfig-r044-20211031
hexagon              randconfig-r045-20211031
hexagon              randconfig-r041-20211031

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
