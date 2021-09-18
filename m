Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 782B04106C1
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 15:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237812AbhIRNYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 09:24:13 -0400
Received: from mga07.intel.com ([134.134.136.100]:52680 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237013AbhIRNYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 09:24:04 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10110"; a="286625387"
X-IronPort-AV: E=Sophos;i="5.85,304,1624345200"; 
   d="scan'208";a="286625387"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2021 06:22:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,304,1624345200"; 
   d="scan'208";a="555170849"
Received: from lkp-server01.sh.intel.com (HELO 285e7b116627) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 18 Sep 2021 06:22:37 -0700
Received: from kbuild by 285e7b116627 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mRaIe-0004ua-Uz; Sat, 18 Sep 2021 13:22:36 +0000
Date:   Sat, 18 Sep 2021 21:21:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:objtool/core] BUILD SUCCESS
 db2b0c5d7b6f19b3c2cab08c531b65342eb5252b
Message-ID: <6145e7f3.aRaSNHt3Bs1cKnbT%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git objtool/core
branch HEAD: db2b0c5d7b6f19b3c2cab08c531b65342eb5252b  objtool: Support pv_opsindirect calls for noinstr

elapsed time: 1453m

configs tested: 205
configs skipped: 3

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
xtensa                         virt_defconfig
powerpc                      ppc64e_defconfig
arm                             ezx_defconfig
mips                       rbtx49xx_defconfig
ia64                                defconfig
powerpc                 mpc8313_rdb_defconfig
mips                      pic32mzda_defconfig
sh                          r7785rp_defconfig
powerpc                      ppc6xx_defconfig
arm                          simpad_defconfig
powerpc                     tqm5200_defconfig
arm                           h3600_defconfig
powerpc                        warp_defconfig
arm                       multi_v4t_defconfig
arm                          pxa910_defconfig
mips                   sb1250_swarm_defconfig
s390                          debug_defconfig
arm                       mainstone_defconfig
arm                            qcom_defconfig
um                           x86_64_defconfig
arm                          pcm027_defconfig
powerpc                 mpc8315_rdb_defconfig
m68k                        m5307c3_defconfig
m68k                        mvme16x_defconfig
powerpc                        fsp2_defconfig
ia64                        generic_defconfig
arm                        vexpress_defconfig
m68k                        m5272c3_defconfig
mips                           ip27_defconfig
arm64                            alldefconfig
mips                           rs90_defconfig
powerpc                      ppc40x_defconfig
powerpc                     tqm8540_defconfig
powerpc                      arches_defconfig
powerpc                      acadia_defconfig
powerpc                  iss476-smp_defconfig
arm                            zeus_defconfig
powerpc                      tqm8xx_defconfig
arm                        mvebu_v5_defconfig
powerpc                     sequoia_defconfig
arm                        mini2440_defconfig
powerpc                       maple_defconfig
arm                             pxa_defconfig
arc                 nsimosci_hs_smp_defconfig
arm                           tegra_defconfig
sh                           se7780_defconfig
powerpc                      chrp32_defconfig
sh                          sdk7786_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                        spear3xx_defconfig
xtensa                  audio_kc705_defconfig
arm                  colibri_pxa270_defconfig
powerpc                     ppa8548_defconfig
sh                          kfr2r09_defconfig
mips                          ath79_defconfig
arm                       omap2plus_defconfig
powerpc                    adder875_defconfig
m68k                         apollo_defconfig
arm                         cm_x300_defconfig
powerpc                    socrates_defconfig
powerpc                       eiger_defconfig
powerpc                mpc7448_hpc2_defconfig
mips                         cobalt_defconfig
ia64                             allmodconfig
powerpc                 linkstation_defconfig
powerpc                     mpc512x_defconfig
arm                        oxnas_v6_defconfig
mips                         tb0219_defconfig
powerpc                 mpc832x_rdb_defconfig
arm                        spear6xx_defconfig
mips                        bcm47xx_defconfig
xtensa                              defconfig
x86_64               randconfig-c001-20210918
arm                  randconfig-c002-20210918
x86_64               randconfig-c001-20210916
arm                  randconfig-c002-20210916
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
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
xtensa                           allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                                defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
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
x86_64               randconfig-a016-20210916
x86_64               randconfig-a013-20210916
x86_64               randconfig-a012-20210916
x86_64               randconfig-a011-20210916
x86_64               randconfig-a014-20210916
x86_64               randconfig-a015-20210916
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
riscv                    nommu_virt_defconfig
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
x86_64               randconfig-a002-20210916
x86_64               randconfig-a003-20210916
x86_64               randconfig-a006-20210916
x86_64               randconfig-a004-20210916
x86_64               randconfig-a005-20210916
x86_64               randconfig-a001-20210916
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
x86_64               randconfig-a002-20210918
x86_64               randconfig-a004-20210918
x86_64               randconfig-a006-20210918
x86_64               randconfig-a003-20210918
x86_64               randconfig-a001-20210918
x86_64               randconfig-a005-20210918
hexagon              randconfig-r045-20210918
hexagon              randconfig-r041-20210918
hexagon              randconfig-r045-20210916
hexagon              randconfig-r041-20210916

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
