Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC0FE330236
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 15:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbhCGOuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 09:50:15 -0500
Received: from mga11.intel.com ([192.55.52.93]:56746 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231143AbhCGOtz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 09:49:55 -0500
IronPort-SDR: pboOWs2BM8sdiKvdK/1baHNwpxkJ+x1DOvgvSBdiowcphVzNrZQFHa7pOIIaem65TLSDKW9PhA
 ZK4EVoZGX4mw==
X-IronPort-AV: E=McAfee;i="6000,8403,9916"; a="184532815"
X-IronPort-AV: E=Sophos;i="5.81,230,1610438400"; 
   d="scan'208";a="184532815"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2021 06:49:55 -0800
IronPort-SDR: uaJGvrNo6tmVGPFL0CY0yLuy8s5I9SbQiFTrxCVABngag8f/zf7L5Zu5Zfaj1krXkLHWtvDCrM
 xsvPUHzPvtqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,230,1610438400"; 
   d="scan'208";a="446849808"
Received: from lkp-server01.sh.intel.com (HELO 3e992a48ca98) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 07 Mar 2021 06:49:53 -0800
Received: from kbuild by 3e992a48ca98 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lIujB-0000UM-2q; Sun, 07 Mar 2021 14:49:53 +0000
Date:   Sun, 07 Mar 2021 22:49:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:tip] BUILD SUCCESS 0e16f466004d7f04296b9676a712a32a12367d1f
Message-ID: <6044e7f4.p9v4dID6a4xrTg/x%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tip
branch HEAD: 0e16f466004d7f04296b9676a712a32a12367d1f  tip: Remove stale branches

elapsed time: 742m

configs tested: 134
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                        sh7763rdp_defconfig
powerpc                          g5_defconfig
csky                             alldefconfig
arm                         orion5x_defconfig
arm                        clps711x_defconfig
arc                              allyesconfig
parisc                              defconfig
powerpc                    klondike_defconfig
sh                            titan_defconfig
xtensa                    smp_lx200_defconfig
sh                           se7705_defconfig
arc                          axs101_defconfig
powerpc                    mvme5100_defconfig
h8300                    h8300h-sim_defconfig
mips                            e55_defconfig
arm                        multi_v7_defconfig
arm                       aspeed_g4_defconfig
powerpc                      pasemi_defconfig
mips                      malta_kvm_defconfig
arm                         lubbock_defconfig
powerpc                      ppc44x_defconfig
powerpc                    ge_imp3a_defconfig
arm                         hackkit_defconfig
arc                 nsimosci_hs_smp_defconfig
arc                         haps_hs_defconfig
powerpc                      arches_defconfig
sh                          rsk7264_defconfig
arm                         bcm2835_defconfig
mips                     decstation_defconfig
powerpc                 mpc8560_ads_defconfig
arm                          pcm027_defconfig
arm                          lpd270_defconfig
riscv                    nommu_k210_defconfig
sparc                            allyesconfig
mips                        maltaup_defconfig
sh                        sh7785lcr_defconfig
sh                          r7780mp_defconfig
parisc                generic-64bit_defconfig
powerpc                      bamboo_defconfig
arc                           tb10x_defconfig
ia64                                defconfig
sparc                       sparc64_defconfig
mips                           ci20_defconfig
s390                       zfcpdump_defconfig
mips                     cu1000-neo_defconfig
arm                        keystone_defconfig
nios2                            alldefconfig
sh                   sh7724_generic_defconfig
xtensa                    xip_kc705_defconfig
m68k                            q40_defconfig
mips                           rs90_defconfig
arm                          pxa3xx_defconfig
arc                      axs103_smp_defconfig
mips                  decstation_64_defconfig
powerpc                     tqm8560_defconfig
microblaze                          defconfig
mips                         tb0287_defconfig
powerpc                     tqm8541_defconfig
sh                          landisk_defconfig
mips                       rbtx49xx_defconfig
mips                         tb0219_defconfig
powerpc                     redwood_defconfig
m68k                          sun3x_defconfig
sh                        apsh4ad0a_defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
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
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20210307
i386                 randconfig-a003-20210307
i386                 randconfig-a002-20210307
i386                 randconfig-a004-20210307
i386                 randconfig-a006-20210307
i386                 randconfig-a001-20210307
x86_64               randconfig-a013-20210307
x86_64               randconfig-a016-20210307
x86_64               randconfig-a015-20210307
x86_64               randconfig-a014-20210307
x86_64               randconfig-a012-20210307
x86_64               randconfig-a011-20210307
i386                 randconfig-a016-20210307
i386                 randconfig-a012-20210307
i386                 randconfig-a013-20210307
i386                 randconfig-a014-20210307
i386                 randconfig-a011-20210307
i386                 randconfig-a015-20210307
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20210307
x86_64               randconfig-a001-20210307
x86_64               randconfig-a004-20210307
x86_64               randconfig-a005-20210307
x86_64               randconfig-a002-20210307
x86_64               randconfig-a003-20210307

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
