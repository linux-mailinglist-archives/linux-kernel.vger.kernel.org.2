Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 712E744F804
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 14:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235756AbhKNNWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 08:22:39 -0500
Received: from mga11.intel.com ([192.55.52.93]:52552 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235827AbhKNNWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 08:22:35 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10167"; a="230781763"
X-IronPort-AV: E=Sophos;i="5.87,234,1631602800"; 
   d="scan'208";a="230781763"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2021 05:19:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,234,1631602800"; 
   d="scan'208";a="453696553"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 14 Nov 2021 05:19:39 -0800
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mmFQ2-000LPV-8J; Sun, 14 Nov 2021 13:19:38 +0000
Date:   Sun, 14 Nov 2021 21:19:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:for-next/clang-fallthrough] BUILD SUCCESS
 9c515d6ed2c46a83b5d63952fb497af0c4be732c
Message-ID: <61910ce4.WZty/77N7SKVF9P6%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git for-next/clang-fallthrough
branch HEAD: 9c515d6ed2c46a83b5d63952fb497af0c4be732c  kconfig: Add support for -Wimplicit-fallthrough

elapsed time: 720m

configs tested: 145
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211113
m68k                          amiga_defconfig
mips                           jazz_defconfig
powerpc                   lite5200b_defconfig
m68k                       bvme6000_defconfig
mips                            gpr_defconfig
arm                             rpc_defconfig
arm                        mini2440_defconfig
arm                         palmz72_defconfig
sh                           se7721_defconfig
powerpc                    sam440ep_defconfig
arm                       aspeed_g4_defconfig
powerpc                    klondike_defconfig
riscv             nommu_k210_sdcard_defconfig
m68k                        mvme147_defconfig
h8300                            allyesconfig
riscv                    nommu_k210_defconfig
arm                         lpc18xx_defconfig
powerpc                      ppc44x_defconfig
arm                          imote2_defconfig
powerpc                 mpc837x_rdb_defconfig
x86_64                           allyesconfig
powerpc                       eiger_defconfig
arm                        trizeps4_defconfig
alpha                            alldefconfig
arm                      tct_hammer_defconfig
powerpc                          g5_defconfig
powerpc                        warp_defconfig
m68k                          multi_defconfig
sh                 kfr2r09-romimage_defconfig
sh                          urquell_defconfig
arm                           h3600_defconfig
powerpc                     skiroot_defconfig
mips                   sb1250_swarm_defconfig
powerpc                 mpc832x_rdb_defconfig
arm                      pxa255-idp_defconfig
sh                        apsh4ad0a_defconfig
powerpc                      pmac32_defconfig
arm                          pxa3xx_defconfig
sh                           se7206_defconfig
arm                            hisi_defconfig
arc                              alldefconfig
m68k                        mvme16x_defconfig
arm                          ep93xx_defconfig
mips                          malta_defconfig
sparc64                             defconfig
mips                         bigsur_defconfig
mips                        jmr3927_defconfig
microblaze                          defconfig
powerpc                 mpc85xx_cds_defconfig
sh                         ap325rxa_defconfig
openrisc                  or1klitex_defconfig
mips                           ip32_defconfig
arm                  randconfig-c002-20211114
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
arc                              allyesconfig
parisc                              defconfig
s390                                defconfig
parisc                           allyesconfig
s390                             allmodconfig
s390                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                              debian-10.3
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
i386                 randconfig-a006-20211113
i386                 randconfig-a003-20211113
i386                 randconfig-a005-20211113
i386                 randconfig-a001-20211113
i386                 randconfig-a004-20211113
i386                 randconfig-a002-20211113
x86_64               randconfig-a015-20211114
x86_64               randconfig-a013-20211114
x86_64               randconfig-a012-20211114
x86_64               randconfig-a011-20211114
x86_64               randconfig-a016-20211114
x86_64               randconfig-a014-20211114
i386                 randconfig-a014-20211114
i386                 randconfig-a016-20211114
i386                 randconfig-a012-20211114
i386                 randconfig-a013-20211114
i386                 randconfig-a011-20211114
i386                 randconfig-a015-20211114
arc                  randconfig-r043-20211114
s390                 randconfig-r044-20211114
riscv                randconfig-r042-20211114
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

clang tested configs:
x86_64               randconfig-c007-20211114
i386                 randconfig-c001-20211114
arm                  randconfig-c002-20211114
riscv                randconfig-c006-20211114
powerpc              randconfig-c003-20211114
s390                 randconfig-c005-20211114
mips                 randconfig-c004-20211114
i386                 randconfig-a006-20211114
i386                 randconfig-a003-20211114
i386                 randconfig-a005-20211114
i386                 randconfig-a001-20211114
i386                 randconfig-a004-20211114
i386                 randconfig-a002-20211114
x86_64               randconfig-a005-20211114
x86_64               randconfig-a003-20211114
x86_64               randconfig-a001-20211114
x86_64               randconfig-a002-20211114
x86_64               randconfig-a006-20211114
x86_64               randconfig-a004-20211114
hexagon              randconfig-r045-20211114
hexagon              randconfig-r041-20211114

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
