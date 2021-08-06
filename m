Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 075043E2630
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 10:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242453AbhHFIeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 04:34:07 -0400
Received: from mga18.intel.com ([134.134.136.126]:57814 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231526AbhHFIeG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 04:34:06 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10067"; a="201516951"
X-IronPort-AV: E=Sophos;i="5.84,300,1620716400"; 
   d="scan'208";a="201516951"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2021 01:33:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,300,1620716400"; 
   d="scan'208";a="503928718"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 06 Aug 2021 01:33:48 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mBvIZ-000GgC-Uy; Fri, 06 Aug 2021 08:33:47 +0000
Date:   Fri, 06 Aug 2021 16:33:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rcu/next] BUILD SUCCESS
 758fa151eb378e18ce082b3c8168458bc6d6f30e
Message-ID: <610cf3e0.067qkFQINGGUQBKB%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: 758fa151eb378e18ce082b3c8168458bc6d6f30e  rcu-tasks: Fix s/instruction/instructions/ typo in comment

elapsed time: 724m

configs tested: 114
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210804
i386                 randconfig-c001-20210805
arm                         socfpga_defconfig
csky                             alldefconfig
powerpc                     pseries_defconfig
m68k                         amcore_defconfig
m68k                        mvme147_defconfig
powerpc                     tqm8560_defconfig
i386                             alldefconfig
sh                   sh7724_generic_defconfig
sh                          sdk7780_defconfig
ia64                        generic_defconfig
arm                            hisi_defconfig
mips                         tb0226_defconfig
sh                      rts7751r2d1_defconfig
powerpc                     sequoia_defconfig
arm                      pxa255-idp_defconfig
powerpc                     taishan_defconfig
mips                      loongson3_defconfig
parisc                           alldefconfig
m68k                         apollo_defconfig
arm                         palmz72_defconfig
mips                            gpr_defconfig
powerpc                 mpc834x_mds_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
x86_64                            allnoconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
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
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20210805
x86_64               randconfig-a006-20210805
x86_64               randconfig-a004-20210805
x86_64               randconfig-a003-20210805
x86_64               randconfig-a001-20210805
x86_64               randconfig-a005-20210805
i386                 randconfig-a005-20210805
i386                 randconfig-a004-20210805
i386                 randconfig-a002-20210805
i386                 randconfig-a006-20210805
i386                 randconfig-a003-20210805
i386                 randconfig-a001-20210805
x86_64               randconfig-a012-20210804
x86_64               randconfig-a016-20210804
x86_64               randconfig-a011-20210804
x86_64               randconfig-a013-20210804
x86_64               randconfig-a014-20210804
x86_64               randconfig-a015-20210804
i386                 randconfig-a012-20210806
i386                 randconfig-a011-20210806
i386                 randconfig-a015-20210806
i386                 randconfig-a013-20210806
i386                 randconfig-a014-20210806
i386                 randconfig-a016-20210806
i386                 randconfig-a012-20210804
i386                 randconfig-a011-20210804
i386                 randconfig-a015-20210804
i386                 randconfig-a013-20210804
i386                 randconfig-a014-20210804
i386                 randconfig-a016-20210804
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c001-20210804
x86_64               randconfig-c001-20210805
x86_64               randconfig-a012-20210805
x86_64               randconfig-a016-20210805
x86_64               randconfig-a011-20210805
x86_64               randconfig-a013-20210805
x86_64               randconfig-a014-20210805
x86_64               randconfig-a015-20210805

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
