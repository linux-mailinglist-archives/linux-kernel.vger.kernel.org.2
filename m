Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9F4427566
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 03:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244042AbhJIBdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 21:33:31 -0400
Received: from mga06.intel.com ([134.134.136.31]:10916 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232063AbhJIBd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 21:33:29 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10131"; a="287501965"
X-IronPort-AV: E=Sophos;i="5.85,358,1624345200"; 
   d="scan'208";a="287501965"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2021 18:31:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,358,1624345200"; 
   d="scan'208";a="479169783"
Received: from lkp-server02.sh.intel.com (HELO 1950922c5479) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 08 Oct 2021 18:31:31 -0700
Received: from kbuild by 1950922c5479 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mZ1D1-0000wh-1F; Sat, 09 Oct 2021 01:31:31 +0000
Date:   Sat, 09 Oct 2021 09:30:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:auto-latest] BUILD SUCCESS
 a6d06ef25c4e1a17d287aafcc200e82ecb7644a8
Message-ID: <6160f0b6.mOB25WgEpwhakf3H%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git auto-latest
branch HEAD: a6d06ef25c4e1a17d287aafcc200e82ecb7644a8  Merge branch 'irq/core'

elapsed time: 2306m

configs tested: 222
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211008
powerpc              randconfig-c003-20211008
s390                          debug_defconfig
parisc                generic-32bit_defconfig
m68k                       bvme6000_defconfig
arm                            hisi_defconfig
sh                            hp6xx_defconfig
powerpc                   motionpro_defconfig
arc                 nsimosci_hs_smp_defconfig
m68k                          atari_defconfig
powerpc                      ppc40x_defconfig
powerpc                     stx_gp3_defconfig
m68k                          multi_defconfig
openrisc                            defconfig
m68k                         amcore_defconfig
arm                      pxa255-idp_defconfig
mips                          rb532_defconfig
mips                            gpr_defconfig
sh                           se7722_defconfig
sparc                            allyesconfig
sh                           sh2007_defconfig
arm                         orion5x_defconfig
m68k                          hp300_defconfig
mips                     loongson1b_defconfig
mips                        qi_lb60_defconfig
xtensa                       common_defconfig
powerpc                  mpc866_ads_defconfig
arm                         bcm2835_defconfig
powerpc                      cm5200_defconfig
microblaze                      mmu_defconfig
powerpc                    socrates_defconfig
m68k                          amiga_defconfig
arm                        realview_defconfig
mips                      loongson3_defconfig
sh                   secureedge5410_defconfig
ia64                        generic_defconfig
mips                        maltaup_defconfig
powerpc                      ppc64e_defconfig
xtensa                  audio_kc705_defconfig
alpha                            allyesconfig
mips                         rt305x_defconfig
arm                            zeus_defconfig
arm                         socfpga_defconfig
arm                           corgi_defconfig
sh                          sdk7786_defconfig
powerpc                       holly_defconfig
arm                     am200epdkit_defconfig
sh                            migor_defconfig
arc                      axs103_smp_defconfig
powerpc                      bamboo_defconfig
arm                        keystone_defconfig
m68k                        mvme147_defconfig
sh                           se7721_defconfig
s390                       zfcpdump_defconfig
m68k                       m5475evb_defconfig
sparc                            alldefconfig
sparc                       sparc64_defconfig
sh                        sh7757lcr_defconfig
arc                          axs101_defconfig
sh                          kfr2r09_defconfig
mips                     cu1830-neo_defconfig
arm                        shmobile_defconfig
riscv                    nommu_virt_defconfig
sh                        apsh4ad0a_defconfig
mips                          ath25_defconfig
mips                        nlm_xlp_defconfig
powerpc                 mpc832x_mds_defconfig
arm                            xcep_defconfig
ia64                             alldefconfig
sh                          rsk7264_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                          g5_defconfig
riscv                               defconfig
arm                     eseries_pxa_defconfig
mips                           rs90_defconfig
arm                         palmz72_defconfig
arm                        vexpress_defconfig
mips                       rbtx49xx_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                   lite5200b_defconfig
arm                       multi_v4t_defconfig
arm                        multi_v7_defconfig
h8300                       h8s-sim_defconfig
sh                         ecovec24_defconfig
sh                           se7705_defconfig
sh                          r7785rp_defconfig
mips                     loongson1c_defconfig
sparc64                          alldefconfig
arm                          moxart_defconfig
arm                           sama5_defconfig
arc                     nsimosci_hs_defconfig
m68k                        stmark2_defconfig
riscv                            alldefconfig
arc                        nsim_700_defconfig
mips                  decstation_64_defconfig
sh                     sh7710voipgw_defconfig
arm                         s3c6400_defconfig
powerpc                     tqm8560_defconfig
arm                     davinci_all_defconfig
sh                          polaris_defconfig
xtensa                          iss_defconfig
powerpc                     ksi8560_defconfig
mips                        bcm63xx_defconfig
powerpc                      tqm8xx_defconfig
m68k                         apollo_defconfig
powerpc                mpc7448_hpc2_defconfig
ia64                      gensparse_defconfig
x86_64               randconfig-c001-20211008
arm                  randconfig-c002-20211008
x86_64               randconfig-c001-20211003
i386                 randconfig-c001-20211003
arm                  randconfig-c002-20211003
x86_64               randconfig-c001-20211004
i386                 randconfig-c001-20211004
arm                  randconfig-c002-20211004
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
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
parisc                              defconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
s390                             allmodconfig
sparc                               defconfig
i386                                defconfig
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a015-20211004
x86_64               randconfig-a012-20211004
x86_64               randconfig-a016-20211004
x86_64               randconfig-a014-20211004
x86_64               randconfig-a013-20211004
x86_64               randconfig-a011-20211004
x86_64               randconfig-a015-20211008
x86_64               randconfig-a012-20211008
x86_64               randconfig-a016-20211008
x86_64               randconfig-a013-20211008
x86_64               randconfig-a011-20211008
x86_64               randconfig-a014-20211008
i386                 randconfig-a013-20211004
i386                 randconfig-a016-20211004
i386                 randconfig-a014-20211004
i386                 randconfig-a011-20211004
i386                 randconfig-a012-20211004
i386                 randconfig-a015-20211004
i386                 randconfig-a013-20211008
i386                 randconfig-a016-20211008
i386                 randconfig-a014-20211008
i386                 randconfig-a011-20211008
i386                 randconfig-a012-20211008
i386                 randconfig-a015-20211008
arc                  randconfig-r043-20211008
s390                 randconfig-r044-20211008
riscv                randconfig-r042-20211008
arc                  randconfig-r043-20211007
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
x86_64               randconfig-c007-20211008
i386                 randconfig-c001-20211008
arm                  randconfig-c002-20211008
s390                 randconfig-c005-20211008
powerpc              randconfig-c003-20211008
riscv                randconfig-c006-20211008
mips                 randconfig-c004-20211008
x86_64               randconfig-a003-20211008
x86_64               randconfig-a005-20211008
x86_64               randconfig-a001-20211008
x86_64               randconfig-a002-20211008
x86_64               randconfig-a004-20211008
x86_64               randconfig-a006-20211008
x86_64               randconfig-a003-20211004
x86_64               randconfig-a005-20211004
x86_64               randconfig-a001-20211004
x86_64               randconfig-a002-20211004
x86_64               randconfig-a004-20211004
x86_64               randconfig-a006-20211004
i386                 randconfig-a001-20211004
i386                 randconfig-a003-20211004
i386                 randconfig-a005-20211004
i386                 randconfig-a002-20211004
i386                 randconfig-a004-20211004
i386                 randconfig-a006-20211004
i386                 randconfig-a001-20211008
i386                 randconfig-a003-20211008
i386                 randconfig-a005-20211008
i386                 randconfig-a004-20211008
i386                 randconfig-a002-20211008
i386                 randconfig-a006-20211008
hexagon              randconfig-r045-20211007
hexagon              randconfig-r041-20211007
s390                 randconfig-r044-20211007
riscv                randconfig-r042-20211007

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
