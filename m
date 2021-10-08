Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9506D426BDF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 15:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbhJHNqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 09:46:51 -0400
Received: from mga14.intel.com ([192.55.52.115]:10861 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229487AbhJHNqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 09:46:48 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10130"; a="226796179"
X-IronPort-AV: E=Sophos;i="5.85,357,1624345200"; 
   d="scan'208";a="226796179"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2021 06:44:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,357,1624345200"; 
   d="scan'208";a="439936859"
Received: from lkp-server02.sh.intel.com (HELO 1950922c5479) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 08 Oct 2021 06:44:51 -0700
Received: from kbuild by 1950922c5479 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mYqB9-0000P0-0K; Fri, 08 Oct 2021 13:44:51 +0000
Date:   Fri, 08 Oct 2021 21:44:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/core] BUILD SUCCESS
 9321f8152d9a764208c3f0dad49e0c55f293b7ab
Message-ID: <61604b4e.zaWc05Rr3/ubFngo%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
branch HEAD: 9321f8152d9a764208c3f0dad49e0c55f293b7ab  rtmutex: Wake up the waiters lockless while dropping the read lock.

elapsed time: 1823m

configs tested: 199
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211008
m68k                       m5475evb_defconfig
powerpc                     tqm5200_defconfig
m68k                       m5249evb_defconfig
powerpc                     skiroot_defconfig
powerpc                   motionpro_defconfig
arc                 nsimosci_hs_smp_defconfig
m68k                          atari_defconfig
powerpc                      ppc40x_defconfig
powerpc                     stx_gp3_defconfig
m68k                          multi_defconfig
sh                          landisk_defconfig
powerpc                      pcm030_defconfig
mips                          malta_defconfig
mips                        qi_lb60_defconfig
mips                       bmips_be_defconfig
powerpc                     tqm8560_defconfig
sh                           se7722_defconfig
sparc                            allyesconfig
sh                           sh2007_defconfig
arm                         orion5x_defconfig
um                           x86_64_defconfig
m68k                          hp300_defconfig
mips                     loongson1b_defconfig
xtensa                       common_defconfig
sh                            migor_defconfig
sh                         microdev_defconfig
powerpc                       ppc64_defconfig
mips                          ath25_defconfig
arm                          collie_defconfig
sh                   secureedge5410_defconfig
ia64                        generic_defconfig
mips                        maltaup_defconfig
powerpc                      ppc64e_defconfig
xtensa                  audio_kc705_defconfig
alpha                            allyesconfig
powerpc                      ppc6xx_defconfig
powerpc                   microwatt_defconfig
arm                        multi_v5_defconfig
m68k                        m5272c3_defconfig
s390                       zfcpdump_defconfig
sparc                            alldefconfig
sparc                       sparc64_defconfig
sh                        sh7757lcr_defconfig
sh                          rsk7264_defconfig
mips                       capcella_defconfig
arm                           h5000_defconfig
openrisc                    or1ksim_defconfig
arc                          axs101_defconfig
sh                          kfr2r09_defconfig
mips                      loongson3_defconfig
mips                     cu1830-neo_defconfig
arm                        shmobile_defconfig
riscv                    nommu_virt_defconfig
sh                        apsh4ad0a_defconfig
mips                        nlm_xlp_defconfig
sh                   sh7724_generic_defconfig
arm                           viper_defconfig
arm                          simpad_defconfig
powerpc                         ps3_defconfig
h8300                            allyesconfig
powerpc                      pasemi_defconfig
powerpc64                           defconfig
arm                     eseries_pxa_defconfig
sh                               allmodconfig
arm                       cns3420vb_defconfig
arm                           sama7_defconfig
riscv             nommu_k210_sdcard_defconfig
h8300                       h8s-sim_defconfig
powerpc                       holly_defconfig
sh                         ecovec24_defconfig
arm                          moxart_defconfig
arm                           sama5_defconfig
arc                     nsimosci_hs_defconfig
m68k                        stmark2_defconfig
arm                       omap2plus_defconfig
mips                           ip27_defconfig
mips                      malta_kvm_defconfig
arm                     davinci_all_defconfig
sh                          polaris_defconfig
xtensa                          iss_defconfig
arm                       multi_v4t_defconfig
powerpc                     ksi8560_defconfig
mips                        bcm63xx_defconfig
powerpc                      tqm8xx_defconfig
m68k                         apollo_defconfig
arm                        realview_defconfig
powerpc                mpc7448_hpc2_defconfig
ia64                      gensparse_defconfig
x86_64               randconfig-c001-20211003
i386                 randconfig-c001-20211003
arm                  randconfig-c002-20211003
x86_64               randconfig-c001-20211008
arm                  randconfig-c002-20211008
x86_64               randconfig-c001-20211004
i386                 randconfig-c001-20211004
arm                  randconfig-c002-20211004
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
arc                                 defconfig
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
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                          allyesconfig
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
x86_64               randconfig-c007-20211003
i386                 randconfig-c001-20211003
arm                  randconfig-c002-20211003
s390                 randconfig-c005-20211003
powerpc              randconfig-c003-20211003
riscv                randconfig-c006-20211003
mips                 randconfig-c004-20211003
x86_64               randconfig-a003-20211004
x86_64               randconfig-a005-20211004
x86_64               randconfig-a001-20211004
x86_64               randconfig-a002-20211004
x86_64               randconfig-a004-20211004
x86_64               randconfig-a006-20211004
x86_64               randconfig-a003-20211008
x86_64               randconfig-a005-20211008
x86_64               randconfig-a001-20211008
x86_64               randconfig-a002-20211008
x86_64               randconfig-a004-20211008
x86_64               randconfig-a006-20211008
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
