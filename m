Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 843723EB4A6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 13:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240034AbhHMLlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 07:41:40 -0400
Received: from mga11.intel.com ([192.55.52.93]:50529 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239938AbhHMLlk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 07:41:40 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10074"; a="212432591"
X-IronPort-AV: E=Sophos;i="5.84,318,1620716400"; 
   d="scan'208";a="212432591"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2021 04:41:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,318,1620716400"; 
   d="scan'208";a="677344298"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 13 Aug 2021 04:41:12 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mEVYl-000Nm1-KS; Fri, 13 Aug 2021 11:41:11 +0000
Date:   Fri, 13 Aug 2021 19:40:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rcu/next] BUILD SUCCESS
 4e32644d45e0abe67d48e162f85b27771ab8f13f
Message-ID: <61165a49.0g+T8bSnK36UjcCG%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: 4e32644d45e0abe67d48e162f85b27771ab8f13f  rcu-tasks: Move RTGS_WAIT_CBS to beginning of rcu_tasks_kthread() loop

elapsed time: 724m

configs tested: 132
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210812
arm                    vt8500_v6_v7_defconfig
sh                           se7751_defconfig
powerpc                     ep8248e_defconfig
sh                           sh2007_defconfig
m68k                        stmark2_defconfig
mips                  maltasmvp_eva_defconfig
powerpc               mpc834x_itxgp_defconfig
mips                        maltaup_defconfig
mips                           ip22_defconfig
sh                           se7721_defconfig
arm                        clps711x_defconfig
powerpc                      ppc6xx_defconfig
powerpc                 mpc837x_mds_defconfig
ia64                             alldefconfig
sh                        edosk7705_defconfig
xtensa                generic_kc705_defconfig
arm                           stm32_defconfig
arm                           omap1_defconfig
arc                           tb10x_defconfig
arm                          exynos_defconfig
mips                          ath25_defconfig
mips                        workpad_defconfig
mips                     decstation_defconfig
powerpc                        cell_defconfig
powerpc                     ppa8548_defconfig
arc                        nsimosci_defconfig
arm                     davinci_all_defconfig
mips                           gcw0_defconfig
arm                            xcep_defconfig
riscv                             allnoconfig
powerpc64                        alldefconfig
powerpc                     ksi8560_defconfig
arm                            zeus_defconfig
sh                             sh03_defconfig
arm                       aspeed_g5_defconfig
arc                     nsimosci_hs_defconfig
arc                          axs103_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
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
x86_64               randconfig-a006-20210812
x86_64               randconfig-a004-20210812
x86_64               randconfig-a003-20210812
x86_64               randconfig-a005-20210812
x86_64               randconfig-a002-20210812
x86_64               randconfig-a001-20210812
i386                 randconfig-a004-20210812
i386                 randconfig-a003-20210812
i386                 randconfig-a002-20210812
i386                 randconfig-a001-20210812
i386                 randconfig-a006-20210812
i386                 randconfig-a005-20210812
i386                 randconfig-a004-20210813
i386                 randconfig-a003-20210813
i386                 randconfig-a001-20210813
i386                 randconfig-a002-20210813
i386                 randconfig-a006-20210813
i386                 randconfig-a005-20210813
i386                 randconfig-a011-20210812
i386                 randconfig-a015-20210812
i386                 randconfig-a013-20210812
i386                 randconfig-a014-20210812
i386                 randconfig-a016-20210812
i386                 randconfig-a012-20210812
i386                 randconfig-a011-20210813
i386                 randconfig-a015-20210813
i386                 randconfig-a014-20210813
i386                 randconfig-a013-20210813
i386                 randconfig-a016-20210813
i386                 randconfig-a012-20210813
riscv                    nommu_k210_defconfig
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
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c001-20210812
x86_64               randconfig-a006-20210813
x86_64               randconfig-a004-20210813
x86_64               randconfig-a003-20210813
x86_64               randconfig-a002-20210813
x86_64               randconfig-a005-20210813
x86_64               randconfig-a001-20210813
x86_64               randconfig-a011-20210812
x86_64               randconfig-a013-20210812
x86_64               randconfig-a012-20210812
x86_64               randconfig-a016-20210812
x86_64               randconfig-a015-20210812
x86_64               randconfig-a014-20210812

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
