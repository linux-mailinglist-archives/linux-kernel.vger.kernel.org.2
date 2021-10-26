Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2247343ABEE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 07:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235186AbhJZF6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 01:58:47 -0400
Received: from mga17.intel.com ([192.55.52.151]:26648 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235129AbhJZF6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 01:58:45 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10148"; a="210610785"
X-IronPort-AV: E=Sophos;i="5.87,182,1631602800"; 
   d="scan'208";a="210610785"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 22:56:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,182,1631602800"; 
   d="scan'208";a="485998194"
Received: from lkp-server01.sh.intel.com (HELO 979d88847c63) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 25 Oct 2021 22:56:20 -0700
Received: from kbuild by 979d88847c63 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mfFRb-0000Ms-94; Tue, 26 Oct 2021 05:56:19 +0000
Date:   Tue, 26 Oct 2021 13:55:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 55409ac5c371c6403012d5f4df5e7c6cf0e7dce6
Message-ID: <6177985c.xhiUSCqa6+Ymga7c%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: 55409ac5c371c6403012d5f4df5e7c6cf0e7dce6  sched,x86: Fix L2 cache mask

elapsed time: 3040m

configs tested: 106
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211025
nios2                            alldefconfig
arm                       mainstone_defconfig
mips                          rb532_defconfig
arm                           sunxi_defconfig
powerpc                   bluestone_defconfig
arc                      axs103_smp_defconfig
powerpc                      obs600_defconfig
mips                          rm200_defconfig
arm                           h5000_defconfig
arm                          pxa3xx_defconfig
nios2                         3c120_defconfig
powerpc                        warp_defconfig
arm                        mvebu_v7_defconfig
arm                            dove_defconfig
mips                          ath79_defconfig
arm                  randconfig-c002-20211025
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
arc                              allyesconfig
nios2                               defconfig
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
parisc                              defconfig
s390                                defconfig
parisc                           allyesconfig
s390                             allyesconfig
s390                             allmodconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                              debian-10.3
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a013-20211025
x86_64               randconfig-a015-20211025
x86_64               randconfig-a011-20211025
x86_64               randconfig-a014-20211025
x86_64               randconfig-a016-20211025
x86_64               randconfig-a012-20211025
i386                 randconfig-a012-20211025
i386                 randconfig-a013-20211025
i386                 randconfig-a011-20211025
i386                 randconfig-a016-20211025
i386                 randconfig-a015-20211025
i386                 randconfig-a014-20211025
x86_64               randconfig-a002-20211024
x86_64               randconfig-a004-20211024
x86_64               randconfig-a005-20211024
x86_64               randconfig-a006-20211024
x86_64               randconfig-a001-20211024
x86_64               randconfig-a003-20211024
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
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
riscv                randconfig-c006-20211025
powerpc              randconfig-c003-20211025
arm                  randconfig-c002-20211025
x86_64               randconfig-c007-20211025
mips                 randconfig-c004-20211025
i386                 randconfig-c001-20211025
s390                 randconfig-c005-20211025
x86_64               randconfig-a002-20211025
x86_64               randconfig-a004-20211025
x86_64               randconfig-a005-20211025
x86_64               randconfig-a006-20211025
x86_64               randconfig-a001-20211025
x86_64               randconfig-a003-20211025
i386                 randconfig-a003-20211025
i386                 randconfig-a004-20211025
i386                 randconfig-a002-20211025
i386                 randconfig-a005-20211025
i386                 randconfig-a001-20211025
i386                 randconfig-a006-20211025
hexagon              randconfig-r045-20211025
hexagon              randconfig-r041-20211025

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
