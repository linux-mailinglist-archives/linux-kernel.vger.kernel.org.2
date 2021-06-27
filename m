Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A444C3B52A0
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jun 2021 11:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbhF0I5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 04:57:52 -0400
Received: from mga17.intel.com ([192.55.52.151]:7096 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229534AbhF0I5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 04:57:51 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10027"; a="188212051"
X-IronPort-AV: E=Sophos;i="5.83,302,1616482800"; 
   d="scan'208";a="188212051"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2021 01:55:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,302,1616482800"; 
   d="scan'208";a="418832437"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 27 Jun 2021 01:55:26 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lxQZZ-00086o-ST; Sun, 27 Jun 2021 08:55:25 +0000
Date:   Sun, 27 Jun 2021 16:54:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS
 34c7342ac1b4e496315fb615d2a1309df8400403
Message-ID: <60d83cca.G8pFlHybifbsPSgq%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
branch HEAD: 34c7342ac1b4e496315fb615d2a1309df8400403  time/kunit: Add missing MODULE_LICENSE()

elapsed time: 725m

configs tested: 99
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arc                        vdk_hs38_defconfig
arm                           corgi_defconfig
m68k                        m5407c3_defconfig
sh                        apsh4ad0a_defconfig
arm                        trizeps4_defconfig
arm                       omap2plus_defconfig
mips                        maltaup_defconfig
riscv                    nommu_virt_defconfig
um                               alldefconfig
powerpc                     stx_gp3_defconfig
arm                        clps711x_defconfig
nios2                         10m50_defconfig
powerpc                      walnut_defconfig
sh                   secureedge5410_defconfig
sh                         ecovec24_defconfig
arm                          imote2_defconfig
mips                     decstation_defconfig
mips                        jmr3927_defconfig
mips                       capcella_defconfig
powerpc                     tqm8548_defconfig
xtensa                  nommu_kc705_defconfig
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
i386                 randconfig-a002-20210627
i386                 randconfig-a001-20210627
i386                 randconfig-a003-20210627
i386                 randconfig-a006-20210627
i386                 randconfig-a005-20210627
i386                 randconfig-a004-20210627
x86_64               randconfig-a002-20210627
x86_64               randconfig-a001-20210627
x86_64               randconfig-a005-20210627
x86_64               randconfig-a003-20210627
x86_64               randconfig-a004-20210627
x86_64               randconfig-a006-20210627
i386                 randconfig-a011-20210627
i386                 randconfig-a014-20210627
i386                 randconfig-a013-20210627
i386                 randconfig-a015-20210627
i386                 randconfig-a012-20210627
i386                 randconfig-a016-20210627
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210627
x86_64               randconfig-a012-20210627
x86_64               randconfig-a016-20210627
x86_64               randconfig-a015-20210627
x86_64               randconfig-a014-20210627
x86_64               randconfig-a013-20210627
x86_64               randconfig-a011-20210627

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
