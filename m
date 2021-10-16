Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D82D42FF66
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 02:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239256AbhJPATo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 20:19:44 -0400
Received: from mga02.intel.com ([134.134.136.20]:10454 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231881AbhJPATo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 20:19:44 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10138"; a="215177294"
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; 
   d="scan'208";a="215177294"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 17:17:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; 
   d="scan'208";a="442696156"
Received: from lkp-server02.sh.intel.com (HELO 08b2c502c3de) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 15 Oct 2021 17:17:35 -0700
Received: from kbuild by 08b2c502c3de with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mbXOI-0008WR-Ud; Sat, 16 Oct 2021 00:17:34 +0000
Date:   Sat, 16 Oct 2021 08:17:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:perf/core] BUILD SUCCESS
 79df45731da68772d2285265864a52c900b8c65f
Message-ID: <616a1a0b.GNbRYIfrvD16bVPo%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/core
branch HEAD: 79df45731da68772d2285265864a52c900b8c65f  perf/core: Allow ftrace for functions in kernel/event/core.c

elapsed time: 845m

configs tested: 154
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211015
i386                             alldefconfig
ia64                                defconfig
mips                          malta_defconfig
sh                     sh7710voipgw_defconfig
powerpc                        icon_defconfig
sh                          rsk7269_defconfig
m68k                        m5307c3_defconfig
m68k                          amiga_defconfig
arm                        realview_defconfig
sh                           se7343_defconfig
ia64                            zx1_defconfig
sh                         ap325rxa_defconfig
powerpc                 mpc8560_ads_defconfig
mips                        nlm_xlr_defconfig
powerpc                          allyesconfig
powerpc                      obs600_defconfig
powerpc                        fsp2_defconfig
powerpc                     sequoia_defconfig
arm                         orion5x_defconfig
arm                            zeus_defconfig
alpha                            alldefconfig
sh                   secureedge5410_defconfig
m68k                          sun3x_defconfig
arc                           tb10x_defconfig
s390                                defconfig
s390                       zfcpdump_defconfig
arm                    vt8500_v6_v7_defconfig
mips                        workpad_defconfig
powerpc                    ge_imp3a_defconfig
arm                         bcm2835_defconfig
arc                              alldefconfig
arm                           sama5_defconfig
arm                             rpc_defconfig
powerpc                 mpc834x_mds_defconfig
mips                   sb1250_swarm_defconfig
mips                         db1xxx_defconfig
microblaze                      mmu_defconfig
mips                        vocore2_defconfig
powerpc                      tqm8xx_defconfig
mips                           gcw0_defconfig
mips                         tb0219_defconfig
m68k                       m5475evb_defconfig
m68k                          atari_defconfig
sh                          rsk7201_defconfig
powerpc                     tqm8541_defconfig
nios2                         3c120_defconfig
mips                      fuloong2e_defconfig
powerpc                   lite5200b_defconfig
powerpc                        warp_defconfig
openrisc                    or1ksim_defconfig
powerpc                   motionpro_defconfig
arm64                            alldefconfig
arm                           omap1_defconfig
arm                          ixp4xx_defconfig
mips                            e55_defconfig
riscv                    nommu_k210_defconfig
sh                        apsh4ad0a_defconfig
mips                      maltaaprp_defconfig
arm                  randconfig-c002-20211015
x86_64               randconfig-c001-20211015
ia64                             allmodconfig
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
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                              defconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
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
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig

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
hexagon              randconfig-r041-20211016
s390                 randconfig-r044-20211016
riscv                randconfig-r042-20211016
hexagon              randconfig-r045-20211016
hexagon              randconfig-r041-20211015
hexagon              randconfig-r045-20211015
hexagon              randconfig-r041-20211014
s390                 randconfig-r044-20211014
riscv                randconfig-r042-20211014
hexagon              randconfig-r045-20211014

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
