Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0A083765BE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 15:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237125AbhEGNHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 09:07:40 -0400
Received: from mga18.intel.com ([134.134.136.126]:40141 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232963AbhEGNHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 09:07:37 -0400
IronPort-SDR: Dog4d3XbhfkVN8ogFevIPUEo6p7VACkVu2IO6gkEEKah5ADy+26qJfQKDEksZ0ccDkONqK4D5a
 J9x2dHNdI4Tw==
X-IronPort-AV: E=McAfee;i="6200,9189,9977"; a="186180907"
X-IronPort-AV: E=Sophos;i="5.82,280,1613462400"; 
   d="scan'208";a="186180907"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2021 06:06:37 -0700
IronPort-SDR: gOsmXGbfI/KcQRGMM+y0ILQkHhhA5pJeqQ5dG4YcRCFxqxBQzvsClauaORiIUzCEaUoZO2kx5G
 JMGXtjdJCktw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,280,1613462400"; 
   d="scan'208";a="407424641"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 07 May 2021 06:06:36 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lf0Bf-000BDA-Nh; Fri, 07 May 2021 13:06:35 +0000
Date:   Fri, 07 May 2021 21:05:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:testing/drm-nislands] BUILD SUCCESS
 4c16031cebe9b4d319974bf86af4f9823f911955
Message-ID: <60953b29.UHMmcII35AmPE2Ku%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/drm-nislands
branch HEAD: 4c16031cebe9b4d319974bf86af4f9823f911955  drm/radeon/ni_dpm: Fix booting bug

elapsed time: 722m

configs tested: 89
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
riscv                            allmodconfig
i386                             allyesconfig
riscv                            allyesconfig
mips                         bigsur_defconfig
arm                           sama5_defconfig
m68k                       m5249evb_defconfig
arm                      integrator_defconfig
sh                      rts7751r2d1_defconfig
mips                     loongson1c_defconfig
sparc64                          alldefconfig
mips                     cu1830-neo_defconfig
arc                            hsdk_defconfig
arm                        realview_defconfig
m68k                       m5275evb_defconfig
arm                       multi_v4t_defconfig
riscv                    nommu_k210_defconfig
powerpc                 mpc832x_rdb_defconfig
sh                           se7751_defconfig
mips                        nlm_xlp_defconfig
powerpc                 mpc8315_rdb_defconfig
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
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a014-20210506
x86_64               randconfig-a015-20210506
x86_64               randconfig-a012-20210506
x86_64               randconfig-a013-20210506
x86_64               randconfig-a011-20210506
x86_64               randconfig-a016-20210506
i386                 randconfig-a015-20210506
i386                 randconfig-a013-20210506
i386                 randconfig-a016-20210506
i386                 randconfig-a014-20210506
i386                 randconfig-a012-20210506
i386                 randconfig-a011-20210506
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
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
x86_64               randconfig-a001-20210506
x86_64               randconfig-a003-20210506
x86_64               randconfig-a005-20210506
x86_64               randconfig-a002-20210506
x86_64               randconfig-a006-20210506
x86_64               randconfig-a004-20210506

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
