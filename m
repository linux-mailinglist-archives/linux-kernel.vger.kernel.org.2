Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0E6307694
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 14:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbhA1M7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 07:59:15 -0500
Received: from mga03.intel.com ([134.134.136.65]:56589 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231153AbhA1M6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 07:58:51 -0500
IronPort-SDR: 6pyPUY9FBrsjKx1gBPXYDwjxbCFQHVY12tzvUrQknEs7iDEKBgBCiDeh/9taYLcIcqO7NyB6/O
 dfjhDtJ7K2gw==
X-IronPort-AV: E=McAfee;i="6000,8403,9877"; a="180304493"
X-IronPort-AV: E=Sophos;i="5.79,382,1602572400"; 
   d="scan'208";a="180304493"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 04:58:10 -0800
IronPort-SDR: TWZWcvwQXSUo33bxnj60GGoqWYsq2GREQQql21mjTuXeMNzMMbNeXSRw1pObi3QAp3fvqn7b9X
 7s1Az/67qVWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,382,1602572400"; 
   d="scan'208";a="473692379"
Received: from lkp-server02.sh.intel.com (HELO 625d3a354f04) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 28 Jan 2021 04:58:09 -0800
Received: from kbuild by 625d3a354f04 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l56sC-0002vJ-DO; Thu, 28 Jan 2021 12:58:08 +0000
Date:   Thu, 28 Jan 2021 20:57:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:for-mingo-rcu] BUILD SUCCESS
 0d2460ba61841e5c2e64e77f7a84d3fc69cfe899
Message-ID: <6012b4c8.pCEsd+szDgAVsL3G%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git for-mingo-rcu
branch HEAD: 0d2460ba61841e5c2e64e77f7a84d3fc69cfe899  Merge branches 'doc.2021.01.06a', 'fixes.2021.01.04b', 'kfree_rcu.2021.01.04a', 'mmdumpobj.2021.01.22a', 'nocb.2021.01.06a', 'rt.2021.01.04a', 'stall.2021.01.06a', 'torture.2021.01.12a' and 'tortureall.2021.01.06a' into HEAD

elapsed time: 726m

configs tested: 123
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                      mgcoge_defconfig
powerpc                          g5_defconfig
powerpc                         ps3_defconfig
nds32                            alldefconfig
c6x                        evmc6457_defconfig
m68k                            q40_defconfig
m68k                       m5208evb_defconfig
sh                            titan_defconfig
arm                         lpc18xx_defconfig
sh                         microdev_defconfig
mips                         mpc30x_defconfig
riscv                               defconfig
arc                     nsimosci_hs_defconfig
c6x                        evmc6474_defconfig
mips                           ip28_defconfig
alpha                            alldefconfig
powerpc                    gamecube_defconfig
sparc                       sparc32_defconfig
mips                         tb0226_defconfig
nios2                            allyesconfig
sh                         apsh4a3a_defconfig
arm                       aspeed_g5_defconfig
arm                        mvebu_v5_defconfig
m68k                       m5275evb_defconfig
powerpc                      ppc44x_defconfig
m68k                        m5407c3_defconfig
powerpc                 mpc8313_rdb_defconfig
arm                  colibri_pxa270_defconfig
arm                       multi_v4t_defconfig
sh                        sh7785lcr_defconfig
arm                        oxnas_v6_defconfig
arm                       aspeed_g4_defconfig
c6x                        evmc6678_defconfig
mips                          malta_defconfig
arc                           tb10x_defconfig
xtensa                generic_kc705_defconfig
sh                          rsk7269_defconfig
mips                            ar7_defconfig
openrisc                            defconfig
ia64                        generic_defconfig
openrisc                 simple_smp_defconfig
mips                  cavium_octeon_defconfig
sparc                            allyesconfig
powerpc                  storcenter_defconfig
x86_64                              defconfig
powerpc                    ge_imp3a_defconfig
arm                         at91_dt_defconfig
arm                            lart_defconfig
sh                          r7785rp_defconfig
ia64                         bigsur_defconfig
m68k                        m5272c3_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
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
i386                 randconfig-a001-20210128
i386                 randconfig-a002-20210128
i386                 randconfig-a004-20210128
i386                 randconfig-a005-20210128
i386                 randconfig-a003-20210128
i386                 randconfig-a006-20210128
x86_64               randconfig-a012-20210128
x86_64               randconfig-a015-20210128
x86_64               randconfig-a016-20210128
x86_64               randconfig-a011-20210128
x86_64               randconfig-a013-20210128
x86_64               randconfig-a014-20210128
i386                 randconfig-a013-20210128
i386                 randconfig-a011-20210128
i386                 randconfig-a012-20210128
i386                 randconfig-a016-20210128
i386                 randconfig-a014-20210128
i386                 randconfig-a015-20210128
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a002-20210128
x86_64               randconfig-a003-20210128
x86_64               randconfig-a001-20210128
x86_64               randconfig-a005-20210128
x86_64               randconfig-a006-20210128
x86_64               randconfig-a004-20210128

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
