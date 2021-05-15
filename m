Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7866381AFF
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 22:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234902AbhEOUcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 16:32:10 -0400
Received: from mga03.intel.com ([134.134.136.65]:11539 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234880AbhEOUcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 16:32:08 -0400
IronPort-SDR: DuqdKSNRhF+y57GpMTPXUIWENI3B9Dzx4WUzwcHhoHXugy/8H7gfR3hw+mStL5LQBAo6fgCWIF
 DWhcEzA8ZuVQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9985"; a="200350810"
X-IronPort-AV: E=Sophos;i="5.82,303,1613462400"; 
   d="scan'208";a="200350810"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2021 13:30:54 -0700
IronPort-SDR: 66I9/OAZn/GFq3p4OtfXG2RoVi8mz94T4YRy+PEDXu3l1aQbUCFLJFl64s6Dsa8XicMTOxNhkT
 SLm9NWbvOBQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,303,1613462400"; 
   d="scan'208";a="410361242"
Received: from lkp-server01.sh.intel.com (HELO ddd90b05c979) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 15 May 2021 13:30:53 -0700
Received: from kbuild by ddd90b05c979 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1li0w0-0001FV-DY; Sat, 15 May 2021 20:30:52 +0000
Date:   Sun, 16 May 2021 04:30:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 ef9eaab932a975e791c717a60911aaa963ffb503
Message-ID: <60a02f4f.rTWGI379kRJUwo7T%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: ef9eaab932a975e791c717a60911aaa963ffb503  Merge branch 'core/urgent'

elapsed time: 722m

configs tested: 100
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                       maple_defconfig
mips                           ip28_defconfig
powerpc                      pcm030_defconfig
powerpc                    socrates_defconfig
powerpc                      walnut_defconfig
mips                          rm200_defconfig
arm                         axm55xx_defconfig
m68k                        m5307c3_defconfig
powerpc                     taishan_defconfig
arm                           tegra_defconfig
mips                  decstation_64_defconfig
xtensa                              defconfig
nios2                            alldefconfig
powerpc                 mpc8540_ads_defconfig
arm                         assabet_defconfig
arm                            dove_defconfig
sh                        sh7785lcr_defconfig
powerpc                   bluestone_defconfig
parisc                              defconfig
powerpc                      arches_defconfig
ia64                          tiger_defconfig
mips                           ip22_defconfig
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
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210515
i386                 randconfig-a001-20210515
i386                 randconfig-a004-20210515
i386                 randconfig-a005-20210515
i386                 randconfig-a002-20210515
i386                 randconfig-a006-20210515
x86_64               randconfig-a012-20210515
x86_64               randconfig-a015-20210515
x86_64               randconfig-a011-20210515
x86_64               randconfig-a013-20210515
x86_64               randconfig-a016-20210515
x86_64               randconfig-a014-20210515
i386                 randconfig-a016-20210515
i386                 randconfig-a014-20210515
i386                 randconfig-a011-20210515
i386                 randconfig-a012-20210515
i386                 randconfig-a015-20210515
i386                 randconfig-a013-20210515
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
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
x86_64               randconfig-a004-20210515
x86_64               randconfig-a003-20210515
x86_64               randconfig-a001-20210515
x86_64               randconfig-a005-20210515
x86_64               randconfig-a002-20210515
x86_64               randconfig-a006-20210515

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
