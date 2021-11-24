Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3677545CAB5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 18:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236187AbhKXRRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 12:17:23 -0500
Received: from mga09.intel.com ([134.134.136.24]:38504 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229882AbhKXRRW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 12:17:22 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10178"; a="235144167"
X-IronPort-AV: E=Sophos;i="5.87,260,1631602800"; 
   d="scan'208";a="235144167"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 08:57:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,260,1631602800"; 
   d="scan'208";a="497743647"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 24 Nov 2021 08:57:56 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mpval-00054w-Ly; Wed, 24 Nov 2021 16:57:55 +0000
Date:   Thu, 25 Nov 2021 00:57:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2021.11.18a] BUILD SUCCESS
 075ba74eadb696eaae3a6f3eec96439e2948ac4e
Message-ID: <619e6ef3.CFsG5nC9ORI6W/sO%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2021.11.18a
branch HEAD: 075ba74eadb696eaae3a6f3eec96439e2948ac4e  fixup! rcu-tasks: Add rcupdate.rcu_task_enqueue_lim to set initial queueing

elapsed time: 729m

configs tested: 165
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211124
powerpc                       maple_defconfig
sh                           se7724_defconfig
powerpc                    mvme5100_defconfig
powerpc                     pseries_defconfig
arc                           tb10x_defconfig
powerpc                         wii_defconfig
arm                            qcom_defconfig
m68k                       m5275evb_defconfig
powerpc                   currituck_defconfig
ia64                             alldefconfig
sh                           se7721_defconfig
arm                        spear3xx_defconfig
powerpc                    socrates_defconfig
arc                            hsdk_defconfig
m68k                           sun3_defconfig
arc                     nsimosci_hs_defconfig
mips                   sb1250_swarm_defconfig
sh                          polaris_defconfig
arm                         bcm2835_defconfig
arm                       aspeed_g5_defconfig
arm64                            alldefconfig
arm                        cerfcube_defconfig
powerpc                  iss476-smp_defconfig
mips                  cavium_octeon_defconfig
mips                malta_qemu_32r6_defconfig
arm                          ixp4xx_defconfig
sh                     magicpanelr2_defconfig
arm                         lubbock_defconfig
h8300                    h8300h-sim_defconfig
sh                     sh7710voipgw_defconfig
arm                        shmobile_defconfig
sh                           se7751_defconfig
arm                       netwinder_defconfig
arm                           h5000_defconfig
mips                           ip22_defconfig
sh                           se7780_defconfig
arm                  colibri_pxa300_defconfig
sh                          rsk7264_defconfig
powerpc64                           defconfig
sh                            shmin_defconfig
arm                          lpd270_defconfig
arm                          collie_defconfig
powerpc                    sam440ep_defconfig
ia64                                defconfig
sh                ecovec24-romimage_defconfig
arm                            xcep_defconfig
arm                         lpc32xx_defconfig
powerpc                  mpc885_ads_defconfig
riscv                    nommu_k210_defconfig
arm                          pxa3xx_defconfig
arm                         orion5x_defconfig
powerpc                  mpc866_ads_defconfig
arm                        clps711x_defconfig
arm                          iop32x_defconfig
mips                          rb532_defconfig
sh                             shx3_defconfig
arm                         socfpga_defconfig
mips                  maltasmvp_eva_defconfig
sparc64                             defconfig
riscv                             allnoconfig
powerpc                 canyonlands_defconfig
arm                     eseries_pxa_defconfig
arm                        realview_defconfig
powerpc                        icon_defconfig
arc                        vdk_hs38_defconfig
arc                 nsimosci_hs_smp_defconfig
sh                   secureedge5410_defconfig
powerpc                        fsp2_defconfig
alpha                               defconfig
h8300                       h8s-sim_defconfig
parisc                           alldefconfig
powerpc                     sequoia_defconfig
sparc                       sparc32_defconfig
sh                           se7343_defconfig
mips                      maltaaprp_defconfig
s390                       zfcpdump_defconfig
mips                         rt305x_defconfig
powerpc                    adder875_defconfig
ia64                      gensparse_defconfig
arm                       spear13xx_defconfig
arm                  randconfig-c002-20211124
ia64                             allmodconfig
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
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a011-20211124
x86_64               randconfig-a014-20211124
x86_64               randconfig-a012-20211124
x86_64               randconfig-a016-20211124
x86_64               randconfig-a013-20211124
x86_64               randconfig-a015-20211124
i386                 randconfig-a016-20211124
i386                 randconfig-a015-20211124
i386                 randconfig-a012-20211124
i386                 randconfig-a013-20211124
i386                 randconfig-a014-20211124
i386                 randconfig-a011-20211124
arc                  randconfig-r043-20211124
s390                 randconfig-r044-20211124
riscv                randconfig-r042-20211124
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
s390                 randconfig-c005-20211124
i386                 randconfig-c001-20211124
powerpc              randconfig-c003-20211124
riscv                randconfig-c006-20211124
arm                  randconfig-c002-20211124
x86_64               randconfig-c007-20211124
mips                 randconfig-c004-20211124
x86_64               randconfig-a001-20211124
x86_64               randconfig-a006-20211124
x86_64               randconfig-a003-20211124
x86_64               randconfig-a004-20211124
x86_64               randconfig-a005-20211124
x86_64               randconfig-a002-20211124
i386                 randconfig-a002-20211124
i386                 randconfig-a001-20211124
i386                 randconfig-a005-20211124
i386                 randconfig-a006-20211124
i386                 randconfig-a004-20211124
i386                 randconfig-a003-20211124
hexagon              randconfig-r045-20211124
hexagon              randconfig-r041-20211124

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
