Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95D4E37F696
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 13:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233312AbhEMLRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 07:17:55 -0400
Received: from mga06.intel.com ([134.134.136.31]:43972 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233308AbhEMLRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 07:17:43 -0400
IronPort-SDR: y/eROH0L4xhlmSRj9d52fley5zONKER/Fl/V4BhI056jdRE99tRpyta3QTmWXlctuBeoDht/8q
 bNvm5QoxcQkA==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="261168921"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="261168921"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 04:16:19 -0700
IronPort-SDR: Ta6nYRQwCyg8ldyReCVpDPgneOPtZs05gCLPaeIxoQ93G5XQNwqU6uVGEGci8c5gqjxfcO2lYe
 IU3ZezpDYr/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="542447716"
Received: from lkp-server01.sh.intel.com (HELO ddd90b05c979) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 13 May 2021 04:16:18 -0700
Received: from kbuild by ddd90b05c979 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lh9KD-0000D3-GL; Thu, 13 May 2021 11:16:17 +0000
Date:   Thu, 13 May 2021 19:16:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 e6fe3f422be128b7d65de607f6ae67bedc55f0ca
Message-ID: <609d0a7f.buG/n7B7TNBK0pEt%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: e6fe3f422be128b7d65de607f6ae67bedc55f0ca  sched: Make multiple runqueue task counters 32-bit

elapsed time: 887m

configs tested: 139
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
arm                       aspeed_g4_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                      mgcoge_defconfig
powerpc                   lite5200b_defconfig
sparc64                          alldefconfig
sh                          polaris_defconfig
arm                         socfpga_defconfig
arm                         at91_dt_defconfig
arm                            lart_defconfig
mips                       bmips_be_defconfig
ia64                             allyesconfig
sh                 kfr2r09-romimage_defconfig
m68k                         apollo_defconfig
sh                          r7785rp_defconfig
arm                        mini2440_defconfig
powerpc                   currituck_defconfig
xtensa                              defconfig
nds32                               defconfig
arm                           h5000_defconfig
h8300                               defconfig
powerpc                     tqm8541_defconfig
powerpc                    socrates_defconfig
mips                       rbtx49xx_defconfig
xtensa                generic_kc705_defconfig
arc                     haps_hs_smp_defconfig
mips                             allyesconfig
parisc                generic-64bit_defconfig
arm                          simpad_defconfig
i386                             alldefconfig
arm                         s3c6400_defconfig
arm                           sama5_defconfig
arm                       aspeed_g5_defconfig
sh                        sh7763rdp_defconfig
powerpc                     pseries_defconfig
nios2                         3c120_defconfig
arc                              allyesconfig
arm                      tct_hammer_defconfig
powerpc                     powernv_defconfig
sh                             sh03_defconfig
powerpc                 mpc8313_rdb_defconfig
m68k                       m5249evb_defconfig
arm                         s5pv210_defconfig
arc                     nsimosci_hs_defconfig
nios2                         10m50_defconfig
arm                           spitz_defconfig
sh                           se7619_defconfig
powerpc                     kilauea_defconfig
mips                           ip27_defconfig
sh                           se7751_defconfig
arm                       spear13xx_defconfig
arc                          axs103_defconfig
powerpc                       ebony_defconfig
m68k                           sun3_defconfig
um                            kunit_defconfig
riscv                          rv32_defconfig
mips                         tb0219_defconfig
arm                         palmz72_defconfig
arm                         assabet_defconfig
arm                          pxa910_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                 mpc832x_rdb_defconfig
mips                          rb532_defconfig
powerpc                 xes_mpc85xx_defconfig
ia64                        generic_defconfig
arm                        mvebu_v7_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
nios2                            allyesconfig
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
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210513
i386                 randconfig-a001-20210513
i386                 randconfig-a005-20210513
i386                 randconfig-a004-20210513
i386                 randconfig-a002-20210513
i386                 randconfig-a006-20210513
x86_64               randconfig-a012-20210513
x86_64               randconfig-a015-20210513
x86_64               randconfig-a011-20210513
x86_64               randconfig-a013-20210513
x86_64               randconfig-a016-20210513
x86_64               randconfig-a014-20210513
i386                 randconfig-a016-20210513
i386                 randconfig-a014-20210513
i386                 randconfig-a011-20210513
i386                 randconfig-a015-20210513
i386                 randconfig-a012-20210513
i386                 randconfig-a013-20210513
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a003-20210513
x86_64               randconfig-a004-20210513
x86_64               randconfig-a001-20210513
x86_64               randconfig-a005-20210513
x86_64               randconfig-a002-20210513
x86_64               randconfig-a006-20210513

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
