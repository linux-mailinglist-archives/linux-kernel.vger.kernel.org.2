Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94E23326D22
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Feb 2021 14:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbhB0Nd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Feb 2021 08:33:57 -0500
Received: from mga18.intel.com ([134.134.136.126]:20873 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229912AbhB0Ndz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Feb 2021 08:33:55 -0500
IronPort-SDR: CoC/GYSPGFoWi+QD0OexB0IhQJM9SBsSsKV6xr47DEnLatKD0uxAz3kERpD6shh6NJL7nxL7pv
 9yVk4Wuh93tQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9907"; a="173752299"
X-IronPort-AV: E=Sophos;i="5.81,211,1610438400"; 
   d="scan'208";a="173752299"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2021 05:33:13 -0800
IronPort-SDR: MgCTbUFljkItcN+6+TF28O9XrAfMDlOkNcHyScUM2BqVqVT6I9SOAqJM4mYgAG5MZAF3tQPRQW
 u9/WAFpl1Ypw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,211,1610438400"; 
   d="scan'208";a="503660388"
Received: from lkp-server01.sh.intel.com (HELO 16660e54978b) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 27 Feb 2021 05:33:12 -0800
Received: from kbuild by 16660e54978b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lFziZ-0003jC-L1; Sat, 27 Feb 2021 13:33:11 +0000
Date:   Sat, 27 Feb 2021 21:32:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2021.02.23a] BUILD SUCCESS
 9ec904dce852815c4fa5c8233cd347e2f3422b88
Message-ID: <603a49f1.Vc5ga8SELAvxW+Fe%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2021.02.23a
branch HEAD: 9ec904dce852815c4fa5c8233cd347e2f3422b88  rcu: Add explicit barrier() to __rcu_read_unlock()

elapsed time: 722m

configs tested: 112
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
h8300                       h8s-sim_defconfig
powerpc                   motionpro_defconfig
powerpc                      pcm030_defconfig
m68k                          sun3x_defconfig
openrisc                            defconfig
sh                        sh7763rdp_defconfig
mips                        omega2p_defconfig
riscv                    nommu_virt_defconfig
sh                           sh2007_defconfig
h8300                            alldefconfig
arm                           sama5_defconfig
arm                            lart_defconfig
powerpc                        warp_defconfig
arm                            dove_defconfig
m68k                          multi_defconfig
arm                             pxa_defconfig
arm                        shmobile_defconfig
m68k                            mac_defconfig
powerpc                        icon_defconfig
arm                         bcm2835_defconfig
powerpc               mpc834x_itxgp_defconfig
mips                        vocore2_defconfig
mips                           ci20_defconfig
arc                        vdk_hs38_defconfig
mips                          rm200_defconfig
powerpc                      bamboo_defconfig
powerpc                      ppc6xx_defconfig
powerpc                      pmac32_defconfig
mips                  cavium_octeon_defconfig
arc                         haps_hs_defconfig
arm                           tegra_defconfig
ia64                             allyesconfig
powerpc                      ppc44x_defconfig
m68k                             alldefconfig
arm                        realview_defconfig
arm                     am200epdkit_defconfig
mips                         mpc30x_defconfig
powerpc                      makalu_defconfig
ia64                             allmodconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
i386                 randconfig-a005-20210227
i386                 randconfig-a006-20210227
i386                 randconfig-a004-20210227
i386                 randconfig-a001-20210227
i386                 randconfig-a003-20210227
i386                 randconfig-a002-20210227
i386                 randconfig-a013-20210226
i386                 randconfig-a012-20210226
i386                 randconfig-a011-20210226
i386                 randconfig-a014-20210226
i386                 randconfig-a016-20210226
i386                 randconfig-a015-20210226
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
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
x86_64               randconfig-a001-20210227
x86_64               randconfig-a002-20210227
x86_64               randconfig-a003-20210227
x86_64               randconfig-a005-20210227
x86_64               randconfig-a004-20210227
x86_64               randconfig-a006-20210227
x86_64               randconfig-a011-20210226
x86_64               randconfig-a012-20210226
x86_64               randconfig-a013-20210226
x86_64               randconfig-a014-20210226
x86_64               randconfig-a015-20210226
x86_64               randconfig-a016-20210226

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
