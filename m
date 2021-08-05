Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD953E134F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 12:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240588AbhHEK5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 06:57:07 -0400
Received: from mga03.intel.com ([134.134.136.65]:41120 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240080AbhHEK5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 06:57:06 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10066"; a="214154416"
X-IronPort-AV: E=Sophos;i="5.84,296,1620716400"; 
   d="scan'208";a="214154416"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2021 03:56:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,296,1620716400"; 
   d="scan'208";a="522560421"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 05 Aug 2021 03:56:50 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mBb3R-000Foh-Vx; Thu, 05 Aug 2021 10:56:49 +0000
Date:   Thu, 05 Aug 2021 18:56:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rcu/next] BUILD SUCCESS
 d9264b6bec039207dc6ee038b80e75b4475a6a7f
Message-ID: <610bc3e9.fBqS1AOC8aagS+S6%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: d9264b6bec039207dc6ee038b80e75b4475a6a7f  rcu: Replace deprecated CPU-hotplug functions.

elapsed time: 721m

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
i386                 randconfig-c001-20210804
i386                 randconfig-c001-20210805
arm                             pxa_defconfig
powerpc                      ep88xc_defconfig
sh                           se7751_defconfig
sh                         apsh4a3a_defconfig
mips                        bcm47xx_defconfig
mips                           ip32_defconfig
sh                          rsk7269_defconfig
arc                            hsdk_defconfig
arm                        keystone_defconfig
arm                         s3c2410_defconfig
arm                       omap2plus_defconfig
ia64                                defconfig
arm                       aspeed_g5_defconfig
openrisc                            defconfig
arm                        mini2440_defconfig
sh                          polaris_defconfig
sh                               j2_defconfig
arm                        vexpress_defconfig
ia64                      gensparse_defconfig
sh                     sh7710voipgw_defconfig
riscv                    nommu_k210_defconfig
powerpc                   bluestone_defconfig
mips                           rs90_defconfig
arm                         lpc32xx_defconfig
arm                        neponset_defconfig
ia64                             allmodconfig
ia64                             allyesconfig
x86_64                            allnoconfig
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
x86_64               randconfig-a002-20210805
x86_64               randconfig-a006-20210805
x86_64               randconfig-a004-20210805
x86_64               randconfig-a003-20210805
x86_64               randconfig-a001-20210805
x86_64               randconfig-a005-20210805
i386                 randconfig-a005-20210804
i386                 randconfig-a004-20210804
i386                 randconfig-a002-20210804
i386                 randconfig-a006-20210804
i386                 randconfig-a003-20210804
i386                 randconfig-a001-20210804
x86_64               randconfig-a012-20210804
x86_64               randconfig-a016-20210804
x86_64               randconfig-a011-20210804
x86_64               randconfig-a013-20210804
x86_64               randconfig-a014-20210804
x86_64               randconfig-a015-20210804
i386                 randconfig-a012-20210805
i386                 randconfig-a011-20210805
i386                 randconfig-a015-20210805
i386                 randconfig-a013-20210805
i386                 randconfig-a014-20210805
i386                 randconfig-a016-20210805
i386                 randconfig-a012-20210804
i386                 randconfig-a011-20210804
i386                 randconfig-a015-20210804
i386                 randconfig-a013-20210804
i386                 randconfig-a014-20210804
i386                 randconfig-a016-20210804
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

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
