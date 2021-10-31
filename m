Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCEB8441174
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 00:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhJaXaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 19:30:13 -0400
Received: from mga18.intel.com ([134.134.136.126]:3074 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230098AbhJaXaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 19:30:12 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10154"; a="217832651"
X-IronPort-AV: E=Sophos;i="5.87,198,1631602800"; 
   d="scan'208";a="217832651"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2021 16:27:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,198,1631602800"; 
   d="scan'208";a="598852905"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 31 Oct 2021 16:27:38 -0700
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mhKEk-0002s4-6K; Sun, 31 Oct 2021 23:27:38 +0000
Date:   Mon, 01 Nov 2021 07:27:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 8ea9183db4ad8afbcb7089a77c23eaf965b0cacd
Message-ID: <617f2651.1pfEb+F5F425/xbb%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: 8ea9183db4ad8afbcb7089a77c23eaf965b0cacd  sched/fair: Cleanup newidle_balance

elapsed time: 774m

configs tested: 128
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                         ps3_defconfig
h8300                     edosk2674_defconfig
sh                           se7206_defconfig
sh                          polaris_defconfig
arm                         at91_dt_defconfig
mips                        maltaup_defconfig
arm                    vt8500_v6_v7_defconfig
mips                  cavium_octeon_defconfig
powerpc                 mpc8313_rdb_defconfig
arm                             ezx_defconfig
xtensa                  cadence_csp_defconfig
sh                   secureedge5410_defconfig
arm                            mps2_defconfig
arm                       omap2plus_defconfig
m68k                          atari_defconfig
arm                         palmz72_defconfig
mips                           ip32_defconfig
powerpc                     ppa8548_defconfig
xtensa                  nommu_kc705_defconfig
arm                            mmp2_defconfig
sh                        apsh4ad0a_defconfig
powerpc                         wii_defconfig
arm                      integrator_defconfig
mips                         rt305x_defconfig
arm                         s3c6400_defconfig
sh                ecovec24-romimage_defconfig
ia64                      gensparse_defconfig
arm                      jornada720_defconfig
powerpc                     redwood_defconfig
arm                        shmobile_defconfig
powerpc                     tqm5200_defconfig
sh                        edosk7760_defconfig
arm                           tegra_defconfig
powerpc                     mpc512x_defconfig
arm                        mvebu_v5_defconfig
mips                             allmodconfig
riscv             nommu_k210_sdcard_defconfig
mips                  decstation_64_defconfig
m68k                         apollo_defconfig
sh                            titan_defconfig
arm                          iop32x_defconfig
mips                   sb1250_swarm_defconfig
mips                             allyesconfig
arm                             rpc_defconfig
sh                        sh7757lcr_defconfig
arm                  randconfig-c002-20211031
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
arc                              allyesconfig
nios2                            allyesconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
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
i386                              debian-10.3
i386                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a005-20211031
x86_64               randconfig-a004-20211031
x86_64               randconfig-a002-20211031
x86_64               randconfig-a003-20211031
x86_64               randconfig-a001-20211031
x86_64               randconfig-a006-20211031
i386                 randconfig-a003-20211031
i386                 randconfig-a006-20211031
i386                 randconfig-a002-20211031
i386                 randconfig-a005-20211031
i386                 randconfig-a001-20211031
i386                 randconfig-a004-20211031
arc                  randconfig-r043-20211031
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
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

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
