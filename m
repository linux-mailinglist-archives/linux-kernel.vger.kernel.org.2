Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF44232CDC2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 08:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbhCDHiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 02:38:14 -0500
Received: from mga03.intel.com ([134.134.136.65]:52834 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232307AbhCDHh7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 02:37:59 -0500
IronPort-SDR: XS4OIr0qgJnVWyL0HZHtzPZKdWAr3gCIibz0bUmSOmKV2vgTZ0fk0UssYcEiAmteUGNHPImvkS
 1DLiiiQLlnkw==
X-IronPort-AV: E=McAfee;i="6000,8403,9912"; a="187416697"
X-IronPort-AV: E=Sophos;i="5.81,222,1610438400"; 
   d="scan'208";a="187416697"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 23:37:17 -0800
IronPort-SDR: AGFQyzogP6KTSqtkMKQ7pLqGz4mAmFE2Z24+2dA+WY62mBjn9Eek545F4AL7vHcJKo2mwOkbNp
 R3QbASVEYqbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,222,1610438400"; 
   d="scan'208";a="586660349"
Received: from lkp-server02.sh.intel.com (HELO 2482ff9f8ac0) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 03 Mar 2021 23:37:15 -0800
Received: from kbuild by 2482ff9f8ac0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lHiXr-00025X-7X; Thu, 04 Mar 2021 07:37:15 +0000
Date:   Thu, 04 Mar 2021 15:36:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2021.03.03a] BUILD SUCCESS
 2a75054f76b2f5c6e1bdc89ec4cc8538129897b0
Message-ID: <60408e1a.r/Y/nbbEllONmtsx%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2021.03.03a
branch HEAD: 2a75054f76b2f5c6e1bdc89ec4cc8538129897b0  kcsan, debugfs: Move debugfs file creation out of early init

elapsed time: 725m

configs tested: 94
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
m68k                             alldefconfig
mips                       capcella_defconfig
powerpc                         wii_defconfig
powerpc                      pmac32_defconfig
m68k                          multi_defconfig
sh                             sh03_defconfig
arc                    vdk_hs38_smp_defconfig
microblaze                          defconfig
sh                        sh7757lcr_defconfig
arm                         bcm2835_defconfig
parisc                           alldefconfig
arm                            lart_defconfig
arm                          lpd270_defconfig
arm                     davinci_all_defconfig
sh                                  defconfig
arc                            hsdk_defconfig
powerpc                      ppc64e_defconfig
arm                       multi_v4t_defconfig
arm                           sunxi_defconfig
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
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20210303
i386                 randconfig-a003-20210303
i386                 randconfig-a002-20210303
i386                 randconfig-a004-20210303
i386                 randconfig-a006-20210303
i386                 randconfig-a001-20210303
x86_64               randconfig-a013-20210303
x86_64               randconfig-a016-20210303
x86_64               randconfig-a015-20210303
x86_64               randconfig-a014-20210303
x86_64               randconfig-a012-20210303
x86_64               randconfig-a011-20210303
i386                 randconfig-a016-20210303
i386                 randconfig-a012-20210303
i386                 randconfig-a014-20210303
i386                 randconfig-a013-20210303
i386                 randconfig-a011-20210303
i386                 randconfig-a015-20210303
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20210303
x86_64               randconfig-a001-20210303
x86_64               randconfig-a004-20210303
x86_64               randconfig-a002-20210303
x86_64               randconfig-a005-20210303
x86_64               randconfig-a003-20210303

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
