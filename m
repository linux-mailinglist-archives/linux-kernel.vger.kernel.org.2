Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF743F7FA2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 03:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235484AbhHZBFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 21:05:24 -0400
Received: from mga02.intel.com ([134.134.136.20]:1473 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232139AbhHZBFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 21:05:23 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10087"; a="204843451"
X-IronPort-AV: E=Sophos;i="5.84,352,1620716400"; 
   d="scan'208";a="204843451"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2021 18:04:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,352,1620716400"; 
   d="scan'208";a="516285659"
Received: from lkp-server01.sh.intel.com (HELO 4fbc2b3ce5aa) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 25 Aug 2021 18:04:34 -0700
Received: from kbuild by 4fbc2b3ce5aa with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mJ3oo-0000e1-7r; Thu, 26 Aug 2021 01:04:34 +0000
Date:   Thu, 26 Aug 2021 09:04:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:auto-latest] BUILD SUCCESS
 32df9c49c98ff26881cd805a56045ddf8b38b2af
Message-ID: <6126e89a.tpiDnF2m4hg19a9i%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git auto-latest
branch HEAD: 32df9c49c98ff26881cd805a56045ddf8b38b2af  Merge branch 'core/debugobjects'

elapsed time: 5302m

configs tested: 189
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210824
sh                           se7751_defconfig
arm                       aspeed_g5_defconfig
sh                          sdk7786_defconfig
m68k                          sun3x_defconfig
sh                             shx3_defconfig
sh                        sh7757lcr_defconfig
powerpc                    adder875_defconfig
powerpc                       ebony_defconfig
arm                            xcep_defconfig
riscv                          rv32_defconfig
sh                          rsk7201_defconfig
sh                           se7206_defconfig
mips                           jazz_defconfig
arm                       spear13xx_defconfig
arm                          pxa910_defconfig
m68k                                defconfig
s390                       zfcpdump_defconfig
arm                       aspeed_g4_defconfig
arm                         s5pv210_defconfig
powerpc                      acadia_defconfig
mips                         tb0287_defconfig
powerpc                 mpc832x_mds_defconfig
mips                            e55_defconfig
microblaze                      mmu_defconfig
mips                        bcm63xx_defconfig
arm                         nhk8815_defconfig
riscv                            alldefconfig
mips                            gpr_defconfig
h8300                               defconfig
powerpc                     stx_gp3_defconfig
arm                            mps2_defconfig
powerpc                  mpc866_ads_defconfig
mips                           gcw0_defconfig
powerpc64                           defconfig
mips                           mtx1_defconfig
m68k                         amcore_defconfig
powerpc                      katmai_defconfig
powerpc                    amigaone_defconfig
sh                          rsk7269_defconfig
powerpc                      mgcoge_defconfig
powerpc               mpc834x_itxgp_defconfig
powerpc64                        alldefconfig
riscv                    nommu_k210_defconfig
nds32                               defconfig
openrisc                         alldefconfig
sh                           se7712_defconfig
arm                           stm32_defconfig
mips                 decstation_r4k_defconfig
powerpc                 mpc8540_ads_defconfig
arc                         haps_hs_defconfig
nios2                            allyesconfig
powerpc                 mpc8272_ads_defconfig
arc                      axs103_smp_defconfig
sh                ecovec24-romimage_defconfig
arm                          badge4_defconfig
sh                     sh7710voipgw_defconfig
arc                     haps_hs_smp_defconfig
powerpc                 linkstation_defconfig
mips                          ath79_defconfig
arm                          lpd270_defconfig
arm                         cm_x300_defconfig
mips                        workpad_defconfig
arm                          moxart_defconfig
arm                           corgi_defconfig
xtensa                  audio_kc705_defconfig
mips                   sb1250_swarm_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
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
x86_64               randconfig-a005-20210824
x86_64               randconfig-a006-20210824
x86_64               randconfig-a001-20210824
x86_64               randconfig-a003-20210824
x86_64               randconfig-a004-20210824
x86_64               randconfig-a002-20210824
x86_64               randconfig-a005-20210822
x86_64               randconfig-a006-20210822
x86_64               randconfig-a001-20210822
x86_64               randconfig-a003-20210822
x86_64               randconfig-a004-20210822
x86_64               randconfig-a002-20210822
i386                 randconfig-a006-20210822
i386                 randconfig-a001-20210822
i386                 randconfig-a002-20210822
i386                 randconfig-a005-20210822
i386                 randconfig-a003-20210822
i386                 randconfig-a004-20210822
i386                 randconfig-a006-20210824
i386                 randconfig-a001-20210824
i386                 randconfig-a002-20210824
i386                 randconfig-a005-20210824
i386                 randconfig-a003-20210824
i386                 randconfig-a004-20210824
i386                 randconfig-a011-20210825
i386                 randconfig-a016-20210825
i386                 randconfig-a012-20210825
i386                 randconfig-a014-20210825
i386                 randconfig-a013-20210825
i386                 randconfig-a015-20210825
arc                  randconfig-r043-20210822
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
i386                 randconfig-c001-20210822
s390                 randconfig-c005-20210822
arm                  randconfig-c002-20210822
riscv                randconfig-c006-20210822
powerpc              randconfig-c003-20210822
x86_64               randconfig-c007-20210822
mips                 randconfig-c004-20210822
i386                 randconfig-c001-20210824
s390                 randconfig-c005-20210824
arm                  randconfig-c002-20210824
riscv                randconfig-c006-20210824
x86_64               randconfig-c007-20210824
mips                 randconfig-c004-20210824
x86_64               randconfig-a014-20210822
x86_64               randconfig-a016-20210822
x86_64               randconfig-a015-20210822
x86_64               randconfig-a013-20210822
x86_64               randconfig-a012-20210822
x86_64               randconfig-a011-20210822
x86_64               randconfig-a014-20210824
x86_64               randconfig-a015-20210824
x86_64               randconfig-a016-20210824
x86_64               randconfig-a013-20210824
x86_64               randconfig-a012-20210824
x86_64               randconfig-a011-20210824
i386                 randconfig-a011-20210824
i386                 randconfig-a016-20210824
i386                 randconfig-a012-20210824
i386                 randconfig-a014-20210824
i386                 randconfig-a013-20210824
i386                 randconfig-a015-20210824
i386                 randconfig-a011-20210822
i386                 randconfig-a016-20210822
i386                 randconfig-a012-20210822
i386                 randconfig-a014-20210822
i386                 randconfig-a013-20210822
i386                 randconfig-a015-20210822
hexagon              randconfig-r041-20210822
hexagon              randconfig-r045-20210822
riscv                randconfig-r042-20210822
s390                 randconfig-r044-20210822
hexagon              randconfig-r041-20210824
hexagon              randconfig-r045-20210824
riscv                randconfig-r042-20210824
s390                 randconfig-r044-20210824

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
