Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B863E3F28FD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 11:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234754AbhHTJP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 05:15:57 -0400
Received: from mga18.intel.com ([134.134.136.126]:19124 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232380AbhHTJPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 05:15:53 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="203888755"
X-IronPort-AV: E=Sophos;i="5.84,337,1620716400"; 
   d="scan'208";a="203888755"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 02:15:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,337,1620716400"; 
   d="scan'208";a="512463943"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 20 Aug 2021 02:15:13 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mH0cL-000UiN-0R; Fri, 20 Aug 2021 09:15:13 +0000
Date:   Fri, 20 Aug 2021 17:14:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2021.08.16a] BUILD SUCCESS
 e376d3475154c40e5210eebbf33ac94696972190
Message-ID: <611f728c.gXclpZIhf+dnVQY7%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2021.08.16a
branch HEAD: e376d3475154c40e5210eebbf33ac94696972190  EXP cpu: Make stopper turn on the tick (crude hack)

elapsed time: 725m

configs tested: 121
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                 xes_mpc85xx_defconfig
mips                malta_qemu_32r6_defconfig
mips                     loongson1c_defconfig
csky                             alldefconfig
arm                          ixp4xx_defconfig
arm                      jornada720_defconfig
sh                          rsk7203_defconfig
arm                           stm32_defconfig
powerpc                       ppc64_defconfig
mips                 decstation_r4k_defconfig
powerpc                     mpc5200_defconfig
nios2                         3c120_defconfig
s390                             allyesconfig
arm                        keystone_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                       imx_v4_v5_defconfig
sh                          r7780mp_defconfig
sh                             espt_defconfig
arm                         lubbock_defconfig
mips                         mpc30x_defconfig
m68k                        stmark2_defconfig
powerpc                       ebony_defconfig
arm                     am200epdkit_defconfig
arm                        cerfcube_defconfig
mips                         tb0226_defconfig
powerpc                     ksi8560_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
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
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20210818
x86_64               randconfig-a006-20210818
x86_64               randconfig-a003-20210818
x86_64               randconfig-a005-20210818
x86_64               randconfig-a002-20210818
x86_64               randconfig-a001-20210818
i386                 randconfig-a004-20210818
i386                 randconfig-a006-20210818
i386                 randconfig-a002-20210818
i386                 randconfig-a001-20210818
i386                 randconfig-a003-20210818
i386                 randconfig-a005-20210818
x86_64               randconfig-a013-20210819
x86_64               randconfig-a011-20210819
x86_64               randconfig-a012-20210819
x86_64               randconfig-a016-20210819
x86_64               randconfig-a014-20210819
x86_64               randconfig-a015-20210819
i386                 randconfig-a015-20210819
i386                 randconfig-a011-20210819
i386                 randconfig-a014-20210819
i386                 randconfig-a013-20210819
i386                 randconfig-a016-20210819
i386                 randconfig-a012-20210819
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
i386                 randconfig-c001-20210818
i386                 randconfig-c001-20210819
x86_64               randconfig-a004-20210819
x86_64               randconfig-a006-20210819
x86_64               randconfig-a003-20210819
x86_64               randconfig-a002-20210819
x86_64               randconfig-a005-20210819
x86_64               randconfig-a001-20210819
x86_64               randconfig-a013-20210818
x86_64               randconfig-a011-20210818
x86_64               randconfig-a012-20210818
x86_64               randconfig-a016-20210818
x86_64               randconfig-a014-20210818
x86_64               randconfig-a015-20210818
i386                 randconfig-a015-20210818
i386                 randconfig-a011-20210818
i386                 randconfig-a013-20210818
i386                 randconfig-a014-20210818
i386                 randconfig-a016-20210818
i386                 randconfig-a012-20210818

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
