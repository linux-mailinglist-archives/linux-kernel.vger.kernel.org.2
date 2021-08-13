Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 451B63EB332
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 11:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239279AbhHMJMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 05:12:25 -0400
Received: from mga14.intel.com ([192.55.52.115]:3325 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231127AbhHMJMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 05:12:23 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10074"; a="215259997"
X-IronPort-AV: E=Sophos;i="5.84,318,1620716400"; 
   d="scan'208";a="215259997"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2021 02:11:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,318,1620716400"; 
   d="scan'208";a="528423655"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 13 Aug 2021 02:11:55 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mETEI-000Nan-JU; Fri, 13 Aug 2021 09:11:54 +0000
Date:   Fri, 13 Aug 2021 17:11:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS
 f80e21489590c00f46226d5802d900e6f66e5633
Message-ID: <6116372a.qDvEk3WF4gnlCTIg%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
branch HEAD: f80e21489590c00f46226d5802d900e6f66e5633  hrtimer: Unbreak hrtimer_force_reprogram()

elapsed time: 729m

configs tested: 139
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
powerpc                     mpc5200_defconfig
powerpc                         wii_defconfig
arm                      integrator_defconfig
arm                        trizeps4_defconfig
sh                          polaris_defconfig
powerpc                      bamboo_defconfig
powerpc                       holly_defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                        cell_defconfig
powerpc                 mpc837x_rdb_defconfig
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
xtensa                    xip_kc705_defconfig
sh                          kfr2r09_defconfig
s390                          debug_defconfig
openrisc                  or1klitex_defconfig
arc                    vdk_hs38_smp_defconfig
mips                           ip32_defconfig
xtensa                              defconfig
powerpc                         ps3_defconfig
mips                         rt305x_defconfig
arm                            qcom_defconfig
sh                   secureedge5410_defconfig
powerpc                       eiger_defconfig
arm                        multi_v7_defconfig
arm                     davinci_all_defconfig
mips                           gcw0_defconfig
arm                            xcep_defconfig
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
s390                             allyesconfig
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
x86_64               randconfig-a006-20210812
x86_64               randconfig-a004-20210812
x86_64               randconfig-a003-20210812
x86_64               randconfig-a005-20210812
x86_64               randconfig-a002-20210812
x86_64               randconfig-a001-20210812
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
