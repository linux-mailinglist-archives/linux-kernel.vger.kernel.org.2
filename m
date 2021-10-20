Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20B6543445F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 06:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhJTEgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 00:36:40 -0400
Received: from mga01.intel.com ([192.55.52.88]:8562 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229492AbhJTEgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 00:36:39 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10142"; a="252170370"
X-IronPort-AV: E=Sophos;i="5.87,165,1631602800"; 
   d="scan'208";a="252170370"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2021 21:34:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,165,1631602800"; 
   d="scan'208";a="483564620"
Received: from lkp-server02.sh.intel.com (HELO 08b2c502c3de) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 19 Oct 2021 21:34:24 -0700
Received: from kbuild by 08b2c502c3de with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1md3J1-000Czz-VR; Wed, 20 Oct 2021 04:34:23 +0000
Date:   Wed, 20 Oct 2021 12:33:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/urgent] BUILD SUCCESS
 63acd42c0d4942f74710b11c38602fb14dea7320
Message-ID: <616f9c1a.kMt12MfwhdVbwV7P%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/urgent
branch HEAD: 63acd42c0d4942f74710b11c38602fb14dea7320  sched/scs: Reset the shadow stack when idle_task_exit

elapsed time: 742m

configs tested: 126
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211019
arm                         hackkit_defconfig
mips                        omega2p_defconfig
powerpc                      cm5200_defconfig
mips                        qi_lb60_defconfig
xtensa                          iss_defconfig
arm                           viper_defconfig
powerpc                       maple_defconfig
m68k                        m5407c3_defconfig
arm                         lubbock_defconfig
mips                           gcw0_defconfig
sh                          rsk7264_defconfig
powerpc                 mpc832x_mds_defconfig
arm                         orion5x_defconfig
powerpc                     ppa8548_defconfig
sh                   sh7724_generic_defconfig
x86_64                           alldefconfig
arc                          axs103_defconfig
sh                           se7722_defconfig
powerpc                   bluestone_defconfig
mips                     decstation_defconfig
m68k                       m5275evb_defconfig
arm                          ep93xx_defconfig
arc                      axs103_smp_defconfig
arm                        realview_defconfig
powerpc                     tqm8540_defconfig
mips                           ci20_defconfig
powerpc                     tqm5200_defconfig
powerpc                      walnut_defconfig
powerpc                        fsp2_defconfig
arm                         palmz72_defconfig
arm                         s3c2410_defconfig
mips                      maltasmvp_defconfig
arm                  randconfig-c002-20211019
x86_64               randconfig-c001-20211019
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                                defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
i386                             allyesconfig
i386                                defconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20211020
i386                 randconfig-a003-20211020
i386                 randconfig-a002-20211020
i386                 randconfig-a005-20211020
i386                 randconfig-a006-20211020
i386                 randconfig-a001-20211020
x86_64               randconfig-a012-20211019
x86_64               randconfig-a013-20211019
x86_64               randconfig-a011-20211019
x86_64               randconfig-a015-20211019
x86_64               randconfig-a016-20211019
x86_64               randconfig-a014-20211019
i386                 randconfig-a014-20211019
i386                 randconfig-a016-20211019
i386                 randconfig-a011-20211019
i386                 randconfig-a015-20211019
i386                 randconfig-a012-20211019
i386                 randconfig-a013-20211019
arc                  randconfig-r043-20211019
s390                 randconfig-r044-20211019
riscv                randconfig-r042-20211019
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
arm                  randconfig-c002-20211019
mips                 randconfig-c004-20211019
i386                 randconfig-c001-20211019
s390                 randconfig-c005-20211019
x86_64               randconfig-c007-20211019
riscv                randconfig-c006-20211019
powerpc              randconfig-c003-20211019
x86_64               randconfig-a004-20211019
x86_64               randconfig-a006-20211019
x86_64               randconfig-a005-20211019
x86_64               randconfig-a001-20211019
x86_64               randconfig-a002-20211019
x86_64               randconfig-a003-20211019
i386                 randconfig-a005-20211019
i386                 randconfig-a006-20211019
riscv                randconfig-r042-20211020
s390                 randconfig-r044-20211020
hexagon              randconfig-r045-20211020
hexagon              randconfig-r041-20211020
hexagon              randconfig-r041-20211019
hexagon              randconfig-r045-20211019

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
