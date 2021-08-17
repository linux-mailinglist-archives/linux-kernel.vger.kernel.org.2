Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 560153EE765
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 09:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234612AbhHQHot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 03:44:49 -0400
Received: from mga01.intel.com ([192.55.52.88]:42192 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231500AbhHQHos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 03:44:48 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10078"; a="238094111"
X-IronPort-AV: E=Sophos;i="5.84,328,1620716400"; 
   d="scan'208";a="238094111"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 00:44:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,328,1620716400"; 
   d="scan'208";a="510363928"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 17 Aug 2021 00:44:13 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mFtld-000RWb-8m; Tue, 17 Aug 2021 07:44:13 +0000
Date:   Tue, 17 Aug 2021 15:44:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:clocksource] BUILD SUCCESS
 a5e8561a2bdf276fdd2a7f63a8154930863fcbda
Message-ID: <611b68c7.0bTk0DfFF5U7H0Y+%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git clocksource
branch HEAD: a5e8561a2bdf276fdd2a7f63a8154930863fcbda  clocksource: Make clocksource-wdtest.c safe for slow-HZ systems

elapsed time: 725m

configs tested: 109
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210816
powerpc                         ps3_defconfig
powerpc                  mpc866_ads_defconfig
arm                         lpc18xx_defconfig
arm                         lubbock_defconfig
mips                        workpad_defconfig
powerpc                    mvme5100_defconfig
powerpc                     rainier_defconfig
mips                        nlm_xlr_defconfig
sh                             shx3_defconfig
arm                         cm_x300_defconfig
arm                             pxa_defconfig
arm                       omap2plus_defconfig
arm                        spear6xx_defconfig
powerpc                       maple_defconfig
arm                       imx_v4_v5_defconfig
arm                         axm55xx_defconfig
powerpc                   lite5200b_defconfig
arm                        mvebu_v7_defconfig
arm                         mv78xx0_defconfig
powerpc                  mpc885_ads_defconfig
arm                          gemini_defconfig
arm                            hisi_defconfig
mips                  decstation_64_defconfig
mips                        vocore2_defconfig
powerpc                  iss476-smp_defconfig
sh                           se7750_defconfig
powerpc                   bluestone_defconfig
m68k                       m5208evb_defconfig
arm                         s5pv210_defconfig
powerpc                 xes_mpc85xx_defconfig
mips                     decstation_defconfig
arm                      jornada720_defconfig
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
x86_64               randconfig-a006-20210816
x86_64               randconfig-a004-20210816
x86_64               randconfig-a003-20210816
x86_64               randconfig-a001-20210816
x86_64               randconfig-a005-20210816
x86_64               randconfig-a002-20210816
i386                 randconfig-a004-20210816
i386                 randconfig-a003-20210816
i386                 randconfig-a002-20210816
i386                 randconfig-a001-20210816
i386                 randconfig-a006-20210816
i386                 randconfig-a005-20210816
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
i386                 randconfig-c001-20210816
x86_64               randconfig-a011-20210816
x86_64               randconfig-a013-20210816
x86_64               randconfig-a016-20210816
x86_64               randconfig-a012-20210816
x86_64               randconfig-a015-20210816
x86_64               randconfig-a014-20210816
i386                 randconfig-a011-20210816
i386                 randconfig-a015-20210816
i386                 randconfig-a013-20210816
i386                 randconfig-a014-20210816
i386                 randconfig-a016-20210816
i386                 randconfig-a012-20210816

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
