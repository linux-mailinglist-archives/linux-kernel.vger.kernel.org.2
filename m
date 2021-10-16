Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0992430006
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 06:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239483AbhJPEXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 00:23:52 -0400
Received: from mga17.intel.com ([192.55.52.151]:59787 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229451AbhJPEXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 00:23:51 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10138"; a="208826046"
X-IronPort-AV: E=Sophos;i="5.85,377,1624345200"; 
   d="scan'208";a="208826046"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 21:21:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,377,1624345200"; 
   d="scan'208";a="481938564"
Received: from lkp-server02.sh.intel.com (HELO 08b2c502c3de) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 15 Oct 2021 21:21:42 -0700
Received: from kbuild by 08b2c502c3de with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mbbCY-0008i2-3e; Sat, 16 Oct 2021 04:21:42 +0000
Date:   Sat, 16 Oct 2021 12:20:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 09089db79859cbccccd8df95b034f36f7027efa6
Message-ID: <616a5327.jydfoAHvflME0i6+%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: 09089db79859cbccccd8df95b034f36f7027efa6  irq_work: Also rcuwait for !IRQ_WORK_HARD_IRQ on PREEMPT_RT

elapsed time: 1088m

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
mips                 randconfig-c004-20211015
i386                 randconfig-c001-20211015
mips                           ip28_defconfig
sh                        sh7763rdp_defconfig
mips                      bmips_stb_defconfig
powerpc                      acadia_defconfig
mips                        nlm_xlr_defconfig
xtensa                           alldefconfig
i386                             alldefconfig
mips                          malta_defconfig
sh                     sh7710voipgw_defconfig
powerpc                        icon_defconfig
sh                           se7724_defconfig
mips                     loongson1b_defconfig
arm                           h3600_defconfig
arm                          badge4_defconfig
arm                       spear13xx_defconfig
arm                        oxnas_v6_defconfig
arm                         at91_dt_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc                    socrates_defconfig
arm                      tct_hammer_defconfig
mips                      maltasmvp_defconfig
arm                        trizeps4_defconfig
arm                          gemini_defconfig
openrisc                            defconfig
powerpc                          g5_defconfig
i386                                defconfig
powerpc                      obs600_defconfig
powerpc                        fsp2_defconfig
powerpc                     sequoia_defconfig
arm                         orion5x_defconfig
h8300                       h8s-sim_defconfig
sh                        sh7785lcr_defconfig
mips                      maltaaprp_defconfig
sh                     magicpanelr2_defconfig
arm                            zeus_defconfig
alpha                            alldefconfig
sh                   secureedge5410_defconfig
m68k                          sun3x_defconfig
arc                           tb10x_defconfig
s390                                defconfig
m68k                         apollo_defconfig
csky                             alldefconfig
powerpc                      ppc64e_defconfig
parisc                generic-32bit_defconfig
powerpc                      tqm8xx_defconfig
parisc                           alldefconfig
arm                        mvebu_v5_defconfig
arm                          moxart_defconfig
arc                     haps_hs_smp_defconfig
sh                         microdev_defconfig
mips                           gcw0_defconfig
mips                         tb0219_defconfig
m68k                       m5475evb_defconfig
m68k                          atari_defconfig
sh                          rsk7201_defconfig
arc                          axs101_defconfig
arm                         socfpga_defconfig
riscv                            alldefconfig
sparc                       sparc32_defconfig
mips                           ip27_defconfig
sh                          r7780mp_defconfig
sh                ecovec24-romimage_defconfig
mips                malta_qemu_32r6_defconfig
arm                        keystone_defconfig
powerpc                   motionpro_defconfig
arm64                            alldefconfig
arm                           omap1_defconfig
arm                          ixp4xx_defconfig
mips                            e55_defconfig
arc                              alldefconfig
microblaze                      mmu_defconfig
arm                      integrator_defconfig
powerpc                    sam440ep_defconfig
sh                          rsk7269_defconfig
sh                        edosk7760_defconfig
arm                          lpd270_defconfig
arm                        spear3xx_defconfig
riscv                    nommu_k210_defconfig
sh                        apsh4ad0a_defconfig
arm                  randconfig-c002-20211015
x86_64               randconfig-c001-20211015
ia64                             allmodconfig
ia64                                defconfig
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
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a006-20211016
x86_64               randconfig-a004-20211016
x86_64               randconfig-a001-20211016
x86_64               randconfig-a005-20211016
x86_64               randconfig-a002-20211016
x86_64               randconfig-a003-20211016
x86_64               randconfig-a012-20211015
x86_64               randconfig-a015-20211015
x86_64               randconfig-a016-20211015
x86_64               randconfig-a014-20211015
x86_64               randconfig-a011-20211015
x86_64               randconfig-a013-20211015
i386                 randconfig-a016-20211015
i386                 randconfig-a014-20211015
i386                 randconfig-a011-20211015
i386                 randconfig-a015-20211015
i386                 randconfig-a012-20211015
i386                 randconfig-a013-20211015
arc                  randconfig-r043-20211014
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
mips                 randconfig-c004-20211015
arm                  randconfig-c002-20211015
i386                 randconfig-c001-20211015
s390                 randconfig-c005-20211015
x86_64               randconfig-c007-20211015
powerpc              randconfig-c003-20211015
riscv                randconfig-c006-20211015
x86_64               randconfig-a006-20211015
x86_64               randconfig-a004-20211015
x86_64               randconfig-a001-20211015
x86_64               randconfig-a005-20211015
x86_64               randconfig-a002-20211015
x86_64               randconfig-a003-20211015
i386                 randconfig-a003-20211015
i386                 randconfig-a001-20211015
i386                 randconfig-a005-20211015
i386                 randconfig-a004-20211015
i386                 randconfig-a002-20211015
i386                 randconfig-a006-20211015
x86_64               randconfig-a012-20211014
x86_64               randconfig-a015-20211014
hexagon              randconfig-r041-20211014
s390                 randconfig-r044-20211014
riscv                randconfig-r042-20211014
hexagon              randconfig-r045-20211014
hexagon              randconfig-r041-20211015
hexagon              randconfig-r045-20211015

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
